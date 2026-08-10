return {
	Play411171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411171001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B10b"

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
				local var_4_5 = arg_1_1.bgs_.B10b

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
					if iter_4_0 ~= "B10b" then
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
			local var_4_23 = 0.3

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

			local var_4_28 = 0
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_16", "se_story_16_rain02_loop", "")
			end

			local var_4_32 = manager.ui.mainCamera.transform
			local var_4_33 = 0

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_34 = arg_1_1.var_.effect工厂雨
				local var_4_35
				local var_4_36 = var_4_32

				if not var_4_34 then
					var_4_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_4_36)
					var_4_34.name = "工厂雨"
					arg_1_1.var_.effect工厂雨 = var_4_34
				else
					var_4_34.transform:SetParent(var_4_36)
				end

				var_4_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_34.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_37 = 0
			local var_4_38 = 0.3

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "music"

				arg_1_1:AudioAction(var_4_39, var_4_40, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_41 = ""
				local var_4_42 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_42 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_42 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_42

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_42
						arg_1_1.bgmTxt2_.text = var_4_42
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

			local var_4_43 = 0.433333333333333
			local var_4_44 = 0.3

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1.awb")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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

			local var_4_49 = 2
			local var_4_50 = 1.075

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_52 = arg_1_1:GetWordFromCfg(411171001)
				local var_4_53 = arg_1_1:FormatText(var_4_52.content)

				arg_1_1.text_.text = var_4_53

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_54 = 43
				local var_4_55 = utf8.len(var_4_53)
				local var_4_56 = var_4_54 <= 0 and var_4_50 or var_4_50 * (var_4_55 / var_4_54)

				if var_4_56 > 0 and var_4_50 < var_4_56 then
					arg_1_1.talkMaxDuration = var_4_56
					var_4_49 = var_4_49 + 0.3

					if var_4_56 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_53
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_57 = var_4_49 + 0.3
			local var_4_58 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_57) / var_4_58

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411171002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 411171002
		arg_10_1.duration_ = 9.1

		local var_10_0 = {
			zh = 6.066,
			ja = 9.1
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
				arg_10_0:Play411171003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "1024ui_story"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_10_1.stage_.transform)

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

			local var_13_5 = arg_10_1.actors_["1024ui_story"].transform
			local var_13_6 = 0

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.var_.moveOldPos1024ui_story = var_13_5.localPosition

				local var_13_7 = "1024ui_story"

				arg_10_1:ShowWeapon(arg_10_1.var_[var_13_7 .. "Animator"].transform, false)
			end

			local var_13_8 = 0.001

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_8 then
				local var_13_9 = (arg_10_1.time_ - var_13_6) / var_13_8
				local var_13_10 = Vector3.New(0, -1, -6.05)

				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1024ui_story, var_13_10, var_13_9)

				local var_13_11 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_11.x, var_13_11.y, var_13_11.z)

				local var_13_12 = var_13_5.localEulerAngles

				var_13_12.z = 0
				var_13_12.x = 0
				var_13_5.localEulerAngles = var_13_12
			end

			if arg_10_1.time_ >= var_13_6 + var_13_8 and arg_10_1.time_ < var_13_6 + var_13_8 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(0, -1, -6.05)

				local var_13_13 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_13.x, var_13_13.y, var_13_13.z)

				local var_13_14 = var_13_5.localEulerAngles

				var_13_14.z = 0
				var_13_14.x = 0
				var_13_5.localEulerAngles = var_13_14
			end

			local var_13_15 = arg_10_1.actors_["1024ui_story"]
			local var_13_16 = 0

			if var_13_16 < arg_10_1.time_ and arg_10_1.time_ <= var_13_16 + arg_13_0 and not isNil(var_13_15) and arg_10_1.var_.characterEffect1024ui_story == nil then
				arg_10_1.var_.characterEffect1024ui_story = var_13_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_17 = 0.200000002980232

			if var_13_16 <= arg_10_1.time_ and arg_10_1.time_ < var_13_16 + var_13_17 and not isNil(var_13_15) then
				local var_13_18 = (arg_10_1.time_ - var_13_16) / var_13_17

				if arg_10_1.var_.characterEffect1024ui_story and not isNil(var_13_15) then
					arg_10_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= var_13_16 + var_13_17 and arg_10_1.time_ < var_13_16 + var_13_17 + arg_13_0 and not isNil(var_13_15) and arg_10_1.var_.characterEffect1024ui_story then
				arg_10_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_13_19 = 0

			if var_13_19 < arg_10_1.time_ and arg_10_1.time_ <= var_13_19 + arg_13_0 then
				arg_10_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_13_20 = 0

			if var_13_20 < arg_10_1.time_ and arg_10_1.time_ <= var_13_20 + arg_13_0 then
				arg_10_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_13_21 = 0
			local var_13_22 = 0.9

			if var_13_21 < arg_10_1.time_ and arg_10_1.time_ <= var_13_21 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_23 = arg_10_1:FormatText(StoryNameCfg[714].name)

				arg_10_1.leftNameTxt_.text = var_13_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_24 = arg_10_1:GetWordFromCfg(411171002)
				local var_13_25 = arg_10_1:FormatText(var_13_24.content)

				arg_10_1.text_.text = var_13_25

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_26 = 36
				local var_13_27 = utf8.len(var_13_25)
				local var_13_28 = var_13_26 <= 0 and var_13_22 or var_13_22 * (var_13_27 / var_13_26)

				if var_13_28 > 0 and var_13_22 < var_13_28 then
					arg_10_1.talkMaxDuration = var_13_28

					if var_13_28 + var_13_21 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_28 + var_13_21
					end
				end

				arg_10_1.text_.text = var_13_25
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171002", "story_v_out_411171.awb") ~= 0 then
					local var_13_29 = manager.audio:GetVoiceLength("story_v_out_411171", "411171002", "story_v_out_411171.awb") / 1000

					if var_13_29 + var_13_21 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_29 + var_13_21
					end

					if var_13_24.prefab_name ~= "" and arg_10_1.actors_[var_13_24.prefab_name] ~= nil then
						local var_13_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_24.prefab_name].transform, "story_v_out_411171", "411171002", "story_v_out_411171.awb")

						arg_10_1:RecordAudio("411171002", var_13_30)
						arg_10_1:RecordAudio("411171002", var_13_30)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_411171", "411171002", "story_v_out_411171.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_411171", "411171002", "story_v_out_411171.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_31 = math.max(var_13_22, arg_10_1.talkMaxDuration)

			if var_13_21 <= arg_10_1.time_ and arg_10_1.time_ < var_13_21 + var_13_31 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_21) / var_13_31

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_21 + var_13_31 and arg_10_1.time_ < var_13_21 + var_13_31 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play411171003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 411171003
		arg_14_1.duration_ = 2.8

		local var_14_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_14_0:Play411171004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_17_2 = 0
			local var_17_3 = 0.225

			if var_17_2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_4 = arg_14_1:FormatText(StoryNameCfg[714].name)

				arg_14_1.leftNameTxt_.text = var_17_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_5 = arg_14_1:GetWordFromCfg(411171003)
				local var_17_6 = arg_14_1:FormatText(var_17_5.content)

				arg_14_1.text_.text = var_17_6

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_7 = 9
				local var_17_8 = utf8.len(var_17_6)
				local var_17_9 = var_17_7 <= 0 and var_17_3 or var_17_3 * (var_17_8 / var_17_7)

				if var_17_9 > 0 and var_17_3 < var_17_9 then
					arg_14_1.talkMaxDuration = var_17_9

					if var_17_9 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_9 + var_17_2
					end
				end

				arg_14_1.text_.text = var_17_6
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171003", "story_v_out_411171.awb") ~= 0 then
					local var_17_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171003", "story_v_out_411171.awb") / 1000

					if var_17_10 + var_17_2 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_10 + var_17_2
					end

					if var_17_5.prefab_name ~= "" and arg_14_1.actors_[var_17_5.prefab_name] ~= nil then
						local var_17_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_5.prefab_name].transform, "story_v_out_411171", "411171003", "story_v_out_411171.awb")

						arg_14_1:RecordAudio("411171003", var_17_11)
						arg_14_1:RecordAudio("411171003", var_17_11)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_411171", "411171003", "story_v_out_411171.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_411171", "411171003", "story_v_out_411171.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_12 = math.max(var_17_3, arg_14_1.talkMaxDuration)

			if var_17_2 <= arg_14_1.time_ and arg_14_1.time_ < var_17_2 + var_17_12 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_2) / var_17_12

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_2 + var_17_12 and arg_14_1.time_ < var_17_2 + var_17_12 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play411171004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 411171004
		arg_18_1.duration_ = 9.7

		local var_18_0 = {
			zh = 5.133,
			ja = 9.7
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
				arg_18_0:Play411171005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "2078ui_story"

			if arg_18_1.actors_[var_21_0] == nil then
				local var_21_1 = Asset.Load("Char/" .. "2078ui_story")

				if not isNil(var_21_1) then
					local var_21_2 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_18_1.stage_.transform)

					var_21_2.name = var_21_0
					var_21_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_18_1.actors_[var_21_0] = var_21_2

					local var_21_3 = var_21_2:GetComponentInChildren(typeof(CharacterEffect))

					var_21_3.enabled = true

					local var_21_4 = GameObjectTools.GetOrAddComponent(var_21_2, typeof(DynamicBoneHelper))

					if var_21_4 then
						var_21_4:EnableDynamicBone(false)
					end

					arg_18_1:ShowWeapon(var_21_3.transform, false)

					arg_18_1.var_[var_21_0 .. "Animator"] = var_21_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_18_1.var_[var_21_0 .. "Animator"].applyRootMotion = true
					arg_18_1.var_[var_21_0 .. "LipSync"] = var_21_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_21_5 = arg_18_1.actors_["2078ui_story"].transform
			local var_21_6 = 0

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.var_.moveOldPos2078ui_story = var_21_5.localPosition
			end

			local var_21_7 = 0.001

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_7 then
				local var_21_8 = (arg_18_1.time_ - var_21_6) / var_21_7
				local var_21_9 = Vector3.New(0, -1.28, -5.6)

				var_21_5.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos2078ui_story, var_21_9, var_21_8)

				local var_21_10 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_10.x, var_21_10.y, var_21_10.z)

				local var_21_11 = var_21_5.localEulerAngles

				var_21_11.z = 0
				var_21_11.x = 0
				var_21_5.localEulerAngles = var_21_11
			end

			if arg_18_1.time_ >= var_21_6 + var_21_7 and arg_18_1.time_ < var_21_6 + var_21_7 + arg_21_0 then
				var_21_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_21_12 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_12.x, var_21_12.y, var_21_12.z)

				local var_21_13 = var_21_5.localEulerAngles

				var_21_13.z = 0
				var_21_13.x = 0
				var_21_5.localEulerAngles = var_21_13
			end

			local var_21_14 = arg_18_1.actors_["2078ui_story"]
			local var_21_15 = 0

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 and not isNil(var_21_14) and arg_18_1.var_.characterEffect2078ui_story == nil then
				arg_18_1.var_.characterEffect2078ui_story = var_21_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_16 = 0.200000002980232

			if var_21_15 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_16 and not isNil(var_21_14) then
				local var_21_17 = (arg_18_1.time_ - var_21_15) / var_21_16

				if arg_18_1.var_.characterEffect2078ui_story and not isNil(var_21_14) then
					arg_18_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_15 + var_21_16 and arg_18_1.time_ < var_21_15 + var_21_16 + arg_21_0 and not isNil(var_21_14) and arg_18_1.var_.characterEffect2078ui_story then
				arg_18_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_21_18 = 0

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				arg_18_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_21_19 = 0

			if var_21_19 < arg_18_1.time_ and arg_18_1.time_ <= var_21_19 + arg_21_0 then
				arg_18_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_21_20 = arg_18_1.actors_["1024ui_story"].transform
			local var_21_21 = 0

			if var_21_21 < arg_18_1.time_ and arg_18_1.time_ <= var_21_21 + arg_21_0 then
				arg_18_1.var_.moveOldPos1024ui_story = var_21_20.localPosition
			end

			local var_21_22 = 0.001

			if var_21_21 <= arg_18_1.time_ and arg_18_1.time_ < var_21_21 + var_21_22 then
				local var_21_23 = (arg_18_1.time_ - var_21_21) / var_21_22
				local var_21_24 = Vector3.New(0, 100, 0)

				var_21_20.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1024ui_story, var_21_24, var_21_23)

				local var_21_25 = manager.ui.mainCamera.transform.position - var_21_20.position

				var_21_20.forward = Vector3.New(var_21_25.x, var_21_25.y, var_21_25.z)

				local var_21_26 = var_21_20.localEulerAngles

				var_21_26.z = 0
				var_21_26.x = 0
				var_21_20.localEulerAngles = var_21_26
			end

			if arg_18_1.time_ >= var_21_21 + var_21_22 and arg_18_1.time_ < var_21_21 + var_21_22 + arg_21_0 then
				var_21_20.localPosition = Vector3.New(0, 100, 0)

				local var_21_27 = manager.ui.mainCamera.transform.position - var_21_20.position

				var_21_20.forward = Vector3.New(var_21_27.x, var_21_27.y, var_21_27.z)

				local var_21_28 = var_21_20.localEulerAngles

				var_21_28.z = 0
				var_21_28.x = 0
				var_21_20.localEulerAngles = var_21_28
			end

			local var_21_29 = arg_18_1.actors_["1024ui_story"]
			local var_21_30 = 0

			if var_21_30 < arg_18_1.time_ and arg_18_1.time_ <= var_21_30 + arg_21_0 and not isNil(var_21_29) and arg_18_1.var_.characterEffect1024ui_story == nil then
				arg_18_1.var_.characterEffect1024ui_story = var_21_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_31 = 0.200000002980232

			if var_21_30 <= arg_18_1.time_ and arg_18_1.time_ < var_21_30 + var_21_31 and not isNil(var_21_29) then
				local var_21_32 = (arg_18_1.time_ - var_21_30) / var_21_31

				if arg_18_1.var_.characterEffect1024ui_story and not isNil(var_21_29) then
					local var_21_33 = Mathf.Lerp(0, 0.5, var_21_32)

					arg_18_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_18_1.var_.characterEffect1024ui_story.fillRatio = var_21_33
				end
			end

			if arg_18_1.time_ >= var_21_30 + var_21_31 and arg_18_1.time_ < var_21_30 + var_21_31 + arg_21_0 and not isNil(var_21_29) and arg_18_1.var_.characterEffect1024ui_story then
				local var_21_34 = 0.5

				arg_18_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_18_1.var_.characterEffect1024ui_story.fillRatio = var_21_34
			end

			local var_21_35 = 0
			local var_21_36 = 0.575

			if var_21_35 < arg_18_1.time_ and arg_18_1.time_ <= var_21_35 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_37 = arg_18_1:FormatText(StoryNameCfg[710].name)

				arg_18_1.leftNameTxt_.text = var_21_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_38 = arg_18_1:GetWordFromCfg(411171004)
				local var_21_39 = arg_18_1:FormatText(var_21_38.content)

				arg_18_1.text_.text = var_21_39

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_40 = 23
				local var_21_41 = utf8.len(var_21_39)
				local var_21_42 = var_21_40 <= 0 and var_21_36 or var_21_36 * (var_21_41 / var_21_40)

				if var_21_42 > 0 and var_21_36 < var_21_42 then
					arg_18_1.talkMaxDuration = var_21_42

					if var_21_42 + var_21_35 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_42 + var_21_35
					end
				end

				arg_18_1.text_.text = var_21_39
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171004", "story_v_out_411171.awb") ~= 0 then
					local var_21_43 = manager.audio:GetVoiceLength("story_v_out_411171", "411171004", "story_v_out_411171.awb") / 1000

					if var_21_43 + var_21_35 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_43 + var_21_35
					end

					if var_21_38.prefab_name ~= "" and arg_18_1.actors_[var_21_38.prefab_name] ~= nil then
						local var_21_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_38.prefab_name].transform, "story_v_out_411171", "411171004", "story_v_out_411171.awb")

						arg_18_1:RecordAudio("411171004", var_21_44)
						arg_18_1:RecordAudio("411171004", var_21_44)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_411171", "411171004", "story_v_out_411171.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_411171", "411171004", "story_v_out_411171.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_45 = math.max(var_21_36, arg_18_1.talkMaxDuration)

			if var_21_35 <= arg_18_1.time_ and arg_18_1.time_ < var_21_35 + var_21_45 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_35) / var_21_45

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_35 + var_21_45 and arg_18_1.time_ < var_21_35 + var_21_45 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play411171005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 411171005
		arg_22_1.duration_ = 3.6

		local var_22_0 = {
			zh = 3.6,
			ja = 2.833
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
				arg_22_0:Play411171006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["2078ui_story"].transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPos2078ui_story = var_25_0.localPosition
			end

			local var_25_2 = 0.001

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2
				local var_25_4 = Vector3.New(0.7, -1.28, -5.6)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos2078ui_story, var_25_4, var_25_3)

				local var_25_5 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_5.x, var_25_5.y, var_25_5.z)

				local var_25_6 = var_25_0.localEulerAngles

				var_25_6.z = 0
				var_25_6.x = 0
				var_25_0.localEulerAngles = var_25_6
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_25_7 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_7.x, var_25_7.y, var_25_7.z)

				local var_25_8 = var_25_0.localEulerAngles

				var_25_8.z = 0
				var_25_8.x = 0
				var_25_0.localEulerAngles = var_25_8
			end

			local var_25_9 = arg_22_1.actors_["2078ui_story"]
			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 and not isNil(var_25_9) and arg_22_1.var_.characterEffect2078ui_story == nil then
				arg_22_1.var_.characterEffect2078ui_story = var_25_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_11 = 0.200000002980232

			if var_25_10 <= arg_22_1.time_ and arg_22_1.time_ < var_25_10 + var_25_11 and not isNil(var_25_9) then
				local var_25_12 = (arg_22_1.time_ - var_25_10) / var_25_11

				if arg_22_1.var_.characterEffect2078ui_story and not isNil(var_25_9) then
					local var_25_13 = Mathf.Lerp(0, 0.5, var_25_12)

					arg_22_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_22_1.var_.characterEffect2078ui_story.fillRatio = var_25_13
				end
			end

			if arg_22_1.time_ >= var_25_10 + var_25_11 and arg_22_1.time_ < var_25_10 + var_25_11 + arg_25_0 and not isNil(var_25_9) and arg_22_1.var_.characterEffect2078ui_story then
				local var_25_14 = 0.5

				arg_22_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_22_1.var_.characterEffect2078ui_story.fillRatio = var_25_14
			end

			local var_25_15 = arg_22_1.actors_["1024ui_story"].transform
			local var_25_16 = 0

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.var_.moveOldPos1024ui_story = var_25_15.localPosition
			end

			local var_25_17 = 0.001

			if var_25_16 <= arg_22_1.time_ and arg_22_1.time_ < var_25_16 + var_25_17 then
				local var_25_18 = (arg_22_1.time_ - var_25_16) / var_25_17
				local var_25_19 = Vector3.New(-0.7, -1, -6.05)

				var_25_15.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1024ui_story, var_25_19, var_25_18)

				local var_25_20 = manager.ui.mainCamera.transform.position - var_25_15.position

				var_25_15.forward = Vector3.New(var_25_20.x, var_25_20.y, var_25_20.z)

				local var_25_21 = var_25_15.localEulerAngles

				var_25_21.z = 0
				var_25_21.x = 0
				var_25_15.localEulerAngles = var_25_21
			end

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				var_25_15.localPosition = Vector3.New(-0.7, -1, -6.05)

				local var_25_22 = manager.ui.mainCamera.transform.position - var_25_15.position

				var_25_15.forward = Vector3.New(var_25_22.x, var_25_22.y, var_25_22.z)

				local var_25_23 = var_25_15.localEulerAngles

				var_25_23.z = 0
				var_25_23.x = 0
				var_25_15.localEulerAngles = var_25_23
			end

			local var_25_24 = arg_22_1.actors_["1024ui_story"]
			local var_25_25 = 0

			if var_25_25 < arg_22_1.time_ and arg_22_1.time_ <= var_25_25 + arg_25_0 and not isNil(var_25_24) and arg_22_1.var_.characterEffect1024ui_story == nil then
				arg_22_1.var_.characterEffect1024ui_story = var_25_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_26 = 0.200000002980232

			if var_25_25 <= arg_22_1.time_ and arg_22_1.time_ < var_25_25 + var_25_26 and not isNil(var_25_24) then
				local var_25_27 = (arg_22_1.time_ - var_25_25) / var_25_26

				if arg_22_1.var_.characterEffect1024ui_story and not isNil(var_25_24) then
					arg_22_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_25 + var_25_26 and arg_22_1.time_ < var_25_25 + var_25_26 + arg_25_0 and not isNil(var_25_24) and arg_22_1.var_.characterEffect1024ui_story then
				arg_22_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_25_28 = 0

			if var_25_28 < arg_22_1.time_ and arg_22_1.time_ <= var_25_28 + arg_25_0 then
				arg_22_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_25_29 = 0

			if var_25_29 < arg_22_1.time_ and arg_22_1.time_ <= var_25_29 + arg_25_0 then
				arg_22_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_25_30 = 0
			local var_25_31 = 0.55

			if var_25_30 < arg_22_1.time_ and arg_22_1.time_ <= var_25_30 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_32 = arg_22_1:FormatText(StoryNameCfg[265].name)

				arg_22_1.leftNameTxt_.text = var_25_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_33 = arg_22_1:GetWordFromCfg(411171005)
				local var_25_34 = arg_22_1:FormatText(var_25_33.content)

				arg_22_1.text_.text = var_25_34

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_35 = 22
				local var_25_36 = utf8.len(var_25_34)
				local var_25_37 = var_25_35 <= 0 and var_25_31 or var_25_31 * (var_25_36 / var_25_35)

				if var_25_37 > 0 and var_25_31 < var_25_37 then
					arg_22_1.talkMaxDuration = var_25_37

					if var_25_37 + var_25_30 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_37 + var_25_30
					end
				end

				arg_22_1.text_.text = var_25_34
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171005", "story_v_out_411171.awb") ~= 0 then
					local var_25_38 = manager.audio:GetVoiceLength("story_v_out_411171", "411171005", "story_v_out_411171.awb") / 1000

					if var_25_38 + var_25_30 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_38 + var_25_30
					end

					if var_25_33.prefab_name ~= "" and arg_22_1.actors_[var_25_33.prefab_name] ~= nil then
						local var_25_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_33.prefab_name].transform, "story_v_out_411171", "411171005", "story_v_out_411171.awb")

						arg_22_1:RecordAudio("411171005", var_25_39)
						arg_22_1:RecordAudio("411171005", var_25_39)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_411171", "411171005", "story_v_out_411171.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_411171", "411171005", "story_v_out_411171.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_40 = math.max(var_25_31, arg_22_1.talkMaxDuration)

			if var_25_30 <= arg_22_1.time_ and arg_22_1.time_ < var_25_30 + var_25_40 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_30) / var_25_40

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_30 + var_25_40 and arg_22_1.time_ < var_25_30 + var_25_40 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play411171006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 411171006
		arg_26_1.duration_ = 5.43

		local var_26_0 = {
			zh = 5.433,
			ja = 3.733
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
				arg_26_0:Play411171007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1024ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1024ui_story == nil then
				arg_26_1.var_.characterEffect1024ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1024ui_story and not isNil(var_29_0) then
					local var_29_4 = Mathf.Lerp(0, 0.5, var_29_3)

					arg_26_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1024ui_story.fillRatio = var_29_4
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1024ui_story then
				local var_29_5 = 0.5

				arg_26_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1024ui_story.fillRatio = var_29_5
			end

			local var_29_6 = arg_26_1.actors_["2078ui_story"]
			local var_29_7 = 0

			if var_29_7 < arg_26_1.time_ and arg_26_1.time_ <= var_29_7 + arg_29_0 and not isNil(var_29_6) and arg_26_1.var_.characterEffect2078ui_story == nil then
				arg_26_1.var_.characterEffect2078ui_story = var_29_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_8 = 0.200000002980232

			if var_29_7 <= arg_26_1.time_ and arg_26_1.time_ < var_29_7 + var_29_8 and not isNil(var_29_6) then
				local var_29_9 = (arg_26_1.time_ - var_29_7) / var_29_8

				if arg_26_1.var_.characterEffect2078ui_story and not isNil(var_29_6) then
					arg_26_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_7 + var_29_8 and arg_26_1.time_ < var_29_7 + var_29_8 + arg_29_0 and not isNil(var_29_6) and arg_26_1.var_.characterEffect2078ui_story then
				arg_26_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_29_10 = 0
			local var_29_11 = 0.75

			if var_29_10 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_12 = arg_26_1:FormatText(StoryNameCfg[710].name)

				arg_26_1.leftNameTxt_.text = var_29_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_13 = arg_26_1:GetWordFromCfg(411171006)
				local var_29_14 = arg_26_1:FormatText(var_29_13.content)

				arg_26_1.text_.text = var_29_14

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_15 = 30
				local var_29_16 = utf8.len(var_29_14)
				local var_29_17 = var_29_15 <= 0 and var_29_11 or var_29_11 * (var_29_16 / var_29_15)

				if var_29_17 > 0 and var_29_11 < var_29_17 then
					arg_26_1.talkMaxDuration = var_29_17

					if var_29_17 + var_29_10 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_17 + var_29_10
					end
				end

				arg_26_1.text_.text = var_29_14
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171006", "story_v_out_411171.awb") ~= 0 then
					local var_29_18 = manager.audio:GetVoiceLength("story_v_out_411171", "411171006", "story_v_out_411171.awb") / 1000

					if var_29_18 + var_29_10 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_18 + var_29_10
					end

					if var_29_13.prefab_name ~= "" and arg_26_1.actors_[var_29_13.prefab_name] ~= nil then
						local var_29_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_13.prefab_name].transform, "story_v_out_411171", "411171006", "story_v_out_411171.awb")

						arg_26_1:RecordAudio("411171006", var_29_19)
						arg_26_1:RecordAudio("411171006", var_29_19)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_411171", "411171006", "story_v_out_411171.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_411171", "411171006", "story_v_out_411171.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_20 = math.max(var_29_11, arg_26_1.talkMaxDuration)

			if var_29_10 <= arg_26_1.time_ and arg_26_1.time_ < var_29_10 + var_29_20 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_10) / var_29_20

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_10 + var_29_20 and arg_26_1.time_ < var_29_10 + var_29_20 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play411171007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 411171007
		arg_30_1.duration_ = 1.13

		local var_30_0 = {
			zh = 0.999999999999,
			ja = 1.133
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
				arg_30_0:Play411171008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["2078ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect2078ui_story == nil then
				arg_30_1.var_.characterEffect2078ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect2078ui_story and not isNil(var_33_0) then
					local var_33_4 = Mathf.Lerp(0, 0.5, var_33_3)

					arg_30_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_30_1.var_.characterEffect2078ui_story.fillRatio = var_33_4
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect2078ui_story then
				local var_33_5 = 0.5

				arg_30_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_30_1.var_.characterEffect2078ui_story.fillRatio = var_33_5
			end

			local var_33_6 = arg_30_1.actors_["1024ui_story"]
			local var_33_7 = 0

			if var_33_7 < arg_30_1.time_ and arg_30_1.time_ <= var_33_7 + arg_33_0 and not isNil(var_33_6) and arg_30_1.var_.characterEffect1024ui_story == nil then
				arg_30_1.var_.characterEffect1024ui_story = var_33_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_8 = 0.200000002980232

			if var_33_7 <= arg_30_1.time_ and arg_30_1.time_ < var_33_7 + var_33_8 and not isNil(var_33_6) then
				local var_33_9 = (arg_30_1.time_ - var_33_7) / var_33_8

				if arg_30_1.var_.characterEffect1024ui_story and not isNil(var_33_6) then
					arg_30_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_7 + var_33_8 and arg_30_1.time_ < var_33_7 + var_33_8 + arg_33_0 and not isNil(var_33_6) and arg_30_1.var_.characterEffect1024ui_story then
				arg_30_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_33_10 = 0
			local var_33_11 = 0.05

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_12 = arg_30_1:FormatText(StoryNameCfg[265].name)

				arg_30_1.leftNameTxt_.text = var_33_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_13 = arg_30_1:GetWordFromCfg(411171007)
				local var_33_14 = arg_30_1:FormatText(var_33_13.content)

				arg_30_1.text_.text = var_33_14

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_15 = 2
				local var_33_16 = utf8.len(var_33_14)
				local var_33_17 = var_33_15 <= 0 and var_33_11 or var_33_11 * (var_33_16 / var_33_15)

				if var_33_17 > 0 and var_33_11 < var_33_17 then
					arg_30_1.talkMaxDuration = var_33_17

					if var_33_17 + var_33_10 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_17 + var_33_10
					end
				end

				arg_30_1.text_.text = var_33_14
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171007", "story_v_out_411171.awb") ~= 0 then
					local var_33_18 = manager.audio:GetVoiceLength("story_v_out_411171", "411171007", "story_v_out_411171.awb") / 1000

					if var_33_18 + var_33_10 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_18 + var_33_10
					end

					if var_33_13.prefab_name ~= "" and arg_30_1.actors_[var_33_13.prefab_name] ~= nil then
						local var_33_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_13.prefab_name].transform, "story_v_out_411171", "411171007", "story_v_out_411171.awb")

						arg_30_1:RecordAudio("411171007", var_33_19)
						arg_30_1:RecordAudio("411171007", var_33_19)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_411171", "411171007", "story_v_out_411171.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_411171", "411171007", "story_v_out_411171.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_20 = math.max(var_33_11, arg_30_1.talkMaxDuration)

			if var_33_10 <= arg_30_1.time_ and arg_30_1.time_ < var_33_10 + var_33_20 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_10) / var_33_20

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_10 + var_33_20 and arg_30_1.time_ < var_33_10 + var_33_20 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play411171008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 411171008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play411171009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["2078ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos2078ui_story = var_37_0.localPosition
			end

			local var_37_2 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2
				local var_37_4 = Vector3.New(0, 100, 0)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos2078ui_story, var_37_4, var_37_3)

				local var_37_5 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_5.x, var_37_5.y, var_37_5.z)

				local var_37_6 = var_37_0.localEulerAngles

				var_37_6.z = 0
				var_37_6.x = 0
				var_37_0.localEulerAngles = var_37_6
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(0, 100, 0)

				local var_37_7 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_7.x, var_37_7.y, var_37_7.z)

				local var_37_8 = var_37_0.localEulerAngles

				var_37_8.z = 0
				var_37_8.x = 0
				var_37_0.localEulerAngles = var_37_8
			end

			local var_37_9 = arg_34_1.actors_["2078ui_story"]
			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect2078ui_story == nil then
				arg_34_1.var_.characterEffect2078ui_story = var_37_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_11 = 0.200000002980232

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_11 and not isNil(var_37_9) then
				local var_37_12 = (arg_34_1.time_ - var_37_10) / var_37_11

				if arg_34_1.var_.characterEffect2078ui_story and not isNil(var_37_9) then
					local var_37_13 = Mathf.Lerp(0, 0.5, var_37_12)

					arg_34_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_34_1.var_.characterEffect2078ui_story.fillRatio = var_37_13
				end
			end

			if arg_34_1.time_ >= var_37_10 + var_37_11 and arg_34_1.time_ < var_37_10 + var_37_11 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect2078ui_story then
				local var_37_14 = 0.5

				arg_34_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_34_1.var_.characterEffect2078ui_story.fillRatio = var_37_14
			end

			local var_37_15 = arg_34_1.actors_["1024ui_story"].transform
			local var_37_16 = 0

			if var_37_16 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1.var_.moveOldPos1024ui_story = var_37_15.localPosition
			end

			local var_37_17 = 0.001

			if var_37_16 <= arg_34_1.time_ and arg_34_1.time_ < var_37_16 + var_37_17 then
				local var_37_18 = (arg_34_1.time_ - var_37_16) / var_37_17
				local var_37_19 = Vector3.New(0, 100, 0)

				var_37_15.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1024ui_story, var_37_19, var_37_18)

				local var_37_20 = manager.ui.mainCamera.transform.position - var_37_15.position

				var_37_15.forward = Vector3.New(var_37_20.x, var_37_20.y, var_37_20.z)

				local var_37_21 = var_37_15.localEulerAngles

				var_37_21.z = 0
				var_37_21.x = 0
				var_37_15.localEulerAngles = var_37_21
			end

			if arg_34_1.time_ >= var_37_16 + var_37_17 and arg_34_1.time_ < var_37_16 + var_37_17 + arg_37_0 then
				var_37_15.localPosition = Vector3.New(0, 100, 0)

				local var_37_22 = manager.ui.mainCamera.transform.position - var_37_15.position

				var_37_15.forward = Vector3.New(var_37_22.x, var_37_22.y, var_37_22.z)

				local var_37_23 = var_37_15.localEulerAngles

				var_37_23.z = 0
				var_37_23.x = 0
				var_37_15.localEulerAngles = var_37_23
			end

			local var_37_24 = arg_34_1.actors_["1024ui_story"]
			local var_37_25 = 0

			if var_37_25 < arg_34_1.time_ and arg_34_1.time_ <= var_37_25 + arg_37_0 and not isNil(var_37_24) and arg_34_1.var_.characterEffect1024ui_story == nil then
				arg_34_1.var_.characterEffect1024ui_story = var_37_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_26 = 0.200000002980232

			if var_37_25 <= arg_34_1.time_ and arg_34_1.time_ < var_37_25 + var_37_26 and not isNil(var_37_24) then
				local var_37_27 = (arg_34_1.time_ - var_37_25) / var_37_26

				if arg_34_1.var_.characterEffect1024ui_story and not isNil(var_37_24) then
					local var_37_28 = Mathf.Lerp(0, 0.5, var_37_27)

					arg_34_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1024ui_story.fillRatio = var_37_28
				end
			end

			if arg_34_1.time_ >= var_37_25 + var_37_26 and arg_34_1.time_ < var_37_25 + var_37_26 + arg_37_0 and not isNil(var_37_24) and arg_34_1.var_.characterEffect1024ui_story then
				local var_37_29 = 0.5

				arg_34_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1024ui_story.fillRatio = var_37_29
			end

			local var_37_30 = 0
			local var_37_31 = 0.85

			if var_37_30 < arg_34_1.time_ and arg_34_1.time_ <= var_37_30 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_32 = arg_34_1:GetWordFromCfg(411171008)
				local var_37_33 = arg_34_1:FormatText(var_37_32.content)

				arg_34_1.text_.text = var_37_33

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_34 = 34
				local var_37_35 = utf8.len(var_37_33)
				local var_37_36 = var_37_34 <= 0 and var_37_31 or var_37_31 * (var_37_35 / var_37_34)

				if var_37_36 > 0 and var_37_31 < var_37_36 then
					arg_34_1.talkMaxDuration = var_37_36

					if var_37_36 + var_37_30 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_36 + var_37_30
					end
				end

				arg_34_1.text_.text = var_37_33
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_37 = math.max(var_37_31, arg_34_1.talkMaxDuration)

			if var_37_30 <= arg_34_1.time_ and arg_34_1.time_ < var_37_30 + var_37_37 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_30) / var_37_37

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_30 + var_37_37 and arg_34_1.time_ < var_37_30 + var_37_37 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play411171009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 411171009
		arg_38_1.duration_ = 5.75

		local var_38_0 = {
			zh = 5.41666666666667,
			ja = 5.74966666666667
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
				arg_38_0:Play411171010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["2078ui_story"].transform
			local var_41_1 = 3.30274141416885

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.moveOldPos2078ui_story = var_41_0.localPosition
			end

			local var_41_2 = 0.001

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2
				local var_41_4 = Vector3.New(0, -1.28, -5.6)

				var_41_0.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos2078ui_story, var_41_4, var_41_3)

				local var_41_5 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_5.x, var_41_5.y, var_41_5.z)

				local var_41_6 = var_41_0.localEulerAngles

				var_41_6.z = 0
				var_41_6.x = 0
				var_41_0.localEulerAngles = var_41_6
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 then
				var_41_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_41_7 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_7.x, var_41_7.y, var_41_7.z)

				local var_41_8 = var_41_0.localEulerAngles

				var_41_8.z = 0
				var_41_8.x = 0
				var_41_0.localEulerAngles = var_41_8
			end

			local var_41_9 = arg_38_1.actors_["2078ui_story"]
			local var_41_10 = 3.30274141416885

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 and not isNil(var_41_9) and arg_38_1.var_.characterEffect2078ui_story == nil then
				arg_38_1.var_.characterEffect2078ui_story = var_41_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_11 = 0.200000002980232

			if var_41_10 <= arg_38_1.time_ and arg_38_1.time_ < var_41_10 + var_41_11 and not isNil(var_41_9) then
				local var_41_12 = (arg_38_1.time_ - var_41_10) / var_41_11

				if arg_38_1.var_.characterEffect2078ui_story and not isNil(var_41_9) then
					arg_38_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_10 + var_41_11 and arg_38_1.time_ < var_41_10 + var_41_11 + arg_41_0 and not isNil(var_41_9) and arg_38_1.var_.characterEffect2078ui_story then
				arg_38_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_41_13 = 3.30274141416885

			if var_41_13 < arg_38_1.time_ and arg_38_1.time_ <= var_41_13 + arg_41_0 then
				arg_38_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_41_14 = 3.30274141416885

			if var_41_14 < arg_38_1.time_ and arg_38_1.time_ <= var_41_14 + arg_41_0 then
				arg_38_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_41_15 = 2

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				local var_41_16 = manager.ui.mainCamera.transform.localPosition
				local var_41_17 = Vector3.New(0, 0, 10) + Vector3.New(var_41_16.x, var_41_16.y, 0)
				local var_41_18 = arg_38_1.bgs_.B10b

				var_41_18.transform.localPosition = var_41_17
				var_41_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_19 = var_41_18:GetComponent("SpriteRenderer")

				if var_41_19 and var_41_19.sprite then
					local var_41_20 = (var_41_18.transform.localPosition - var_41_16).z
					local var_41_21 = manager.ui.mainCameraCom_
					local var_41_22 = 2 * var_41_20 * Mathf.Tan(var_41_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_41_23 = var_41_22 * var_41_21.aspect
					local var_41_24 = var_41_19.sprite.bounds.size.x
					local var_41_25 = var_41_19.sprite.bounds.size.y
					local var_41_26 = var_41_23 / var_41_24
					local var_41_27 = var_41_22 / var_41_25
					local var_41_28 = var_41_27 < var_41_26 and var_41_26 or var_41_27

					var_41_18.transform.localScale = Vector3.New(var_41_28, var_41_28, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "B10b" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_29 = 0

			if var_41_29 < arg_38_1.time_ and arg_38_1.time_ <= var_41_29 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_30 = 2

			if var_41_29 <= arg_38_1.time_ and arg_38_1.time_ < var_41_29 + var_41_30 then
				local var_41_31 = (arg_38_1.time_ - var_41_29) / var_41_30
				local var_41_32 = Color.New(0, 0, 0)

				var_41_32.a = Mathf.Lerp(0, 1, var_41_31)
				arg_38_1.mask_.color = var_41_32
			end

			if arg_38_1.time_ >= var_41_29 + var_41_30 and arg_38_1.time_ < var_41_29 + var_41_30 + arg_41_0 then
				local var_41_33 = Color.New(0, 0, 0)

				var_41_33.a = 1
				arg_38_1.mask_.color = var_41_33
			end

			local var_41_34 = 2

			if var_41_34 < arg_38_1.time_ and arg_38_1.time_ <= var_41_34 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_35 = 1.41666666666667

			if var_41_34 <= arg_38_1.time_ and arg_38_1.time_ < var_41_34 + var_41_35 then
				local var_41_36 = (arg_38_1.time_ - var_41_34) / var_41_35
				local var_41_37 = Color.New(0, 0, 0)

				var_41_37.a = Mathf.Lerp(1, 0, var_41_36)
				arg_38_1.mask_.color = var_41_37
			end

			if arg_38_1.time_ >= var_41_34 + var_41_35 and arg_38_1.time_ < var_41_34 + var_41_35 + arg_41_0 then
				local var_41_38 = Color.New(0, 0, 0)
				local var_41_39 = 0

				arg_38_1.mask_.enabled = false
				var_41_38.a = var_41_39
				arg_38_1.mask_.color = var_41_38
			end

			local var_41_40 = arg_38_1.actors_["2078ui_story"].transform
			local var_41_41 = 2

			if var_41_41 < arg_38_1.time_ and arg_38_1.time_ <= var_41_41 + arg_41_0 then
				arg_38_1.var_.moveOldPos2078ui_story = var_41_40.localPosition
			end

			local var_41_42 = 0.001

			if var_41_41 <= arg_38_1.time_ and arg_38_1.time_ < var_41_41 + var_41_42 then
				local var_41_43 = (arg_38_1.time_ - var_41_41) / var_41_42
				local var_41_44 = Vector3.New(0, 100, 0)

				var_41_40.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos2078ui_story, var_41_44, var_41_43)

				local var_41_45 = manager.ui.mainCamera.transform.position - var_41_40.position

				var_41_40.forward = Vector3.New(var_41_45.x, var_41_45.y, var_41_45.z)

				local var_41_46 = var_41_40.localEulerAngles

				var_41_46.z = 0
				var_41_46.x = 0
				var_41_40.localEulerAngles = var_41_46
			end

			if arg_38_1.time_ >= var_41_41 + var_41_42 and arg_38_1.time_ < var_41_41 + var_41_42 + arg_41_0 then
				var_41_40.localPosition = Vector3.New(0, 100, 0)

				local var_41_47 = manager.ui.mainCamera.transform.position - var_41_40.position

				var_41_40.forward = Vector3.New(var_41_47.x, var_41_47.y, var_41_47.z)

				local var_41_48 = var_41_40.localEulerAngles

				var_41_48.z = 0
				var_41_48.x = 0
				var_41_40.localEulerAngles = var_41_48
			end

			local var_41_49 = arg_38_1.actors_["1024ui_story"].transform
			local var_41_50 = 2

			if var_41_50 < arg_38_1.time_ and arg_38_1.time_ <= var_41_50 + arg_41_0 then
				arg_38_1.var_.moveOldPos1024ui_story = var_41_49.localPosition
			end

			local var_41_51 = 0.001

			if var_41_50 <= arg_38_1.time_ and arg_38_1.time_ < var_41_50 + var_41_51 then
				local var_41_52 = (arg_38_1.time_ - var_41_50) / var_41_51
				local var_41_53 = Vector3.New(0, 100, 0)

				var_41_49.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1024ui_story, var_41_53, var_41_52)

				local var_41_54 = manager.ui.mainCamera.transform.position - var_41_49.position

				var_41_49.forward = Vector3.New(var_41_54.x, var_41_54.y, var_41_54.z)

				local var_41_55 = var_41_49.localEulerAngles

				var_41_55.z = 0
				var_41_55.x = 0
				var_41_49.localEulerAngles = var_41_55
			end

			if arg_38_1.time_ >= var_41_50 + var_41_51 and arg_38_1.time_ < var_41_50 + var_41_51 + arg_41_0 then
				var_41_49.localPosition = Vector3.New(0, 100, 0)

				local var_41_56 = manager.ui.mainCamera.transform.position - var_41_49.position

				var_41_49.forward = Vector3.New(var_41_56.x, var_41_56.y, var_41_56.z)

				local var_41_57 = var_41_49.localEulerAngles

				var_41_57.z = 0
				var_41_57.x = 0
				var_41_49.localEulerAngles = var_41_57
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_58 = 3.41666666666667
			local var_41_59 = 0.275

			if var_41_58 < arg_38_1.time_ and arg_38_1.time_ <= var_41_58 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_60 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_60:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_38_1.dialogCg_.alpha = arg_42_0
				end))
				var_41_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_61 = arg_38_1:FormatText(StoryNameCfg[710].name)

				arg_38_1.leftNameTxt_.text = var_41_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_62 = arg_38_1:GetWordFromCfg(411171009)
				local var_41_63 = arg_38_1:FormatText(var_41_62.content)

				arg_38_1.text_.text = var_41_63

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_64 = 11
				local var_41_65 = utf8.len(var_41_63)
				local var_41_66 = var_41_64 <= 0 and var_41_59 or var_41_59 * (var_41_65 / var_41_64)

				if var_41_66 > 0 and var_41_59 < var_41_66 then
					arg_38_1.talkMaxDuration = var_41_66
					var_41_58 = var_41_58 + 0.3

					if var_41_66 + var_41_58 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_66 + var_41_58
					end
				end

				arg_38_1.text_.text = var_41_63
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171009", "story_v_out_411171.awb") ~= 0 then
					local var_41_67 = manager.audio:GetVoiceLength("story_v_out_411171", "411171009", "story_v_out_411171.awb") / 1000

					if var_41_67 + var_41_58 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_67 + var_41_58
					end

					if var_41_62.prefab_name ~= "" and arg_38_1.actors_[var_41_62.prefab_name] ~= nil then
						local var_41_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_62.prefab_name].transform, "story_v_out_411171", "411171009", "story_v_out_411171.awb")

						arg_38_1:RecordAudio("411171009", var_41_68)
						arg_38_1:RecordAudio("411171009", var_41_68)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_411171", "411171009", "story_v_out_411171.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_411171", "411171009", "story_v_out_411171.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_69 = var_41_58 + 0.3
			local var_41_70 = math.max(var_41_59, arg_38_1.talkMaxDuration)

			if var_41_69 <= arg_38_1.time_ and arg_38_1.time_ < var_41_69 + var_41_70 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_69) / var_41_70

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_69 + var_41_70 and arg_38_1.time_ < var_41_69 + var_41_70 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.30274141416885,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play411171010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 411171010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play411171011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1024ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1024ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1024ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1024ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1024ui_story == nil then
				arg_44_1.var_.characterEffect1024ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1024ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1024ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1024ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1024ui_story.fillRatio = var_47_14
			end

			local var_47_15 = arg_44_1.actors_["2078ui_story"].transform
			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.var_.moveOldPos2078ui_story = var_47_15.localPosition
			end

			local var_47_17 = 0.001

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Vector3.New(0, 100, 0)

				var_47_15.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2078ui_story, var_47_19, var_47_18)

				local var_47_20 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_20.x, var_47_20.y, var_47_20.z)

				local var_47_21 = var_47_15.localEulerAngles

				var_47_21.z = 0
				var_47_21.x = 0
				var_47_15.localEulerAngles = var_47_21
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				var_47_15.localPosition = Vector3.New(0, 100, 0)

				local var_47_22 = manager.ui.mainCamera.transform.position - var_47_15.position

				var_47_15.forward = Vector3.New(var_47_22.x, var_47_22.y, var_47_22.z)

				local var_47_23 = var_47_15.localEulerAngles

				var_47_23.z = 0
				var_47_23.x = 0
				var_47_15.localEulerAngles = var_47_23
			end

			local var_47_24 = arg_44_1.actors_["2078ui_story"]
			local var_47_25 = 0

			if var_47_25 < arg_44_1.time_ and arg_44_1.time_ <= var_47_25 + arg_47_0 and not isNil(var_47_24) and arg_44_1.var_.characterEffect2078ui_story == nil then
				arg_44_1.var_.characterEffect2078ui_story = var_47_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_26 = 0.200000002980232

			if var_47_25 <= arg_44_1.time_ and arg_44_1.time_ < var_47_25 + var_47_26 and not isNil(var_47_24) then
				local var_47_27 = (arg_44_1.time_ - var_47_25) / var_47_26

				if arg_44_1.var_.characterEffect2078ui_story and not isNil(var_47_24) then
					local var_47_28 = Mathf.Lerp(0, 0.5, var_47_27)

					arg_44_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_44_1.var_.characterEffect2078ui_story.fillRatio = var_47_28
				end
			end

			if arg_44_1.time_ >= var_47_25 + var_47_26 and arg_44_1.time_ < var_47_25 + var_47_26 + arg_47_0 and not isNil(var_47_24) and arg_44_1.var_.characterEffect2078ui_story then
				local var_47_29 = 0.5

				arg_44_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_44_1.var_.characterEffect2078ui_story.fillRatio = var_47_29
			end

			local var_47_30 = 0
			local var_47_31 = 0.825

			if var_47_30 < arg_44_1.time_ and arg_44_1.time_ <= var_47_30 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_32 = arg_44_1:GetWordFromCfg(411171010)
				local var_47_33 = arg_44_1:FormatText(var_47_32.content)

				arg_44_1.text_.text = var_47_33

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_34 = 33
				local var_47_35 = utf8.len(var_47_33)
				local var_47_36 = var_47_34 <= 0 and var_47_31 or var_47_31 * (var_47_35 / var_47_34)

				if var_47_36 > 0 and var_47_31 < var_47_36 then
					arg_44_1.talkMaxDuration = var_47_36

					if var_47_36 + var_47_30 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_36 + var_47_30
					end
				end

				arg_44_1.text_.text = var_47_33
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_37 = math.max(var_47_31, arg_44_1.talkMaxDuration)

			if var_47_30 <= arg_44_1.time_ and arg_44_1.time_ < var_47_30 + var_47_37 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_30) / var_47_37

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_30 + var_47_37 and arg_44_1.time_ < var_47_30 + var_47_37 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play411171011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 411171011
		arg_48_1.duration_ = 2

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play411171012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1024ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1024ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, -1, -6.05)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1024ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1024ui_story"]
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1024ui_story == nil then
				arg_48_1.var_.characterEffect1024ui_story = var_51_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 and not isNil(var_51_9) then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11

				if arg_48_1.var_.characterEffect1024ui_story and not isNil(var_51_9) then
					arg_48_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 and not isNil(var_51_9) and arg_48_1.var_.characterEffect1024ui_story then
				arg_48_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_51_15 = 0
			local var_51_16 = 0.125

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[265].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(411171011)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 5
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171011", "story_v_out_411171.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171011", "story_v_out_411171.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_out_411171", "411171011", "story_v_out_411171.awb")

						arg_48_1:RecordAudio("411171011", var_51_24)
						arg_48_1:RecordAudio("411171011", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_411171", "411171011", "story_v_out_411171.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_411171", "411171011", "story_v_out_411171.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_25 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_25 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_25

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_25 and arg_48_1.time_ < var_51_15 + var_51_25 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play411171012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 411171012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play411171013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1024ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1024ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1024ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1024ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1024ui_story == nil then
				arg_52_1.var_.characterEffect1024ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1024ui_story and not isNil(var_55_9) then
					local var_55_13 = Mathf.Lerp(0, 0.5, var_55_12)

					arg_52_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1024ui_story.fillRatio = var_55_13
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1024ui_story then
				local var_55_14 = 0.5

				arg_52_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1024ui_story.fillRatio = var_55_14
			end

			local var_55_15 = arg_52_1.actors_["2078ui_story"].transform
			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.var_.moveOldPos2078ui_story = var_55_15.localPosition
			end

			local var_55_17 = 0.001

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_17 then
				local var_55_18 = (arg_52_1.time_ - var_55_16) / var_55_17
				local var_55_19 = Vector3.New(0, 100, 0)

				var_55_15.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2078ui_story, var_55_19, var_55_18)

				local var_55_20 = manager.ui.mainCamera.transform.position - var_55_15.position

				var_55_15.forward = Vector3.New(var_55_20.x, var_55_20.y, var_55_20.z)

				local var_55_21 = var_55_15.localEulerAngles

				var_55_21.z = 0
				var_55_21.x = 0
				var_55_15.localEulerAngles = var_55_21
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				var_55_15.localPosition = Vector3.New(0, 100, 0)

				local var_55_22 = manager.ui.mainCamera.transform.position - var_55_15.position

				var_55_15.forward = Vector3.New(var_55_22.x, var_55_22.y, var_55_22.z)

				local var_55_23 = var_55_15.localEulerAngles

				var_55_23.z = 0
				var_55_23.x = 0
				var_55_15.localEulerAngles = var_55_23
			end

			local var_55_24 = arg_52_1.actors_["2078ui_story"]
			local var_55_25 = 0

			if var_55_25 < arg_52_1.time_ and arg_52_1.time_ <= var_55_25 + arg_55_0 and not isNil(var_55_24) and arg_52_1.var_.characterEffect2078ui_story == nil then
				arg_52_1.var_.characterEffect2078ui_story = var_55_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_26 = 0.200000002980232

			if var_55_25 <= arg_52_1.time_ and arg_52_1.time_ < var_55_25 + var_55_26 and not isNil(var_55_24) then
				local var_55_27 = (arg_52_1.time_ - var_55_25) / var_55_26

				if arg_52_1.var_.characterEffect2078ui_story and not isNil(var_55_24) then
					local var_55_28 = Mathf.Lerp(0, 0.5, var_55_27)

					arg_52_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_52_1.var_.characterEffect2078ui_story.fillRatio = var_55_28
				end
			end

			if arg_52_1.time_ >= var_55_25 + var_55_26 and arg_52_1.time_ < var_55_25 + var_55_26 + arg_55_0 and not isNil(var_55_24) and arg_52_1.var_.characterEffect2078ui_story then
				local var_55_29 = 0.5

				arg_52_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_52_1.var_.characterEffect2078ui_story.fillRatio = var_55_29
			end

			local var_55_30 = 0
			local var_55_31 = 1.1

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_32 = arg_52_1:GetWordFromCfg(411171012)
				local var_55_33 = arg_52_1:FormatText(var_55_32.content)

				arg_52_1.text_.text = var_55_33

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_34 = 44
				local var_55_35 = utf8.len(var_55_33)
				local var_55_36 = var_55_34 <= 0 and var_55_31 or var_55_31 * (var_55_35 / var_55_34)

				if var_55_36 > 0 and var_55_31 < var_55_36 then
					arg_52_1.talkMaxDuration = var_55_36

					if var_55_36 + var_55_30 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_36 + var_55_30
					end
				end

				arg_52_1.text_.text = var_55_33
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_37 = math.max(var_55_31, arg_52_1.talkMaxDuration)

			if var_55_30 <= arg_52_1.time_ and arg_52_1.time_ < var_55_30 + var_55_37 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_30) / var_55_37

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_30 + var_55_37 and arg_52_1.time_ < var_55_30 + var_55_37 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play411171013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 411171013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play411171014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.875

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(411171013)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 35
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play411171014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 411171014
		arg_60_1.duration_ = 5.67

		local var_60_0 = {
			zh = 4.6,
			ja = 5.666
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play411171015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["2078ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos2078ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, -1.28, -5.6)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos2078ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["2078ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect2078ui_story == nil then
				arg_60_1.var_.characterEffect2078ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect2078ui_story and not isNil(var_63_9) then
					arg_60_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect2078ui_story then
				arg_60_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_63_13 = 0

			if var_63_13 < arg_60_1.time_ and arg_60_1.time_ <= var_63_13 + arg_63_0 then
				arg_60_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_15 = 0
			local var_63_16 = 0.625

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[710].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(411171014)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 25
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171014", "story_v_out_411171.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171014", "story_v_out_411171.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_411171", "411171014", "story_v_out_411171.awb")

						arg_60_1:RecordAudio("411171014", var_63_24)
						arg_60_1:RecordAudio("411171014", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_411171", "411171014", "story_v_out_411171.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_411171", "411171014", "story_v_out_411171.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play411171015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 411171015
		arg_64_1.duration_ = 2.7

		local var_64_0 = {
			zh = 2.36666666666667,
			ja = 2.69966666666667
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play411171016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1024ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1024ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, -1, -6.05)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1024ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1024ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1024ui_story == nil then
				arg_64_1.var_.characterEffect1024ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1024ui_story and not isNil(var_67_9) then
					arg_64_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1024ui_story then
				arg_64_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_67_13 = 0

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_1")
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_67_15 = arg_64_1.actors_["2078ui_story"].transform
			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.var_.moveOldPos2078ui_story = var_67_15.localPosition
			end

			local var_67_17 = 0.001

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_17 then
				local var_67_18 = (arg_64_1.time_ - var_67_16) / var_67_17
				local var_67_19 = Vector3.New(0, 100, 0)

				var_67_15.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2078ui_story, var_67_19, var_67_18)

				local var_67_20 = manager.ui.mainCamera.transform.position - var_67_15.position

				var_67_15.forward = Vector3.New(var_67_20.x, var_67_20.y, var_67_20.z)

				local var_67_21 = var_67_15.localEulerAngles

				var_67_21.z = 0
				var_67_21.x = 0
				var_67_15.localEulerAngles = var_67_21
			end

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 then
				var_67_15.localPosition = Vector3.New(0, 100, 0)

				local var_67_22 = manager.ui.mainCamera.transform.position - var_67_15.position

				var_67_15.forward = Vector3.New(var_67_22.x, var_67_22.y, var_67_22.z)

				local var_67_23 = var_67_15.localEulerAngles

				var_67_23.z = 0
				var_67_23.x = 0
				var_67_15.localEulerAngles = var_67_23
			end

			local var_67_24 = arg_64_1.actors_["2078ui_story"]
			local var_67_25 = 0

			if var_67_25 < arg_64_1.time_ and arg_64_1.time_ <= var_67_25 + arg_67_0 and not isNil(var_67_24) and arg_64_1.var_.characterEffect2078ui_story == nil then
				arg_64_1.var_.characterEffect2078ui_story = var_67_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_26 = 0.200000002980232

			if var_67_25 <= arg_64_1.time_ and arg_64_1.time_ < var_67_25 + var_67_26 and not isNil(var_67_24) then
				local var_67_27 = (arg_64_1.time_ - var_67_25) / var_67_26

				if arg_64_1.var_.characterEffect2078ui_story and not isNil(var_67_24) then
					local var_67_28 = Mathf.Lerp(0, 0.5, var_67_27)

					arg_64_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_64_1.var_.characterEffect2078ui_story.fillRatio = var_67_28
				end
			end

			if arg_64_1.time_ >= var_67_25 + var_67_26 and arg_64_1.time_ < var_67_25 + var_67_26 + arg_67_0 and not isNil(var_67_24) and arg_64_1.var_.characterEffect2078ui_story then
				local var_67_29 = 0.5

				arg_64_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_64_1.var_.characterEffect2078ui_story.fillRatio = var_67_29
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_30 = 0.566666666666667
			local var_67_31 = 0.3

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_32 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_32:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_33 = arg_64_1:FormatText(StoryNameCfg[265].name)

				arg_64_1.leftNameTxt_.text = var_67_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_34 = arg_64_1:GetWordFromCfg(411171015)
				local var_67_35 = arg_64_1:FormatText(var_67_34.content)

				arg_64_1.text_.text = var_67_35

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_36 = 12
				local var_67_37 = utf8.len(var_67_35)
				local var_67_38 = var_67_36 <= 0 and var_67_31 or var_67_31 * (var_67_37 / var_67_36)

				if var_67_38 > 0 and var_67_31 < var_67_38 then
					arg_64_1.talkMaxDuration = var_67_38
					var_67_30 = var_67_30 + 0.3

					if var_67_38 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_38 + var_67_30
					end
				end

				arg_64_1.text_.text = var_67_35
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171015", "story_v_out_411171.awb") ~= 0 then
					local var_67_39 = manager.audio:GetVoiceLength("story_v_out_411171", "411171015", "story_v_out_411171.awb") / 1000

					if var_67_39 + var_67_30 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_39 + var_67_30
					end

					if var_67_34.prefab_name ~= "" and arg_64_1.actors_[var_67_34.prefab_name] ~= nil then
						local var_67_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_34.prefab_name].transform, "story_v_out_411171", "411171015", "story_v_out_411171.awb")

						arg_64_1:RecordAudio("411171015", var_67_40)
						arg_64_1:RecordAudio("411171015", var_67_40)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_411171", "411171015", "story_v_out_411171.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_411171", "411171015", "story_v_out_411171.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_41 = var_67_30 + 0.3
			local var_67_42 = math.max(var_67_31, arg_64_1.talkMaxDuration)

			if var_67_41 <= arg_64_1.time_ and arg_64_1.time_ < var_67_41 + var_67_42 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_41) / var_67_42

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_41 + var_67_42 and arg_64_1.time_ < var_67_41 + var_67_42 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play411171016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 411171016
		arg_70_1.duration_ = 11.5

		local var_70_0 = {
			zh = 11.2,
			ja = 11.5
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play411171017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "ST75"

			if arg_70_1.bgs_[var_73_0] == nil then
				local var_73_1 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_0)
				var_73_1.name = var_73_0
				var_73_1.transform.parent = arg_70_1.stage_.transform
				var_73_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_0] = var_73_1
			end

			local var_73_2 = 2

			if var_73_2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				local var_73_3 = manager.ui.mainCamera.transform.localPosition
				local var_73_4 = Vector3.New(0, 0, 10) + Vector3.New(var_73_3.x, var_73_3.y, 0)
				local var_73_5 = arg_70_1.bgs_.ST75

				var_73_5.transform.localPosition = var_73_4
				var_73_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_6 = var_73_5:GetComponent("SpriteRenderer")

				if var_73_6 and var_73_6.sprite then
					local var_73_7 = (var_73_5.transform.localPosition - var_73_3).z
					local var_73_8 = manager.ui.mainCameraCom_
					local var_73_9 = 2 * var_73_7 * Mathf.Tan(var_73_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_73_10 = var_73_9 * var_73_8.aspect
					local var_73_11 = var_73_6.sprite.bounds.size.x
					local var_73_12 = var_73_6.sprite.bounds.size.y
					local var_73_13 = var_73_10 / var_73_11
					local var_73_14 = var_73_9 / var_73_12
					local var_73_15 = var_73_14 < var_73_13 and var_73_13 or var_73_14

					var_73_5.transform.localScale = Vector3.New(var_73_15, var_73_15, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST75" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_16 = 0

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_17 = 2

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_17 then
				local var_73_18 = (arg_70_1.time_ - var_73_16) / var_73_17
				local var_73_19 = Color.New(0, 0, 0)

				var_73_19.a = Mathf.Lerp(0, 1, var_73_18)
				arg_70_1.mask_.color = var_73_19
			end

			if arg_70_1.time_ >= var_73_16 + var_73_17 and arg_70_1.time_ < var_73_16 + var_73_17 + arg_73_0 then
				local var_73_20 = Color.New(0, 0, 0)

				var_73_20.a = 1
				arg_70_1.mask_.color = var_73_20
			end

			local var_73_21 = 2

			if var_73_21 < arg_70_1.time_ and arg_70_1.time_ <= var_73_21 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_22 = 2

			if var_73_21 <= arg_70_1.time_ and arg_70_1.time_ < var_73_21 + var_73_22 then
				local var_73_23 = (arg_70_1.time_ - var_73_21) / var_73_22
				local var_73_24 = Color.New(0, 0, 0)

				var_73_24.a = Mathf.Lerp(1, 0, var_73_23)
				arg_70_1.mask_.color = var_73_24
			end

			if arg_70_1.time_ >= var_73_21 + var_73_22 and arg_70_1.time_ < var_73_21 + var_73_22 + arg_73_0 then
				local var_73_25 = Color.New(0, 0, 0)
				local var_73_26 = 0

				arg_70_1.mask_.enabled = false
				var_73_25.a = var_73_26
				arg_70_1.mask_.color = var_73_25
			end

			local var_73_27 = arg_70_1.actors_["1024ui_story"].transform
			local var_73_28 = 2

			if var_73_28 < arg_70_1.time_ and arg_70_1.time_ <= var_73_28 + arg_73_0 then
				arg_70_1.var_.moveOldPos1024ui_story = var_73_27.localPosition
			end

			local var_73_29 = 0.001

			if var_73_28 <= arg_70_1.time_ and arg_70_1.time_ < var_73_28 + var_73_29 then
				local var_73_30 = (arg_70_1.time_ - var_73_28) / var_73_29
				local var_73_31 = Vector3.New(0, 100, 0)

				var_73_27.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1024ui_story, var_73_31, var_73_30)

				local var_73_32 = manager.ui.mainCamera.transform.position - var_73_27.position

				var_73_27.forward = Vector3.New(var_73_32.x, var_73_32.y, var_73_32.z)

				local var_73_33 = var_73_27.localEulerAngles

				var_73_33.z = 0
				var_73_33.x = 0
				var_73_27.localEulerAngles = var_73_33
			end

			if arg_70_1.time_ >= var_73_28 + var_73_29 and arg_70_1.time_ < var_73_28 + var_73_29 + arg_73_0 then
				var_73_27.localPosition = Vector3.New(0, 100, 0)

				local var_73_34 = manager.ui.mainCamera.transform.position - var_73_27.position

				var_73_27.forward = Vector3.New(var_73_34.x, var_73_34.y, var_73_34.z)

				local var_73_35 = var_73_27.localEulerAngles

				var_73_35.z = 0
				var_73_35.x = 0
				var_73_27.localEulerAngles = var_73_35
			end

			local var_73_36 = manager.ui.mainCamera.transform
			local var_73_37 = 2

			if var_73_37 < arg_70_1.time_ and arg_70_1.time_ <= var_73_37 + arg_73_0 then
				local var_73_38 = arg_70_1.var_.effect工厂雨

				if var_73_38 then
					Object.Destroy(var_73_38)

					arg_70_1.var_.effect工厂雨 = nil
				end
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_39 = 4
			local var_73_40 = 0.875

			if var_73_39 < arg_70_1.time_ and arg_70_1.time_ <= var_73_39 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_41 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_41:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_42 = arg_70_1:FormatText(StoryNameCfg[42].name)

				arg_70_1.leftNameTxt_.text = var_73_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_43 = arg_70_1:GetWordFromCfg(411171016)
				local var_73_44 = arg_70_1:FormatText(var_73_43.content)

				arg_70_1.text_.text = var_73_44

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_45 = 35
				local var_73_46 = utf8.len(var_73_44)
				local var_73_47 = var_73_45 <= 0 and var_73_40 or var_73_40 * (var_73_46 / var_73_45)

				if var_73_47 > 0 and var_73_40 < var_73_47 then
					arg_70_1.talkMaxDuration = var_73_47
					var_73_39 = var_73_39 + 0.3

					if var_73_47 + var_73_39 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_47 + var_73_39
					end
				end

				arg_70_1.text_.text = var_73_44
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171016", "story_v_out_411171.awb") ~= 0 then
					local var_73_48 = manager.audio:GetVoiceLength("story_v_out_411171", "411171016", "story_v_out_411171.awb") / 1000

					if var_73_48 + var_73_39 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_48 + var_73_39
					end

					if var_73_43.prefab_name ~= "" and arg_70_1.actors_[var_73_43.prefab_name] ~= nil then
						local var_73_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_43.prefab_name].transform, "story_v_out_411171", "411171016", "story_v_out_411171.awb")

						arg_70_1:RecordAudio("411171016", var_73_49)
						arg_70_1:RecordAudio("411171016", var_73_49)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_411171", "411171016", "story_v_out_411171.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_411171", "411171016", "story_v_out_411171.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_50 = var_73_39 + 0.3
			local var_73_51 = math.max(var_73_40, arg_70_1.talkMaxDuration)

			if var_73_50 <= arg_70_1.time_ and arg_70_1.time_ < var_73_50 + var_73_51 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_50) / var_73_51

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_50 + var_73_51 and arg_70_1.time_ < var_73_50 + var_73_51 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play411171017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 411171017
		arg_76_1.duration_ = 3.2

		local var_76_0 = {
			zh = 3.2,
			ja = 1.3
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play411171018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = manager.ui.mainCamera.transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.shakeOldPos = var_79_0.localPosition
			end

			local var_79_2 = 0.6

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / 0.066
				local var_79_4, var_79_5 = math.modf(var_79_3)

				var_79_0.localPosition = Vector3.New(var_79_5 * 0.13, var_79_5 * 0.13, var_79_5 * 0.13) + arg_76_1.var_.shakeOldPos
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = arg_76_1.var_.shakeOldPos
			end

			local var_79_6 = 0

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			local var_79_7 = 0.6

			if arg_76_1.time_ >= var_79_6 + var_79_7 and arg_76_1.time_ < var_79_6 + var_79_7 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_8 = 0
			local var_79_9 = 0.175

			if var_79_8 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_10 = arg_76_1:FormatText(StoryNameCfg[42].name)

				arg_76_1.leftNameTxt_.text = var_79_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_11 = arg_76_1:GetWordFromCfg(411171017)
				local var_79_12 = arg_76_1:FormatText(var_79_11.content)

				arg_76_1.text_.text = var_79_12

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 7
				local var_79_14 = utf8.len(var_79_12)
				local var_79_15 = var_79_13 <= 0 and var_79_9 or var_79_9 * (var_79_14 / var_79_13)

				if var_79_15 > 0 and var_79_9 < var_79_15 then
					arg_76_1.talkMaxDuration = var_79_15

					if var_79_15 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_12
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171017", "story_v_out_411171.awb") ~= 0 then
					local var_79_16 = manager.audio:GetVoiceLength("story_v_out_411171", "411171017", "story_v_out_411171.awb") / 1000

					if var_79_16 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_8
					end

					if var_79_11.prefab_name ~= "" and arg_76_1.actors_[var_79_11.prefab_name] ~= nil then
						local var_79_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_11.prefab_name].transform, "story_v_out_411171", "411171017", "story_v_out_411171.awb")

						arg_76_1:RecordAudio("411171017", var_79_17)
						arg_76_1:RecordAudio("411171017", var_79_17)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_411171", "411171017", "story_v_out_411171.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_411171", "411171017", "story_v_out_411171.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_18 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_18 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_18

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_18 and arg_76_1.time_ < var_79_8 + var_79_18 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play411171018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411171018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play411171019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = "4010ui_story"

			if arg_80_1.actors_[var_83_0] == nil then
				local var_83_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_83_1) then
					local var_83_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_80_1.stage_.transform)

					var_83_2.name = var_83_0
					var_83_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_80_1.actors_[var_83_0] = var_83_2

					local var_83_3 = var_83_2:GetComponentInChildren(typeof(CharacterEffect))

					var_83_3.enabled = true

					local var_83_4 = GameObjectTools.GetOrAddComponent(var_83_2, typeof(DynamicBoneHelper))

					if var_83_4 then
						var_83_4:EnableDynamicBone(false)
					end

					arg_80_1:ShowWeapon(var_83_3.transform, false)

					arg_80_1.var_[var_83_0 .. "Animator"] = var_83_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_80_1.var_[var_83_0 .. "Animator"].applyRootMotion = true
					arg_80_1.var_[var_83_0 .. "LipSync"] = var_83_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_83_5 = arg_80_1.actors_["4010ui_story"].transform
			local var_83_6 = 0

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.var_.moveOldPos4010ui_story = var_83_5.localPosition
			end

			local var_83_7 = 0.001

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_7 then
				local var_83_8 = (arg_80_1.time_ - var_83_6) / var_83_7
				local var_83_9 = Vector3.New(0, 100, 0)

				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4010ui_story, var_83_9, var_83_8)

				local var_83_10 = manager.ui.mainCamera.transform.position - var_83_5.position

				var_83_5.forward = Vector3.New(var_83_10.x, var_83_10.y, var_83_10.z)

				local var_83_11 = var_83_5.localEulerAngles

				var_83_11.z = 0
				var_83_11.x = 0
				var_83_5.localEulerAngles = var_83_11
			end

			if arg_80_1.time_ >= var_83_6 + var_83_7 and arg_80_1.time_ < var_83_6 + var_83_7 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(0, 100, 0)

				local var_83_12 = manager.ui.mainCamera.transform.position - var_83_5.position

				var_83_5.forward = Vector3.New(var_83_12.x, var_83_12.y, var_83_12.z)

				local var_83_13 = var_83_5.localEulerAngles

				var_83_13.z = 0
				var_83_13.x = 0
				var_83_5.localEulerAngles = var_83_13
			end

			local var_83_14 = arg_80_1.actors_["4010ui_story"]
			local var_83_15 = 0

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 and not isNil(var_83_14) and arg_80_1.var_.characterEffect4010ui_story == nil then
				arg_80_1.var_.characterEffect4010ui_story = var_83_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_16 = 0.200000002980232

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_16 and not isNil(var_83_14) then
				local var_83_17 = (arg_80_1.time_ - var_83_15) / var_83_16

				if arg_80_1.var_.characterEffect4010ui_story and not isNil(var_83_14) then
					local var_83_18 = Mathf.Lerp(0, 0.5, var_83_17)

					arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_80_1.var_.characterEffect4010ui_story.fillRatio = var_83_18
				end
			end

			if arg_80_1.time_ >= var_83_15 + var_83_16 and arg_80_1.time_ < var_83_15 + var_83_16 + arg_83_0 and not isNil(var_83_14) and arg_80_1.var_.characterEffect4010ui_story then
				local var_83_19 = 0.5

				arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_80_1.var_.characterEffect4010ui_story.fillRatio = var_83_19
			end

			local var_83_20 = 0
			local var_83_21 = 1.125

			if var_83_20 < arg_80_1.time_ and arg_80_1.time_ <= var_83_20 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_22 = arg_80_1:GetWordFromCfg(411171018)
				local var_83_23 = arg_80_1:FormatText(var_83_22.content)

				arg_80_1.text_.text = var_83_23

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_24 = 45
				local var_83_25 = utf8.len(var_83_23)
				local var_83_26 = var_83_24 <= 0 and var_83_21 or var_83_21 * (var_83_25 / var_83_24)

				if var_83_26 > 0 and var_83_21 < var_83_26 then
					arg_80_1.talkMaxDuration = var_83_26

					if var_83_26 + var_83_20 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_26 + var_83_20
					end
				end

				arg_80_1.text_.text = var_83_23
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_27 = math.max(var_83_21, arg_80_1.talkMaxDuration)

			if var_83_20 <= arg_80_1.time_ and arg_80_1.time_ < var_83_20 + var_83_27 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_20) / var_83_27

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_20 + var_83_27 and arg_80_1.time_ < var_83_20 + var_83_27 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play411171019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411171019
		arg_84_1.duration_ = 4

		local var_84_0 = {
			zh = 4,
			ja = 3.3
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
				arg_84_0:Play411171020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["4010ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos4010ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(-0.7, -1.59, -5.2)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos4010ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["4010ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect4010ui_story == nil then
				arg_84_1.var_.characterEffect4010ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect4010ui_story and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect4010ui_story then
				arg_84_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_15 = 0
			local var_87_16 = 0.425

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[42].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(411171019)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 17
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171019", "story_v_out_411171.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171019", "story_v_out_411171.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_out_411171", "411171019", "story_v_out_411171.awb")

						arg_84_1:RecordAudio("411171019", var_87_24)
						arg_84_1:RecordAudio("411171019", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_411171", "411171019", "story_v_out_411171.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_411171", "411171019", "story_v_out_411171.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play411171020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411171020
		arg_88_1.duration_ = 7.23

		local var_88_0 = {
			zh = 6,
			ja = 7.233
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
				arg_88_0:Play411171021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["4010ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect4010ui_story == nil then
				arg_88_1.var_.characterEffect4010ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect4010ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_88_1.var_.characterEffect4010ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect4010ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_88_1.var_.characterEffect4010ui_story.fillRatio = var_91_5
			end

			local var_91_6 = "1095ui_story"

			if arg_88_1.actors_[var_91_6] == nil then
				local var_91_7 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_91_7) then
					local var_91_8 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_88_1.stage_.transform)

					var_91_8.name = var_91_6
					var_91_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_6] = var_91_8

					local var_91_9 = var_91_8:GetComponentInChildren(typeof(CharacterEffect))

					var_91_9.enabled = true

					local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_8, typeof(DynamicBoneHelper))

					if var_91_10 then
						var_91_10:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_9.transform, false)

					arg_88_1.var_[var_91_6 .. "Animator"] = var_91_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_6 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_6 .. "LipSync"] = var_91_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_11 = arg_88_1.actors_["1095ui_story"]
			local var_91_12 = 0

			if var_91_12 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect1095ui_story == nil then
				arg_88_1.var_.characterEffect1095ui_story = var_91_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_13 = 0.200000002980232

			if var_91_12 <= arg_88_1.time_ and arg_88_1.time_ < var_91_12 + var_91_13 and not isNil(var_91_11) then
				local var_91_14 = (arg_88_1.time_ - var_91_12) / var_91_13

				if arg_88_1.var_.characterEffect1095ui_story and not isNil(var_91_11) then
					arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_12 + var_91_13 and arg_88_1.time_ < var_91_12 + var_91_13 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect1095ui_story then
				arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_91_15 = 0

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_91_17 = arg_88_1.actors_["1095ui_story"].transform
			local var_91_18 = 0

			if var_91_18 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.var_.moveOldPos1095ui_story = var_91_17.localPosition
			end

			local var_91_19 = 0.001

			if var_91_18 <= arg_88_1.time_ and arg_88_1.time_ < var_91_18 + var_91_19 then
				local var_91_20 = (arg_88_1.time_ - var_91_18) / var_91_19
				local var_91_21 = Vector3.New(0.7, -0.98, -6.1)

				var_91_17.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1095ui_story, var_91_21, var_91_20)

				local var_91_22 = manager.ui.mainCamera.transform.position - var_91_17.position

				var_91_17.forward = Vector3.New(var_91_22.x, var_91_22.y, var_91_22.z)

				local var_91_23 = var_91_17.localEulerAngles

				var_91_23.z = 0
				var_91_23.x = 0
				var_91_17.localEulerAngles = var_91_23
			end

			if arg_88_1.time_ >= var_91_18 + var_91_19 and arg_88_1.time_ < var_91_18 + var_91_19 + arg_91_0 then
				var_91_17.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_91_24 = manager.ui.mainCamera.transform.position - var_91_17.position

				var_91_17.forward = Vector3.New(var_91_24.x, var_91_24.y, var_91_24.z)

				local var_91_25 = var_91_17.localEulerAngles

				var_91_25.z = 0
				var_91_25.x = 0
				var_91_17.localEulerAngles = var_91_25
			end

			local var_91_26 = 0
			local var_91_27 = 0.625

			if var_91_26 < arg_88_1.time_ and arg_88_1.time_ <= var_91_26 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_28 = arg_88_1:FormatText(StoryNameCfg[471].name)

				arg_88_1.leftNameTxt_.text = var_91_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_29 = arg_88_1:GetWordFromCfg(411171020)
				local var_91_30 = arg_88_1:FormatText(var_91_29.content)

				arg_88_1.text_.text = var_91_30

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_31 = 25
				local var_91_32 = utf8.len(var_91_30)
				local var_91_33 = var_91_31 <= 0 and var_91_27 or var_91_27 * (var_91_32 / var_91_31)

				if var_91_33 > 0 and var_91_27 < var_91_33 then
					arg_88_1.talkMaxDuration = var_91_33

					if var_91_33 + var_91_26 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_33 + var_91_26
					end
				end

				arg_88_1.text_.text = var_91_30
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171020", "story_v_out_411171.awb") ~= 0 then
					local var_91_34 = manager.audio:GetVoiceLength("story_v_out_411171", "411171020", "story_v_out_411171.awb") / 1000

					if var_91_34 + var_91_26 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_34 + var_91_26
					end

					if var_91_29.prefab_name ~= "" and arg_88_1.actors_[var_91_29.prefab_name] ~= nil then
						local var_91_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_29.prefab_name].transform, "story_v_out_411171", "411171020", "story_v_out_411171.awb")

						arg_88_1:RecordAudio("411171020", var_91_35)
						arg_88_1:RecordAudio("411171020", var_91_35)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_411171", "411171020", "story_v_out_411171.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_411171", "411171020", "story_v_out_411171.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_36 = math.max(var_91_27, arg_88_1.talkMaxDuration)

			if var_91_26 <= arg_88_1.time_ and arg_88_1.time_ < var_91_26 + var_91_36 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_26) / var_91_36

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_26 + var_91_36 and arg_88_1.time_ < var_91_26 + var_91_36 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play411171021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411171021
		arg_92_1.duration_ = 3.43

		local var_92_0 = {
			zh = 3.433,
			ja = 2.466
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
				arg_92_0:Play411171022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["4010ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect4010ui_story == nil then
				arg_92_1.var_.characterEffect4010ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect4010ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect4010ui_story then
				arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1095ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1095ui_story == nil then
				arg_92_1.var_.characterEffect1095ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect1095ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1095ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1095ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1095ui_story.fillRatio = var_95_9
			end

			local var_95_10 = 0
			local var_95_11 = 0.35

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_12 = arg_92_1:FormatText(StoryNameCfg[42].name)

				arg_92_1.leftNameTxt_.text = var_95_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_13 = arg_92_1:GetWordFromCfg(411171021)
				local var_95_14 = arg_92_1:FormatText(var_95_13.content)

				arg_92_1.text_.text = var_95_14

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_15 = 14
				local var_95_16 = utf8.len(var_95_14)
				local var_95_17 = var_95_15 <= 0 and var_95_11 or var_95_11 * (var_95_16 / var_95_15)

				if var_95_17 > 0 and var_95_11 < var_95_17 then
					arg_92_1.talkMaxDuration = var_95_17

					if var_95_17 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_17 + var_95_10
					end
				end

				arg_92_1.text_.text = var_95_14
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171021", "story_v_out_411171.awb") ~= 0 then
					local var_95_18 = manager.audio:GetVoiceLength("story_v_out_411171", "411171021", "story_v_out_411171.awb") / 1000

					if var_95_18 + var_95_10 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_10
					end

					if var_95_13.prefab_name ~= "" and arg_92_1.actors_[var_95_13.prefab_name] ~= nil then
						local var_95_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_13.prefab_name].transform, "story_v_out_411171", "411171021", "story_v_out_411171.awb")

						arg_92_1:RecordAudio("411171021", var_95_19)
						arg_92_1:RecordAudio("411171021", var_95_19)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_411171", "411171021", "story_v_out_411171.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_411171", "411171021", "story_v_out_411171.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_20 = math.max(var_95_11, arg_92_1.talkMaxDuration)

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_20 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_10) / var_95_20

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_10 + var_95_20 and arg_92_1.time_ < var_95_10 + var_95_20 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play411171022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 411171022
		arg_96_1.duration_ = 9.5

		local var_96_0 = {
			zh = 4,
			ja = 9.5
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play411171023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["4010ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect4010ui_story == nil then
				arg_96_1.var_.characterEffect4010ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect4010ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_96_1.var_.characterEffect4010ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect4010ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_96_1.var_.characterEffect4010ui_story.fillRatio = var_99_5
			end

			local var_99_6 = arg_96_1.actors_["1095ui_story"]
			local var_99_7 = 0

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1095ui_story == nil then
				arg_96_1.var_.characterEffect1095ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_8 = 0.200000002980232

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_8 and not isNil(var_99_6) then
				local var_99_9 = (arg_96_1.time_ - var_99_7) / var_99_8

				if arg_96_1.var_.characterEffect1095ui_story and not isNil(var_99_6) then
					arg_96_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_7 + var_99_8 and arg_96_1.time_ < var_99_7 + var_99_8 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1095ui_story then
				arg_96_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_99_10 = 0
			local var_99_11 = 0.575

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_12 = arg_96_1:FormatText(StoryNameCfg[471].name)

				arg_96_1.leftNameTxt_.text = var_99_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_13 = arg_96_1:GetWordFromCfg(411171022)
				local var_99_14 = arg_96_1:FormatText(var_99_13.content)

				arg_96_1.text_.text = var_99_14

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 23
				local var_99_16 = utf8.len(var_99_14)
				local var_99_17 = var_99_15 <= 0 and var_99_11 or var_99_11 * (var_99_16 / var_99_15)

				if var_99_17 > 0 and var_99_11 < var_99_17 then
					arg_96_1.talkMaxDuration = var_99_17

					if var_99_17 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_17 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_14
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171022", "story_v_out_411171.awb") ~= 0 then
					local var_99_18 = manager.audio:GetVoiceLength("story_v_out_411171", "411171022", "story_v_out_411171.awb") / 1000

					if var_99_18 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_10
					end

					if var_99_13.prefab_name ~= "" and arg_96_1.actors_[var_99_13.prefab_name] ~= nil then
						local var_99_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_13.prefab_name].transform, "story_v_out_411171", "411171022", "story_v_out_411171.awb")

						arg_96_1:RecordAudio("411171022", var_99_19)
						arg_96_1:RecordAudio("411171022", var_99_19)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_411171", "411171022", "story_v_out_411171.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_411171", "411171022", "story_v_out_411171.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_20 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_20 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_20

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_20 and arg_96_1.time_ < var_99_10 + var_99_20 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play411171023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 411171023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play411171024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1095ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1095ui_story == nil then
				arg_100_1.var_.characterEffect1095ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1095ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1095ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1095ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1095ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.925

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_8 = arg_100_1:GetWordFromCfg(411171023)
				local var_103_9 = arg_100_1:FormatText(var_103_8.content)

				arg_100_1.text_.text = var_103_9

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 37
				local var_103_11 = utf8.len(var_103_9)
				local var_103_12 = var_103_10 <= 0 and var_103_7 or var_103_7 * (var_103_11 / var_103_10)

				if var_103_12 > 0 and var_103_7 < var_103_12 then
					arg_100_1.talkMaxDuration = var_103_12

					if var_103_12 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_12 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_9
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_13 and arg_100_1.time_ < var_103_6 + var_103_13 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play411171024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 411171024
		arg_104_1.duration_ = 7.97

		local var_104_0 = {
			zh = 3.466,
			ja = 7.966
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play411171025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["4010ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect4010ui_story == nil then
				arg_104_1.var_.characterEffect4010ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect4010ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect4010ui_story then
				arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_107_4 = 0
			local var_107_5 = 0.425

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_6 = arg_104_1:FormatText(StoryNameCfg[42].name)

				arg_104_1.leftNameTxt_.text = var_107_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_7 = arg_104_1:GetWordFromCfg(411171024)
				local var_107_8 = arg_104_1:FormatText(var_107_7.content)

				arg_104_1.text_.text = var_107_8

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 17
				local var_107_10 = utf8.len(var_107_8)
				local var_107_11 = var_107_9 <= 0 and var_107_5 or var_107_5 * (var_107_10 / var_107_9)

				if var_107_11 > 0 and var_107_5 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_8
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171024", "story_v_out_411171.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_411171", "411171024", "story_v_out_411171.awb") / 1000

					if var_107_12 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_4
					end

					if var_107_7.prefab_name ~= "" and arg_104_1.actors_[var_107_7.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_7.prefab_name].transform, "story_v_out_411171", "411171024", "story_v_out_411171.awb")

						arg_104_1:RecordAudio("411171024", var_107_13)
						arg_104_1:RecordAudio("411171024", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_411171", "411171024", "story_v_out_411171.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_411171", "411171024", "story_v_out_411171.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_14 and arg_104_1.time_ < var_107_4 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play411171025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 411171025
		arg_108_1.duration_ = 7.5

		local var_108_0 = {
			zh = 7.5,
			ja = 5.9
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play411171026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1095ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1095ui_story == nil then
				arg_108_1.var_.characterEffect1095ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1095ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1095ui_story then
				arg_108_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_111_4 = 0

			if var_111_4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_111_6 = arg_108_1.actors_["4010ui_story"]
			local var_111_7 = 0

			if var_111_7 < arg_108_1.time_ and arg_108_1.time_ <= var_111_7 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect4010ui_story == nil then
				arg_108_1.var_.characterEffect4010ui_story = var_111_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_8 = 0.200000002980232

			if var_111_7 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_8 and not isNil(var_111_6) then
				local var_111_9 = (arg_108_1.time_ - var_111_7) / var_111_8

				if arg_108_1.var_.characterEffect4010ui_story and not isNil(var_111_6) then
					local var_111_10 = Mathf.Lerp(0, 0.5, var_111_9)

					arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4010ui_story.fillRatio = var_111_10
				end
			end

			if arg_108_1.time_ >= var_111_7 + var_111_8 and arg_108_1.time_ < var_111_7 + var_111_8 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect4010ui_story then
				local var_111_11 = 0.5

				arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4010ui_story.fillRatio = var_111_11
			end

			local var_111_12 = 0
			local var_111_13 = 0.95

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_14 = arg_108_1:FormatText(StoryNameCfg[471].name)

				arg_108_1.leftNameTxt_.text = var_111_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_15 = arg_108_1:GetWordFromCfg(411171025)
				local var_111_16 = arg_108_1:FormatText(var_111_15.content)

				arg_108_1.text_.text = var_111_16

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_17 = 38
				local var_111_18 = utf8.len(var_111_16)
				local var_111_19 = var_111_17 <= 0 and var_111_13 or var_111_13 * (var_111_18 / var_111_17)

				if var_111_19 > 0 and var_111_13 < var_111_19 then
					arg_108_1.talkMaxDuration = var_111_19

					if var_111_19 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_12
					end
				end

				arg_108_1.text_.text = var_111_16
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171025", "story_v_out_411171.awb") ~= 0 then
					local var_111_20 = manager.audio:GetVoiceLength("story_v_out_411171", "411171025", "story_v_out_411171.awb") / 1000

					if var_111_20 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_20 + var_111_12
					end

					if var_111_15.prefab_name ~= "" and arg_108_1.actors_[var_111_15.prefab_name] ~= nil then
						local var_111_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_15.prefab_name].transform, "story_v_out_411171", "411171025", "story_v_out_411171.awb")

						arg_108_1:RecordAudio("411171025", var_111_21)
						arg_108_1:RecordAudio("411171025", var_111_21)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_411171", "411171025", "story_v_out_411171.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_411171", "411171025", "story_v_out_411171.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_22 = math.max(var_111_13, arg_108_1.talkMaxDuration)

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_22 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_12) / var_111_22

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_12 + var_111_22 and arg_108_1.time_ < var_111_12 + var_111_22 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play411171026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 411171026
		arg_112_1.duration_ = 7.67

		local var_112_0 = {
			zh = 4.533,
			ja = 7.666
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play411171027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.65

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[471].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(411171026)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171026", "story_v_out_411171.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171026", "story_v_out_411171.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_411171", "411171026", "story_v_out_411171.awb")

						arg_112_1:RecordAudio("411171026", var_115_9)
						arg_112_1:RecordAudio("411171026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_411171", "411171026", "story_v_out_411171.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_411171", "411171026", "story_v_out_411171.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play411171027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 411171027
		arg_116_1.duration_ = 11.9

		local var_116_0 = {
			zh = 7.166,
			ja = 11.9
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play411171028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["4010ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect4010ui_story == nil then
				arg_116_1.var_.characterEffect4010ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect4010ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect4010ui_story then
				arg_116_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_119_4 = 0

			if var_119_4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_119_6 = arg_116_1.actors_["1095ui_story"]
			local var_119_7 = 0

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1095ui_story == nil then
				arg_116_1.var_.characterEffect1095ui_story = var_119_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_8 = 0.200000002980232

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_8 and not isNil(var_119_6) then
				local var_119_9 = (arg_116_1.time_ - var_119_7) / var_119_8

				if arg_116_1.var_.characterEffect1095ui_story and not isNil(var_119_6) then
					local var_119_10 = Mathf.Lerp(0, 0.5, var_119_9)

					arg_116_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1095ui_story.fillRatio = var_119_10
				end
			end

			if arg_116_1.time_ >= var_119_7 + var_119_8 and arg_116_1.time_ < var_119_7 + var_119_8 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect1095ui_story then
				local var_119_11 = 0.5

				arg_116_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1095ui_story.fillRatio = var_119_11
			end

			local var_119_12 = 0
			local var_119_13 = 0.875

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[42].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(411171027)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 35
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_13 or var_119_13 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_13 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171027", "story_v_out_411171.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_411171", "411171027", "story_v_out_411171.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_411171", "411171027", "story_v_out_411171.awb")

						arg_116_1:RecordAudio("411171027", var_119_21)
						arg_116_1:RecordAudio("411171027", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_411171", "411171027", "story_v_out_411171.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_411171", "411171027", "story_v_out_411171.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_22 and arg_116_1.time_ < var_119_12 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play411171028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 411171028
		arg_120_1.duration_ = 3.87

		local var_120_0 = {
			zh = 1.999999999999,
			ja = 3.866
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
				arg_120_0:Play411171029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["4010ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect4010ui_story == nil then
				arg_120_1.var_.characterEffect4010ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect4010ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_120_1.var_.characterEffect4010ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect4010ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_120_1.var_.characterEffect4010ui_story.fillRatio = var_123_5
			end

			local var_123_6 = arg_120_1.actors_["1095ui_story"]
			local var_123_7 = 0

			if var_123_7 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1095ui_story == nil then
				arg_120_1.var_.characterEffect1095ui_story = var_123_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_8 = 0.200000002980232

			if var_123_7 <= arg_120_1.time_ and arg_120_1.time_ < var_123_7 + var_123_8 and not isNil(var_123_6) then
				local var_123_9 = (arg_120_1.time_ - var_123_7) / var_123_8

				if arg_120_1.var_.characterEffect1095ui_story and not isNil(var_123_6) then
					arg_120_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_7 + var_123_8 and arg_120_1.time_ < var_123_7 + var_123_8 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1095ui_story then
				arg_120_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_123_11 = 0

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_123_12 = 0
			local var_123_13 = 0.175

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_14 = arg_120_1:FormatText(StoryNameCfg[471].name)

				arg_120_1.leftNameTxt_.text = var_123_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_15 = arg_120_1:GetWordFromCfg(411171028)
				local var_123_16 = arg_120_1:FormatText(var_123_15.content)

				arg_120_1.text_.text = var_123_16

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_17 = 7
				local var_123_18 = utf8.len(var_123_16)
				local var_123_19 = var_123_17 <= 0 and var_123_13 or var_123_13 * (var_123_18 / var_123_17)

				if var_123_19 > 0 and var_123_13 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19

					if var_123_19 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_12
					end
				end

				arg_120_1.text_.text = var_123_16
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171028", "story_v_out_411171.awb") ~= 0 then
					local var_123_20 = manager.audio:GetVoiceLength("story_v_out_411171", "411171028", "story_v_out_411171.awb") / 1000

					if var_123_20 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_12
					end

					if var_123_15.prefab_name ~= "" and arg_120_1.actors_[var_123_15.prefab_name] ~= nil then
						local var_123_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_15.prefab_name].transform, "story_v_out_411171", "411171028", "story_v_out_411171.awb")

						arg_120_1:RecordAudio("411171028", var_123_21)
						arg_120_1:RecordAudio("411171028", var_123_21)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_411171", "411171028", "story_v_out_411171.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_411171", "411171028", "story_v_out_411171.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_22 = math.max(var_123_13, arg_120_1.talkMaxDuration)

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_22 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_12) / var_123_22

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_12 + var_123_22 and arg_120_1.time_ < var_123_12 + var_123_22 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play411171029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 411171029
		arg_124_1.duration_ = 8.33

		local var_124_0 = {
			zh = 5.733,
			ja = 8.333
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
				arg_124_0:Play411171030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.825

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[471].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(411171029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 33
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171029", "story_v_out_411171.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171029", "story_v_out_411171.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_411171", "411171029", "story_v_out_411171.awb")

						arg_124_1:RecordAudio("411171029", var_127_9)
						arg_124_1:RecordAudio("411171029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_411171", "411171029", "story_v_out_411171.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_411171", "411171029", "story_v_out_411171.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play411171030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 411171030
		arg_128_1.duration_ = 4.97

		local var_128_0 = {
			zh = 1.999999999999,
			ja = 4.966
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
				arg_128_0:Play411171031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["4010ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4010ui_story == nil then
				arg_128_1.var_.characterEffect4010ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect4010ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4010ui_story then
				arg_128_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1095ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1095ui_story == nil then
				arg_128_1.var_.characterEffect1095ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.200000002980232

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect1095ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1095ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect1095ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1095ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_2")
			end

			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_131_12 = 0
			local var_131_13 = 0.2

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_14 = arg_128_1:FormatText(StoryNameCfg[42].name)

				arg_128_1.leftNameTxt_.text = var_131_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_15 = arg_128_1:GetWordFromCfg(411171030)
				local var_131_16 = arg_128_1:FormatText(var_131_15.content)

				arg_128_1.text_.text = var_131_16

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_17 = 8
				local var_131_18 = utf8.len(var_131_16)
				local var_131_19 = var_131_17 <= 0 and var_131_13 or var_131_13 * (var_131_18 / var_131_17)

				if var_131_19 > 0 and var_131_13 < var_131_19 then
					arg_128_1.talkMaxDuration = var_131_19

					if var_131_19 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_12
					end
				end

				arg_128_1.text_.text = var_131_16
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171030", "story_v_out_411171.awb") ~= 0 then
					local var_131_20 = manager.audio:GetVoiceLength("story_v_out_411171", "411171030", "story_v_out_411171.awb") / 1000

					if var_131_20 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_20 + var_131_12
					end

					if var_131_15.prefab_name ~= "" and arg_128_1.actors_[var_131_15.prefab_name] ~= nil then
						local var_131_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_15.prefab_name].transform, "story_v_out_411171", "411171030", "story_v_out_411171.awb")

						arg_128_1:RecordAudio("411171030", var_131_21)
						arg_128_1:RecordAudio("411171030", var_131_21)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_411171", "411171030", "story_v_out_411171.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_411171", "411171030", "story_v_out_411171.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_13, arg_128_1.talkMaxDuration)

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_12) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_12 + var_131_22 and arg_128_1.time_ < var_131_12 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play411171031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 411171031
		arg_132_1.duration_ = 5.6

		local var_132_0 = {
			zh = 5.6,
			ja = 4.333
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play411171032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["4010ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect4010ui_story == nil then
				arg_132_1.var_.characterEffect4010ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect4010ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_132_1.var_.characterEffect4010ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect4010ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_132_1.var_.characterEffect4010ui_story.fillRatio = var_135_5
			end

			local var_135_6 = arg_132_1.actors_["1095ui_story"]
			local var_135_7 = 0

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1095ui_story == nil then
				arg_132_1.var_.characterEffect1095ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.200000002980232

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_8 and not isNil(var_135_6) then
				local var_135_9 = (arg_132_1.time_ - var_135_7) / var_135_8

				if arg_132_1.var_.characterEffect1095ui_story and not isNil(var_135_6) then
					arg_132_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_7 + var_135_8 and arg_132_1.time_ < var_135_7 + var_135_8 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1095ui_story then
				arg_132_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_135_11 = 0

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_12 = 0
			local var_135_13 = 0.725

			if var_135_12 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_14 = arg_132_1:FormatText(StoryNameCfg[471].name)

				arg_132_1.leftNameTxt_.text = var_135_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_15 = arg_132_1:GetWordFromCfg(411171031)
				local var_135_16 = arg_132_1:FormatText(var_135_15.content)

				arg_132_1.text_.text = var_135_16

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 29
				local var_135_18 = utf8.len(var_135_16)
				local var_135_19 = var_135_17 <= 0 and var_135_13 or var_135_13 * (var_135_18 / var_135_17)

				if var_135_19 > 0 and var_135_13 < var_135_19 then
					arg_132_1.talkMaxDuration = var_135_19

					if var_135_19 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_19 + var_135_12
					end
				end

				arg_132_1.text_.text = var_135_16
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171031", "story_v_out_411171.awb") ~= 0 then
					local var_135_20 = manager.audio:GetVoiceLength("story_v_out_411171", "411171031", "story_v_out_411171.awb") / 1000

					if var_135_20 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_20 + var_135_12
					end

					if var_135_15.prefab_name ~= "" and arg_132_1.actors_[var_135_15.prefab_name] ~= nil then
						local var_135_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_15.prefab_name].transform, "story_v_out_411171", "411171031", "story_v_out_411171.awb")

						arg_132_1:RecordAudio("411171031", var_135_21)
						arg_132_1:RecordAudio("411171031", var_135_21)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_411171", "411171031", "story_v_out_411171.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_411171", "411171031", "story_v_out_411171.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_22 = math.max(var_135_13, arg_132_1.talkMaxDuration)

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_22 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_12) / var_135_22

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_12 + var_135_22 and arg_132_1.time_ < var_135_12 + var_135_22 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play411171032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 411171032
		arg_136_1.duration_ = 4.03

		local var_136_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_136_0:Play411171033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["4010ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect4010ui_story == nil then
				arg_136_1.var_.characterEffect4010ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect4010ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect4010ui_story then
				arg_136_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1095ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1095ui_story == nil then
				arg_136_1.var_.characterEffect1095ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.200000002980232

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1095ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1095ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1095ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1095ui_story.fillRatio = var_139_9
			end

			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_139_11 = 0
			local var_139_12 = 0.175

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_13 = arg_136_1:FormatText(StoryNameCfg[42].name)

				arg_136_1.leftNameTxt_.text = var_139_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_14 = arg_136_1:GetWordFromCfg(411171032)
				local var_139_15 = arg_136_1:FormatText(var_139_14.content)

				arg_136_1.text_.text = var_139_15

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_16 = 7
				local var_139_17 = utf8.len(var_139_15)
				local var_139_18 = var_139_16 <= 0 and var_139_12 or var_139_12 * (var_139_17 / var_139_16)

				if var_139_18 > 0 and var_139_12 < var_139_18 then
					arg_136_1.talkMaxDuration = var_139_18

					if var_139_18 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_11
					end
				end

				arg_136_1.text_.text = var_139_15
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171032", "story_v_out_411171.awb") ~= 0 then
					local var_139_19 = manager.audio:GetVoiceLength("story_v_out_411171", "411171032", "story_v_out_411171.awb") / 1000

					if var_139_19 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_19 + var_139_11
					end

					if var_139_14.prefab_name ~= "" and arg_136_1.actors_[var_139_14.prefab_name] ~= nil then
						local var_139_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_14.prefab_name].transform, "story_v_out_411171", "411171032", "story_v_out_411171.awb")

						arg_136_1:RecordAudio("411171032", var_139_20)
						arg_136_1:RecordAudio("411171032", var_139_20)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_411171", "411171032", "story_v_out_411171.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_411171", "411171032", "story_v_out_411171.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_21 = math.max(var_139_12, arg_136_1.talkMaxDuration)

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_21 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_11) / var_139_21

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_11 + var_139_21 and arg_136_1.time_ < var_139_11 + var_139_21 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play411171033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 411171033
		arg_140_1.duration_ = 10.6

		local var_140_0 = {
			zh = 9.7,
			ja = 10.6
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
				arg_140_0:Play411171034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1.05

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[42].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:GetWordFromCfg(411171033)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171033", "story_v_out_411171.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171033", "story_v_out_411171.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_411171", "411171033", "story_v_out_411171.awb")

						arg_140_1:RecordAudio("411171033", var_143_9)
						arg_140_1:RecordAudio("411171033", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_411171", "411171033", "story_v_out_411171.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_411171", "411171033", "story_v_out_411171.awb")
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
	Play411171034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 411171034
		arg_144_1.duration_ = 1.87

		local var_144_0 = {
			zh = 0.999999999999,
			ja = 1.866
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play411171035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["4010ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4010ui_story == nil then
				arg_144_1.var_.characterEffect4010ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect4010ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_144_1.var_.characterEffect4010ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4010ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_144_1.var_.characterEffect4010ui_story.fillRatio = var_147_5
			end

			local var_147_6 = arg_144_1.actors_["1095ui_story"]
			local var_147_7 = 0

			if var_147_7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_8 = 0.200000002980232

			if var_147_7 <= arg_144_1.time_ and arg_144_1.time_ < var_147_7 + var_147_8 and not isNil(var_147_6) then
				local var_147_9 = (arg_144_1.time_ - var_147_7) / var_147_8

				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_6) then
					arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_7 + var_147_8 and arg_144_1.time_ < var_147_7 + var_147_8 + arg_147_0 and not isNil(var_147_6) and arg_144_1.var_.characterEffect1095ui_story then
				arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_147_10 = 0
			local var_147_11 = 0.05

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_12 = arg_144_1:FormatText(StoryNameCfg[471].name)

				arg_144_1.leftNameTxt_.text = var_147_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_13 = arg_144_1:GetWordFromCfg(411171034)
				local var_147_14 = arg_144_1:FormatText(var_147_13.content)

				arg_144_1.text_.text = var_147_14

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_15 = 2
				local var_147_16 = utf8.len(var_147_14)
				local var_147_17 = var_147_15 <= 0 and var_147_11 or var_147_11 * (var_147_16 / var_147_15)

				if var_147_17 > 0 and var_147_11 < var_147_17 then
					arg_144_1.talkMaxDuration = var_147_17

					if var_147_17 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_10
					end
				end

				arg_144_1.text_.text = var_147_14
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171034", "story_v_out_411171.awb") ~= 0 then
					local var_147_18 = manager.audio:GetVoiceLength("story_v_out_411171", "411171034", "story_v_out_411171.awb") / 1000

					if var_147_18 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_18 + var_147_10
					end

					if var_147_13.prefab_name ~= "" and arg_144_1.actors_[var_147_13.prefab_name] ~= nil then
						local var_147_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_13.prefab_name].transform, "story_v_out_411171", "411171034", "story_v_out_411171.awb")

						arg_144_1:RecordAudio("411171034", var_147_19)
						arg_144_1:RecordAudio("411171034", var_147_19)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_411171", "411171034", "story_v_out_411171.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_411171", "411171034", "story_v_out_411171.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_20 = math.max(var_147_11, arg_144_1.talkMaxDuration)

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_20 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_10) / var_147_20

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_10 + var_147_20 and arg_144_1.time_ < var_147_10 + var_147_20 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play411171035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 411171035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play411171036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1095ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1095ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1095ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1095ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1095ui_story == nil then
				arg_148_1.var_.characterEffect1095ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect1095ui_story and not isNil(var_151_9) then
					local var_151_13 = Mathf.Lerp(0, 0.5, var_151_12)

					arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1095ui_story.fillRatio = var_151_13
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1095ui_story then
				local var_151_14 = 0.5

				arg_148_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1095ui_story.fillRatio = var_151_14
			end

			local var_151_15 = arg_148_1.actors_["4010ui_story"].transform
			local var_151_16 = 0

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.var_.moveOldPos4010ui_story = var_151_15.localPosition
			end

			local var_151_17 = 0.001

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_17 then
				local var_151_18 = (arg_148_1.time_ - var_151_16) / var_151_17
				local var_151_19 = Vector3.New(0, 100, 0)

				var_151_15.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos4010ui_story, var_151_19, var_151_18)

				local var_151_20 = manager.ui.mainCamera.transform.position - var_151_15.position

				var_151_15.forward = Vector3.New(var_151_20.x, var_151_20.y, var_151_20.z)

				local var_151_21 = var_151_15.localEulerAngles

				var_151_21.z = 0
				var_151_21.x = 0
				var_151_15.localEulerAngles = var_151_21
			end

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 then
				var_151_15.localPosition = Vector3.New(0, 100, 0)

				local var_151_22 = manager.ui.mainCamera.transform.position - var_151_15.position

				var_151_15.forward = Vector3.New(var_151_22.x, var_151_22.y, var_151_22.z)

				local var_151_23 = var_151_15.localEulerAngles

				var_151_23.z = 0
				var_151_23.x = 0
				var_151_15.localEulerAngles = var_151_23
			end

			local var_151_24 = arg_148_1.actors_["4010ui_story"]
			local var_151_25 = 0

			if var_151_25 < arg_148_1.time_ and arg_148_1.time_ <= var_151_25 + arg_151_0 and not isNil(var_151_24) and arg_148_1.var_.characterEffect4010ui_story == nil then
				arg_148_1.var_.characterEffect4010ui_story = var_151_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_26 = 0.200000002980232

			if var_151_25 <= arg_148_1.time_ and arg_148_1.time_ < var_151_25 + var_151_26 and not isNil(var_151_24) then
				local var_151_27 = (arg_148_1.time_ - var_151_25) / var_151_26

				if arg_148_1.var_.characterEffect4010ui_story and not isNil(var_151_24) then
					local var_151_28 = Mathf.Lerp(0, 0.5, var_151_27)

					arg_148_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_148_1.var_.characterEffect4010ui_story.fillRatio = var_151_28
				end
			end

			if arg_148_1.time_ >= var_151_25 + var_151_26 and arg_148_1.time_ < var_151_25 + var_151_26 + arg_151_0 and not isNil(var_151_24) and arg_148_1.var_.characterEffect4010ui_story then
				local var_151_29 = 0.5

				arg_148_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_148_1.var_.characterEffect4010ui_story.fillRatio = var_151_29
			end

			local var_151_30 = 0
			local var_151_31 = 0.4

			if var_151_30 < arg_148_1.time_ and arg_148_1.time_ <= var_151_30 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_32 = arg_148_1:GetWordFromCfg(411171035)
				local var_151_33 = arg_148_1:FormatText(var_151_32.content)

				arg_148_1.text_.text = var_151_33

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_34 = 16
				local var_151_35 = utf8.len(var_151_33)
				local var_151_36 = var_151_34 <= 0 and var_151_31 or var_151_31 * (var_151_35 / var_151_34)

				if var_151_36 > 0 and var_151_31 < var_151_36 then
					arg_148_1.talkMaxDuration = var_151_36

					if var_151_36 + var_151_30 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_36 + var_151_30
					end
				end

				arg_148_1.text_.text = var_151_33
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_37 = math.max(var_151_31, arg_148_1.talkMaxDuration)

			if var_151_30 <= arg_148_1.time_ and arg_148_1.time_ < var_151_30 + var_151_37 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_30) / var_151_37

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_30 + var_151_37 and arg_148_1.time_ < var_151_30 + var_151_37 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play411171036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411171036
		arg_152_1.duration_ = 3.37

		local var_152_0 = {
			zh = 2.4,
			ja = 3.366
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play411171037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1095ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1095ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.98, -6.1)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1095ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1095ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1095ui_story == nil then
				arg_152_1.var_.characterEffect1095ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect1095ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1095ui_story then
				arg_152_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_155_13 = 0
			local var_155_14 = 0.3

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_15 = arg_152_1:FormatText(StoryNameCfg[471].name)

				arg_152_1.leftNameTxt_.text = var_155_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_16 = arg_152_1:GetWordFromCfg(411171036)
				local var_155_17 = arg_152_1:FormatText(var_155_16.content)

				arg_152_1.text_.text = var_155_17

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_18 = 12
				local var_155_19 = utf8.len(var_155_17)
				local var_155_20 = var_155_18 <= 0 and var_155_14 or var_155_14 * (var_155_19 / var_155_18)

				if var_155_20 > 0 and var_155_14 < var_155_20 then
					arg_152_1.talkMaxDuration = var_155_20

					if var_155_20 + var_155_13 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_20 + var_155_13
					end
				end

				arg_152_1.text_.text = var_155_17
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171036", "story_v_out_411171.awb") ~= 0 then
					local var_155_21 = manager.audio:GetVoiceLength("story_v_out_411171", "411171036", "story_v_out_411171.awb") / 1000

					if var_155_21 + var_155_13 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_21 + var_155_13
					end

					if var_155_16.prefab_name ~= "" and arg_152_1.actors_[var_155_16.prefab_name] ~= nil then
						local var_155_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_16.prefab_name].transform, "story_v_out_411171", "411171036", "story_v_out_411171.awb")

						arg_152_1:RecordAudio("411171036", var_155_22)
						arg_152_1:RecordAudio("411171036", var_155_22)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_411171", "411171036", "story_v_out_411171.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_411171", "411171036", "story_v_out_411171.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_23 = math.max(var_155_14, arg_152_1.talkMaxDuration)

			if var_155_13 <= arg_152_1.time_ and arg_152_1.time_ < var_155_13 + var_155_23 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_13) / var_155_23

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_13 + var_155_23 and arg_152_1.time_ < var_155_13 + var_155_23 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play411171037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 411171037
		arg_156_1.duration_ = 4.63

		local var_156_0 = {
			zh = 4.2,
			ja = 4.633
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play411171038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_2 = 0
			local var_159_3 = 0.375

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_4 = arg_156_1:FormatText(StoryNameCfg[471].name)

				arg_156_1.leftNameTxt_.text = var_159_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:GetWordFromCfg(411171037)
				local var_159_6 = arg_156_1:FormatText(var_159_5.content)

				arg_156_1.text_.text = var_159_6

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 15
				local var_159_8 = utf8.len(var_159_6)
				local var_159_9 = var_159_7 <= 0 and var_159_3 or var_159_3 * (var_159_8 / var_159_7)

				if var_159_9 > 0 and var_159_3 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_6
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171037", "story_v_out_411171.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171037", "story_v_out_411171.awb") / 1000

					if var_159_10 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_2
					end

					if var_159_5.prefab_name ~= "" and arg_156_1.actors_[var_159_5.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_5.prefab_name].transform, "story_v_out_411171", "411171037", "story_v_out_411171.awb")

						arg_156_1:RecordAudio("411171037", var_159_11)
						arg_156_1:RecordAudio("411171037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_411171", "411171037", "story_v_out_411171.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_411171", "411171037", "story_v_out_411171.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_12 and arg_156_1.time_ < var_159_2 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play411171038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 411171038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play411171039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1095ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1095ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1095ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1095ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1095ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.9

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(411171038)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 36
				local var_163_11 = utf8.len(var_163_9)
				local var_163_12 = var_163_10 <= 0 and var_163_7 or var_163_7 * (var_163_11 / var_163_10)

				if var_163_12 > 0 and var_163_7 < var_163_12 then
					arg_160_1.talkMaxDuration = var_163_12

					if var_163_12 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_13 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_13 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_13

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_13 and arg_160_1.time_ < var_163_6 + var_163_13 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play411171039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 411171039
		arg_164_1.duration_ = 8.53

		local var_164_0 = {
			zh = 8.433,
			ja = 8.533
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play411171040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1095ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1095ui_story == nil then
				arg_164_1.var_.characterEffect1095ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1095ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1095ui_story then
				arg_164_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_167_4 = 0
			local var_167_5 = 1.025

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_6 = arg_164_1:FormatText(StoryNameCfg[471].name)

				arg_164_1.leftNameTxt_.text = var_167_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:GetWordFromCfg(411171039)
				local var_167_8 = arg_164_1:FormatText(var_167_7.content)

				arg_164_1.text_.text = var_167_8

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 41
				local var_167_10 = utf8.len(var_167_8)
				local var_167_11 = var_167_9 <= 0 and var_167_5 or var_167_5 * (var_167_10 / var_167_9)

				if var_167_11 > 0 and var_167_5 < var_167_11 then
					arg_164_1.talkMaxDuration = var_167_11

					if var_167_11 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_4
					end
				end

				arg_164_1.text_.text = var_167_8
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171039", "story_v_out_411171.awb") ~= 0 then
					local var_167_12 = manager.audio:GetVoiceLength("story_v_out_411171", "411171039", "story_v_out_411171.awb") / 1000

					if var_167_12 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_4
					end

					if var_167_7.prefab_name ~= "" and arg_164_1.actors_[var_167_7.prefab_name] ~= nil then
						local var_167_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_7.prefab_name].transform, "story_v_out_411171", "411171039", "story_v_out_411171.awb")

						arg_164_1:RecordAudio("411171039", var_167_13)
						arg_164_1:RecordAudio("411171039", var_167_13)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_411171", "411171039", "story_v_out_411171.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_411171", "411171039", "story_v_out_411171.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_5, arg_164_1.talkMaxDuration)

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_4) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_4 + var_167_14 and arg_164_1.time_ < var_167_4 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play411171040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 411171040
		arg_168_1.duration_ = 4.4

		local var_168_0 = {
			zh = 3.766,
			ja = 4.4
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play411171041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["4010ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos4010ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(-0.7, -1.59, -5.2)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos4010ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["4010ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect4010ui_story == nil then
				arg_168_1.var_.characterEffect4010ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect4010ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect4010ui_story then
				arg_168_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			local var_171_14 = 0

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_15 = arg_168_1.actors_["1095ui_story"].transform
			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				arg_168_1.var_.moveOldPos1095ui_story = var_171_15.localPosition
			end

			local var_171_17 = 0.001

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_17 then
				local var_171_18 = (arg_168_1.time_ - var_171_16) / var_171_17
				local var_171_19 = Vector3.New(0.7, -0.98, -6.1)

				var_171_15.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1095ui_story, var_171_19, var_171_18)

				local var_171_20 = manager.ui.mainCamera.transform.position - var_171_15.position

				var_171_15.forward = Vector3.New(var_171_20.x, var_171_20.y, var_171_20.z)

				local var_171_21 = var_171_15.localEulerAngles

				var_171_21.z = 0
				var_171_21.x = 0
				var_171_15.localEulerAngles = var_171_21
			end

			if arg_168_1.time_ >= var_171_16 + var_171_17 and arg_168_1.time_ < var_171_16 + var_171_17 + arg_171_0 then
				var_171_15.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_171_22 = manager.ui.mainCamera.transform.position - var_171_15.position

				var_171_15.forward = Vector3.New(var_171_22.x, var_171_22.y, var_171_22.z)

				local var_171_23 = var_171_15.localEulerAngles

				var_171_23.z = 0
				var_171_23.x = 0
				var_171_15.localEulerAngles = var_171_23
			end

			local var_171_24 = arg_168_1.actors_["1095ui_story"]
			local var_171_25 = 0

			if var_171_25 < arg_168_1.time_ and arg_168_1.time_ <= var_171_25 + arg_171_0 and not isNil(var_171_24) and arg_168_1.var_.characterEffect1095ui_story == nil then
				arg_168_1.var_.characterEffect1095ui_story = var_171_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_26 = 0.200000002980232

			if var_171_25 <= arg_168_1.time_ and arg_168_1.time_ < var_171_25 + var_171_26 and not isNil(var_171_24) then
				local var_171_27 = (arg_168_1.time_ - var_171_25) / var_171_26

				if arg_168_1.var_.characterEffect1095ui_story and not isNil(var_171_24) then
					local var_171_28 = Mathf.Lerp(0, 0.5, var_171_27)

					arg_168_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1095ui_story.fillRatio = var_171_28
				end
			end

			if arg_168_1.time_ >= var_171_25 + var_171_26 and arg_168_1.time_ < var_171_25 + var_171_26 + arg_171_0 and not isNil(var_171_24) and arg_168_1.var_.characterEffect1095ui_story then
				local var_171_29 = 0.5

				arg_168_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1095ui_story.fillRatio = var_171_29
			end

			local var_171_30 = 0
			local var_171_31 = 0.4

			if var_171_30 < arg_168_1.time_ and arg_168_1.time_ <= var_171_30 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_32 = arg_168_1:FormatText(StoryNameCfg[42].name)

				arg_168_1.leftNameTxt_.text = var_171_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_33 = arg_168_1:GetWordFromCfg(411171040)
				local var_171_34 = arg_168_1:FormatText(var_171_33.content)

				arg_168_1.text_.text = var_171_34

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_35 = 16
				local var_171_36 = utf8.len(var_171_34)
				local var_171_37 = var_171_35 <= 0 and var_171_31 or var_171_31 * (var_171_36 / var_171_35)

				if var_171_37 > 0 and var_171_31 < var_171_37 then
					arg_168_1.talkMaxDuration = var_171_37

					if var_171_37 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_37 + var_171_30
					end
				end

				arg_168_1.text_.text = var_171_34
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171040", "story_v_out_411171.awb") ~= 0 then
					local var_171_38 = manager.audio:GetVoiceLength("story_v_out_411171", "411171040", "story_v_out_411171.awb") / 1000

					if var_171_38 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_38 + var_171_30
					end

					if var_171_33.prefab_name ~= "" and arg_168_1.actors_[var_171_33.prefab_name] ~= nil then
						local var_171_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_33.prefab_name].transform, "story_v_out_411171", "411171040", "story_v_out_411171.awb")

						arg_168_1:RecordAudio("411171040", var_171_39)
						arg_168_1:RecordAudio("411171040", var_171_39)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_411171", "411171040", "story_v_out_411171.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_411171", "411171040", "story_v_out_411171.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_40 = math.max(var_171_31, arg_168_1.talkMaxDuration)

			if var_171_30 <= arg_168_1.time_ and arg_168_1.time_ < var_171_30 + var_171_40 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_30) / var_171_40

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_30 + var_171_40 and arg_168_1.time_ < var_171_30 + var_171_40 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_168_1:InitPlayNodeList()
	end,
	Play411171041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 411171041
		arg_172_1.duration_ = 6.17

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play411171042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["4010ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect4010ui_story == nil then
				arg_172_1.var_.characterEffect4010ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect4010ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_172_1.var_.characterEffect4010ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect4010ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_172_1.var_.characterEffect4010ui_story.fillRatio = var_175_5
			end

			local var_175_6 = manager.ui.mainCamera.transform
			local var_175_7 = 0

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 then
				local var_175_8 = arg_172_1.var_.effect991
				local var_175_9
				local var_175_10 = var_175_6

				if not var_175_8 then
					var_175_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_175_10)
					var_175_8.name = "991"
					arg_172_1.var_.effect991 = var_175_8
				else
					var_175_8.transform:SetParent(var_175_10)
				end

				var_175_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_175_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_175_11 = arg_172_1.actors_["1095ui_story"].transform
			local var_175_12 = 0

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.var_.moveOldPos1095ui_story = var_175_11.localPosition
			end

			local var_175_13 = 0.001

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_13 then
				local var_175_14 = (arg_172_1.time_ - var_175_12) / var_175_13
				local var_175_15 = Vector3.New(0, 100, 0)

				var_175_11.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1095ui_story, var_175_15, var_175_14)

				local var_175_16 = manager.ui.mainCamera.transform.position - var_175_11.position

				var_175_11.forward = Vector3.New(var_175_16.x, var_175_16.y, var_175_16.z)

				local var_175_17 = var_175_11.localEulerAngles

				var_175_17.z = 0
				var_175_17.x = 0
				var_175_11.localEulerAngles = var_175_17
			end

			if arg_172_1.time_ >= var_175_12 + var_175_13 and arg_172_1.time_ < var_175_12 + var_175_13 + arg_175_0 then
				var_175_11.localPosition = Vector3.New(0, 100, 0)

				local var_175_18 = manager.ui.mainCamera.transform.position - var_175_11.position

				var_175_11.forward = Vector3.New(var_175_18.x, var_175_18.y, var_175_18.z)

				local var_175_19 = var_175_11.localEulerAngles

				var_175_19.z = 0
				var_175_19.x = 0
				var_175_11.localEulerAngles = var_175_19
			end

			local var_175_20 = arg_172_1.actors_["4010ui_story"].transform
			local var_175_21 = 0

			if var_175_21 < arg_172_1.time_ and arg_172_1.time_ <= var_175_21 + arg_175_0 then
				arg_172_1.var_.moveOldPos4010ui_story = var_175_20.localPosition
			end

			local var_175_22 = 0.001

			if var_175_21 <= arg_172_1.time_ and arg_172_1.time_ < var_175_21 + var_175_22 then
				local var_175_23 = (arg_172_1.time_ - var_175_21) / var_175_22
				local var_175_24 = Vector3.New(0, 100, 0)

				var_175_20.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos4010ui_story, var_175_24, var_175_23)

				local var_175_25 = manager.ui.mainCamera.transform.position - var_175_20.position

				var_175_20.forward = Vector3.New(var_175_25.x, var_175_25.y, var_175_25.z)

				local var_175_26 = var_175_20.localEulerAngles

				var_175_26.z = 0
				var_175_26.x = 0
				var_175_20.localEulerAngles = var_175_26
			end

			if arg_172_1.time_ >= var_175_21 + var_175_22 and arg_172_1.time_ < var_175_21 + var_175_22 + arg_175_0 then
				var_175_20.localPosition = Vector3.New(0, 100, 0)

				local var_175_27 = manager.ui.mainCamera.transform.position - var_175_20.position

				var_175_20.forward = Vector3.New(var_175_27.x, var_175_27.y, var_175_27.z)

				local var_175_28 = var_175_20.localEulerAngles

				var_175_28.z = 0
				var_175_28.x = 0
				var_175_20.localEulerAngles = var_175_28
			end

			if arg_172_1.frameCnt_ <= 1 then
				arg_172_1.dialog_:SetActive(false)
			end

			local var_175_29 = 1.16666666666667
			local var_175_30 = 1.125

			if var_175_29 < arg_172_1.time_ and arg_172_1.time_ <= var_175_29 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				arg_172_1.dialog_:SetActive(true)

				arg_172_1.dialogCg_.alpha = 0

				local var_175_31 = LeanTween.value(arg_172_1.dialog_, 0, 1, 0.3)

				var_175_31:setOnUpdate(LuaHelper.FloatAction(function(arg_176_0)
					arg_172_1.dialogCg_.alpha = arg_176_0
				end))
				var_175_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_172_1.dialog_)
					var_175_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_172_1.duration_ = arg_172_1.duration_ + 0.3

				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_32 = arg_172_1:GetWordFromCfg(411171041)
				local var_175_33 = arg_172_1:FormatText(var_175_32.content)

				arg_172_1.text_.text = var_175_33

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_34 = 45
				local var_175_35 = utf8.len(var_175_33)
				local var_175_36 = var_175_34 <= 0 and var_175_30 or var_175_30 * (var_175_35 / var_175_34)

				if var_175_36 > 0 and var_175_30 < var_175_36 then
					arg_172_1.talkMaxDuration = var_175_36
					var_175_29 = var_175_29 + 0.3

					if var_175_36 + var_175_29 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_36 + var_175_29
					end
				end

				arg_172_1.text_.text = var_175_33
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_37 = var_175_29 + 0.3
			local var_175_38 = math.max(var_175_30, arg_172_1.talkMaxDuration)

			if var_175_37 <= arg_172_1.time_ and arg_172_1.time_ < var_175_37 + var_175_38 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_37) / var_175_38

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_37 + var_175_38 and arg_172_1.time_ < var_175_37 + var_175_38 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play411171042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 411171042
		arg_178_1.duration_ = 6.3

		local var_178_0 = {
			zh = 6.29966666666667,
			ja = 4.96666666666667
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
				arg_178_0:Play411171043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["4010ui_story"].transform
			local var_181_1 = 2.41666666666667

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos4010ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -1.59, -5.2)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos4010ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = 1.51666666666667

			if var_181_9 < arg_178_1.time_ and arg_178_1.time_ <= var_181_9 + arg_181_0 then
				local var_181_10 = manager.ui.mainCamera.transform.localPosition
				local var_181_11 = Vector3.New(0, 0, 10) + Vector3.New(var_181_10.x, var_181_10.y, 0)
				local var_181_12 = arg_178_1.bgs_.ST75

				var_181_12.transform.localPosition = var_181_11
				var_181_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_13 = var_181_12:GetComponent("SpriteRenderer")

				if var_181_13 and var_181_13.sprite then
					local var_181_14 = (var_181_12.transform.localPosition - var_181_10).z
					local var_181_15 = manager.ui.mainCameraCom_
					local var_181_16 = 2 * var_181_14 * Mathf.Tan(var_181_15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_181_17 = var_181_16 * var_181_15.aspect
					local var_181_18 = var_181_13.sprite.bounds.size.x
					local var_181_19 = var_181_13.sprite.bounds.size.y
					local var_181_20 = var_181_17 / var_181_18
					local var_181_21 = var_181_16 / var_181_19
					local var_181_22 = var_181_21 < var_181_20 and var_181_20 or var_181_21

					var_181_12.transform.localScale = Vector3.New(var_181_22, var_181_22, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "ST75" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_23 = 0

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_24 = 1.51666666666667

			if var_181_23 <= arg_178_1.time_ and arg_178_1.time_ < var_181_23 + var_181_24 then
				local var_181_25 = (arg_178_1.time_ - var_181_23) / var_181_24
				local var_181_26 = Color.New(0, 0, 0)

				var_181_26.a = Mathf.Lerp(0, 1, var_181_25)
				arg_178_1.mask_.color = var_181_26
			end

			if arg_178_1.time_ >= var_181_23 + var_181_24 and arg_178_1.time_ < var_181_23 + var_181_24 + arg_181_0 then
				local var_181_27 = Color.New(0, 0, 0)

				var_181_27.a = 1
				arg_178_1.mask_.color = var_181_27
			end

			local var_181_28 = 1.51666666666667

			if var_181_28 < arg_178_1.time_ and arg_178_1.time_ <= var_181_28 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_29 = 1

			if var_181_28 <= arg_178_1.time_ and arg_178_1.time_ < var_181_28 + var_181_29 then
				local var_181_30 = (arg_178_1.time_ - var_181_28) / var_181_29
				local var_181_31 = Color.New(0, 0, 0)

				var_181_31.a = Mathf.Lerp(1, 0, var_181_30)
				arg_178_1.mask_.color = var_181_31
			end

			if arg_178_1.time_ >= var_181_28 + var_181_29 and arg_178_1.time_ < var_181_28 + var_181_29 + arg_181_0 then
				local var_181_32 = Color.New(0, 0, 0)
				local var_181_33 = 0

				arg_178_1.mask_.enabled = false
				var_181_32.a = var_181_33
				arg_178_1.mask_.color = var_181_32
			end

			local var_181_34 = manager.ui.mainCamera.transform
			local var_181_35 = 0

			if var_181_35 < arg_178_1.time_ and arg_178_1.time_ <= var_181_35 + arg_181_0 then
				local var_181_36 = arg_178_1.var_.effect991

				if var_181_36 then
					Object.Destroy(var_181_36)

					arg_178_1.var_.effect991 = nil
				end
			end

			local var_181_37 = 2.41666666666667

			if var_181_37 < arg_178_1.time_ and arg_178_1.time_ <= var_181_37 + arg_181_0 then
				arg_178_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			local var_181_38 = 2.41666666666667

			if var_181_38 < arg_178_1.time_ and arg_178_1.time_ <= var_181_38 + arg_181_0 then
				arg_178_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_181_39 = arg_178_1.actors_["4010ui_story"]
			local var_181_40 = 2.41666666666667

			if var_181_40 < arg_178_1.time_ and arg_178_1.time_ <= var_181_40 + arg_181_0 and not isNil(var_181_39) and arg_178_1.var_.characterEffect4010ui_story == nil then
				arg_178_1.var_.characterEffect4010ui_story = var_181_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_41 = 0.2

			if var_181_40 <= arg_178_1.time_ and arg_178_1.time_ < var_181_40 + var_181_41 and not isNil(var_181_39) then
				local var_181_42 = (arg_178_1.time_ - var_181_40) / var_181_41

				if arg_178_1.var_.characterEffect4010ui_story and not isNil(var_181_39) then
					arg_178_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_40 + var_181_41 and arg_178_1.time_ < var_181_40 + var_181_41 + arg_181_0 and not isNil(var_181_39) and arg_178_1.var_.characterEffect4010ui_story then
				arg_178_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_43 = 2.56666666666667
			local var_181_44 = 0.35

			if var_181_43 < arg_178_1.time_ and arg_178_1.time_ <= var_181_43 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_45 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_45:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_46 = arg_178_1:FormatText(StoryNameCfg[42].name)

				arg_178_1.leftNameTxt_.text = var_181_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_47 = arg_178_1:GetWordFromCfg(411171042)
				local var_181_48 = arg_178_1:FormatText(var_181_47.content)

				arg_178_1.text_.text = var_181_48

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_49 = 14
				local var_181_50 = utf8.len(var_181_48)
				local var_181_51 = var_181_49 <= 0 and var_181_44 or var_181_44 * (var_181_50 / var_181_49)

				if var_181_51 > 0 and var_181_44 < var_181_51 then
					arg_178_1.talkMaxDuration = var_181_51
					var_181_43 = var_181_43 + 0.3

					if var_181_51 + var_181_43 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_51 + var_181_43
					end
				end

				arg_178_1.text_.text = var_181_48
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171042", "story_v_out_411171.awb") ~= 0 then
					local var_181_52 = manager.audio:GetVoiceLength("story_v_out_411171", "411171042", "story_v_out_411171.awb") / 1000

					if var_181_52 + var_181_43 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_52 + var_181_43
					end

					if var_181_47.prefab_name ~= "" and arg_178_1.actors_[var_181_47.prefab_name] ~= nil then
						local var_181_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_47.prefab_name].transform, "story_v_out_411171", "411171042", "story_v_out_411171.awb")

						arg_178_1:RecordAudio("411171042", var_181_53)
						arg_178_1:RecordAudio("411171042", var_181_53)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_411171", "411171042", "story_v_out_411171.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_411171", "411171042", "story_v_out_411171.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_54 = var_181_43 + 0.3
			local var_181_55 = math.max(var_181_44, arg_178_1.talkMaxDuration)

			if var_181_54 <= arg_178_1.time_ and arg_178_1.time_ < var_181_54 + var_181_55 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_54) / var_181_55

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_54 + var_181_55 and arg_178_1.time_ < var_181_54 + var_181_55 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.41666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play411171043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 411171043
		arg_184_1.duration_ = 3.43

		local var_184_0 = {
			zh = 3.433,
			ja = 2.9
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play411171044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1095ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1095ui_story == nil then
				arg_184_1.var_.characterEffect1095ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1095ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1095ui_story then
				arg_184_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_6 = arg_184_1.actors_["4010ui_story"]
			local var_187_7 = 0

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect4010ui_story == nil then
				arg_184_1.var_.characterEffect4010ui_story = var_187_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_8 = 0.200000002980232

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_8 and not isNil(var_187_6) then
				local var_187_9 = (arg_184_1.time_ - var_187_7) / var_187_8

				if arg_184_1.var_.characterEffect4010ui_story and not isNil(var_187_6) then
					local var_187_10 = Mathf.Lerp(0, 0.5, var_187_9)

					arg_184_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_184_1.var_.characterEffect4010ui_story.fillRatio = var_187_10
				end
			end

			if arg_184_1.time_ >= var_187_7 + var_187_8 and arg_184_1.time_ < var_187_7 + var_187_8 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect4010ui_story then
				local var_187_11 = 0.5

				arg_184_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_184_1.var_.characterEffect4010ui_story.fillRatio = var_187_11
			end

			local var_187_12 = arg_184_1.actors_["4010ui_story"].transform
			local var_187_13 = 0

			if var_187_13 < arg_184_1.time_ and arg_184_1.time_ <= var_187_13 + arg_187_0 then
				arg_184_1.var_.moveOldPos4010ui_story = var_187_12.localPosition
			end

			local var_187_14 = 0.001

			if var_187_13 <= arg_184_1.time_ and arg_184_1.time_ < var_187_13 + var_187_14 then
				local var_187_15 = (arg_184_1.time_ - var_187_13) / var_187_14
				local var_187_16 = Vector3.New(-0.7, -1.59, -5.2)

				var_187_12.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos4010ui_story, var_187_16, var_187_15)

				local var_187_17 = manager.ui.mainCamera.transform.position - var_187_12.position

				var_187_12.forward = Vector3.New(var_187_17.x, var_187_17.y, var_187_17.z)

				local var_187_18 = var_187_12.localEulerAngles

				var_187_18.z = 0
				var_187_18.x = 0
				var_187_12.localEulerAngles = var_187_18
			end

			if arg_184_1.time_ >= var_187_13 + var_187_14 and arg_184_1.time_ < var_187_13 + var_187_14 + arg_187_0 then
				var_187_12.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_187_19 = manager.ui.mainCamera.transform.position - var_187_12.position

				var_187_12.forward = Vector3.New(var_187_19.x, var_187_19.y, var_187_19.z)

				local var_187_20 = var_187_12.localEulerAngles

				var_187_20.z = 0
				var_187_20.x = 0
				var_187_12.localEulerAngles = var_187_20
			end

			local var_187_21 = arg_184_1.actors_["1095ui_story"].transform
			local var_187_22 = 0

			if var_187_22 < arg_184_1.time_ and arg_184_1.time_ <= var_187_22 + arg_187_0 then
				arg_184_1.var_.moveOldPos1095ui_story = var_187_21.localPosition
			end

			local var_187_23 = 0.001

			if var_187_22 <= arg_184_1.time_ and arg_184_1.time_ < var_187_22 + var_187_23 then
				local var_187_24 = (arg_184_1.time_ - var_187_22) / var_187_23
				local var_187_25 = Vector3.New(0.7, -0.98, -6.1)

				var_187_21.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1095ui_story, var_187_25, var_187_24)

				local var_187_26 = manager.ui.mainCamera.transform.position - var_187_21.position

				var_187_21.forward = Vector3.New(var_187_26.x, var_187_26.y, var_187_26.z)

				local var_187_27 = var_187_21.localEulerAngles

				var_187_27.z = 0
				var_187_27.x = 0
				var_187_21.localEulerAngles = var_187_27
			end

			if arg_184_1.time_ >= var_187_22 + var_187_23 and arg_184_1.time_ < var_187_22 + var_187_23 + arg_187_0 then
				var_187_21.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_187_28 = manager.ui.mainCamera.transform.position - var_187_21.position

				var_187_21.forward = Vector3.New(var_187_28.x, var_187_28.y, var_187_28.z)

				local var_187_29 = var_187_21.localEulerAngles

				var_187_29.z = 0
				var_187_29.x = 0
				var_187_21.localEulerAngles = var_187_29
			end

			local var_187_30 = 0
			local var_187_31 = 0.325

			if var_187_30 < arg_184_1.time_ and arg_184_1.time_ <= var_187_30 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_32 = arg_184_1:FormatText(StoryNameCfg[471].name)

				arg_184_1.leftNameTxt_.text = var_187_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_33 = arg_184_1:GetWordFromCfg(411171043)
				local var_187_34 = arg_184_1:FormatText(var_187_33.content)

				arg_184_1.text_.text = var_187_34

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_35 = 13
				local var_187_36 = utf8.len(var_187_34)
				local var_187_37 = var_187_35 <= 0 and var_187_31 or var_187_31 * (var_187_36 / var_187_35)

				if var_187_37 > 0 and var_187_31 < var_187_37 then
					arg_184_1.talkMaxDuration = var_187_37

					if var_187_37 + var_187_30 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_37 + var_187_30
					end
				end

				arg_184_1.text_.text = var_187_34
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171043", "story_v_out_411171.awb") ~= 0 then
					local var_187_38 = manager.audio:GetVoiceLength("story_v_out_411171", "411171043", "story_v_out_411171.awb") / 1000

					if var_187_38 + var_187_30 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_38 + var_187_30
					end

					if var_187_33.prefab_name ~= "" and arg_184_1.actors_[var_187_33.prefab_name] ~= nil then
						local var_187_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_33.prefab_name].transform, "story_v_out_411171", "411171043", "story_v_out_411171.awb")

						arg_184_1:RecordAudio("411171043", var_187_39)
						arg_184_1:RecordAudio("411171043", var_187_39)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_411171", "411171043", "story_v_out_411171.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_411171", "411171043", "story_v_out_411171.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_40 = math.max(var_187_31, arg_184_1.talkMaxDuration)

			if var_187_30 <= arg_184_1.time_ and arg_184_1.time_ < var_187_30 + var_187_40 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_30) / var_187_40

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_30 + var_187_40 and arg_184_1.time_ < var_187_30 + var_187_40 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_184_1:InitPlayNodeList()
	end,
	Play411171044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 411171044
		arg_188_1.duration_ = 2

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play411171045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["4010ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect4010ui_story == nil then
				arg_188_1.var_.characterEffect4010ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect4010ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect4010ui_story then
				arg_188_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_191_4 = 0

			if var_191_4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_191_5 = arg_188_1.actors_["1095ui_story"]
			local var_191_6 = 0

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.characterEffect1095ui_story == nil then
				arg_188_1.var_.characterEffect1095ui_story = var_191_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_7 = 0.200000002980232

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_7 and not isNil(var_191_5) then
				local var_191_8 = (arg_188_1.time_ - var_191_6) / var_191_7

				if arg_188_1.var_.characterEffect1095ui_story and not isNil(var_191_5) then
					local var_191_9 = Mathf.Lerp(0, 0.5, var_191_8)

					arg_188_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1095ui_story.fillRatio = var_191_9
				end
			end

			if arg_188_1.time_ >= var_191_6 + var_191_7 and arg_188_1.time_ < var_191_6 + var_191_7 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.characterEffect1095ui_story then
				local var_191_10 = 0.5

				arg_188_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1095ui_story.fillRatio = var_191_10
			end

			local var_191_11 = 0
			local var_191_12 = 0.125

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_13 = arg_188_1:FormatText(StoryNameCfg[42].name)

				arg_188_1.leftNameTxt_.text = var_191_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_14 = arg_188_1:GetWordFromCfg(411171044)
				local var_191_15 = arg_188_1:FormatText(var_191_14.content)

				arg_188_1.text_.text = var_191_15

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_16 = 5
				local var_191_17 = utf8.len(var_191_15)
				local var_191_18 = var_191_16 <= 0 and var_191_12 or var_191_12 * (var_191_17 / var_191_16)

				if var_191_18 > 0 and var_191_12 < var_191_18 then
					arg_188_1.talkMaxDuration = var_191_18

					if var_191_18 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_18 + var_191_11
					end
				end

				arg_188_1.text_.text = var_191_15
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171044", "story_v_out_411171.awb") ~= 0 then
					local var_191_19 = manager.audio:GetVoiceLength("story_v_out_411171", "411171044", "story_v_out_411171.awb") / 1000

					if var_191_19 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_19 + var_191_11
					end

					if var_191_14.prefab_name ~= "" and arg_188_1.actors_[var_191_14.prefab_name] ~= nil then
						local var_191_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_14.prefab_name].transform, "story_v_out_411171", "411171044", "story_v_out_411171.awb")

						arg_188_1:RecordAudio("411171044", var_191_20)
						arg_188_1:RecordAudio("411171044", var_191_20)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_411171", "411171044", "story_v_out_411171.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_411171", "411171044", "story_v_out_411171.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_21 = math.max(var_191_12, arg_188_1.talkMaxDuration)

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_21 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_11) / var_191_21

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_11 + var_191_21 and arg_188_1.time_ < var_191_11 + var_191_21 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play411171045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 411171045
		arg_192_1.duration_ = 5.82

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play411171046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["4010ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect4010ui_story == nil then
				arg_192_1.var_.characterEffect4010ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect4010ui_story and not isNil(var_195_0) then
					local var_195_4 = Mathf.Lerp(0, 0.5, var_195_3)

					arg_192_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_192_1.var_.characterEffect4010ui_story.fillRatio = var_195_4
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect4010ui_story then
				local var_195_5 = 0.5

				arg_192_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_192_1.var_.characterEffect4010ui_story.fillRatio = var_195_5
			end

			local var_195_6 = arg_192_1.actors_["4010ui_story"].transform
			local var_195_7 = 0

			if var_195_7 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.var_.moveOldPos4010ui_story = var_195_6.localPosition
			end

			local var_195_8 = 0.001

			if var_195_7 <= arg_192_1.time_ and arg_192_1.time_ < var_195_7 + var_195_8 then
				local var_195_9 = (arg_192_1.time_ - var_195_7) / var_195_8
				local var_195_10 = Vector3.New(0, 100, 0)

				var_195_6.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos4010ui_story, var_195_10, var_195_9)

				local var_195_11 = manager.ui.mainCamera.transform.position - var_195_6.position

				var_195_6.forward = Vector3.New(var_195_11.x, var_195_11.y, var_195_11.z)

				local var_195_12 = var_195_6.localEulerAngles

				var_195_12.z = 0
				var_195_12.x = 0
				var_195_6.localEulerAngles = var_195_12
			end

			if arg_192_1.time_ >= var_195_7 + var_195_8 and arg_192_1.time_ < var_195_7 + var_195_8 + arg_195_0 then
				var_195_6.localPosition = Vector3.New(0, 100, 0)

				local var_195_13 = manager.ui.mainCamera.transform.position - var_195_6.position

				var_195_6.forward = Vector3.New(var_195_13.x, var_195_13.y, var_195_13.z)

				local var_195_14 = var_195_6.localEulerAngles

				var_195_14.z = 0
				var_195_14.x = 0
				var_195_6.localEulerAngles = var_195_14
			end

			local var_195_15 = arg_192_1.actors_["1095ui_story"].transform
			local var_195_16 = 0

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.var_.moveOldPos1095ui_story = var_195_15.localPosition
			end

			local var_195_17 = 0.001

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_17 then
				local var_195_18 = (arg_192_1.time_ - var_195_16) / var_195_17
				local var_195_19 = Vector3.New(0, 100, 0)

				var_195_15.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1095ui_story, var_195_19, var_195_18)

				local var_195_20 = manager.ui.mainCamera.transform.position - var_195_15.position

				var_195_15.forward = Vector3.New(var_195_20.x, var_195_20.y, var_195_20.z)

				local var_195_21 = var_195_15.localEulerAngles

				var_195_21.z = 0
				var_195_21.x = 0
				var_195_15.localEulerAngles = var_195_21
			end

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 then
				var_195_15.localPosition = Vector3.New(0, 100, 0)

				local var_195_22 = manager.ui.mainCamera.transform.position - var_195_15.position

				var_195_15.forward = Vector3.New(var_195_22.x, var_195_22.y, var_195_22.z)

				local var_195_23 = var_195_15.localEulerAngles

				var_195_23.z = 0
				var_195_23.x = 0
				var_195_15.localEulerAngles = var_195_23
			end

			local var_195_24 = manager.ui.mainCamera.transform
			local var_195_25 = 0

			if var_195_25 < arg_192_1.time_ and arg_192_1.time_ <= var_195_25 + arg_195_0 then
				arg_192_1.var_.shakeOldPos = var_195_24.localPosition
			end

			local var_195_26 = 0.816666666666667

			if var_195_25 <= arg_192_1.time_ and arg_192_1.time_ < var_195_25 + var_195_26 then
				local var_195_27 = (arg_192_1.time_ - var_195_25) / 0.066
				local var_195_28, var_195_29 = math.modf(var_195_27)

				var_195_24.localPosition = Vector3.New(var_195_29 * 0.13, var_195_29 * 0.13, var_195_29 * 0.13) + arg_192_1.var_.shakeOldPos
			end

			if arg_192_1.time_ >= var_195_25 + var_195_26 and arg_192_1.time_ < var_195_25 + var_195_26 + arg_195_0 then
				var_195_24.localPosition = arg_192_1.var_.shakeOldPos
			end

			local var_195_30 = 0

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			local var_195_31 = 0.816666666666667

			if arg_192_1.time_ >= var_195_30 + var_195_31 and arg_192_1.time_ < var_195_30 + var_195_31 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_32 = 0.816666666666667
			local var_195_33 = 0.675

			if var_195_32 < arg_192_1.time_ and arg_192_1.time_ <= var_195_32 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_34 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_34:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_35 = arg_192_1:GetWordFromCfg(411171045)
				local var_195_36 = arg_192_1:FormatText(var_195_35.content)

				arg_192_1.text_.text = var_195_36

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_37 = 27
				local var_195_38 = utf8.len(var_195_36)
				local var_195_39 = var_195_37 <= 0 and var_195_33 or var_195_33 * (var_195_38 / var_195_37)

				if var_195_39 > 0 and var_195_33 < var_195_39 then
					arg_192_1.talkMaxDuration = var_195_39
					var_195_32 = var_195_32 + 0.3

					if var_195_39 + var_195_32 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_39 + var_195_32
					end
				end

				arg_192_1.text_.text = var_195_36
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_40 = var_195_32 + 0.3
			local var_195_41 = math.max(var_195_33, arg_192_1.talkMaxDuration)

			if var_195_40 <= arg_192_1.time_ and arg_192_1.time_ < var_195_40 + var_195_41 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_40) / var_195_41

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_40 + var_195_41 and arg_192_1.time_ < var_195_40 + var_195_41 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_192_1:InitPlayNodeList()
	end,
	Play411171046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 411171046
		arg_198_1.duration_ = 4.63

		local var_198_0 = {
			zh = 1.999999999999,
			ja = 4.633
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
				arg_198_0:Play411171047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1095ui_story"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos1095ui_story = var_201_0.localPosition
			end

			local var_201_2 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2
				local var_201_4 = Vector3.New(0, -0.98, -6.1)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1095ui_story, var_201_4, var_201_3)

				local var_201_5 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_5.x, var_201_5.y, var_201_5.z)

				local var_201_6 = var_201_0.localEulerAngles

				var_201_6.z = 0
				var_201_6.x = 0
				var_201_0.localEulerAngles = var_201_6
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_201_7 = manager.ui.mainCamera.transform.position - var_201_0.position

				var_201_0.forward = Vector3.New(var_201_7.x, var_201_7.y, var_201_7.z)

				local var_201_8 = var_201_0.localEulerAngles

				var_201_8.z = 0
				var_201_8.x = 0
				var_201_0.localEulerAngles = var_201_8
			end

			local var_201_9 = arg_198_1.actors_["1095ui_story"]
			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1095ui_story == nil then
				arg_198_1.var_.characterEffect1095ui_story = var_201_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_11 = 0.200000002980232

			if var_201_10 <= arg_198_1.time_ and arg_198_1.time_ < var_201_10 + var_201_11 and not isNil(var_201_9) then
				local var_201_12 = (arg_198_1.time_ - var_201_10) / var_201_11

				if arg_198_1.var_.characterEffect1095ui_story and not isNil(var_201_9) then
					arg_198_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_10 + var_201_11 and arg_198_1.time_ < var_201_10 + var_201_11 + arg_201_0 and not isNil(var_201_9) and arg_198_1.var_.characterEffect1095ui_story then
				arg_198_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_201_13 = 0

			if var_201_13 < arg_198_1.time_ and arg_198_1.time_ <= var_201_13 + arg_201_0 then
				arg_198_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_201_14 = 0

			if var_201_14 < arg_198_1.time_ and arg_198_1.time_ <= var_201_14 + arg_201_0 then
				arg_198_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_201_15 = 0
			local var_201_16 = 0.3

			if var_201_15 < arg_198_1.time_ and arg_198_1.time_ <= var_201_15 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_17 = arg_198_1:FormatText(StoryNameCfg[471].name)

				arg_198_1.leftNameTxt_.text = var_201_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_18 = arg_198_1:GetWordFromCfg(411171046)
				local var_201_19 = arg_198_1:FormatText(var_201_18.content)

				arg_198_1.text_.text = var_201_19

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_20 = 12
				local var_201_21 = utf8.len(var_201_19)
				local var_201_22 = var_201_20 <= 0 and var_201_16 or var_201_16 * (var_201_21 / var_201_20)

				if var_201_22 > 0 and var_201_16 < var_201_22 then
					arg_198_1.talkMaxDuration = var_201_22

					if var_201_22 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_22 + var_201_15
					end
				end

				arg_198_1.text_.text = var_201_19
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171046", "story_v_out_411171.awb") ~= 0 then
					local var_201_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171046", "story_v_out_411171.awb") / 1000

					if var_201_23 + var_201_15 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_23 + var_201_15
					end

					if var_201_18.prefab_name ~= "" and arg_198_1.actors_[var_201_18.prefab_name] ~= nil then
						local var_201_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_18.prefab_name].transform, "story_v_out_411171", "411171046", "story_v_out_411171.awb")

						arg_198_1:RecordAudio("411171046", var_201_24)
						arg_198_1:RecordAudio("411171046", var_201_24)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_411171", "411171046", "story_v_out_411171.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_411171", "411171046", "story_v_out_411171.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_25 = math.max(var_201_16, arg_198_1.talkMaxDuration)

			if var_201_15 <= arg_198_1.time_ and arg_198_1.time_ < var_201_15 + var_201_25 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_15) / var_201_25

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_15 + var_201_25 and arg_198_1.time_ < var_201_15 + var_201_25 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play411171047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 411171047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play411171048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1095ui_story"].transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.var_.moveOldPos1095ui_story = var_205_0.localPosition
			end

			local var_205_2 = 0.001

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2
				local var_205_4 = Vector3.New(0, 100, 0)

				var_205_0.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1095ui_story, var_205_4, var_205_3)

				local var_205_5 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_5.x, var_205_5.y, var_205_5.z)

				local var_205_6 = var_205_0.localEulerAngles

				var_205_6.z = 0
				var_205_6.x = 0
				var_205_0.localEulerAngles = var_205_6
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 then
				var_205_0.localPosition = Vector3.New(0, 100, 0)

				local var_205_7 = manager.ui.mainCamera.transform.position - var_205_0.position

				var_205_0.forward = Vector3.New(var_205_7.x, var_205_7.y, var_205_7.z)

				local var_205_8 = var_205_0.localEulerAngles

				var_205_8.z = 0
				var_205_8.x = 0
				var_205_0.localEulerAngles = var_205_8
			end

			local var_205_9 = arg_202_1.actors_["1095ui_story"]
			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1095ui_story == nil then
				arg_202_1.var_.characterEffect1095ui_story = var_205_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_11 = 0.200000002980232

			if var_205_10 <= arg_202_1.time_ and arg_202_1.time_ < var_205_10 + var_205_11 and not isNil(var_205_9) then
				local var_205_12 = (arg_202_1.time_ - var_205_10) / var_205_11

				if arg_202_1.var_.characterEffect1095ui_story and not isNil(var_205_9) then
					local var_205_13 = Mathf.Lerp(0, 0.5, var_205_12)

					arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1095ui_story.fillRatio = var_205_13
				end
			end

			if arg_202_1.time_ >= var_205_10 + var_205_11 and arg_202_1.time_ < var_205_10 + var_205_11 + arg_205_0 and not isNil(var_205_9) and arg_202_1.var_.characterEffect1095ui_story then
				local var_205_14 = 0.5

				arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1095ui_story.fillRatio = var_205_14
			end

			local var_205_15 = 0
			local var_205_16 = 0.6

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_17 = arg_202_1:GetWordFromCfg(411171047)
				local var_205_18 = arg_202_1:FormatText(var_205_17.content)

				arg_202_1.text_.text = var_205_18

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_19 = 24
				local var_205_20 = utf8.len(var_205_18)
				local var_205_21 = var_205_19 <= 0 and var_205_16 or var_205_16 * (var_205_20 / var_205_19)

				if var_205_21 > 0 and var_205_16 < var_205_21 then
					arg_202_1.talkMaxDuration = var_205_21

					if var_205_21 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_21 + var_205_15
					end
				end

				arg_202_1.text_.text = var_205_18
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_22 = math.max(var_205_16, arg_202_1.talkMaxDuration)

			if var_205_15 <= arg_202_1.time_ and arg_202_1.time_ < var_205_15 + var_205_22 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_15) / var_205_22

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_15 + var_205_22 and arg_202_1.time_ < var_205_15 + var_205_22 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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

		arg_202_1:InitPlayNodeList()
	end,
	Play411171048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 411171048
		arg_206_1.duration_ = 9.53

		local var_206_0 = {
			zh = 9.2,
			ja = 9.533
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
				arg_206_0:Play411171049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1095ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1095ui_story == nil then
				arg_206_1.var_.characterEffect1095ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect1095ui_story and not isNil(var_209_0) then
					arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1095ui_story then
				arg_206_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_209_4 = 0

			if var_209_4 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_209_5 = 0

			if var_209_5 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_209_6 = arg_206_1.actors_["1095ui_story"].transform
			local var_209_7 = 0

			if var_209_7 < arg_206_1.time_ and arg_206_1.time_ <= var_209_7 + arg_209_0 then
				arg_206_1.var_.moveOldPos1095ui_story = var_209_6.localPosition
			end

			local var_209_8 = 0.001

			if var_209_7 <= arg_206_1.time_ and arg_206_1.time_ < var_209_7 + var_209_8 then
				local var_209_9 = (arg_206_1.time_ - var_209_7) / var_209_8
				local var_209_10 = Vector3.New(0, -0.98, -6.1)

				var_209_6.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1095ui_story, var_209_10, var_209_9)

				local var_209_11 = manager.ui.mainCamera.transform.position - var_209_6.position

				var_209_6.forward = Vector3.New(var_209_11.x, var_209_11.y, var_209_11.z)

				local var_209_12 = var_209_6.localEulerAngles

				var_209_12.z = 0
				var_209_12.x = 0
				var_209_6.localEulerAngles = var_209_12
			end

			if arg_206_1.time_ >= var_209_7 + var_209_8 and arg_206_1.time_ < var_209_7 + var_209_8 + arg_209_0 then
				var_209_6.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_209_13 = manager.ui.mainCamera.transform.position - var_209_6.position

				var_209_6.forward = Vector3.New(var_209_13.x, var_209_13.y, var_209_13.z)

				local var_209_14 = var_209_6.localEulerAngles

				var_209_14.z = 0
				var_209_14.x = 0
				var_209_6.localEulerAngles = var_209_14
			end

			local var_209_15 = 0
			local var_209_16 = 1.15

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[471].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(411171048)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 46
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171048", "story_v_out_411171.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171048", "story_v_out_411171.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_411171", "411171048", "story_v_out_411171.awb")

						arg_206_1:RecordAudio("411171048", var_209_24)
						arg_206_1:RecordAudio("411171048", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_411171", "411171048", "story_v_out_411171.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_411171", "411171048", "story_v_out_411171.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play411171049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 411171049
		arg_210_1.duration_ = 9.37

		local var_210_0 = {
			zh = 8.2,
			ja = 9.366
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play411171050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 1.1

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_2 = arg_210_1:FormatText(StoryNameCfg[471].name)

				arg_210_1.leftNameTxt_.text = var_213_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_3 = arg_210_1:GetWordFromCfg(411171049)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 44
				local var_213_6 = utf8.len(var_213_4)
				local var_213_7 = var_213_5 <= 0 and var_213_1 or var_213_1 * (var_213_6 / var_213_5)

				if var_213_7 > 0 and var_213_1 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171049", "story_v_out_411171.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171049", "story_v_out_411171.awb") / 1000

					if var_213_8 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_0
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_411171", "411171049", "story_v_out_411171.awb")

						arg_210_1:RecordAudio("411171049", var_213_9)
						arg_210_1:RecordAudio("411171049", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_411171", "411171049", "story_v_out_411171.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_411171", "411171049", "story_v_out_411171.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_10 and arg_210_1.time_ < var_213_0 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play411171050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 411171050
		arg_214_1.duration_ = 4.5

		local var_214_0 = {
			zh = 4.5,
			ja = 2.566
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
				arg_214_0:Play411171051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["4010ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos4010ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(-0.7, -1.59, -5.2)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos4010ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = arg_214_1.actors_["4010ui_story"]
			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect4010ui_story == nil then
				arg_214_1.var_.characterEffect4010ui_story = var_217_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_11 and not isNil(var_217_9) then
				local var_217_12 = (arg_214_1.time_ - var_217_10) / var_217_11

				if arg_214_1.var_.characterEffect4010ui_story and not isNil(var_217_9) then
					arg_214_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_10 + var_217_11 and arg_214_1.time_ < var_217_10 + var_217_11 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect4010ui_story then
				arg_214_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_217_14 = 0

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_217_15 = arg_214_1.actors_["1095ui_story"].transform
			local var_217_16 = 0

			if var_217_16 < arg_214_1.time_ and arg_214_1.time_ <= var_217_16 + arg_217_0 then
				arg_214_1.var_.moveOldPos1095ui_story = var_217_15.localPosition
			end

			local var_217_17 = 0.001

			if var_217_16 <= arg_214_1.time_ and arg_214_1.time_ < var_217_16 + var_217_17 then
				local var_217_18 = (arg_214_1.time_ - var_217_16) / var_217_17
				local var_217_19 = Vector3.New(0.7, -0.98, -6.1)

				var_217_15.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1095ui_story, var_217_19, var_217_18)

				local var_217_20 = manager.ui.mainCamera.transform.position - var_217_15.position

				var_217_15.forward = Vector3.New(var_217_20.x, var_217_20.y, var_217_20.z)

				local var_217_21 = var_217_15.localEulerAngles

				var_217_21.z = 0
				var_217_21.x = 0
				var_217_15.localEulerAngles = var_217_21
			end

			if arg_214_1.time_ >= var_217_16 + var_217_17 and arg_214_1.time_ < var_217_16 + var_217_17 + arg_217_0 then
				var_217_15.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_217_22 = manager.ui.mainCamera.transform.position - var_217_15.position

				var_217_15.forward = Vector3.New(var_217_22.x, var_217_22.y, var_217_22.z)

				local var_217_23 = var_217_15.localEulerAngles

				var_217_23.z = 0
				var_217_23.x = 0
				var_217_15.localEulerAngles = var_217_23
			end

			local var_217_24 = arg_214_1.actors_["1095ui_story"]
			local var_217_25 = 0

			if var_217_25 < arg_214_1.time_ and arg_214_1.time_ <= var_217_25 + arg_217_0 and not isNil(var_217_24) and arg_214_1.var_.characterEffect1095ui_story == nil then
				arg_214_1.var_.characterEffect1095ui_story = var_217_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_26 = 0.200000002980232

			if var_217_25 <= arg_214_1.time_ and arg_214_1.time_ < var_217_25 + var_217_26 and not isNil(var_217_24) then
				local var_217_27 = (arg_214_1.time_ - var_217_25) / var_217_26

				if arg_214_1.var_.characterEffect1095ui_story and not isNil(var_217_24) then
					local var_217_28 = Mathf.Lerp(0, 0.5, var_217_27)

					arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1095ui_story.fillRatio = var_217_28
				end
			end

			if arg_214_1.time_ >= var_217_25 + var_217_26 and arg_214_1.time_ < var_217_25 + var_217_26 + arg_217_0 and not isNil(var_217_24) and arg_214_1.var_.characterEffect1095ui_story then
				local var_217_29 = 0.5

				arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1095ui_story.fillRatio = var_217_29
			end

			local var_217_30 = 0
			local var_217_31 = 0.575

			if var_217_30 < arg_214_1.time_ and arg_214_1.time_ <= var_217_30 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_32 = arg_214_1:FormatText(StoryNameCfg[42].name)

				arg_214_1.leftNameTxt_.text = var_217_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_33 = arg_214_1:GetWordFromCfg(411171050)
				local var_217_34 = arg_214_1:FormatText(var_217_33.content)

				arg_214_1.text_.text = var_217_34

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_35 = 23
				local var_217_36 = utf8.len(var_217_34)
				local var_217_37 = var_217_35 <= 0 and var_217_31 or var_217_31 * (var_217_36 / var_217_35)

				if var_217_37 > 0 and var_217_31 < var_217_37 then
					arg_214_1.talkMaxDuration = var_217_37

					if var_217_37 + var_217_30 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_37 + var_217_30
					end
				end

				arg_214_1.text_.text = var_217_34
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171050", "story_v_out_411171.awb") ~= 0 then
					local var_217_38 = manager.audio:GetVoiceLength("story_v_out_411171", "411171050", "story_v_out_411171.awb") / 1000

					if var_217_38 + var_217_30 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_38 + var_217_30
					end

					if var_217_33.prefab_name ~= "" and arg_214_1.actors_[var_217_33.prefab_name] ~= nil then
						local var_217_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_33.prefab_name].transform, "story_v_out_411171", "411171050", "story_v_out_411171.awb")

						arg_214_1:RecordAudio("411171050", var_217_39)
						arg_214_1:RecordAudio("411171050", var_217_39)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_411171", "411171050", "story_v_out_411171.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_411171", "411171050", "story_v_out_411171.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_40 = math.max(var_217_31, arg_214_1.talkMaxDuration)

			if var_217_30 <= arg_214_1.time_ and arg_214_1.time_ < var_217_30 + var_217_40 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_30) / var_217_40

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_30 + var_217_40 and arg_214_1.time_ < var_217_30 + var_217_40 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_214_1:InitPlayNodeList()
	end,
	Play411171051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 411171051
		arg_218_1.duration_ = 6.1

		local var_218_0 = {
			zh = 5.633,
			ja = 6.1
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play411171052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["4010ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect4010ui_story == nil then
				arg_218_1.var_.characterEffect4010ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect4010ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_218_1.var_.characterEffect4010ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect4010ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_218_1.var_.characterEffect4010ui_story.fillRatio = var_221_5
			end

			local var_221_6 = arg_218_1.actors_["1095ui_story"]
			local var_221_7 = 0

			if var_221_7 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect1095ui_story == nil then
				arg_218_1.var_.characterEffect1095ui_story = var_221_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_8 = 0.200000002980232

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_8 and not isNil(var_221_6) then
				local var_221_9 = (arg_218_1.time_ - var_221_7) / var_221_8

				if arg_218_1.var_.characterEffect1095ui_story and not isNil(var_221_6) then
					arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_7 + var_221_8 and arg_218_1.time_ < var_221_7 + var_221_8 + arg_221_0 and not isNil(var_221_6) and arg_218_1.var_.characterEffect1095ui_story then
				arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_221_11 = 0

			if var_221_11 < arg_218_1.time_ and arg_218_1.time_ <= var_221_11 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_221_12 = 0
			local var_221_13 = 0.65

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_14 = arg_218_1:FormatText(StoryNameCfg[471].name)

				arg_218_1.leftNameTxt_.text = var_221_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_15 = arg_218_1:GetWordFromCfg(411171051)
				local var_221_16 = arg_218_1:FormatText(var_221_15.content)

				arg_218_1.text_.text = var_221_16

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_17 = 26
				local var_221_18 = utf8.len(var_221_16)
				local var_221_19 = var_221_17 <= 0 and var_221_13 or var_221_13 * (var_221_18 / var_221_17)

				if var_221_19 > 0 and var_221_13 < var_221_19 then
					arg_218_1.talkMaxDuration = var_221_19

					if var_221_19 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_19 + var_221_12
					end
				end

				arg_218_1.text_.text = var_221_16
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171051", "story_v_out_411171.awb") ~= 0 then
					local var_221_20 = manager.audio:GetVoiceLength("story_v_out_411171", "411171051", "story_v_out_411171.awb") / 1000

					if var_221_20 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_20 + var_221_12
					end

					if var_221_15.prefab_name ~= "" and arg_218_1.actors_[var_221_15.prefab_name] ~= nil then
						local var_221_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_15.prefab_name].transform, "story_v_out_411171", "411171051", "story_v_out_411171.awb")

						arg_218_1:RecordAudio("411171051", var_221_21)
						arg_218_1:RecordAudio("411171051", var_221_21)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_411171", "411171051", "story_v_out_411171.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_411171", "411171051", "story_v_out_411171.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_22 = math.max(var_221_13, arg_218_1.talkMaxDuration)

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_22 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_12) / var_221_22

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_12 + var_221_22 and arg_218_1.time_ < var_221_12 + var_221_22 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play411171052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 411171052
		arg_222_1.duration_ = 5

		local var_222_0 = {
			zh = 5,
			ja = 3.7
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
				arg_222_0:Play411171053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["4010ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect4010ui_story == nil then
				arg_222_1.var_.characterEffect4010ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect4010ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect4010ui_story then
				arg_222_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_225_4 = arg_222_1.actors_["1095ui_story"]
			local var_225_5 = 0

			if var_225_5 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 and not isNil(var_225_4) and arg_222_1.var_.characterEffect1095ui_story == nil then
				arg_222_1.var_.characterEffect1095ui_story = var_225_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_6 = 0.200000002980232

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_6 and not isNil(var_225_4) then
				local var_225_7 = (arg_222_1.time_ - var_225_5) / var_225_6

				if arg_222_1.var_.characterEffect1095ui_story and not isNil(var_225_4) then
					local var_225_8 = Mathf.Lerp(0, 0.5, var_225_7)

					arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1095ui_story.fillRatio = var_225_8
				end
			end

			if arg_222_1.time_ >= var_225_5 + var_225_6 and arg_222_1.time_ < var_225_5 + var_225_6 + arg_225_0 and not isNil(var_225_4) and arg_222_1.var_.characterEffect1095ui_story then
				local var_225_9 = 0.5

				arg_222_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1095ui_story.fillRatio = var_225_9
			end

			local var_225_10 = 0
			local var_225_11 = 0.6

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_12 = arg_222_1:FormatText(StoryNameCfg[42].name)

				arg_222_1.leftNameTxt_.text = var_225_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_13 = arg_222_1:GetWordFromCfg(411171052)
				local var_225_14 = arg_222_1:FormatText(var_225_13.content)

				arg_222_1.text_.text = var_225_14

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_15 = 24
				local var_225_16 = utf8.len(var_225_14)
				local var_225_17 = var_225_15 <= 0 and var_225_11 or var_225_11 * (var_225_16 / var_225_15)

				if var_225_17 > 0 and var_225_11 < var_225_17 then
					arg_222_1.talkMaxDuration = var_225_17

					if var_225_17 + var_225_10 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_17 + var_225_10
					end
				end

				arg_222_1.text_.text = var_225_14
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171052", "story_v_out_411171.awb") ~= 0 then
					local var_225_18 = manager.audio:GetVoiceLength("story_v_out_411171", "411171052", "story_v_out_411171.awb") / 1000

					if var_225_18 + var_225_10 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_18 + var_225_10
					end

					if var_225_13.prefab_name ~= "" and arg_222_1.actors_[var_225_13.prefab_name] ~= nil then
						local var_225_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_13.prefab_name].transform, "story_v_out_411171", "411171052", "story_v_out_411171.awb")

						arg_222_1:RecordAudio("411171052", var_225_19)
						arg_222_1:RecordAudio("411171052", var_225_19)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_411171", "411171052", "story_v_out_411171.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_411171", "411171052", "story_v_out_411171.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_20 = math.max(var_225_11, arg_222_1.talkMaxDuration)

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_20 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_10) / var_225_20

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_10 + var_225_20 and arg_222_1.time_ < var_225_10 + var_225_20 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play411171053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 411171053
		arg_226_1.duration_ = 3.43

		local var_226_0 = {
			zh = 2.966,
			ja = 3.433
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
				arg_226_0:Play411171054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["4010ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect4010ui_story == nil then
				arg_226_1.var_.characterEffect4010ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect4010ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_226_1.var_.characterEffect4010ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect4010ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_226_1.var_.characterEffect4010ui_story.fillRatio = var_229_5
			end

			local var_229_6 = arg_226_1.actors_["1095ui_story"]
			local var_229_7 = 0

			if var_229_7 < arg_226_1.time_ and arg_226_1.time_ <= var_229_7 + arg_229_0 and not isNil(var_229_6) and arg_226_1.var_.characterEffect1095ui_story == nil then
				arg_226_1.var_.characterEffect1095ui_story = var_229_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_8 = 0.200000002980232

			if var_229_7 <= arg_226_1.time_ and arg_226_1.time_ < var_229_7 + var_229_8 and not isNil(var_229_6) then
				local var_229_9 = (arg_226_1.time_ - var_229_7) / var_229_8

				if arg_226_1.var_.characterEffect1095ui_story and not isNil(var_229_6) then
					arg_226_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_7 + var_229_8 and arg_226_1.time_ < var_229_7 + var_229_8 + arg_229_0 and not isNil(var_229_6) and arg_226_1.var_.characterEffect1095ui_story then
				arg_226_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 then
				arg_226_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_11 = 0
			local var_229_12 = 0.35

			if var_229_11 < arg_226_1.time_ and arg_226_1.time_ <= var_229_11 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_13 = arg_226_1:FormatText(StoryNameCfg[471].name)

				arg_226_1.leftNameTxt_.text = var_229_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_14 = arg_226_1:GetWordFromCfg(411171053)
				local var_229_15 = arg_226_1:FormatText(var_229_14.content)

				arg_226_1.text_.text = var_229_15

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_16 = 14
				local var_229_17 = utf8.len(var_229_15)
				local var_229_18 = var_229_16 <= 0 and var_229_12 or var_229_12 * (var_229_17 / var_229_16)

				if var_229_18 > 0 and var_229_12 < var_229_18 then
					arg_226_1.talkMaxDuration = var_229_18

					if var_229_18 + var_229_11 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_18 + var_229_11
					end
				end

				arg_226_1.text_.text = var_229_15
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171053", "story_v_out_411171.awb") ~= 0 then
					local var_229_19 = manager.audio:GetVoiceLength("story_v_out_411171", "411171053", "story_v_out_411171.awb") / 1000

					if var_229_19 + var_229_11 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_19 + var_229_11
					end

					if var_229_14.prefab_name ~= "" and arg_226_1.actors_[var_229_14.prefab_name] ~= nil then
						local var_229_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_14.prefab_name].transform, "story_v_out_411171", "411171053", "story_v_out_411171.awb")

						arg_226_1:RecordAudio("411171053", var_229_20)
						arg_226_1:RecordAudio("411171053", var_229_20)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_411171", "411171053", "story_v_out_411171.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_411171", "411171053", "story_v_out_411171.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_21 = math.max(var_229_12, arg_226_1.talkMaxDuration)

			if var_229_11 <= arg_226_1.time_ and arg_226_1.time_ < var_229_11 + var_229_21 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_11) / var_229_21

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_11 + var_229_21 and arg_226_1.time_ < var_229_11 + var_229_21 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play411171054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 411171054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play411171055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["4010ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos4010ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, 100, 0)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos4010ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, 100, 0)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["4010ui_story"]
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect4010ui_story == nil then
				arg_230_1.var_.characterEffect4010ui_story = var_233_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_11 = 0.200000002980232

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 and not isNil(var_233_9) then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11

				if arg_230_1.var_.characterEffect4010ui_story and not isNil(var_233_9) then
					local var_233_13 = Mathf.Lerp(0, 0.5, var_233_12)

					arg_230_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_230_1.var_.characterEffect4010ui_story.fillRatio = var_233_13
				end
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 and not isNil(var_233_9) and arg_230_1.var_.characterEffect4010ui_story then
				local var_233_14 = 0.5

				arg_230_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_230_1.var_.characterEffect4010ui_story.fillRatio = var_233_14
			end

			local var_233_15 = arg_230_1.actors_["1095ui_story"].transform
			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.var_.moveOldPos1095ui_story = var_233_15.localPosition
			end

			local var_233_17 = 0.001

			if var_233_16 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_17 then
				local var_233_18 = (arg_230_1.time_ - var_233_16) / var_233_17
				local var_233_19 = Vector3.New(0, 100, 0)

				var_233_15.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1095ui_story, var_233_19, var_233_18)

				local var_233_20 = manager.ui.mainCamera.transform.position - var_233_15.position

				var_233_15.forward = Vector3.New(var_233_20.x, var_233_20.y, var_233_20.z)

				local var_233_21 = var_233_15.localEulerAngles

				var_233_21.z = 0
				var_233_21.x = 0
				var_233_15.localEulerAngles = var_233_21
			end

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				var_233_15.localPosition = Vector3.New(0, 100, 0)

				local var_233_22 = manager.ui.mainCamera.transform.position - var_233_15.position

				var_233_15.forward = Vector3.New(var_233_22.x, var_233_22.y, var_233_22.z)

				local var_233_23 = var_233_15.localEulerAngles

				var_233_23.z = 0
				var_233_23.x = 0
				var_233_15.localEulerAngles = var_233_23
			end

			local var_233_24 = arg_230_1.actors_["1095ui_story"]
			local var_233_25 = 0

			if var_233_25 < arg_230_1.time_ and arg_230_1.time_ <= var_233_25 + arg_233_0 and not isNil(var_233_24) and arg_230_1.var_.characterEffect1095ui_story == nil then
				arg_230_1.var_.characterEffect1095ui_story = var_233_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_26 = 0.200000002980232

			if var_233_25 <= arg_230_1.time_ and arg_230_1.time_ < var_233_25 + var_233_26 and not isNil(var_233_24) then
				local var_233_27 = (arg_230_1.time_ - var_233_25) / var_233_26

				if arg_230_1.var_.characterEffect1095ui_story and not isNil(var_233_24) then
					local var_233_28 = Mathf.Lerp(0, 0.5, var_233_27)

					arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1095ui_story.fillRatio = var_233_28
				end
			end

			if arg_230_1.time_ >= var_233_25 + var_233_26 and arg_230_1.time_ < var_233_25 + var_233_26 + arg_233_0 and not isNil(var_233_24) and arg_230_1.var_.characterEffect1095ui_story then
				local var_233_29 = 0.5

				arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1095ui_story.fillRatio = var_233_29
			end

			local var_233_30 = 0
			local var_233_31 = 1.025

			if var_233_30 < arg_230_1.time_ and arg_230_1.time_ <= var_233_30 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_32 = arg_230_1:GetWordFromCfg(411171054)
				local var_233_33 = arg_230_1:FormatText(var_233_32.content)

				arg_230_1.text_.text = var_233_33

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_34 = 41
				local var_233_35 = utf8.len(var_233_33)
				local var_233_36 = var_233_34 <= 0 and var_233_31 or var_233_31 * (var_233_35 / var_233_34)

				if var_233_36 > 0 and var_233_31 < var_233_36 then
					arg_230_1.talkMaxDuration = var_233_36

					if var_233_36 + var_233_30 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_36 + var_233_30
					end
				end

				arg_230_1.text_.text = var_233_33
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_37 = math.max(var_233_31, arg_230_1.talkMaxDuration)

			if var_233_30 <= arg_230_1.time_ and arg_230_1.time_ < var_233_30 + var_233_37 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_30) / var_233_37

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_30 + var_233_37 and arg_230_1.time_ < var_233_30 + var_233_37 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_230_1:InitPlayNodeList()
	end,
	Play411171055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 411171055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play411171056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 1.125

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_2 = arg_234_1:GetWordFromCfg(411171055)
				local var_237_3 = arg_234_1:FormatText(var_237_2.content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 45
				local var_237_5 = utf8.len(var_237_3)
				local var_237_6 = var_237_4 <= 0 and var_237_1 or var_237_1 * (var_237_5 / var_237_4)

				if var_237_6 > 0 and var_237_1 < var_237_6 then
					arg_234_1.talkMaxDuration = var_237_6

					if var_237_6 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_7 and arg_234_1.time_ < var_237_0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play411171056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 411171056
		arg_238_1.duration_ = 8.44

		local var_238_0 = {
			zh = 4.849999999999,
			ja = 8.44100000298023
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
				arg_238_0:Play411171057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1095ui_story"].transform
			local var_241_1 = 2.85

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1095ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, -0.98, -6.1)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1095ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["1095ui_story"]
			local var_241_10 = 2.85

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1095ui_story == nil then
				arg_238_1.var_.characterEffect1095ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect1095ui_story and not isNil(var_241_9) then
					arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1095ui_story then
				arg_238_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_241_13 = 2.85

			if var_241_13 < arg_238_1.time_ and arg_238_1.time_ <= var_241_13 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_241_14 = 2.85

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_15 = 1.55

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				local var_241_16 = manager.ui.mainCamera.transform.localPosition
				local var_241_17 = Vector3.New(0, 0, 10) + Vector3.New(var_241_16.x, var_241_16.y, 0)
				local var_241_18 = arg_238_1.bgs_.ST75

				var_241_18.transform.localPosition = var_241_17
				var_241_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_19 = var_241_18:GetComponent("SpriteRenderer")

				if var_241_19 and var_241_19.sprite then
					local var_241_20 = (var_241_18.transform.localPosition - var_241_16).z
					local var_241_21 = manager.ui.mainCameraCom_
					local var_241_22 = 2 * var_241_20 * Mathf.Tan(var_241_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_241_23 = var_241_22 * var_241_21.aspect
					local var_241_24 = var_241_19.sprite.bounds.size.x
					local var_241_25 = var_241_19.sprite.bounds.size.y
					local var_241_26 = var_241_23 / var_241_24
					local var_241_27 = var_241_22 / var_241_25
					local var_241_28 = var_241_27 < var_241_26 and var_241_26 or var_241_27

					var_241_18.transform.localScale = Vector3.New(var_241_28, var_241_28, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "ST75" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_29 = 0

			if var_241_29 < arg_238_1.time_ and arg_238_1.time_ <= var_241_29 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_30 = 1.55

			if var_241_29 <= arg_238_1.time_ and arg_238_1.time_ < var_241_29 + var_241_30 then
				local var_241_31 = (arg_238_1.time_ - var_241_29) / var_241_30
				local var_241_32 = Color.New(0, 0, 0)

				var_241_32.a = Mathf.Lerp(0, 1, var_241_31)
				arg_238_1.mask_.color = var_241_32
			end

			if arg_238_1.time_ >= var_241_29 + var_241_30 and arg_238_1.time_ < var_241_29 + var_241_30 + arg_241_0 then
				local var_241_33 = Color.New(0, 0, 0)

				var_241_33.a = 1
				arg_238_1.mask_.color = var_241_33
			end

			local var_241_34 = 1.55

			if var_241_34 < arg_238_1.time_ and arg_238_1.time_ <= var_241_34 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_35 = 1.45

			if var_241_34 <= arg_238_1.time_ and arg_238_1.time_ < var_241_34 + var_241_35 then
				local var_241_36 = (arg_238_1.time_ - var_241_34) / var_241_35
				local var_241_37 = Color.New(0, 0, 0)

				var_241_37.a = Mathf.Lerp(1, 0, var_241_36)
				arg_238_1.mask_.color = var_241_37
			end

			if arg_238_1.time_ >= var_241_34 + var_241_35 and arg_238_1.time_ < var_241_34 + var_241_35 + arg_241_0 then
				local var_241_38 = Color.New(0, 0, 0)
				local var_241_39 = 0

				arg_238_1.mask_.enabled = false
				var_241_38.a = var_241_39
				arg_238_1.mask_.color = var_241_38
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_40 = 2.97500000298023
			local var_241_41 = 0.225

			if var_241_40 < arg_238_1.time_ and arg_238_1.time_ <= var_241_40 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_42 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_42:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_43 = arg_238_1:FormatText(StoryNameCfg[471].name)

				arg_238_1.leftNameTxt_.text = var_241_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_44 = arg_238_1:GetWordFromCfg(411171056)
				local var_241_45 = arg_238_1:FormatText(var_241_44.content)

				arg_238_1.text_.text = var_241_45

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_46 = 9
				local var_241_47 = utf8.len(var_241_45)
				local var_241_48 = var_241_46 <= 0 and var_241_41 or var_241_41 * (var_241_47 / var_241_46)

				if var_241_48 > 0 and var_241_41 < var_241_48 then
					arg_238_1.talkMaxDuration = var_241_48
					var_241_40 = var_241_40 + 0.3

					if var_241_48 + var_241_40 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_48 + var_241_40
					end
				end

				arg_238_1.text_.text = var_241_45
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171056", "story_v_out_411171.awb") ~= 0 then
					local var_241_49 = manager.audio:GetVoiceLength("story_v_out_411171", "411171056", "story_v_out_411171.awb") / 1000

					if var_241_49 + var_241_40 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_49 + var_241_40
					end

					if var_241_44.prefab_name ~= "" and arg_238_1.actors_[var_241_44.prefab_name] ~= nil then
						local var_241_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_44.prefab_name].transform, "story_v_out_411171", "411171056", "story_v_out_411171.awb")

						arg_238_1:RecordAudio("411171056", var_241_50)
						arg_238_1:RecordAudio("411171056", var_241_50)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_411171", "411171056", "story_v_out_411171.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_411171", "411171056", "story_v_out_411171.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_51 = var_241_40 + 0.3
			local var_241_52 = math.max(var_241_41, arg_238_1.talkMaxDuration)

			if var_241_51 <= arg_238_1.time_ and arg_238_1.time_ < var_241_51 + var_241_52 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_51) / var_241_52

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_51 + var_241_52 and arg_238_1.time_ < var_241_51 + var_241_52 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.85,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play411171057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 411171057
		arg_244_1.duration_ = 9.77

		local var_244_0 = {
			zh = 6.066,
			ja = 9.766
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play411171058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["4010ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos4010ui_story = var_247_0.localPosition
			end

			local var_247_2 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2
				local var_247_4 = Vector3.New(0, -1.59, -5.2)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos4010ui_story, var_247_4, var_247_3)

				local var_247_5 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_5.x, var_247_5.y, var_247_5.z)

				local var_247_6 = var_247_0.localEulerAngles

				var_247_6.z = 0
				var_247_6.x = 0
				var_247_0.localEulerAngles = var_247_6
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_247_7 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_7.x, var_247_7.y, var_247_7.z)

				local var_247_8 = var_247_0.localEulerAngles

				var_247_8.z = 0
				var_247_8.x = 0
				var_247_0.localEulerAngles = var_247_8
			end

			local var_247_9 = arg_244_1.actors_["4010ui_story"]
			local var_247_10 = 0

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect4010ui_story == nil then
				arg_244_1.var_.characterEffect4010ui_story = var_247_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_11 = 0.200000002980232

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_11 and not isNil(var_247_9) then
				local var_247_12 = (arg_244_1.time_ - var_247_10) / var_247_11

				if arg_244_1.var_.characterEffect4010ui_story and not isNil(var_247_9) then
					arg_244_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_10 + var_247_11 and arg_244_1.time_ < var_247_10 + var_247_11 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect4010ui_story then
				arg_244_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_247_13 = 0

			if var_247_13 < arg_244_1.time_ and arg_244_1.time_ <= var_247_13 + arg_247_0 then
				arg_244_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_247_14 = 0

			if var_247_14 < arg_244_1.time_ and arg_244_1.time_ <= var_247_14 + arg_247_0 then
				arg_244_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_247_15 = arg_244_1.actors_["1095ui_story"].transform
			local var_247_16 = 0

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.var_.moveOldPos1095ui_story = var_247_15.localPosition
			end

			local var_247_17 = 0.001

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_17 then
				local var_247_18 = (arg_244_1.time_ - var_247_16) / var_247_17
				local var_247_19 = Vector3.New(0, 100, 0)

				var_247_15.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1095ui_story, var_247_19, var_247_18)

				local var_247_20 = manager.ui.mainCamera.transform.position - var_247_15.position

				var_247_15.forward = Vector3.New(var_247_20.x, var_247_20.y, var_247_20.z)

				local var_247_21 = var_247_15.localEulerAngles

				var_247_21.z = 0
				var_247_21.x = 0
				var_247_15.localEulerAngles = var_247_21
			end

			if arg_244_1.time_ >= var_247_16 + var_247_17 and arg_244_1.time_ < var_247_16 + var_247_17 + arg_247_0 then
				var_247_15.localPosition = Vector3.New(0, 100, 0)

				local var_247_22 = manager.ui.mainCamera.transform.position - var_247_15.position

				var_247_15.forward = Vector3.New(var_247_22.x, var_247_22.y, var_247_22.z)

				local var_247_23 = var_247_15.localEulerAngles

				var_247_23.z = 0
				var_247_23.x = 0
				var_247_15.localEulerAngles = var_247_23
			end

			local var_247_24 = arg_244_1.actors_["1095ui_story"]
			local var_247_25 = 0

			if var_247_25 < arg_244_1.time_ and arg_244_1.time_ <= var_247_25 + arg_247_0 and not isNil(var_247_24) and arg_244_1.var_.characterEffect1095ui_story == nil then
				arg_244_1.var_.characterEffect1095ui_story = var_247_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_26 = 0.200000002980232

			if var_247_25 <= arg_244_1.time_ and arg_244_1.time_ < var_247_25 + var_247_26 and not isNil(var_247_24) then
				local var_247_27 = (arg_244_1.time_ - var_247_25) / var_247_26

				if arg_244_1.var_.characterEffect1095ui_story and not isNil(var_247_24) then
					local var_247_28 = Mathf.Lerp(0, 0.5, var_247_27)

					arg_244_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1095ui_story.fillRatio = var_247_28
				end
			end

			if arg_244_1.time_ >= var_247_25 + var_247_26 and arg_244_1.time_ < var_247_25 + var_247_26 + arg_247_0 and not isNil(var_247_24) and arg_244_1.var_.characterEffect1095ui_story then
				local var_247_29 = 0.5

				arg_244_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1095ui_story.fillRatio = var_247_29
			end

			local var_247_30 = 0
			local var_247_31 = 0.725

			if var_247_30 < arg_244_1.time_ and arg_244_1.time_ <= var_247_30 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_32 = arg_244_1:FormatText(StoryNameCfg[42].name)

				arg_244_1.leftNameTxt_.text = var_247_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_33 = arg_244_1:GetWordFromCfg(411171057)
				local var_247_34 = arg_244_1:FormatText(var_247_33.content)

				arg_244_1.text_.text = var_247_34

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_35 = 29
				local var_247_36 = utf8.len(var_247_34)
				local var_247_37 = var_247_35 <= 0 and var_247_31 or var_247_31 * (var_247_36 / var_247_35)

				if var_247_37 > 0 and var_247_31 < var_247_37 then
					arg_244_1.talkMaxDuration = var_247_37

					if var_247_37 + var_247_30 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_37 + var_247_30
					end
				end

				arg_244_1.text_.text = var_247_34
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171057", "story_v_out_411171.awb") ~= 0 then
					local var_247_38 = manager.audio:GetVoiceLength("story_v_out_411171", "411171057", "story_v_out_411171.awb") / 1000

					if var_247_38 + var_247_30 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_38 + var_247_30
					end

					if var_247_33.prefab_name ~= "" and arg_244_1.actors_[var_247_33.prefab_name] ~= nil then
						local var_247_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_33.prefab_name].transform, "story_v_out_411171", "411171057", "story_v_out_411171.awb")

						arg_244_1:RecordAudio("411171057", var_247_39)
						arg_244_1:RecordAudio("411171057", var_247_39)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_411171", "411171057", "story_v_out_411171.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_411171", "411171057", "story_v_out_411171.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_40 = math.max(var_247_31, arg_244_1.talkMaxDuration)

			if var_247_30 <= arg_244_1.time_ and arg_244_1.time_ < var_247_30 + var_247_40 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_30) / var_247_40

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_30 + var_247_40 and arg_244_1.time_ < var_247_30 + var_247_40 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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

		arg_244_1:InitPlayNodeList()
	end,
	Play411171058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 411171058
		arg_248_1.duration_ = 13.07

		local var_248_0 = {
			zh = 5.833,
			ja = 13.066
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play411171059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.7

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[42].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(411171058)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 28
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171058", "story_v_out_411171.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171058", "story_v_out_411171.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_411171", "411171058", "story_v_out_411171.awb")

						arg_248_1:RecordAudio("411171058", var_251_9)
						arg_248_1:RecordAudio("411171058", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_411171", "411171058", "story_v_out_411171.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_411171", "411171058", "story_v_out_411171.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_10 and arg_248_1.time_ < var_251_0 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play411171059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 411171059
		arg_252_1.duration_ = 9

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play411171060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 2

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				local var_255_1 = manager.ui.mainCamera.transform.localPosition
				local var_255_2 = Vector3.New(0, 0, 10) + Vector3.New(var_255_1.x, var_255_1.y, 0)
				local var_255_3 = arg_252_1.bgs_.B10b

				var_255_3.transform.localPosition = var_255_2
				var_255_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_4 = var_255_3:GetComponent("SpriteRenderer")

				if var_255_4 and var_255_4.sprite then
					local var_255_5 = (var_255_3.transform.localPosition - var_255_1).z
					local var_255_6 = manager.ui.mainCameraCom_
					local var_255_7 = 2 * var_255_5 * Mathf.Tan(var_255_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_255_8 = var_255_7 * var_255_6.aspect
					local var_255_9 = var_255_4.sprite.bounds.size.x
					local var_255_10 = var_255_4.sprite.bounds.size.y
					local var_255_11 = var_255_8 / var_255_9
					local var_255_12 = var_255_7 / var_255_10
					local var_255_13 = var_255_12 < var_255_11 and var_255_11 or var_255_12

					var_255_3.transform.localScale = Vector3.New(var_255_13, var_255_13, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "B10b" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_14 = 0

			if var_255_14 < arg_252_1.time_ and arg_252_1.time_ <= var_255_14 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_15 = 2

			if var_255_14 <= arg_252_1.time_ and arg_252_1.time_ < var_255_14 + var_255_15 then
				local var_255_16 = (arg_252_1.time_ - var_255_14) / var_255_15
				local var_255_17 = Color.New(0, 0, 0)

				var_255_17.a = Mathf.Lerp(0, 1, var_255_16)
				arg_252_1.mask_.color = var_255_17
			end

			if arg_252_1.time_ >= var_255_14 + var_255_15 and arg_252_1.time_ < var_255_14 + var_255_15 + arg_255_0 then
				local var_255_18 = Color.New(0, 0, 0)

				var_255_18.a = 1
				arg_252_1.mask_.color = var_255_18
			end

			local var_255_19 = 2

			if var_255_19 < arg_252_1.time_ and arg_252_1.time_ <= var_255_19 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_20 = 2

			if var_255_19 <= arg_252_1.time_ and arg_252_1.time_ < var_255_19 + var_255_20 then
				local var_255_21 = (arg_252_1.time_ - var_255_19) / var_255_20
				local var_255_22 = Color.New(0, 0, 0)

				var_255_22.a = Mathf.Lerp(1, 0, var_255_21)
				arg_252_1.mask_.color = var_255_22
			end

			if arg_252_1.time_ >= var_255_19 + var_255_20 and arg_252_1.time_ < var_255_19 + var_255_20 + arg_255_0 then
				local var_255_23 = Color.New(0, 0, 0)
				local var_255_24 = 0

				arg_252_1.mask_.enabled = false
				var_255_23.a = var_255_24
				arg_252_1.mask_.color = var_255_23
			end

			local var_255_25 = arg_252_1.actors_["1095ui_story"].transform
			local var_255_26 = 2

			if var_255_26 < arg_252_1.time_ and arg_252_1.time_ <= var_255_26 + arg_255_0 then
				arg_252_1.var_.moveOldPos1095ui_story = var_255_25.localPosition
			end

			local var_255_27 = 0.001

			if var_255_26 <= arg_252_1.time_ and arg_252_1.time_ < var_255_26 + var_255_27 then
				local var_255_28 = (arg_252_1.time_ - var_255_26) / var_255_27
				local var_255_29 = Vector3.New(0, 100, 0)

				var_255_25.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1095ui_story, var_255_29, var_255_28)

				local var_255_30 = manager.ui.mainCamera.transform.position - var_255_25.position

				var_255_25.forward = Vector3.New(var_255_30.x, var_255_30.y, var_255_30.z)

				local var_255_31 = var_255_25.localEulerAngles

				var_255_31.z = 0
				var_255_31.x = 0
				var_255_25.localEulerAngles = var_255_31
			end

			if arg_252_1.time_ >= var_255_26 + var_255_27 and arg_252_1.time_ < var_255_26 + var_255_27 + arg_255_0 then
				var_255_25.localPosition = Vector3.New(0, 100, 0)

				local var_255_32 = manager.ui.mainCamera.transform.position - var_255_25.position

				var_255_25.forward = Vector3.New(var_255_32.x, var_255_32.y, var_255_32.z)

				local var_255_33 = var_255_25.localEulerAngles

				var_255_33.z = 0
				var_255_33.x = 0
				var_255_25.localEulerAngles = var_255_33
			end

			local var_255_34 = arg_252_1.actors_["1095ui_story"]
			local var_255_35 = 2

			if var_255_35 < arg_252_1.time_ and arg_252_1.time_ <= var_255_35 + arg_255_0 and not isNil(var_255_34) and arg_252_1.var_.characterEffect1095ui_story == nil then
				arg_252_1.var_.characterEffect1095ui_story = var_255_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_36 = 0.200000002980232

			if var_255_35 <= arg_252_1.time_ and arg_252_1.time_ < var_255_35 + var_255_36 and not isNil(var_255_34) then
				local var_255_37 = (arg_252_1.time_ - var_255_35) / var_255_36

				if arg_252_1.var_.characterEffect1095ui_story and not isNil(var_255_34) then
					local var_255_38 = Mathf.Lerp(0, 0.5, var_255_37)

					arg_252_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1095ui_story.fillRatio = var_255_38
				end
			end

			if arg_252_1.time_ >= var_255_35 + var_255_36 and arg_252_1.time_ < var_255_35 + var_255_36 + arg_255_0 and not isNil(var_255_34) and arg_252_1.var_.characterEffect1095ui_story then
				local var_255_39 = 0.5

				arg_252_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1095ui_story.fillRatio = var_255_39
			end

			local var_255_40 = arg_252_1.actors_["4010ui_story"].transform
			local var_255_41 = 2

			if var_255_41 < arg_252_1.time_ and arg_252_1.time_ <= var_255_41 + arg_255_0 then
				arg_252_1.var_.moveOldPos4010ui_story = var_255_40.localPosition
			end

			local var_255_42 = 0.001

			if var_255_41 <= arg_252_1.time_ and arg_252_1.time_ < var_255_41 + var_255_42 then
				local var_255_43 = (arg_252_1.time_ - var_255_41) / var_255_42
				local var_255_44 = Vector3.New(0, 100, 0)

				var_255_40.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos4010ui_story, var_255_44, var_255_43)

				local var_255_45 = manager.ui.mainCamera.transform.position - var_255_40.position

				var_255_40.forward = Vector3.New(var_255_45.x, var_255_45.y, var_255_45.z)

				local var_255_46 = var_255_40.localEulerAngles

				var_255_46.z = 0
				var_255_46.x = 0
				var_255_40.localEulerAngles = var_255_46
			end

			if arg_252_1.time_ >= var_255_41 + var_255_42 and arg_252_1.time_ < var_255_41 + var_255_42 + arg_255_0 then
				var_255_40.localPosition = Vector3.New(0, 100, 0)

				local var_255_47 = manager.ui.mainCamera.transform.position - var_255_40.position

				var_255_40.forward = Vector3.New(var_255_47.x, var_255_47.y, var_255_47.z)

				local var_255_48 = var_255_40.localEulerAngles

				var_255_48.z = 0
				var_255_48.x = 0
				var_255_40.localEulerAngles = var_255_48
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_49 = 4
			local var_255_50 = 1.275

			if var_255_49 < arg_252_1.time_ and arg_252_1.time_ <= var_255_49 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_51 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_51:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_52 = arg_252_1:GetWordFromCfg(411171059)
				local var_255_53 = arg_252_1:FormatText(var_255_52.content)

				arg_252_1.text_.text = var_255_53

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_54 = 52
				local var_255_55 = utf8.len(var_255_53)
				local var_255_56 = var_255_54 <= 0 and var_255_50 or var_255_50 * (var_255_55 / var_255_54)

				if var_255_56 > 0 and var_255_50 < var_255_56 then
					arg_252_1.talkMaxDuration = var_255_56
					var_255_49 = var_255_49 + 0.3

					if var_255_56 + var_255_49 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_56 + var_255_49
					end
				end

				arg_252_1.text_.text = var_255_53
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_57 = var_255_49 + 0.3
			local var_255_58 = math.max(var_255_50, arg_252_1.talkMaxDuration)

			if var_255_57 <= arg_252_1.time_ and arg_252_1.time_ < var_255_57 + var_255_58 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_57) / var_255_58

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_57 + var_255_58 and arg_252_1.time_ < var_255_57 + var_255_58 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play411171060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 411171060
		arg_258_1.duration_ = 1.77

		local var_258_0 = {
			zh = 1.433,
			ja = 1.766
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
				arg_258_0:Play411171061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1024ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1024ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, -1, -6.05)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1024ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1024ui_story"]
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1024ui_story == nil then
				arg_258_1.var_.characterEffect1024ui_story = var_261_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_11 = 0.200000002980232

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 and not isNil(var_261_9) then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11

				if arg_258_1.var_.characterEffect1024ui_story and not isNil(var_261_9) then
					arg_258_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1024ui_story then
				arg_258_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_261_13 = 0

			if var_261_13 < arg_258_1.time_ and arg_258_1.time_ <= var_261_13 + arg_261_0 then
				arg_258_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_261_15 = 0
			local var_261_16 = 0.3

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_17 = arg_258_1:FormatText(StoryNameCfg[265].name)

				arg_258_1.leftNameTxt_.text = var_261_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_18 = arg_258_1:GetWordFromCfg(411171060)
				local var_261_19 = arg_258_1:FormatText(var_261_18.content)

				arg_258_1.text_.text = var_261_19

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_20 = 12
				local var_261_21 = utf8.len(var_261_19)
				local var_261_22 = var_261_20 <= 0 and var_261_16 or var_261_16 * (var_261_21 / var_261_20)

				if var_261_22 > 0 and var_261_16 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_19
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171060", "story_v_out_411171.awb") ~= 0 then
					local var_261_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171060", "story_v_out_411171.awb") / 1000

					if var_261_23 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_15
					end

					if var_261_18.prefab_name ~= "" and arg_258_1.actors_[var_261_18.prefab_name] ~= nil then
						local var_261_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_18.prefab_name].transform, "story_v_out_411171", "411171060", "story_v_out_411171.awb")

						arg_258_1:RecordAudio("411171060", var_261_24)
						arg_258_1:RecordAudio("411171060", var_261_24)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_411171", "411171060", "story_v_out_411171.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_411171", "411171060", "story_v_out_411171.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_25 and arg_258_1.time_ < var_261_15 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play411171061 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 411171061
		arg_262_1.duration_ = 4.57

		local var_262_0 = {
			zh = 2.7,
			ja = 4.566
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
				arg_262_0:Play411171062(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1024ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1024ui_story == nil then
				arg_262_1.var_.characterEffect1024ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1024ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1024ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1024ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1024ui_story.fillRatio = var_265_5
			end

			local var_265_6 = 0
			local var_265_7 = 0.3

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_8 = arg_262_1:FormatText(StoryNameCfg[715].name)

				arg_262_1.leftNameTxt_.text = var_265_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_9 = arg_262_1:GetWordFromCfg(411171061)
				local var_265_10 = arg_262_1:FormatText(var_265_9.content)

				arg_262_1.text_.text = var_265_10

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 12
				local var_265_12 = utf8.len(var_265_10)
				local var_265_13 = var_265_11 <= 0 and var_265_7 or var_265_7 * (var_265_12 / var_265_11)

				if var_265_13 > 0 and var_265_7 < var_265_13 then
					arg_262_1.talkMaxDuration = var_265_13

					if var_265_13 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_13 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_10
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171061", "story_v_out_411171.awb") ~= 0 then
					local var_265_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171061", "story_v_out_411171.awb") / 1000

					if var_265_14 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_14 + var_265_6
					end

					if var_265_9.prefab_name ~= "" and arg_262_1.actors_[var_265_9.prefab_name] ~= nil then
						local var_265_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_9.prefab_name].transform, "story_v_out_411171", "411171061", "story_v_out_411171.awb")

						arg_262_1:RecordAudio("411171061", var_265_15)
						arg_262_1:RecordAudio("411171061", var_265_15)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_411171", "411171061", "story_v_out_411171.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_411171", "411171061", "story_v_out_411171.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_16 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_16

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_16 and arg_262_1.time_ < var_265_6 + var_265_16 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play411171062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 411171062
		arg_266_1.duration_ = 7.4

		local var_266_0 = {
			zh = 7.4,
			ja = 7.266
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
				arg_266_0:Play411171063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1024ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1024ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, -1, -6.05)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1024ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["1024ui_story"]
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1024ui_story == nil then
				arg_266_1.var_.characterEffect1024ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_11 = 0.200000002980232

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 and not isNil(var_269_9) then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11

				if arg_266_1.var_.characterEffect1024ui_story and not isNil(var_269_9) then
					arg_266_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1024ui_story then
				arg_266_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_269_13 = 0

			if var_269_13 < arg_266_1.time_ and arg_266_1.time_ <= var_269_13 + arg_269_0 then
				arg_266_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_1")
			end

			local var_269_14 = 0

			if var_269_14 < arg_266_1.time_ and arg_266_1.time_ <= var_269_14 + arg_269_0 then
				arg_266_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_15 = 0
			local var_269_16 = 0.8

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_17 = arg_266_1:FormatText(StoryNameCfg[265].name)

				arg_266_1.leftNameTxt_.text = var_269_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_18 = arg_266_1:GetWordFromCfg(411171062)
				local var_269_19 = arg_266_1:FormatText(var_269_18.content)

				arg_266_1.text_.text = var_269_19

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_20 = 32
				local var_269_21 = utf8.len(var_269_19)
				local var_269_22 = var_269_20 <= 0 and var_269_16 or var_269_16 * (var_269_21 / var_269_20)

				if var_269_22 > 0 and var_269_16 < var_269_22 then
					arg_266_1.talkMaxDuration = var_269_22

					if var_269_22 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_22 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_19
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171062", "story_v_out_411171.awb") ~= 0 then
					local var_269_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171062", "story_v_out_411171.awb") / 1000

					if var_269_23 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_15
					end

					if var_269_18.prefab_name ~= "" and arg_266_1.actors_[var_269_18.prefab_name] ~= nil then
						local var_269_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_18.prefab_name].transform, "story_v_out_411171", "411171062", "story_v_out_411171.awb")

						arg_266_1:RecordAudio("411171062", var_269_24)
						arg_266_1:RecordAudio("411171062", var_269_24)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_411171", "411171062", "story_v_out_411171.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_411171", "411171062", "story_v_out_411171.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_25 and arg_266_1.time_ < var_269_15 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play411171063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 411171063
		arg_270_1.duration_ = 4.73

		local var_270_0 = {
			zh = 4.733,
			ja = 3.166
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
				arg_270_0:Play411171064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1024ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1024ui_story == nil then
				arg_270_1.var_.characterEffect1024ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1024ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1024ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1024ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1024ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 0.5

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_8 = arg_270_1:FormatText(StoryNameCfg[715].name)

				arg_270_1.leftNameTxt_.text = var_273_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_9 = arg_270_1:GetWordFromCfg(411171063)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 20
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171063", "story_v_out_411171.awb") ~= 0 then
					local var_273_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171063", "story_v_out_411171.awb") / 1000

					if var_273_14 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_6
					end

					if var_273_9.prefab_name ~= "" and arg_270_1.actors_[var_273_9.prefab_name] ~= nil then
						local var_273_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_9.prefab_name].transform, "story_v_out_411171", "411171063", "story_v_out_411171.awb")

						arg_270_1:RecordAudio("411171063", var_273_15)
						arg_270_1:RecordAudio("411171063", var_273_15)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_411171", "411171063", "story_v_out_411171.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_411171", "411171063", "story_v_out_411171.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_16 and arg_270_1.time_ < var_273_6 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play411171064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 411171064
		arg_274_1.duration_ = 6.77

		local var_274_0 = {
			zh = 3.933,
			ja = 6.766
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
				arg_274_0:Play411171065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1024ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1024ui_story == nil then
				arg_274_1.var_.characterEffect1024ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1024ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1024ui_story then
				arg_274_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_277_4 = 0
			local var_277_5 = 0.45

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_6 = arg_274_1:FormatText(StoryNameCfg[265].name)

				arg_274_1.leftNameTxt_.text = var_277_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_7 = arg_274_1:GetWordFromCfg(411171064)
				local var_277_8 = arg_274_1:FormatText(var_277_7.content)

				arg_274_1.text_.text = var_277_8

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 18
				local var_277_10 = utf8.len(var_277_8)
				local var_277_11 = var_277_9 <= 0 and var_277_5 or var_277_5 * (var_277_10 / var_277_9)

				if var_277_11 > 0 and var_277_5 < var_277_11 then
					arg_274_1.talkMaxDuration = var_277_11

					if var_277_11 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_8
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171064", "story_v_out_411171.awb") ~= 0 then
					local var_277_12 = manager.audio:GetVoiceLength("story_v_out_411171", "411171064", "story_v_out_411171.awb") / 1000

					if var_277_12 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_4
					end

					if var_277_7.prefab_name ~= "" and arg_274_1.actors_[var_277_7.prefab_name] ~= nil then
						local var_277_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_7.prefab_name].transform, "story_v_out_411171", "411171064", "story_v_out_411171.awb")

						arg_274_1:RecordAudio("411171064", var_277_13)
						arg_274_1:RecordAudio("411171064", var_277_13)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_411171", "411171064", "story_v_out_411171.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_411171", "411171064", "story_v_out_411171.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_14 and arg_274_1.time_ < var_277_4 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play411171065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 411171065
		arg_278_1.duration_ = 5.03

		local var_278_0 = {
			zh = 5.033,
			ja = 3.633
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
				arg_278_0:Play411171066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1024ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1024ui_story == nil then
				arg_278_1.var_.characterEffect1024ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect1024ui_story and not isNil(var_281_0) then
					local var_281_4 = Mathf.Lerp(0, 0.5, var_281_3)

					arg_278_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1024ui_story.fillRatio = var_281_4
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect1024ui_story then
				local var_281_5 = 0.5

				arg_278_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1024ui_story.fillRatio = var_281_5
			end

			local var_281_6 = 0
			local var_281_7 = 0.5

			if var_281_6 < arg_278_1.time_ and arg_278_1.time_ <= var_281_6 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_8 = arg_278_1:FormatText(StoryNameCfg[716].name)

				arg_278_1.leftNameTxt_.text = var_281_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_9 = arg_278_1:GetWordFromCfg(411171065)
				local var_281_10 = arg_278_1:FormatText(var_281_9.content)

				arg_278_1.text_.text = var_281_10

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_11 = 20
				local var_281_12 = utf8.len(var_281_10)
				local var_281_13 = var_281_11 <= 0 and var_281_7 or var_281_7 * (var_281_12 / var_281_11)

				if var_281_13 > 0 and var_281_7 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_6 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_6
					end
				end

				arg_278_1.text_.text = var_281_10
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171065", "story_v_out_411171.awb") ~= 0 then
					local var_281_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171065", "story_v_out_411171.awb") / 1000

					if var_281_14 + var_281_6 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_14 + var_281_6
					end

					if var_281_9.prefab_name ~= "" and arg_278_1.actors_[var_281_9.prefab_name] ~= nil then
						local var_281_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_9.prefab_name].transform, "story_v_out_411171", "411171065", "story_v_out_411171.awb")

						arg_278_1:RecordAudio("411171065", var_281_15)
						arg_278_1:RecordAudio("411171065", var_281_15)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_411171", "411171065", "story_v_out_411171.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_411171", "411171065", "story_v_out_411171.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_16 = math.max(var_281_7, arg_278_1.talkMaxDuration)

			if var_281_6 <= arg_278_1.time_ and arg_278_1.time_ < var_281_6 + var_281_16 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_6) / var_281_16

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_6 + var_281_16 and arg_278_1.time_ < var_281_6 + var_281_16 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play411171066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 411171066
		arg_282_1.duration_ = 3.13

		local var_282_0 = {
			zh = 2,
			ja = 3.133
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
				arg_282_0:Play411171067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1024ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1024ui_story == nil then
				arg_282_1.var_.characterEffect1024ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1024ui_story and not isNil(var_285_0) then
					arg_282_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1024ui_story then
				arg_282_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_285_4 = 0
			local var_285_5 = 0.225

			if var_285_4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_6 = arg_282_1:FormatText(StoryNameCfg[265].name)

				arg_282_1.leftNameTxt_.text = var_285_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_7 = arg_282_1:GetWordFromCfg(411171066)
				local var_285_8 = arg_282_1:FormatText(var_285_7.content)

				arg_282_1.text_.text = var_285_8

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 9
				local var_285_10 = utf8.len(var_285_8)
				local var_285_11 = var_285_9 <= 0 and var_285_5 or var_285_5 * (var_285_10 / var_285_9)

				if var_285_11 > 0 and var_285_5 < var_285_11 then
					arg_282_1.talkMaxDuration = var_285_11

					if var_285_11 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_4
					end
				end

				arg_282_1.text_.text = var_285_8
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171066", "story_v_out_411171.awb") ~= 0 then
					local var_285_12 = manager.audio:GetVoiceLength("story_v_out_411171", "411171066", "story_v_out_411171.awb") / 1000

					if var_285_12 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_12 + var_285_4
					end

					if var_285_7.prefab_name ~= "" and arg_282_1.actors_[var_285_7.prefab_name] ~= nil then
						local var_285_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_7.prefab_name].transform, "story_v_out_411171", "411171066", "story_v_out_411171.awb")

						arg_282_1:RecordAudio("411171066", var_285_13)
						arg_282_1:RecordAudio("411171066", var_285_13)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_411171", "411171066", "story_v_out_411171.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_411171", "411171066", "story_v_out_411171.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_5, arg_282_1.talkMaxDuration)

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_4) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_4 + var_285_14 and arg_282_1.time_ < var_285_4 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play411171067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 411171067
		arg_286_1.duration_ = 10.13

		local var_286_0 = {
			zh = 9.533,
			ja = 10.133
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
				arg_286_0:Play411171068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1024ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1024ui_story == nil then
				arg_286_1.var_.characterEffect1024ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect1024ui_story and not isNil(var_289_0) then
					local var_289_4 = Mathf.Lerp(0, 0.5, var_289_3)

					arg_286_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1024ui_story.fillRatio = var_289_4
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1024ui_story then
				local var_289_5 = 0.5

				arg_286_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1024ui_story.fillRatio = var_289_5
			end

			local var_289_6 = 0
			local var_289_7 = 1.05

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_8 = arg_286_1:FormatText(StoryNameCfg[716].name)

				arg_286_1.leftNameTxt_.text = var_289_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_9 = arg_286_1:GetWordFromCfg(411171067)
				local var_289_10 = arg_286_1:FormatText(var_289_9.content)

				arg_286_1.text_.text = var_289_10

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 42
				local var_289_12 = utf8.len(var_289_10)
				local var_289_13 = var_289_11 <= 0 and var_289_7 or var_289_7 * (var_289_12 / var_289_11)

				if var_289_13 > 0 and var_289_7 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_10
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171067", "story_v_out_411171.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171067", "story_v_out_411171.awb") / 1000

					if var_289_14 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_6
					end

					if var_289_9.prefab_name ~= "" and arg_286_1.actors_[var_289_9.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_9.prefab_name].transform, "story_v_out_411171", "411171067", "story_v_out_411171.awb")

						arg_286_1:RecordAudio("411171067", var_289_15)
						arg_286_1:RecordAudio("411171067", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_411171", "411171067", "story_v_out_411171.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_411171", "411171067", "story_v_out_411171.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_16 and arg_286_1.time_ < var_289_6 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play411171068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 411171068
		arg_290_1.duration_ = 7.43

		local var_290_0 = {
			zh = 7.433,
			ja = 7.033
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
				arg_290_0:Play411171069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.875

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[716].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(411171068)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 35
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171068", "story_v_out_411171.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171068", "story_v_out_411171.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_411171", "411171068", "story_v_out_411171.awb")

						arg_290_1:RecordAudio("411171068", var_293_9)
						arg_290_1:RecordAudio("411171068", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_411171", "411171068", "story_v_out_411171.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_411171", "411171068", "story_v_out_411171.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play411171069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 411171069
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play411171070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.95

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_2 = arg_294_1:GetWordFromCfg(411171069)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 38
				local var_297_5 = utf8.len(var_297_3)
				local var_297_6 = var_297_4 <= 0 and var_297_1 or var_297_1 * (var_297_5 / var_297_4)

				if var_297_6 > 0 and var_297_1 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_7 and arg_294_1.time_ < var_297_0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play411171070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 411171070
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play411171071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1024ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1024ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0, 100, 0)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1024ui_story, var_301_4, var_301_3)

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

			local var_301_9 = 0
			local var_301_10 = 0.725

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_11 = arg_298_1:GetWordFromCfg(411171070)
				local var_301_12 = arg_298_1:FormatText(var_301_11.content)

				arg_298_1.text_.text = var_301_12

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 29
				local var_301_14 = utf8.len(var_301_12)
				local var_301_15 = var_301_13 <= 0 and var_301_10 or var_301_10 * (var_301_14 / var_301_13)

				if var_301_15 > 0 and var_301_10 < var_301_15 then
					arg_298_1.talkMaxDuration = var_301_15

					if var_301_15 + var_301_9 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_15 + var_301_9
					end
				end

				arg_298_1.text_.text = var_301_12
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_10, arg_298_1.talkMaxDuration)

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_9) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_9 + var_301_16 and arg_298_1.time_ < var_301_9 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play411171071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 411171071
		arg_302_1.duration_ = 6.93

		local var_302_0 = {
			zh = 6.933,
			ja = 2.3
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
				arg_302_0:Play411171072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1024ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1024ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, -1, -6.05)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1024ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1024ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1024ui_story == nil then
				arg_302_1.var_.characterEffect1024ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect1024ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1024ui_story then
				arg_302_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024actionlink/1024action462")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_305_15 = 0
			local var_305_16 = 0.925

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[265].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(411171071)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 37
				local var_305_21 = utf8.len(var_305_19)
				local var_305_22 = var_305_20 <= 0 and var_305_16 or var_305_16 * (var_305_21 / var_305_20)

				if var_305_22 > 0 and var_305_16 < var_305_22 then
					arg_302_1.talkMaxDuration = var_305_22

					if var_305_22 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_22 + var_305_15
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171071", "story_v_out_411171.awb") ~= 0 then
					local var_305_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171071", "story_v_out_411171.awb") / 1000

					if var_305_23 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_15
					end

					if var_305_18.prefab_name ~= "" and arg_302_1.actors_[var_305_18.prefab_name] ~= nil then
						local var_305_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_18.prefab_name].transform, "story_v_out_411171", "411171071", "story_v_out_411171.awb")

						arg_302_1:RecordAudio("411171071", var_305_24)
						arg_302_1:RecordAudio("411171071", var_305_24)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_411171", "411171071", "story_v_out_411171.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_411171", "411171071", "story_v_out_411171.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_25 = math.max(var_305_16, arg_302_1.talkMaxDuration)

			if var_305_15 <= arg_302_1.time_ and arg_302_1.time_ < var_305_15 + var_305_25 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_15) / var_305_25

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_15 + var_305_25 and arg_302_1.time_ < var_305_15 + var_305_25 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play411171072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 411171072
		arg_306_1.duration_ = 8.27

		local var_306_0 = {
			zh = 8.266,
			ja = 4
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play411171073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 1.125

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[265].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:GetWordFromCfg(411171072)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 45
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171072", "story_v_out_411171.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171072", "story_v_out_411171.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_out_411171", "411171072", "story_v_out_411171.awb")

						arg_306_1:RecordAudio("411171072", var_309_9)
						arg_306_1:RecordAudio("411171072", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_411171", "411171072", "story_v_out_411171.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_411171", "411171072", "story_v_out_411171.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_10 and arg_306_1.time_ < var_309_0 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play411171073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 411171073
		arg_310_1.duration_ = 4.03

		local var_310_0 = {
			zh = 4,
			ja = 4.033
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
				arg_310_0:Play411171074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1024ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1024ui_story == nil then
				arg_310_1.var_.characterEffect1024ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1024ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1024ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1024ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1024ui_story.fillRatio = var_313_5
			end

			local var_313_6 = 0
			local var_313_7 = 0.425

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_8 = arg_310_1:FormatText(StoryNameCfg[715].name)

				arg_310_1.leftNameTxt_.text = var_313_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_9 = arg_310_1:GetWordFromCfg(411171073)
				local var_313_10 = arg_310_1:FormatText(var_313_9.content)

				arg_310_1.text_.text = var_313_10

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 17
				local var_313_12 = utf8.len(var_313_10)
				local var_313_13 = var_313_11 <= 0 and var_313_7 or var_313_7 * (var_313_12 / var_313_11)

				if var_313_13 > 0 and var_313_7 < var_313_13 then
					arg_310_1.talkMaxDuration = var_313_13

					if var_313_13 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_6
					end
				end

				arg_310_1.text_.text = var_313_10
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171073", "story_v_out_411171.awb") ~= 0 then
					local var_313_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171073", "story_v_out_411171.awb") / 1000

					if var_313_14 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_14 + var_313_6
					end

					if var_313_9.prefab_name ~= "" and arg_310_1.actors_[var_313_9.prefab_name] ~= nil then
						local var_313_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_9.prefab_name].transform, "story_v_out_411171", "411171073", "story_v_out_411171.awb")

						arg_310_1:RecordAudio("411171073", var_313_15)
						arg_310_1:RecordAudio("411171073", var_313_15)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_411171", "411171073", "story_v_out_411171.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_411171", "411171073", "story_v_out_411171.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_16 and arg_310_1.time_ < var_313_6 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play411171074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 411171074
		arg_314_1.duration_ = 2.83

		local var_314_0 = {
			zh = 1.733,
			ja = 2.833
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play411171075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1024ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1024ui_story == nil then
				arg_314_1.var_.characterEffect1024ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1024ui_story and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1024ui_story then
				arg_314_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_317_4 = 0
			local var_317_5 = 0.225

			if var_317_4 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_6 = arg_314_1:FormatText(StoryNameCfg[265].name)

				arg_314_1.leftNameTxt_.text = var_317_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:GetWordFromCfg(411171074)
				local var_317_8 = arg_314_1:FormatText(var_317_7.content)

				arg_314_1.text_.text = var_317_8

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 9
				local var_317_10 = utf8.len(var_317_8)
				local var_317_11 = var_317_9 <= 0 and var_317_5 or var_317_5 * (var_317_10 / var_317_9)

				if var_317_11 > 0 and var_317_5 < var_317_11 then
					arg_314_1.talkMaxDuration = var_317_11

					if var_317_11 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_11 + var_317_4
					end
				end

				arg_314_1.text_.text = var_317_8
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171074", "story_v_out_411171.awb") ~= 0 then
					local var_317_12 = manager.audio:GetVoiceLength("story_v_out_411171", "411171074", "story_v_out_411171.awb") / 1000

					if var_317_12 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_12 + var_317_4
					end

					if var_317_7.prefab_name ~= "" and arg_314_1.actors_[var_317_7.prefab_name] ~= nil then
						local var_317_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_7.prefab_name].transform, "story_v_out_411171", "411171074", "story_v_out_411171.awb")

						arg_314_1:RecordAudio("411171074", var_317_13)
						arg_314_1:RecordAudio("411171074", var_317_13)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_411171", "411171074", "story_v_out_411171.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_411171", "411171074", "story_v_out_411171.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_14 = math.max(var_317_5, arg_314_1.talkMaxDuration)

			if var_317_4 <= arg_314_1.time_ and arg_314_1.time_ < var_317_4 + var_317_14 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_4) / var_317_14

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_4 + var_317_14 and arg_314_1.time_ < var_317_4 + var_317_14 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play411171075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 411171075
		arg_318_1.duration_ = 2.5

		local var_318_0 = {
			zh = 2.033,
			ja = 2.5
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play411171076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1024ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1024ui_story == nil then
				arg_318_1.var_.characterEffect1024ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1024ui_story and not isNil(var_321_0) then
					local var_321_4 = Mathf.Lerp(0, 0.5, var_321_3)

					arg_318_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1024ui_story.fillRatio = var_321_4
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1024ui_story then
				local var_321_5 = 0.5

				arg_318_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1024ui_story.fillRatio = var_321_5
			end

			local var_321_6 = 0
			local var_321_7 = 0.2

			if var_321_6 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_8 = arg_318_1:FormatText(StoryNameCfg[715].name)

				arg_318_1.leftNameTxt_.text = var_321_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_9 = arg_318_1:GetWordFromCfg(411171075)
				local var_321_10 = arg_318_1:FormatText(var_321_9.content)

				arg_318_1.text_.text = var_321_10

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_11 = 8
				local var_321_12 = utf8.len(var_321_10)
				local var_321_13 = var_321_11 <= 0 and var_321_7 or var_321_7 * (var_321_12 / var_321_11)

				if var_321_13 > 0 and var_321_7 < var_321_13 then
					arg_318_1.talkMaxDuration = var_321_13

					if var_321_13 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_13 + var_321_6
					end
				end

				arg_318_1.text_.text = var_321_10
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171075", "story_v_out_411171.awb") ~= 0 then
					local var_321_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171075", "story_v_out_411171.awb") / 1000

					if var_321_14 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_6
					end

					if var_321_9.prefab_name ~= "" and arg_318_1.actors_[var_321_9.prefab_name] ~= nil then
						local var_321_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_9.prefab_name].transform, "story_v_out_411171", "411171075", "story_v_out_411171.awb")

						arg_318_1:RecordAudio("411171075", var_321_15)
						arg_318_1:RecordAudio("411171075", var_321_15)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_411171", "411171075", "story_v_out_411171.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_411171", "411171075", "story_v_out_411171.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_7, arg_318_1.talkMaxDuration)

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_6) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_6 + var_321_16 and arg_318_1.time_ < var_321_6 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play411171076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 411171076
		arg_322_1.duration_ = 2.47

		local var_322_0 = {
			zh = 2.1,
			ja = 2.466
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play411171077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1024ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1024ui_story == nil then
				arg_322_1.var_.characterEffect1024ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect1024ui_story and not isNil(var_325_0) then
					arg_322_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1024ui_story then
				arg_322_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_325_4 = 0

			if var_325_4 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_2")
			end

			local var_325_5 = 0
			local var_325_6 = 0.3

			if var_325_5 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_7 = arg_322_1:FormatText(StoryNameCfg[265].name)

				arg_322_1.leftNameTxt_.text = var_325_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_8 = arg_322_1:GetWordFromCfg(411171076)
				local var_325_9 = arg_322_1:FormatText(var_325_8.content)

				arg_322_1.text_.text = var_325_9

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_10 = 12
				local var_325_11 = utf8.len(var_325_9)
				local var_325_12 = var_325_10 <= 0 and var_325_6 or var_325_6 * (var_325_11 / var_325_10)

				if var_325_12 > 0 and var_325_6 < var_325_12 then
					arg_322_1.talkMaxDuration = var_325_12

					if var_325_12 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_12 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_9
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171076", "story_v_out_411171.awb") ~= 0 then
					local var_325_13 = manager.audio:GetVoiceLength("story_v_out_411171", "411171076", "story_v_out_411171.awb") / 1000

					if var_325_13 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_5
					end

					if var_325_8.prefab_name ~= "" and arg_322_1.actors_[var_325_8.prefab_name] ~= nil then
						local var_325_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_8.prefab_name].transform, "story_v_out_411171", "411171076", "story_v_out_411171.awb")

						arg_322_1:RecordAudio("411171076", var_325_14)
						arg_322_1:RecordAudio("411171076", var_325_14)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_411171", "411171076", "story_v_out_411171.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_411171", "411171076", "story_v_out_411171.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_15 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_15 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_15

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_15 and arg_322_1.time_ < var_325_5 + var_325_15 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play411171077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 411171077
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play411171078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1024ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos1024ui_story = var_329_0.localPosition
			end

			local var_329_2 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2
				local var_329_4 = Vector3.New(0, 100, 0)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1024ui_story, var_329_4, var_329_3)

				local var_329_5 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_5.x, var_329_5.y, var_329_5.z)

				local var_329_6 = var_329_0.localEulerAngles

				var_329_6.z = 0
				var_329_6.x = 0
				var_329_0.localEulerAngles = var_329_6
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(0, 100, 0)

				local var_329_7 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_7.x, var_329_7.y, var_329_7.z)

				local var_329_8 = var_329_0.localEulerAngles

				var_329_8.z = 0
				var_329_8.x = 0
				var_329_0.localEulerAngles = var_329_8
			end

			local var_329_9 = arg_326_1.actors_["1024ui_story"]
			local var_329_10 = 0

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect1024ui_story == nil then
				arg_326_1.var_.characterEffect1024ui_story = var_329_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_11 = 0.200000002980232

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_11 and not isNil(var_329_9) then
				local var_329_12 = (arg_326_1.time_ - var_329_10) / var_329_11

				if arg_326_1.var_.characterEffect1024ui_story and not isNil(var_329_9) then
					local var_329_13 = Mathf.Lerp(0, 0.5, var_329_12)

					arg_326_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1024ui_story.fillRatio = var_329_13
				end
			end

			if arg_326_1.time_ >= var_329_10 + var_329_11 and arg_326_1.time_ < var_329_10 + var_329_11 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect1024ui_story then
				local var_329_14 = 0.5

				arg_326_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1024ui_story.fillRatio = var_329_14
			end

			local var_329_15 = 0
			local var_329_16 = 0.9

			if var_329_15 < arg_326_1.time_ and arg_326_1.time_ <= var_329_15 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_17 = arg_326_1:GetWordFromCfg(411171077)
				local var_329_18 = arg_326_1:FormatText(var_329_17.content)

				arg_326_1.text_.text = var_329_18

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_19 = 36
				local var_329_20 = utf8.len(var_329_18)
				local var_329_21 = var_329_19 <= 0 and var_329_16 or var_329_16 * (var_329_20 / var_329_19)

				if var_329_21 > 0 and var_329_16 < var_329_21 then
					arg_326_1.talkMaxDuration = var_329_21

					if var_329_21 + var_329_15 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_21 + var_329_15
					end
				end

				arg_326_1.text_.text = var_329_18
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_22 = math.max(var_329_16, arg_326_1.talkMaxDuration)

			if var_329_15 <= arg_326_1.time_ and arg_326_1.time_ < var_329_15 + var_329_22 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_15) / var_329_22

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_15 + var_329_22 and arg_326_1.time_ < var_329_15 + var_329_22 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play411171078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 411171078
		arg_330_1.duration_ = 4.27

		local var_330_0 = {
			zh = 2.533,
			ja = 4.266
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play411171079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1024ui_story"].transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPos1024ui_story = var_333_0.localPosition
			end

			local var_333_2 = 0.001

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2
				local var_333_4 = Vector3.New(0, -1, -6.05)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1024ui_story, var_333_4, var_333_3)

				local var_333_5 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_5.x, var_333_5.y, var_333_5.z)

				local var_333_6 = var_333_0.localEulerAngles

				var_333_6.z = 0
				var_333_6.x = 0
				var_333_0.localEulerAngles = var_333_6
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_333_7 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_7.x, var_333_7.y, var_333_7.z)

				local var_333_8 = var_333_0.localEulerAngles

				var_333_8.z = 0
				var_333_8.x = 0
				var_333_0.localEulerAngles = var_333_8
			end

			local var_333_9 = arg_330_1.actors_["1024ui_story"]
			local var_333_10 = 0

			if var_333_10 < arg_330_1.time_ and arg_330_1.time_ <= var_333_10 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect1024ui_story == nil then
				arg_330_1.var_.characterEffect1024ui_story = var_333_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_11 = 0.200000002980232

			if var_333_10 <= arg_330_1.time_ and arg_330_1.time_ < var_333_10 + var_333_11 and not isNil(var_333_9) then
				local var_333_12 = (arg_330_1.time_ - var_333_10) / var_333_11

				if arg_330_1.var_.characterEffect1024ui_story and not isNil(var_333_9) then
					arg_330_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_10 + var_333_11 and arg_330_1.time_ < var_333_10 + var_333_11 + arg_333_0 and not isNil(var_333_9) and arg_330_1.var_.characterEffect1024ui_story then
				arg_330_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_333_13 = 0

			if var_333_13 < arg_330_1.time_ and arg_330_1.time_ <= var_333_13 + arg_333_0 then
				arg_330_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_333_14 = 0

			if var_333_14 < arg_330_1.time_ and arg_330_1.time_ <= var_333_14 + arg_333_0 then
				arg_330_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_333_15 = 0
			local var_333_16 = 0.275

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_17 = arg_330_1:FormatText(StoryNameCfg[265].name)

				arg_330_1.leftNameTxt_.text = var_333_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_18 = arg_330_1:GetWordFromCfg(411171078)
				local var_333_19 = arg_330_1:FormatText(var_333_18.content)

				arg_330_1.text_.text = var_333_19

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_20 = 11
				local var_333_21 = utf8.len(var_333_19)
				local var_333_22 = var_333_20 <= 0 and var_333_16 or var_333_16 * (var_333_21 / var_333_20)

				if var_333_22 > 0 and var_333_16 < var_333_22 then
					arg_330_1.talkMaxDuration = var_333_22

					if var_333_22 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_22 + var_333_15
					end
				end

				arg_330_1.text_.text = var_333_19
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171078", "story_v_out_411171.awb") ~= 0 then
					local var_333_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171078", "story_v_out_411171.awb") / 1000

					if var_333_23 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_23 + var_333_15
					end

					if var_333_18.prefab_name ~= "" and arg_330_1.actors_[var_333_18.prefab_name] ~= nil then
						local var_333_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_18.prefab_name].transform, "story_v_out_411171", "411171078", "story_v_out_411171.awb")

						arg_330_1:RecordAudio("411171078", var_333_24)
						arg_330_1:RecordAudio("411171078", var_333_24)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_411171", "411171078", "story_v_out_411171.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_411171", "411171078", "story_v_out_411171.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_25 = math.max(var_333_16, arg_330_1.talkMaxDuration)

			if var_333_15 <= arg_330_1.time_ and arg_330_1.time_ < var_333_15 + var_333_25 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_15) / var_333_25

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_15 + var_333_25 and arg_330_1.time_ < var_333_15 + var_333_25 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play411171079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 411171079
		arg_334_1.duration_ = 6.73

		local var_334_0 = {
			zh = 4.2,
			ja = 6.733
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play411171080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1024ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1024ui_story == nil then
				arg_334_1.var_.characterEffect1024ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect1024ui_story and not isNil(var_337_0) then
					local var_337_4 = Mathf.Lerp(0, 0.5, var_337_3)

					arg_334_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1024ui_story.fillRatio = var_337_4
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1024ui_story then
				local var_337_5 = 0.5

				arg_334_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1024ui_story.fillRatio = var_337_5
			end

			local var_337_6 = 0
			local var_337_7 = 0.5

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_8 = arg_334_1:FormatText(StoryNameCfg[715].name)

				arg_334_1.leftNameTxt_.text = var_337_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_9 = arg_334_1:GetWordFromCfg(411171079)
				local var_337_10 = arg_334_1:FormatText(var_337_9.content)

				arg_334_1.text_.text = var_337_10

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_11 = 20
				local var_337_12 = utf8.len(var_337_10)
				local var_337_13 = var_337_11 <= 0 and var_337_7 or var_337_7 * (var_337_12 / var_337_11)

				if var_337_13 > 0 and var_337_7 < var_337_13 then
					arg_334_1.talkMaxDuration = var_337_13

					if var_337_13 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_10
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171079", "story_v_out_411171.awb") ~= 0 then
					local var_337_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171079", "story_v_out_411171.awb") / 1000

					if var_337_14 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_14 + var_337_6
					end

					if var_337_9.prefab_name ~= "" and arg_334_1.actors_[var_337_9.prefab_name] ~= nil then
						local var_337_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_9.prefab_name].transform, "story_v_out_411171", "411171079", "story_v_out_411171.awb")

						arg_334_1:RecordAudio("411171079", var_337_15)
						arg_334_1:RecordAudio("411171079", var_337_15)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_411171", "411171079", "story_v_out_411171.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_411171", "411171079", "story_v_out_411171.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_16 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_16 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_16

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_16 and arg_334_1.time_ < var_337_6 + var_337_16 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play411171080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 411171080
		arg_338_1.duration_ = 1.27

		local var_338_0 = {
			zh = 1.133,
			ja = 1.266
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play411171081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1024ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1024ui_story == nil then
				arg_338_1.var_.characterEffect1024ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1024ui_story and not isNil(var_341_0) then
					arg_338_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1024ui_story then
				arg_338_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_341_4 = 0
			local var_341_5 = 0.1

			if var_341_4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_6 = arg_338_1:FormatText(StoryNameCfg[265].name)

				arg_338_1.leftNameTxt_.text = var_341_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_7 = arg_338_1:GetWordFromCfg(411171080)
				local var_341_8 = arg_338_1:FormatText(var_341_7.content)

				arg_338_1.text_.text = var_341_8

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 4
				local var_341_10 = utf8.len(var_341_8)
				local var_341_11 = var_341_9 <= 0 and var_341_5 or var_341_5 * (var_341_10 / var_341_9)

				if var_341_11 > 0 and var_341_5 < var_341_11 then
					arg_338_1.talkMaxDuration = var_341_11

					if var_341_11 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_8
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171080", "story_v_out_411171.awb") ~= 0 then
					local var_341_12 = manager.audio:GetVoiceLength("story_v_out_411171", "411171080", "story_v_out_411171.awb") / 1000

					if var_341_12 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_12 + var_341_4
					end

					if var_341_7.prefab_name ~= "" and arg_338_1.actors_[var_341_7.prefab_name] ~= nil then
						local var_341_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_7.prefab_name].transform, "story_v_out_411171", "411171080", "story_v_out_411171.awb")

						arg_338_1:RecordAudio("411171080", var_341_13)
						arg_338_1:RecordAudio("411171080", var_341_13)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_411171", "411171080", "story_v_out_411171.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_411171", "411171080", "story_v_out_411171.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_14 and arg_338_1.time_ < var_341_4 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play411171081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 411171081
		arg_342_1.duration_ = 5.13

		local var_342_0 = {
			zh = 4.833,
			ja = 5.133
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play411171082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1024ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1024ui_story == nil then
				arg_342_1.var_.characterEffect1024ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1024ui_story and not isNil(var_345_0) then
					local var_345_4 = Mathf.Lerp(0, 0.5, var_345_3)

					arg_342_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1024ui_story.fillRatio = var_345_4
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1024ui_story then
				local var_345_5 = 0.5

				arg_342_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1024ui_story.fillRatio = var_345_5
			end

			local var_345_6 = 0
			local var_345_7 = 0.625

			if var_345_6 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_8 = arg_342_1:FormatText(StoryNameCfg[715].name)

				arg_342_1.leftNameTxt_.text = var_345_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_9 = arg_342_1:GetWordFromCfg(411171081)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 25
				local var_345_12 = utf8.len(var_345_10)
				local var_345_13 = var_345_11 <= 0 and var_345_7 or var_345_7 * (var_345_12 / var_345_11)

				if var_345_13 > 0 and var_345_7 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_6
					end
				end

				arg_342_1.text_.text = var_345_10
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171081", "story_v_out_411171.awb") ~= 0 then
					local var_345_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171081", "story_v_out_411171.awb") / 1000

					if var_345_14 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_6
					end

					if var_345_9.prefab_name ~= "" and arg_342_1.actors_[var_345_9.prefab_name] ~= nil then
						local var_345_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_9.prefab_name].transform, "story_v_out_411171", "411171081", "story_v_out_411171.awb")

						arg_342_1:RecordAudio("411171081", var_345_15)
						arg_342_1:RecordAudio("411171081", var_345_15)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_411171", "411171081", "story_v_out_411171.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_411171", "411171081", "story_v_out_411171.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_7, arg_342_1.talkMaxDuration)

			if var_345_6 <= arg_342_1.time_ and arg_342_1.time_ < var_345_6 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_6) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_6 + var_345_16 and arg_342_1.time_ < var_345_6 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play411171082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 411171082
		arg_346_1.duration_ = 2.77

		local var_346_0 = {
			zh = 1.999999999999,
			ja = 2.766
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play411171083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1024ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1024ui_story == nil then
				arg_346_1.var_.characterEffect1024ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1024ui_story and not isNil(var_349_0) then
					arg_346_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1024ui_story then
				arg_346_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_349_4 = 0

			if var_349_4 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_349_5 = 0

			if var_349_5 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_349_6 = 0
			local var_349_7 = 0.25

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_8 = arg_346_1:FormatText(StoryNameCfg[265].name)

				arg_346_1.leftNameTxt_.text = var_349_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_9 = arg_346_1:GetWordFromCfg(411171082)
				local var_349_10 = arg_346_1:FormatText(var_349_9.content)

				arg_346_1.text_.text = var_349_10

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_11 = 10
				local var_349_12 = utf8.len(var_349_10)
				local var_349_13 = var_349_11 <= 0 and var_349_7 or var_349_7 * (var_349_12 / var_349_11)

				if var_349_13 > 0 and var_349_7 < var_349_13 then
					arg_346_1.talkMaxDuration = var_349_13

					if var_349_13 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_13 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_10
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171082", "story_v_out_411171.awb") ~= 0 then
					local var_349_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171082", "story_v_out_411171.awb") / 1000

					if var_349_14 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_14 + var_349_6
					end

					if var_349_9.prefab_name ~= "" and arg_346_1.actors_[var_349_9.prefab_name] ~= nil then
						local var_349_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_9.prefab_name].transform, "story_v_out_411171", "411171082", "story_v_out_411171.awb")

						arg_346_1:RecordAudio("411171082", var_349_15)
						arg_346_1:RecordAudio("411171082", var_349_15)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_411171", "411171082", "story_v_out_411171.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_411171", "411171082", "story_v_out_411171.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_16 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_16 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_16

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_16 and arg_346_1.time_ < var_349_6 + var_349_16 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play411171083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 411171083
		arg_350_1.duration_ = 7.73

		local var_350_0 = {
			zh = 7.733,
			ja = 5.7
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play411171084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.975

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[265].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_3 = arg_350_1:GetWordFromCfg(411171083)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 39
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171083", "story_v_out_411171.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171083", "story_v_out_411171.awb") / 1000

					if var_353_8 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_0
					end

					if var_353_3.prefab_name ~= "" and arg_350_1.actors_[var_353_3.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_3.prefab_name].transform, "story_v_out_411171", "411171083", "story_v_out_411171.awb")

						arg_350_1:RecordAudio("411171083", var_353_9)
						arg_350_1:RecordAudio("411171083", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_411171", "411171083", "story_v_out_411171.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_411171", "411171083", "story_v_out_411171.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_10 and arg_350_1.time_ < var_353_0 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play411171084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 411171084
		arg_354_1.duration_ = 4.23

		local var_354_0 = {
			zh = 3.2,
			ja = 4.233
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play411171085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_357_1 = 0
			local var_357_2 = 0.375

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_3 = arg_354_1:FormatText(StoryNameCfg[265].name)

				arg_354_1.leftNameTxt_.text = var_357_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_4 = arg_354_1:GetWordFromCfg(411171084)
				local var_357_5 = arg_354_1:FormatText(var_357_4.content)

				arg_354_1.text_.text = var_357_5

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_6 = 15
				local var_357_7 = utf8.len(var_357_5)
				local var_357_8 = var_357_6 <= 0 and var_357_2 or var_357_2 * (var_357_7 / var_357_6)

				if var_357_8 > 0 and var_357_2 < var_357_8 then
					arg_354_1.talkMaxDuration = var_357_8

					if var_357_8 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_5
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171084", "story_v_out_411171.awb") ~= 0 then
					local var_357_9 = manager.audio:GetVoiceLength("story_v_out_411171", "411171084", "story_v_out_411171.awb") / 1000

					if var_357_9 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_1
					end

					if var_357_4.prefab_name ~= "" and arg_354_1.actors_[var_357_4.prefab_name] ~= nil then
						local var_357_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_4.prefab_name].transform, "story_v_out_411171", "411171084", "story_v_out_411171.awb")

						arg_354_1:RecordAudio("411171084", var_357_10)
						arg_354_1:RecordAudio("411171084", var_357_10)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_411171", "411171084", "story_v_out_411171.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_411171", "411171084", "story_v_out_411171.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_11 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_11 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_11

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_11 and arg_354_1.time_ < var_357_1 + var_357_11 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play411171085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 411171085
		arg_358_1.duration_ = 4.7

		local var_358_0 = {
			zh = 4.7,
			ja = 4.4
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play411171086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1024ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1024ui_story == nil then
				arg_358_1.var_.characterEffect1024ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1024ui_story and not isNil(var_361_0) then
					local var_361_4 = Mathf.Lerp(0, 0.5, var_361_3)

					arg_358_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1024ui_story.fillRatio = var_361_4
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1024ui_story then
				local var_361_5 = 0.5

				arg_358_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1024ui_story.fillRatio = var_361_5
			end

			local var_361_6 = 0
			local var_361_7 = 0.575

			if var_361_6 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_8 = arg_358_1:FormatText(StoryNameCfg[715].name)

				arg_358_1.leftNameTxt_.text = var_361_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_9 = arg_358_1:GetWordFromCfg(411171085)
				local var_361_10 = arg_358_1:FormatText(var_361_9.content)

				arg_358_1.text_.text = var_361_10

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_11 = 23
				local var_361_12 = utf8.len(var_361_10)
				local var_361_13 = var_361_11 <= 0 and var_361_7 or var_361_7 * (var_361_12 / var_361_11)

				if var_361_13 > 0 and var_361_7 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_6
					end
				end

				arg_358_1.text_.text = var_361_10
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171085", "story_v_out_411171.awb") ~= 0 then
					local var_361_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171085", "story_v_out_411171.awb") / 1000

					if var_361_14 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_6
					end

					if var_361_9.prefab_name ~= "" and arg_358_1.actors_[var_361_9.prefab_name] ~= nil then
						local var_361_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_9.prefab_name].transform, "story_v_out_411171", "411171085", "story_v_out_411171.awb")

						arg_358_1:RecordAudio("411171085", var_361_15)
						arg_358_1:RecordAudio("411171085", var_361_15)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_411171", "411171085", "story_v_out_411171.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_411171", "411171085", "story_v_out_411171.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_7, arg_358_1.talkMaxDuration)

			if var_361_6 <= arg_358_1.time_ and arg_358_1.time_ < var_361_6 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_6) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_6 + var_361_16 and arg_358_1.time_ < var_361_6 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play411171086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 411171086
		arg_362_1.duration_ = 3.13

		local var_362_0 = {
			zh = 3.133,
			ja = 2.066
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play411171087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1024ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1024ui_story == nil then
				arg_362_1.var_.characterEffect1024ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect1024ui_story and not isNil(var_365_0) then
					arg_362_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect1024ui_story then
				arg_362_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_365_4 = 0

			if var_365_4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_1")
			end

			local var_365_5 = 0

			if var_365_5 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_365_6 = 0
			local var_365_7 = 0.35

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_8 = arg_362_1:FormatText(StoryNameCfg[265].name)

				arg_362_1.leftNameTxt_.text = var_365_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_9 = arg_362_1:GetWordFromCfg(411171086)
				local var_365_10 = arg_362_1:FormatText(var_365_9.content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 14
				local var_365_12 = utf8.len(var_365_10)
				local var_365_13 = var_365_11 <= 0 and var_365_7 or var_365_7 * (var_365_12 / var_365_11)

				if var_365_13 > 0 and var_365_7 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171086", "story_v_out_411171.awb") ~= 0 then
					local var_365_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171086", "story_v_out_411171.awb") / 1000

					if var_365_14 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_6
					end

					if var_365_9.prefab_name ~= "" and arg_362_1.actors_[var_365_9.prefab_name] ~= nil then
						local var_365_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_9.prefab_name].transform, "story_v_out_411171", "411171086", "story_v_out_411171.awb")

						arg_362_1:RecordAudio("411171086", var_365_15)
						arg_362_1:RecordAudio("411171086", var_365_15)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_411171", "411171086", "story_v_out_411171.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_411171", "411171086", "story_v_out_411171.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_16 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_6 <= arg_362_1.time_ and arg_362_1.time_ < var_365_6 + var_365_16 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_6) / var_365_16

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_6 + var_365_16 and arg_362_1.time_ < var_365_6 + var_365_16 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play411171087 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 411171087
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play411171088(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1024ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos1024ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(0, 100, 0)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1024ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(0, 100, 0)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = arg_366_1.actors_["1024ui_story"]
			local var_369_10 = 0

			if var_369_10 < arg_366_1.time_ and arg_366_1.time_ <= var_369_10 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect1024ui_story == nil then
				arg_366_1.var_.characterEffect1024ui_story = var_369_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_11 = 0.200000002980232

			if var_369_10 <= arg_366_1.time_ and arg_366_1.time_ < var_369_10 + var_369_11 and not isNil(var_369_9) then
				local var_369_12 = (arg_366_1.time_ - var_369_10) / var_369_11

				if arg_366_1.var_.characterEffect1024ui_story and not isNil(var_369_9) then
					local var_369_13 = Mathf.Lerp(0, 0.5, var_369_12)

					arg_366_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1024ui_story.fillRatio = var_369_13
				end
			end

			if arg_366_1.time_ >= var_369_10 + var_369_11 and arg_366_1.time_ < var_369_10 + var_369_11 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect1024ui_story then
				local var_369_14 = 0.5

				arg_366_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1024ui_story.fillRatio = var_369_14
			end

			local var_369_15 = 0
			local var_369_16 = 0.95

			if var_369_15 < arg_366_1.time_ and arg_366_1.time_ <= var_369_15 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_17 = arg_366_1:GetWordFromCfg(411171087)
				local var_369_18 = arg_366_1:FormatText(var_369_17.content)

				arg_366_1.text_.text = var_369_18

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_19 = 38
				local var_369_20 = utf8.len(var_369_18)
				local var_369_21 = var_369_19 <= 0 and var_369_16 or var_369_16 * (var_369_20 / var_369_19)

				if var_369_21 > 0 and var_369_16 < var_369_21 then
					arg_366_1.talkMaxDuration = var_369_21

					if var_369_21 + var_369_15 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_21 + var_369_15
					end
				end

				arg_366_1.text_.text = var_369_18
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_22 = math.max(var_369_16, arg_366_1.talkMaxDuration)

			if var_369_15 <= arg_366_1.time_ and arg_366_1.time_ < var_369_15 + var_369_22 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_15) / var_369_22

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_15 + var_369_22 and arg_366_1.time_ < var_369_15 + var_369_22 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play411171088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 411171088
		arg_370_1.duration_ = 10.17

		local var_370_0 = {
			zh = 5.2,
			ja = 10.166
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play411171089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0
			local var_373_1 = 0.625

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_2 = arg_370_1:FormatText(StoryNameCfg[715].name)

				arg_370_1.leftNameTxt_.text = var_373_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:GetWordFromCfg(411171088)
				local var_373_4 = arg_370_1:FormatText(var_373_3.content)

				arg_370_1.text_.text = var_373_4

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 25
				local var_373_6 = utf8.len(var_373_4)
				local var_373_7 = var_373_5 <= 0 and var_373_1 or var_373_1 * (var_373_6 / var_373_5)

				if var_373_7 > 0 and var_373_1 < var_373_7 then
					arg_370_1.talkMaxDuration = var_373_7

					if var_373_7 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_7 + var_373_0
					end
				end

				arg_370_1.text_.text = var_373_4
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171088", "story_v_out_411171.awb") ~= 0 then
					local var_373_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171088", "story_v_out_411171.awb") / 1000

					if var_373_8 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_8 + var_373_0
					end

					if var_373_3.prefab_name ~= "" and arg_370_1.actors_[var_373_3.prefab_name] ~= nil then
						local var_373_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_3.prefab_name].transform, "story_v_out_411171", "411171088", "story_v_out_411171.awb")

						arg_370_1:RecordAudio("411171088", var_373_9)
						arg_370_1:RecordAudio("411171088", var_373_9)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_411171", "411171088", "story_v_out_411171.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_411171", "411171088", "story_v_out_411171.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_10 = math.max(var_373_1, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_10 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_0) / var_373_10

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_10 and arg_370_1.time_ < var_373_0 + var_373_10 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play411171089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 411171089
		arg_374_1.duration_ = 2.3

		local var_374_0 = {
			zh = 2.3,
			ja = 1.666
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play411171090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.15

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_2 = arg_374_1:FormatText(StoryNameCfg[716].name)

				arg_374_1.leftNameTxt_.text = var_377_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:GetWordFromCfg(411171089)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 6
				local var_377_6 = utf8.len(var_377_4)
				local var_377_7 = var_377_5 <= 0 and var_377_1 or var_377_1 * (var_377_6 / var_377_5)

				if var_377_7 > 0 and var_377_1 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_4
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171089", "story_v_out_411171.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171089", "story_v_out_411171.awb") / 1000

					if var_377_8 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_0
					end

					if var_377_3.prefab_name ~= "" and arg_374_1.actors_[var_377_3.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_3.prefab_name].transform, "story_v_out_411171", "411171089", "story_v_out_411171.awb")

						arg_374_1:RecordAudio("411171089", var_377_9)
						arg_374_1:RecordAudio("411171089", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_411171", "411171089", "story_v_out_411171.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_411171", "411171089", "story_v_out_411171.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_10 and arg_374_1.time_ < var_377_0 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play411171090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 411171090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play411171091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.8

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_2 = arg_378_1:GetWordFromCfg(411171090)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 32
				local var_381_5 = utf8.len(var_381_3)
				local var_381_6 = var_381_4 <= 0 and var_381_1 or var_381_1 * (var_381_5 / var_381_4)

				if var_381_6 > 0 and var_381_1 < var_381_6 then
					arg_378_1.talkMaxDuration = var_381_6

					if var_381_6 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_7 and arg_378_1.time_ < var_381_0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play411171091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 411171091
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play411171092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 1.15

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_2 = arg_382_1:GetWordFromCfg(411171091)
				local var_385_3 = arg_382_1:FormatText(var_385_2.content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 46
				local var_385_5 = utf8.len(var_385_3)
				local var_385_6 = var_385_4 <= 0 and var_385_1 or var_385_1 * (var_385_5 / var_385_4)

				if var_385_6 > 0 and var_385_1 < var_385_6 then
					arg_382_1.talkMaxDuration = var_385_6

					if var_385_6 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_6 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_7 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_7 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_7

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_7 and arg_382_1.time_ < var_385_0 + var_385_7 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play411171092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 411171092
		arg_386_1.duration_ = 2.63

		local var_386_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play411171093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1024ui_story"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos1024ui_story = var_389_0.localPosition
			end

			local var_389_2 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2
				local var_389_4 = Vector3.New(0, -1, -6.05)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1024ui_story, var_389_4, var_389_3)

				local var_389_5 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_5.x, var_389_5.y, var_389_5.z)

				local var_389_6 = var_389_0.localEulerAngles

				var_389_6.z = 0
				var_389_6.x = 0
				var_389_0.localEulerAngles = var_389_6
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_389_7 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_7.x, var_389_7.y, var_389_7.z)

				local var_389_8 = var_389_0.localEulerAngles

				var_389_8.z = 0
				var_389_8.x = 0
				var_389_0.localEulerAngles = var_389_8
			end

			local var_389_9 = arg_386_1.actors_["1024ui_story"]
			local var_389_10 = 0

			if var_389_10 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect1024ui_story == nil then
				arg_386_1.var_.characterEffect1024ui_story = var_389_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_11 = 0.200000002980232

			if var_389_10 <= arg_386_1.time_ and arg_386_1.time_ < var_389_10 + var_389_11 and not isNil(var_389_9) then
				local var_389_12 = (arg_386_1.time_ - var_389_10) / var_389_11

				if arg_386_1.var_.characterEffect1024ui_story and not isNil(var_389_9) then
					arg_386_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_10 + var_389_11 and arg_386_1.time_ < var_389_10 + var_389_11 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect1024ui_story then
				arg_386_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_389_13 = 0

			if var_389_13 < arg_386_1.time_ and arg_386_1.time_ <= var_389_13 + arg_389_0 then
				arg_386_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action2_2")
			end

			local var_389_14 = 0

			if var_389_14 < arg_386_1.time_ and arg_386_1.time_ <= var_389_14 + arg_389_0 then
				arg_386_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_389_15 = 0
			local var_389_16 = 0.25

			if var_389_15 < arg_386_1.time_ and arg_386_1.time_ <= var_389_15 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_17 = arg_386_1:FormatText(StoryNameCfg[265].name)

				arg_386_1.leftNameTxt_.text = var_389_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_18 = arg_386_1:GetWordFromCfg(411171092)
				local var_389_19 = arg_386_1:FormatText(var_389_18.content)

				arg_386_1.text_.text = var_389_19

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_20 = 10
				local var_389_21 = utf8.len(var_389_19)
				local var_389_22 = var_389_20 <= 0 and var_389_16 or var_389_16 * (var_389_21 / var_389_20)

				if var_389_22 > 0 and var_389_16 < var_389_22 then
					arg_386_1.talkMaxDuration = var_389_22

					if var_389_22 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_22 + var_389_15
					end
				end

				arg_386_1.text_.text = var_389_19
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171092", "story_v_out_411171.awb") ~= 0 then
					local var_389_23 = manager.audio:GetVoiceLength("story_v_out_411171", "411171092", "story_v_out_411171.awb") / 1000

					if var_389_23 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_23 + var_389_15
					end

					if var_389_18.prefab_name ~= "" and arg_386_1.actors_[var_389_18.prefab_name] ~= nil then
						local var_389_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_18.prefab_name].transform, "story_v_out_411171", "411171092", "story_v_out_411171.awb")

						arg_386_1:RecordAudio("411171092", var_389_24)
						arg_386_1:RecordAudio("411171092", var_389_24)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_411171", "411171092", "story_v_out_411171.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_411171", "411171092", "story_v_out_411171.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_25 = math.max(var_389_16, arg_386_1.talkMaxDuration)

			if var_389_15 <= arg_386_1.time_ and arg_386_1.time_ < var_389_15 + var_389_25 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_15) / var_389_25

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_15 + var_389_25 and arg_386_1.time_ < var_389_15 + var_389_25 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play411171093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 411171093
		arg_390_1.duration_ = 11.03

		local var_390_0 = {
			zh = 7.233,
			ja = 11.033
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play411171094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1024ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1024ui_story == nil then
				arg_390_1.var_.characterEffect1024ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect1024ui_story and not isNil(var_393_0) then
					local var_393_4 = Mathf.Lerp(0, 0.5, var_393_3)

					arg_390_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1024ui_story.fillRatio = var_393_4
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1024ui_story then
				local var_393_5 = 0.5

				arg_390_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1024ui_story.fillRatio = var_393_5
			end

			local var_393_6 = 0
			local var_393_7 = 0.925

			if var_393_6 < arg_390_1.time_ and arg_390_1.time_ <= var_393_6 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_8 = arg_390_1:FormatText(StoryNameCfg[1155].name)

				arg_390_1.leftNameTxt_.text = var_393_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_9 = arg_390_1:GetWordFromCfg(411171093)
				local var_393_10 = arg_390_1:FormatText(var_393_9.content)

				arg_390_1.text_.text = var_393_10

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_11 = 37
				local var_393_12 = utf8.len(var_393_10)
				local var_393_13 = var_393_11 <= 0 and var_393_7 or var_393_7 * (var_393_12 / var_393_11)

				if var_393_13 > 0 and var_393_7 < var_393_13 then
					arg_390_1.talkMaxDuration = var_393_13

					if var_393_13 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_6
					end
				end

				arg_390_1.text_.text = var_393_10
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171093", "story_v_out_411171.awb") ~= 0 then
					local var_393_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171093", "story_v_out_411171.awb") / 1000

					if var_393_14 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_14 + var_393_6
					end

					if var_393_9.prefab_name ~= "" and arg_390_1.actors_[var_393_9.prefab_name] ~= nil then
						local var_393_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_9.prefab_name].transform, "story_v_out_411171", "411171093", "story_v_out_411171.awb")

						arg_390_1:RecordAudio("411171093", var_393_15)
						arg_390_1:RecordAudio("411171093", var_393_15)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_411171", "411171093", "story_v_out_411171.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_411171", "411171093", "story_v_out_411171.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_16 = math.max(var_393_7, arg_390_1.talkMaxDuration)

			if var_393_6 <= arg_390_1.time_ and arg_390_1.time_ < var_393_6 + var_393_16 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_6) / var_393_16

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_6 + var_393_16 and arg_390_1.time_ < var_393_6 + var_393_16 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play411171094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 411171094
		arg_394_1.duration_ = 3.87

		local var_394_0 = {
			zh = 2.566,
			ja = 3.866
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play411171095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.375

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_2 = arg_394_1:FormatText(StoryNameCfg[1155].name)

				arg_394_1.leftNameTxt_.text = var_397_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:GetWordFromCfg(411171094)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 15
				local var_397_6 = utf8.len(var_397_4)
				local var_397_7 = var_397_5 <= 0 and var_397_1 or var_397_1 * (var_397_6 / var_397_5)

				if var_397_7 > 0 and var_397_1 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171094", "story_v_out_411171.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171094", "story_v_out_411171.awb") / 1000

					if var_397_8 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_0
					end

					if var_397_3.prefab_name ~= "" and arg_394_1.actors_[var_397_3.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_3.prefab_name].transform, "story_v_out_411171", "411171094", "story_v_out_411171.awb")

						arg_394_1:RecordAudio("411171094", var_397_9)
						arg_394_1:RecordAudio("411171094", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_411171", "411171094", "story_v_out_411171.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_411171", "411171094", "story_v_out_411171.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_10 and arg_394_1.time_ < var_397_0 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play411171095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 411171095
		arg_398_1.duration_ = 3.87

		local var_398_0 = {
			zh = 3.3,
			ja = 3.866
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play411171096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1024ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos1024ui_story = var_401_0.localPosition
			end

			local var_401_2 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2
				local var_401_4 = Vector3.New(0, -1, -6.05)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1024ui_story, var_401_4, var_401_3)

				local var_401_5 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_5.x, var_401_5.y, var_401_5.z)

				local var_401_6 = var_401_0.localEulerAngles

				var_401_6.z = 0
				var_401_6.x = 0
				var_401_0.localEulerAngles = var_401_6
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_401_7 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_7.x, var_401_7.y, var_401_7.z)

				local var_401_8 = var_401_0.localEulerAngles

				var_401_8.z = 0
				var_401_8.x = 0
				var_401_0.localEulerAngles = var_401_8
			end

			local var_401_9 = arg_398_1.actors_["1024ui_story"]
			local var_401_10 = 0

			if var_401_10 < arg_398_1.time_ and arg_398_1.time_ <= var_401_10 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1024ui_story == nil then
				arg_398_1.var_.characterEffect1024ui_story = var_401_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_11 = 0.200000002980232

			if var_401_10 <= arg_398_1.time_ and arg_398_1.time_ < var_401_10 + var_401_11 and not isNil(var_401_9) then
				local var_401_12 = (arg_398_1.time_ - var_401_10) / var_401_11

				if arg_398_1.var_.characterEffect1024ui_story and not isNil(var_401_9) then
					arg_398_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_10 + var_401_11 and arg_398_1.time_ < var_401_10 + var_401_11 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1024ui_story then
				arg_398_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_401_13 = 0
			local var_401_14 = 0.4

			if var_401_13 < arg_398_1.time_ and arg_398_1.time_ <= var_401_13 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_15 = arg_398_1:FormatText(StoryNameCfg[265].name)

				arg_398_1.leftNameTxt_.text = var_401_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_16 = arg_398_1:GetWordFromCfg(411171095)
				local var_401_17 = arg_398_1:FormatText(var_401_16.content)

				arg_398_1.text_.text = var_401_17

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_18 = 16
				local var_401_19 = utf8.len(var_401_17)
				local var_401_20 = var_401_18 <= 0 and var_401_14 or var_401_14 * (var_401_19 / var_401_18)

				if var_401_20 > 0 and var_401_14 < var_401_20 then
					arg_398_1.talkMaxDuration = var_401_20

					if var_401_20 + var_401_13 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_20 + var_401_13
					end
				end

				arg_398_1.text_.text = var_401_17
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171095", "story_v_out_411171.awb") ~= 0 then
					local var_401_21 = manager.audio:GetVoiceLength("story_v_out_411171", "411171095", "story_v_out_411171.awb") / 1000

					if var_401_21 + var_401_13 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_21 + var_401_13
					end

					if var_401_16.prefab_name ~= "" and arg_398_1.actors_[var_401_16.prefab_name] ~= nil then
						local var_401_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_16.prefab_name].transform, "story_v_out_411171", "411171095", "story_v_out_411171.awb")

						arg_398_1:RecordAudio("411171095", var_401_22)
						arg_398_1:RecordAudio("411171095", var_401_22)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_411171", "411171095", "story_v_out_411171.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_411171", "411171095", "story_v_out_411171.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_23 = math.max(var_401_14, arg_398_1.talkMaxDuration)

			if var_401_13 <= arg_398_1.time_ and arg_398_1.time_ < var_401_13 + var_401_23 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_13) / var_401_23

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_13 + var_401_23 and arg_398_1.time_ < var_401_13 + var_401_23 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play411171096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 411171096
		arg_402_1.duration_ = 7.9

		local var_402_0 = {
			zh = 7.9,
			ja = 7.233
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play411171097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_1")
			end

			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_405_2 = 0
			local var_405_3 = 1.05

			if var_405_2 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_4 = arg_402_1:FormatText(StoryNameCfg[265].name)

				arg_402_1.leftNameTxt_.text = var_405_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_5 = arg_402_1:GetWordFromCfg(411171096)
				local var_405_6 = arg_402_1:FormatText(var_405_5.content)

				arg_402_1.text_.text = var_405_6

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_7 = 42
				local var_405_8 = utf8.len(var_405_6)
				local var_405_9 = var_405_7 <= 0 and var_405_3 or var_405_3 * (var_405_8 / var_405_7)

				if var_405_9 > 0 and var_405_3 < var_405_9 then
					arg_402_1.talkMaxDuration = var_405_9

					if var_405_9 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_9 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_6
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171096", "story_v_out_411171.awb") ~= 0 then
					local var_405_10 = manager.audio:GetVoiceLength("story_v_out_411171", "411171096", "story_v_out_411171.awb") / 1000

					if var_405_10 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_10 + var_405_2
					end

					if var_405_5.prefab_name ~= "" and arg_402_1.actors_[var_405_5.prefab_name] ~= nil then
						local var_405_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_5.prefab_name].transform, "story_v_out_411171", "411171096", "story_v_out_411171.awb")

						arg_402_1:RecordAudio("411171096", var_405_11)
						arg_402_1:RecordAudio("411171096", var_405_11)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_411171", "411171096", "story_v_out_411171.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_411171", "411171096", "story_v_out_411171.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_12 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_12 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_12

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_12 and arg_402_1.time_ < var_405_2 + var_405_12 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play411171097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 411171097
		arg_406_1.duration_ = 4.63

		local var_406_0 = {
			zh = 1.533,
			ja = 4.633
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play411171098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1024ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1024ui_story == nil then
				arg_406_1.var_.characterEffect1024ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1024ui_story and not isNil(var_409_0) then
					local var_409_4 = Mathf.Lerp(0, 0.5, var_409_3)

					arg_406_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1024ui_story.fillRatio = var_409_4
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1024ui_story then
				local var_409_5 = 0.5

				arg_406_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1024ui_story.fillRatio = var_409_5
			end

			local var_409_6 = 0
			local var_409_7 = 0.15

			if var_409_6 < arg_406_1.time_ and arg_406_1.time_ <= var_409_6 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_8 = arg_406_1:FormatText(StoryNameCfg[1155].name)

				arg_406_1.leftNameTxt_.text = var_409_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_9 = arg_406_1:GetWordFromCfg(411171097)
				local var_409_10 = arg_406_1:FormatText(var_409_9.content)

				arg_406_1.text_.text = var_409_10

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_11 = 6
				local var_409_12 = utf8.len(var_409_10)
				local var_409_13 = var_409_11 <= 0 and var_409_7 or var_409_7 * (var_409_12 / var_409_11)

				if var_409_13 > 0 and var_409_7 < var_409_13 then
					arg_406_1.talkMaxDuration = var_409_13

					if var_409_13 + var_409_6 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_13 + var_409_6
					end
				end

				arg_406_1.text_.text = var_409_10
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171097", "story_v_out_411171.awb") ~= 0 then
					local var_409_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171097", "story_v_out_411171.awb") / 1000

					if var_409_14 + var_409_6 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_14 + var_409_6
					end

					if var_409_9.prefab_name ~= "" and arg_406_1.actors_[var_409_9.prefab_name] ~= nil then
						local var_409_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_9.prefab_name].transform, "story_v_out_411171", "411171097", "story_v_out_411171.awb")

						arg_406_1:RecordAudio("411171097", var_409_15)
						arg_406_1:RecordAudio("411171097", var_409_15)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_411171", "411171097", "story_v_out_411171.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_411171", "411171097", "story_v_out_411171.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_16 = math.max(var_409_7, arg_406_1.talkMaxDuration)

			if var_409_6 <= arg_406_1.time_ and arg_406_1.time_ < var_409_6 + var_409_16 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_6) / var_409_16

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_6 + var_409_16 and arg_406_1.time_ < var_409_6 + var_409_16 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play411171098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 411171098
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play411171099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1024ui_story"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos1024ui_story = var_413_0.localPosition
			end

			local var_413_2 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2
				local var_413_4 = Vector3.New(0, 100, 0)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1024ui_story, var_413_4, var_413_3)

				local var_413_5 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_5.x, var_413_5.y, var_413_5.z)

				local var_413_6 = var_413_0.localEulerAngles

				var_413_6.z = 0
				var_413_6.x = 0
				var_413_0.localEulerAngles = var_413_6
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(0, 100, 0)

				local var_413_7 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_7.x, var_413_7.y, var_413_7.z)

				local var_413_8 = var_413_0.localEulerAngles

				var_413_8.z = 0
				var_413_8.x = 0
				var_413_0.localEulerAngles = var_413_8
			end

			local var_413_9 = 0
			local var_413_10 = 1.025

			if var_413_9 < arg_410_1.time_ and arg_410_1.time_ <= var_413_9 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_11 = arg_410_1:GetWordFromCfg(411171098)
				local var_413_12 = arg_410_1:FormatText(var_413_11.content)

				arg_410_1.text_.text = var_413_12

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_13 = 41
				local var_413_14 = utf8.len(var_413_12)
				local var_413_15 = var_413_13 <= 0 and var_413_10 or var_413_10 * (var_413_14 / var_413_13)

				if var_413_15 > 0 and var_413_10 < var_413_15 then
					arg_410_1.talkMaxDuration = var_413_15

					if var_413_15 + var_413_9 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_15 + var_413_9
					end
				end

				arg_410_1.text_.text = var_413_12
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_16 = math.max(var_413_10, arg_410_1.talkMaxDuration)

			if var_413_9 <= arg_410_1.time_ and arg_410_1.time_ < var_413_9 + var_413_16 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_9) / var_413_16

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_9 + var_413_16 and arg_410_1.time_ < var_413_9 + var_413_16 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play411171099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 411171099
		arg_414_1.duration_ = 5.5

		local var_414_0 = {
			zh = 5.2,
			ja = 5.5
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play411171100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.4

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[1155].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(411171099)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 16
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171099", "story_v_out_411171.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171099", "story_v_out_411171.awb") / 1000

					if var_417_8 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_0
					end

					if var_417_3.prefab_name ~= "" and arg_414_1.actors_[var_417_3.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_3.prefab_name].transform, "story_v_out_411171", "411171099", "story_v_out_411171.awb")

						arg_414_1:RecordAudio("411171099", var_417_9)
						arg_414_1:RecordAudio("411171099", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_411171", "411171099", "story_v_out_411171.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_411171", "411171099", "story_v_out_411171.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_10 and arg_414_1.time_ < var_417_0 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play411171100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 411171100
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play411171101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.7

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:GetWordFromCfg(411171100)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 28
				local var_421_5 = utf8.len(var_421_3)
				local var_421_6 = var_421_4 <= 0 and var_421_1 or var_421_1 * (var_421_5 / var_421_4)

				if var_421_6 > 0 and var_421_1 < var_421_6 then
					arg_418_1.talkMaxDuration = var_421_6

					if var_421_6 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_7 and arg_418_1.time_ < var_421_0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play411171101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 411171101
		arg_422_1.duration_ = 2

		local var_422_0 = {
			zh = 1.4,
			ja = 2
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
				arg_422_0:Play411171102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 0.1

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_2 = arg_422_1:FormatText(StoryNameCfg[715].name)

				arg_422_1.leftNameTxt_.text = var_425_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_3 = arg_422_1:GetWordFromCfg(411171101)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_5 = 4
				local var_425_6 = utf8.len(var_425_4)
				local var_425_7 = var_425_5 <= 0 and var_425_1 or var_425_1 * (var_425_6 / var_425_5)

				if var_425_7 > 0 and var_425_1 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171101", "story_v_out_411171.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171101", "story_v_out_411171.awb") / 1000

					if var_425_8 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_0
					end

					if var_425_3.prefab_name ~= "" and arg_422_1.actors_[var_425_3.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_3.prefab_name].transform, "story_v_out_411171", "411171101", "story_v_out_411171.awb")

						arg_422_1:RecordAudio("411171101", var_425_9)
						arg_422_1:RecordAudio("411171101", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_411171", "411171101", "story_v_out_411171.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_411171", "411171101", "story_v_out_411171.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_10 and arg_422_1.time_ < var_425_0 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play411171102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 411171102
		arg_426_1.duration_ = 8.9

		local var_426_0 = {
			zh = 4,
			ja = 8.9
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play411171103(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.375

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[1155].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:GetWordFromCfg(411171102)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 15
				local var_429_6 = utf8.len(var_429_4)
				local var_429_7 = var_429_5 <= 0 and var_429_1 or var_429_1 * (var_429_6 / var_429_5)

				if var_429_7 > 0 and var_429_1 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_4
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171102", "story_v_out_411171.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171102", "story_v_out_411171.awb") / 1000

					if var_429_8 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_0
					end

					if var_429_3.prefab_name ~= "" and arg_426_1.actors_[var_429_3.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_3.prefab_name].transform, "story_v_out_411171", "411171102", "story_v_out_411171.awb")

						arg_426_1:RecordAudio("411171102", var_429_9)
						arg_426_1:RecordAudio("411171102", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_411171", "411171102", "story_v_out_411171.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_411171", "411171102", "story_v_out_411171.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_10 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_10 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_10

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_10 and arg_426_1.time_ < var_429_0 + var_429_10 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play411171103 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 411171103
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play411171104(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 1

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

				local var_433_2 = arg_430_1:GetWordFromCfg(411171103)
				local var_433_3 = arg_430_1:FormatText(var_433_2.content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 40
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
	Play411171104 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 411171104
		arg_434_1.duration_ = 13.27

		local var_434_0 = {
			zh = 6.2,
			ja = 13.266
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
				arg_434_0:Play411171105(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.675

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[1155].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(411171104)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 27
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171104", "story_v_out_411171.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171104", "story_v_out_411171.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_411171", "411171104", "story_v_out_411171.awb")

						arg_434_1:RecordAudio("411171104", var_437_9)
						arg_434_1:RecordAudio("411171104", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_411171", "411171104", "story_v_out_411171.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_411171", "411171104", "story_v_out_411171.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_10 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_10 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_10

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_10 and arg_434_1.time_ < var_437_0 + var_437_10 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play411171105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 411171105
		arg_438_1.duration_ = 4.1

		local var_438_0 = {
			zh = 3.066,
			ja = 4.1
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
				arg_438_0:Play411171106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.4

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[715].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:GetWordFromCfg(411171105)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 16
				local var_441_6 = utf8.len(var_441_4)
				local var_441_7 = var_441_5 <= 0 and var_441_1 or var_441_1 * (var_441_6 / var_441_5)

				if var_441_7 > 0 and var_441_1 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171105", "story_v_out_411171.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171105", "story_v_out_411171.awb") / 1000

					if var_441_8 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_0
					end

					if var_441_3.prefab_name ~= "" and arg_438_1.actors_[var_441_3.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_3.prefab_name].transform, "story_v_out_411171", "411171105", "story_v_out_411171.awb")

						arg_438_1:RecordAudio("411171105", var_441_9)
						arg_438_1:RecordAudio("411171105", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_411171", "411171105", "story_v_out_411171.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_411171", "411171105", "story_v_out_411171.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_10 and arg_438_1.time_ < var_441_0 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play411171106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 411171106
		arg_442_1.duration_ = 2.17

		local var_442_0 = {
			zh = 0.999999999999,
			ja = 2.166
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
				arg_442_0:Play411171107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.075

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_2 = arg_442_1:FormatText(StoryNameCfg[1155].name)

				arg_442_1.leftNameTxt_.text = var_445_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:GetWordFromCfg(411171106)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 3
				local var_445_6 = utf8.len(var_445_4)
				local var_445_7 = var_445_5 <= 0 and var_445_1 or var_445_1 * (var_445_6 / var_445_5)

				if var_445_7 > 0 and var_445_1 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171106", "story_v_out_411171.awb") ~= 0 then
					local var_445_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171106", "story_v_out_411171.awb") / 1000

					if var_445_8 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_0
					end

					if var_445_3.prefab_name ~= "" and arg_442_1.actors_[var_445_3.prefab_name] ~= nil then
						local var_445_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_3.prefab_name].transform, "story_v_out_411171", "411171106", "story_v_out_411171.awb")

						arg_442_1:RecordAudio("411171106", var_445_9)
						arg_442_1:RecordAudio("411171106", var_445_9)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_411171", "411171106", "story_v_out_411171.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_411171", "411171106", "story_v_out_411171.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_10 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_10 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_10

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_10 and arg_442_1.time_ < var_445_0 + var_445_10 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play411171107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 411171107
		arg_446_1.duration_ = 10.27

		local var_446_0 = {
			zh = 8.533,
			ja = 10.266
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play411171108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.9

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_2 = arg_446_1:FormatText(StoryNameCfg[1155].name)

				arg_446_1.leftNameTxt_.text = var_449_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:GetWordFromCfg(411171107)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 36
				local var_449_6 = utf8.len(var_449_4)
				local var_449_7 = var_449_5 <= 0 and var_449_1 or var_449_1 * (var_449_6 / var_449_5)

				if var_449_7 > 0 and var_449_1 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171107", "story_v_out_411171.awb") ~= 0 then
					local var_449_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171107", "story_v_out_411171.awb") / 1000

					if var_449_8 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_0
					end

					if var_449_3.prefab_name ~= "" and arg_446_1.actors_[var_449_3.prefab_name] ~= nil then
						local var_449_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_3.prefab_name].transform, "story_v_out_411171", "411171107", "story_v_out_411171.awb")

						arg_446_1:RecordAudio("411171107", var_449_9)
						arg_446_1:RecordAudio("411171107", var_449_9)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_411171", "411171107", "story_v_out_411171.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_411171", "411171107", "story_v_out_411171.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_10 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_10 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_10

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_10 and arg_446_1.time_ < var_449_0 + var_449_10 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play411171108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 411171108
		arg_450_1.duration_ = 2.6

		local var_450_0 = {
			zh = 2.6,
			ja = 1.966
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play411171109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1024ui_story"].transform
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.var_.moveOldPos1024ui_story = var_453_0.localPosition
			end

			local var_453_2 = 0.001

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2
				local var_453_4 = Vector3.New(0, -1, -6.05)

				var_453_0.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1024ui_story, var_453_4, var_453_3)

				local var_453_5 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_5.x, var_453_5.y, var_453_5.z)

				local var_453_6 = var_453_0.localEulerAngles

				var_453_6.z = 0
				var_453_6.x = 0
				var_453_0.localEulerAngles = var_453_6
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 then
				var_453_0.localPosition = Vector3.New(0, -1, -6.05)

				local var_453_7 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_7.x, var_453_7.y, var_453_7.z)

				local var_453_8 = var_453_0.localEulerAngles

				var_453_8.z = 0
				var_453_8.x = 0
				var_453_0.localEulerAngles = var_453_8
			end

			local var_453_9 = arg_450_1.actors_["1024ui_story"]
			local var_453_10 = 0

			if var_453_10 < arg_450_1.time_ and arg_450_1.time_ <= var_453_10 + arg_453_0 and not isNil(var_453_9) and arg_450_1.var_.characterEffect1024ui_story == nil then
				arg_450_1.var_.characterEffect1024ui_story = var_453_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_11 = 0.200000002980232

			if var_453_10 <= arg_450_1.time_ and arg_450_1.time_ < var_453_10 + var_453_11 and not isNil(var_453_9) then
				local var_453_12 = (arg_450_1.time_ - var_453_10) / var_453_11

				if arg_450_1.var_.characterEffect1024ui_story and not isNil(var_453_9) then
					arg_450_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= var_453_10 + var_453_11 and arg_450_1.time_ < var_453_10 + var_453_11 + arg_453_0 and not isNil(var_453_9) and arg_450_1.var_.characterEffect1024ui_story then
				arg_450_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_453_13 = 0
			local var_453_14 = 0.325

			if var_453_13 < arg_450_1.time_ and arg_450_1.time_ <= var_453_13 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_15 = arg_450_1:FormatText(StoryNameCfg[265].name)

				arg_450_1.leftNameTxt_.text = var_453_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_16 = arg_450_1:GetWordFromCfg(411171108)
				local var_453_17 = arg_450_1:FormatText(var_453_16.content)

				arg_450_1.text_.text = var_453_17

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_18 = 13
				local var_453_19 = utf8.len(var_453_17)
				local var_453_20 = var_453_18 <= 0 and var_453_14 or var_453_14 * (var_453_19 / var_453_18)

				if var_453_20 > 0 and var_453_14 < var_453_20 then
					arg_450_1.talkMaxDuration = var_453_20

					if var_453_20 + var_453_13 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_20 + var_453_13
					end
				end

				arg_450_1.text_.text = var_453_17
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171108", "story_v_out_411171.awb") ~= 0 then
					local var_453_21 = manager.audio:GetVoiceLength("story_v_out_411171", "411171108", "story_v_out_411171.awb") / 1000

					if var_453_21 + var_453_13 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_21 + var_453_13
					end

					if var_453_16.prefab_name ~= "" and arg_450_1.actors_[var_453_16.prefab_name] ~= nil then
						local var_453_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_16.prefab_name].transform, "story_v_out_411171", "411171108", "story_v_out_411171.awb")

						arg_450_1:RecordAudio("411171108", var_453_22)
						arg_450_1:RecordAudio("411171108", var_453_22)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_411171", "411171108", "story_v_out_411171.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_411171", "411171108", "story_v_out_411171.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_23 = math.max(var_453_14, arg_450_1.talkMaxDuration)

			if var_453_13 <= arg_450_1.time_ and arg_450_1.time_ < var_453_13 + var_453_23 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_13) / var_453_23

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_13 + var_453_23 and arg_450_1.time_ < var_453_13 + var_453_23 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play411171109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 411171109
		arg_454_1.duration_ = 9.5

		local var_454_0 = {
			zh = 4.3,
			ja = 9.5
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
				arg_454_0:Play411171110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1024ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1024ui_story == nil then
				arg_454_1.var_.characterEffect1024ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1024ui_story and not isNil(var_457_0) then
					local var_457_4 = Mathf.Lerp(0, 0.5, var_457_3)

					arg_454_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1024ui_story.fillRatio = var_457_4
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1024ui_story then
				local var_457_5 = 0.5

				arg_454_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1024ui_story.fillRatio = var_457_5
			end

			local var_457_6 = 0
			local var_457_7 = 0.575

			if var_457_6 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_8 = arg_454_1:FormatText(StoryNameCfg[1155].name)

				arg_454_1.leftNameTxt_.text = var_457_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_9 = arg_454_1:GetWordFromCfg(411171109)
				local var_457_10 = arg_454_1:FormatText(var_457_9.content)

				arg_454_1.text_.text = var_457_10

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_11 = 23
				local var_457_12 = utf8.len(var_457_10)
				local var_457_13 = var_457_11 <= 0 and var_457_7 or var_457_7 * (var_457_12 / var_457_11)

				if var_457_13 > 0 and var_457_7 < var_457_13 then
					arg_454_1.talkMaxDuration = var_457_13

					if var_457_13 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_6
					end
				end

				arg_454_1.text_.text = var_457_10
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171109", "story_v_out_411171.awb") ~= 0 then
					local var_457_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171109", "story_v_out_411171.awb") / 1000

					if var_457_14 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_14 + var_457_6
					end

					if var_457_9.prefab_name ~= "" and arg_454_1.actors_[var_457_9.prefab_name] ~= nil then
						local var_457_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_9.prefab_name].transform, "story_v_out_411171", "411171109", "story_v_out_411171.awb")

						arg_454_1:RecordAudio("411171109", var_457_15)
						arg_454_1:RecordAudio("411171109", var_457_15)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_411171", "411171109", "story_v_out_411171.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_411171", "411171109", "story_v_out_411171.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_16 = math.max(var_457_7, arg_454_1.talkMaxDuration)

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_16 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_6) / var_457_16

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_6 + var_457_16 and arg_454_1.time_ < var_457_6 + var_457_16 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play411171110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 411171110
		arg_458_1.duration_ = 6.83

		local var_458_0 = {
			zh = 6.833,
			ja = 3.433
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play411171111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1024ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1024ui_story == nil then
				arg_458_1.var_.characterEffect1024ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1024ui_story and not isNil(var_461_0) then
					arg_458_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1024ui_story then
				arg_458_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_461_4 = 0

			if var_461_4 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action6_2")
			end

			local var_461_5 = 0

			if var_461_5 < arg_458_1.time_ and arg_458_1.time_ <= var_461_5 + arg_461_0 then
				arg_458_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_461_6 = 0
			local var_461_7 = 0.95

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_8 = arg_458_1:FormatText(StoryNameCfg[265].name)

				arg_458_1.leftNameTxt_.text = var_461_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_9 = arg_458_1:GetWordFromCfg(411171110)
				local var_461_10 = arg_458_1:FormatText(var_461_9.content)

				arg_458_1.text_.text = var_461_10

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_11 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171110", "story_v_out_411171.awb") ~= 0 then
					local var_461_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171110", "story_v_out_411171.awb") / 1000

					if var_461_14 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_14 + var_461_6
					end

					if var_461_9.prefab_name ~= "" and arg_458_1.actors_[var_461_9.prefab_name] ~= nil then
						local var_461_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_9.prefab_name].transform, "story_v_out_411171", "411171110", "story_v_out_411171.awb")

						arg_458_1:RecordAudio("411171110", var_461_15)
						arg_458_1:RecordAudio("411171110", var_461_15)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_411171", "411171110", "story_v_out_411171.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_411171", "411171110", "story_v_out_411171.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_16 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_16 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_16

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_16 and arg_458_1.time_ < var_461_6 + var_461_16 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play411171111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 411171111
		arg_462_1.duration_ = 2.2

		local var_462_0 = {
			zh = 0.999999999999,
			ja = 2.2
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
				arg_462_0:Play411171112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1024ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1024ui_story == nil then
				arg_462_1.var_.characterEffect1024ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect1024ui_story and not isNil(var_465_0) then
					local var_465_4 = Mathf.Lerp(0, 0.5, var_465_3)

					arg_462_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1024ui_story.fillRatio = var_465_4
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1024ui_story then
				local var_465_5 = 0.5

				arg_462_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1024ui_story.fillRatio = var_465_5
			end

			local var_465_6 = 0
			local var_465_7 = 0.075

			if var_465_6 < arg_462_1.time_ and arg_462_1.time_ <= var_465_6 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_8 = arg_462_1:FormatText(StoryNameCfg[1155].name)

				arg_462_1.leftNameTxt_.text = var_465_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_9 = arg_462_1:GetWordFromCfg(411171111)
				local var_465_10 = arg_462_1:FormatText(var_465_9.content)

				arg_462_1.text_.text = var_465_10

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_11 = 3
				local var_465_12 = utf8.len(var_465_10)
				local var_465_13 = var_465_11 <= 0 and var_465_7 or var_465_7 * (var_465_12 / var_465_11)

				if var_465_13 > 0 and var_465_7 < var_465_13 then
					arg_462_1.talkMaxDuration = var_465_13

					if var_465_13 + var_465_6 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_13 + var_465_6
					end
				end

				arg_462_1.text_.text = var_465_10
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171111", "story_v_out_411171.awb") ~= 0 then
					local var_465_14 = manager.audio:GetVoiceLength("story_v_out_411171", "411171111", "story_v_out_411171.awb") / 1000

					if var_465_14 + var_465_6 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_14 + var_465_6
					end

					if var_465_9.prefab_name ~= "" and arg_462_1.actors_[var_465_9.prefab_name] ~= nil then
						local var_465_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_9.prefab_name].transform, "story_v_out_411171", "411171111", "story_v_out_411171.awb")

						arg_462_1:RecordAudio("411171111", var_465_15)
						arg_462_1:RecordAudio("411171111", var_465_15)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_411171", "411171111", "story_v_out_411171.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_411171", "411171111", "story_v_out_411171.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_16 = math.max(var_465_7, arg_462_1.talkMaxDuration)

			if var_465_6 <= arg_462_1.time_ and arg_462_1.time_ < var_465_6 + var_465_16 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_6) / var_465_16

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_6 + var_465_16 and arg_462_1.time_ < var_465_6 + var_465_16 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play411171112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 411171112
		arg_466_1.duration_ = 5.6

		local var_466_0 = {
			zh = 3.8,
			ja = 5.6
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play411171113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.525

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_2 = arg_466_1:FormatText(StoryNameCfg[1155].name)

				arg_466_1.leftNameTxt_.text = var_469_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossm")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:GetWordFromCfg(411171112)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 21
				local var_469_6 = utf8.len(var_469_4)
				local var_469_7 = var_469_5 <= 0 and var_469_1 or var_469_1 * (var_469_6 / var_469_5)

				if var_469_7 > 0 and var_469_1 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411171", "411171112", "story_v_out_411171.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_out_411171", "411171112", "story_v_out_411171.awb") / 1000

					if var_469_8 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_0
					end

					if var_469_3.prefab_name ~= "" and arg_466_1.actors_[var_469_3.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_3.prefab_name].transform, "story_v_out_411171", "411171112", "story_v_out_411171.awb")

						arg_466_1:RecordAudio("411171112", var_469_9)
						arg_466_1:RecordAudio("411171112", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_411171", "411171112", "story_v_out_411171.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_411171", "411171112", "story_v_out_411171.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_10 and arg_466_1.time_ < var_469_0 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play411171113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 411171113
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
			arg_470_1.auto_ = false
		end

		function arg_470_1.playNext_(arg_472_0)
			arg_470_1.onStoryFinished_()
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1024ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos1024ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, 100, 0)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1024ui_story, var_473_4, var_473_3)

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

			local var_473_9 = arg_470_1.actors_["1024ui_story"]
			local var_473_10 = 0

			if var_473_10 < arg_470_1.time_ and arg_470_1.time_ <= var_473_10 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect1024ui_story == nil then
				arg_470_1.var_.characterEffect1024ui_story = var_473_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_11 = 0.200000002980232

			if var_473_10 <= arg_470_1.time_ and arg_470_1.time_ < var_473_10 + var_473_11 and not isNil(var_473_9) then
				local var_473_12 = (arg_470_1.time_ - var_473_10) / var_473_11

				if arg_470_1.var_.characterEffect1024ui_story and not isNil(var_473_9) then
					local var_473_13 = Mathf.Lerp(0, 0.5, var_473_12)

					arg_470_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1024ui_story.fillRatio = var_473_13
				end
			end

			if arg_470_1.time_ >= var_473_10 + var_473_11 and arg_470_1.time_ < var_473_10 + var_473_11 + arg_473_0 and not isNil(var_473_9) and arg_470_1.var_.characterEffect1024ui_story then
				local var_473_14 = 0.5

				arg_470_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1024ui_story.fillRatio = var_473_14
			end

			local var_473_15 = manager.ui.mainCamera.transform
			local var_473_16 = 0

			if var_473_16 < arg_470_1.time_ and arg_470_1.time_ <= var_473_16 + arg_473_0 then
				local var_473_17 = arg_470_1.var_.effect工厂雨

				if var_473_17 then
					Object.Destroy(var_473_17)

					arg_470_1.var_.effect工厂雨 = nil
				end
			end

			local var_473_18 = 0
			local var_473_19 = 1.05

			if var_473_18 < arg_470_1.time_ and arg_470_1.time_ <= var_473_18 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_20 = arg_470_1:GetWordFromCfg(411171113)
				local var_473_21 = arg_470_1:FormatText(var_473_20.content)

				arg_470_1.text_.text = var_473_21

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_22 = 42
				local var_473_23 = utf8.len(var_473_21)
				local var_473_24 = var_473_22 <= 0 and var_473_19 or var_473_19 * (var_473_23 / var_473_22)

				if var_473_24 > 0 and var_473_19 < var_473_24 then
					arg_470_1.talkMaxDuration = var_473_24

					if var_473_24 + var_473_18 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_24 + var_473_18
					end
				end

				arg_470_1.text_.text = var_473_21
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_25 = math.max(var_473_19, arg_470_1.talkMaxDuration)

			if var_473_18 <= arg_470_1.time_ and arg_470_1.time_ < var_473_18 + var_473_25 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_18) / var_473_25

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_18 + var_473_25 and arg_470_1.time_ < var_473_18 + var_473_25 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10b",
		"TextureConfig/Background/ST75"
	},
	voices = {
		"story_v_out_411171.awb"
	}
}
