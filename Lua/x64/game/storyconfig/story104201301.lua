return {
	Play420131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420131001
		arg_1_1.duration_ = 12.37

		local var_1_0 = {
			zh = 8.766,
			ja = 12.366
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
				arg_1_0:Play420131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0504a"

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
				local var_4_5 = arg_1_1.bgs_.ST0504a

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
					if iter_4_0 ~= "ST0504a" then
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

			local var_4_24 = "404001ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["404001ui_story"].transform
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos404001ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.55, -5.5)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos404001ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["404001ui_story"]
			local var_4_39 = 2

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect404001ui_story == nil then
				arg_1_1.var_.characterEffect404001ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect404001ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect404001ui_story then
				arg_1_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_4_42 = 2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_43 = 2

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_4_44 = 0
			local var_4_45 = 0.2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 0.4
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

				if var_4_55 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_55 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_55

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_55
						arg_1_1.bgmTxt2_.text = var_4_55
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

			local var_4_56 = 2
			local var_4_57 = 0.8

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[668].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(420131001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 32
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131001", "story_v_out_420131.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_420131", "420131001", "story_v_out_420131.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_420131", "420131001", "story_v_out_420131.awb")

						arg_1_1:RecordAudio("420131001", var_4_66)
						arg_1_1:RecordAudio("420131001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_420131", "420131001", "story_v_out_420131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_420131", "420131001", "story_v_out_420131.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play420131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420131002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["404001ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos404001ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos404001ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = "1085ui_story"

			if arg_9_1.actors_[var_12_9] == nil then
				local var_12_10 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_12_10) then
					local var_12_11 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_9_1.stage_.transform)

					var_12_11.name = var_12_9
					var_12_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_9] = var_12_11

					local var_12_12 = var_12_11:GetComponentInChildren(typeof(CharacterEffect))

					var_12_12.enabled = true

					local var_12_13 = GameObjectTools.GetOrAddComponent(var_12_11, typeof(DynamicBoneHelper))

					if var_12_13 then
						var_12_13:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_12.transform, false)

					arg_9_1.var_[var_12_9 .. "Animator"] = var_12_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_9 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_9 .. "LipSync"] = var_12_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_14 = arg_9_1.actors_["1085ui_story"].transform
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.var_.moveOldPos1085ui_story = var_12_14.localPosition
			end

			local var_12_16 = 0.001

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16
				local var_12_18 = Vector3.New(0.75, -1.01, -5.83)

				var_12_14.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1085ui_story, var_12_18, var_12_17)

				local var_12_19 = manager.ui.mainCamera.transform.position - var_12_14.position

				var_12_14.forward = Vector3.New(var_12_19.x, var_12_19.y, var_12_19.z)

				local var_12_20 = var_12_14.localEulerAngles

				var_12_20.z = 0
				var_12_20.x = 0
				var_12_14.localEulerAngles = var_12_20
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 then
				var_12_14.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_12_21 = manager.ui.mainCamera.transform.position - var_12_14.position

				var_12_14.forward = Vector3.New(var_12_21.x, var_12_21.y, var_12_21.z)

				local var_12_22 = var_12_14.localEulerAngles

				var_12_22.z = 0
				var_12_22.x = 0
				var_12_14.localEulerAngles = var_12_22
			end

			local var_12_23 = arg_9_1.actors_["1085ui_story"]
			local var_12_24 = 0

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 and not isNil(var_12_23) and arg_9_1.var_.characterEffect1085ui_story == nil then
				arg_9_1.var_.characterEffect1085ui_story = var_12_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_25 = 0.200000002980232

			if var_12_24 <= arg_9_1.time_ and arg_9_1.time_ < var_12_24 + var_12_25 and not isNil(var_12_23) then
				local var_12_26 = (arg_9_1.time_ - var_12_24) / var_12_25

				if arg_9_1.var_.characterEffect1085ui_story and not isNil(var_12_23) then
					arg_9_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_24 + var_12_25 and arg_9_1.time_ < var_12_24 + var_12_25 + arg_12_0 and not isNil(var_12_23) and arg_9_1.var_.characterEffect1085ui_story then
				arg_9_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_12_27 = arg_9_1.actors_["404001ui_story"]
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 and not isNil(var_12_27) and arg_9_1.var_.characterEffect404001ui_story == nil then
				arg_9_1.var_.characterEffect404001ui_story = var_12_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_29 = 0.200000002980232

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_29 and not isNil(var_12_27) then
				local var_12_30 = (arg_9_1.time_ - var_12_28) / var_12_29

				if arg_9_1.var_.characterEffect404001ui_story and not isNil(var_12_27) then
					local var_12_31 = Mathf.Lerp(0, 0.5, var_12_30)

					arg_9_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_9_1.var_.characterEffect404001ui_story.fillRatio = var_12_31
				end
			end

			if arg_9_1.time_ >= var_12_28 + var_12_29 and arg_9_1.time_ < var_12_28 + var_12_29 + arg_12_0 and not isNil(var_12_27) and arg_9_1.var_.characterEffect404001ui_story then
				local var_12_32 = 0.5

				arg_9_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_9_1.var_.characterEffect404001ui_story.fillRatio = var_12_32
			end

			local var_12_33 = 0

			if var_12_33 < arg_9_1.time_ and arg_9_1.time_ <= var_12_33 + arg_12_0 then
				arg_9_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_12_34 = 0

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_12_35 = 0
			local var_12_36 = 0.425

			if var_12_35 < arg_9_1.time_ and arg_9_1.time_ <= var_12_35 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_37 = arg_9_1:FormatText(StoryNameCfg[328].name)

				arg_9_1.leftNameTxt_.text = var_12_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_38 = arg_9_1:GetWordFromCfg(420131002)
				local var_12_39 = arg_9_1:FormatText(var_12_38.content)

				arg_9_1.text_.text = var_12_39

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_40 = 17
				local var_12_41 = utf8.len(var_12_39)
				local var_12_42 = var_12_40 <= 0 and var_12_36 or var_12_36 * (var_12_41 / var_12_40)

				if var_12_42 > 0 and var_12_36 < var_12_42 then
					arg_9_1.talkMaxDuration = var_12_42

					if var_12_42 + var_12_35 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_35
					end
				end

				arg_9_1.text_.text = var_12_39
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131002", "story_v_out_420131.awb") ~= 0 then
					local var_12_43 = manager.audio:GetVoiceLength("story_v_out_420131", "420131002", "story_v_out_420131.awb") / 1000

					if var_12_43 + var_12_35 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_43 + var_12_35
					end

					if var_12_38.prefab_name ~= "" and arg_9_1.actors_[var_12_38.prefab_name] ~= nil then
						local var_12_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_38.prefab_name].transform, "story_v_out_420131", "420131002", "story_v_out_420131.awb")

						arg_9_1:RecordAudio("420131002", var_12_44)
						arg_9_1:RecordAudio("420131002", var_12_44)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_420131", "420131002", "story_v_out_420131.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_420131", "420131002", "story_v_out_420131.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_45 = math.max(var_12_36, arg_9_1.talkMaxDuration)

			if var_12_35 <= arg_9_1.time_ and arg_9_1.time_ < var_12_35 + var_12_45 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_35) / var_12_45

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_35 + var_12_45 and arg_9_1.time_ < var_12_35 + var_12_45 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420131003
		arg_13_1.duration_ = 7.07

		local var_13_0 = {
			zh = 7,
			ja = 7.066
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
				arg_13_0:Play420131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["404001ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect404001ui_story then
				arg_13_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_16_4 = arg_13_1.actors_["1085ui_story"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1085ui_story == nil then
				arg_13_1.var_.characterEffect1085ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.characterEffect1085ui_story and not isNil(var_16_4) then
					local var_16_8 = Mathf.Lerp(0, 0.5, var_16_7)

					arg_13_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1085ui_story.fillRatio = var_16_8
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1085ui_story then
				local var_16_9 = 0.5

				arg_13_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1085ui_story.fillRatio = var_16_9
			end

			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_11 = 0

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_16_12 = 0
			local var_16_13 = 0.775

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[668].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(420131003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 31
				local var_16_18 = utf8.len(var_16_16)
				local var_16_19 = var_16_17 <= 0 and var_16_13 or var_16_13 * (var_16_18 / var_16_17)

				if var_16_19 > 0 and var_16_13 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131003", "story_v_out_420131.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_420131", "420131003", "story_v_out_420131.awb") / 1000

					if var_16_20 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_420131", "420131003", "story_v_out_420131.awb")

						arg_13_1:RecordAudio("420131003", var_16_21)
						arg_13_1:RecordAudio("420131003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_420131", "420131003", "story_v_out_420131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_420131", "420131003", "story_v_out_420131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_22 and arg_13_1.time_ < var_16_12 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play420131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420131004
		arg_17_1.duration_ = 8.2

		local var_17_0 = {
			zh = 8.2,
			ja = 7.666
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
				arg_17_0:Play420131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.975

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[668].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(420131004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 39
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131004", "story_v_out_420131.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_420131", "420131004", "story_v_out_420131.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_420131", "420131004", "story_v_out_420131.awb")

						arg_17_1:RecordAudio("420131004", var_20_9)
						arg_17_1:RecordAudio("420131004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_420131", "420131004", "story_v_out_420131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_420131", "420131004", "story_v_out_420131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play420131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 420131005
		arg_21_1.duration_ = 3.17

		local var_21_0 = {
			zh = 1.999999999999,
			ja = 3.166
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
				arg_21_0:Play420131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1085ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1085ui_story == nil then
				arg_21_1.var_.characterEffect1085ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1085ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1085ui_story then
				arg_21_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["404001ui_story"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect404001ui_story == nil then
				arg_21_1.var_.characterEffect404001ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.characterEffect404001ui_story and not isNil(var_24_4) then
					local var_24_8 = Mathf.Lerp(0, 0.5, var_24_7)

					arg_21_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_21_1.var_.characterEffect404001ui_story.fillRatio = var_24_8
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect404001ui_story then
				local var_24_9 = 0.5

				arg_21_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_21_1.var_.characterEffect404001ui_story.fillRatio = var_24_9
			end

			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_24_11 = 0
			local var_24_12 = 0.2

			if var_24_11 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_13 = arg_21_1:FormatText(StoryNameCfg[328].name)

				arg_21_1.leftNameTxt_.text = var_24_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(420131005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 8
				local var_24_17 = utf8.len(var_24_15)
				local var_24_18 = var_24_16 <= 0 and var_24_12 or var_24_12 * (var_24_17 / var_24_16)

				if var_24_18 > 0 and var_24_12 < var_24_18 then
					arg_21_1.talkMaxDuration = var_24_18

					if var_24_18 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131005", "story_v_out_420131.awb") ~= 0 then
					local var_24_19 = manager.audio:GetVoiceLength("story_v_out_420131", "420131005", "story_v_out_420131.awb") / 1000

					if var_24_19 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_11
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_420131", "420131005", "story_v_out_420131.awb")

						arg_21_1:RecordAudio("420131005", var_24_20)
						arg_21_1:RecordAudio("420131005", var_24_20)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_420131", "420131005", "story_v_out_420131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_420131", "420131005", "story_v_out_420131.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_21 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_21 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_21

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_21 and arg_21_1.time_ < var_24_11 + var_24_21 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play420131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 420131006
		arg_25_1.duration_ = 4.2

		local var_25_0 = {
			zh = 3.233,
			ja = 4.2
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
				arg_25_0:Play420131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.325

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[328].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(420131006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 13
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131006", "story_v_out_420131.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_420131", "420131006", "story_v_out_420131.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_420131", "420131006", "story_v_out_420131.awb")

						arg_25_1:RecordAudio("420131006", var_28_9)
						arg_25_1:RecordAudio("420131006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_420131", "420131006", "story_v_out_420131.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_420131", "420131006", "story_v_out_420131.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play420131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 420131007
		arg_29_1.duration_ = 4.73

		local var_29_0 = {
			zh = 2.833,
			ja = 4.733
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
				arg_29_0:Play420131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["404001ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect404001ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect404001ui_story then
				arg_29_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["1085ui_story"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1085ui_story == nil then
				arg_29_1.var_.characterEffect1085ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.characterEffect1085ui_story and not isNil(var_32_4) then
					local var_32_8 = Mathf.Lerp(0, 0.5, var_32_7)

					arg_29_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1085ui_story.fillRatio = var_32_8
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1085ui_story then
				local var_32_9 = 0.5

				arg_29_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1085ui_story.fillRatio = var_32_9
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_32_11 = 0

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_32_12 = 0
			local var_32_13 = 0.3

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[668].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(420131007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 12
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131007", "story_v_out_420131.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_420131", "420131007", "story_v_out_420131.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_420131", "420131007", "story_v_out_420131.awb")

						arg_29_1:RecordAudio("420131007", var_32_21)
						arg_29_1:RecordAudio("420131007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_420131", "420131007", "story_v_out_420131.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_420131", "420131007", "story_v_out_420131.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_22 and arg_29_1.time_ < var_32_12 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play420131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 420131008
		arg_33_1.duration_ = 5.4

		local var_33_0 = {
			zh = 3.733,
			ja = 5.4
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
				arg_33_0:Play420131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1085ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1085ui_story == nil then
				arg_33_1.var_.characterEffect1085ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1085ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1085ui_story then
				arg_33_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["404001ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect404001ui_story == nil then
				arg_33_1.var_.characterEffect404001ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect404001ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_33_1.var_.characterEffect404001ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect404001ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_33_1.var_.characterEffect404001ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_36_11 = 0

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_36_12 = 0
			local var_36_13 = 0.325

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_14 = arg_33_1:FormatText(StoryNameCfg[328].name)

				arg_33_1.leftNameTxt_.text = var_36_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_15 = arg_33_1:GetWordFromCfg(420131008)
				local var_36_16 = arg_33_1:FormatText(var_36_15.content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 13
				local var_36_18 = utf8.len(var_36_16)
				local var_36_19 = var_36_17 <= 0 and var_36_13 or var_36_13 * (var_36_18 / var_36_17)

				if var_36_19 > 0 and var_36_13 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19

					if var_36_19 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_16
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131008", "story_v_out_420131.awb") ~= 0 then
					local var_36_20 = manager.audio:GetVoiceLength("story_v_out_420131", "420131008", "story_v_out_420131.awb") / 1000

					if var_36_20 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_12
					end

					if var_36_15.prefab_name ~= "" and arg_33_1.actors_[var_36_15.prefab_name] ~= nil then
						local var_36_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_15.prefab_name].transform, "story_v_out_420131", "420131008", "story_v_out_420131.awb")

						arg_33_1:RecordAudio("420131008", var_36_21)
						arg_33_1:RecordAudio("420131008", var_36_21)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_420131", "420131008", "story_v_out_420131.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_420131", "420131008", "story_v_out_420131.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_22 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_22 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_22

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_22 and arg_33_1.time_ < var_36_12 + var_36_22 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play420131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 420131009
		arg_37_1.duration_ = 9.6

		local var_37_0 = {
			zh = 8.133,
			ja = 9.6
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
				arg_37_0:Play420131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["404001ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect404001ui_story == nil then
				arg_37_1.var_.characterEffect404001ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect404001ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect404001ui_story then
				arg_37_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["1085ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1085ui_story == nil then
				arg_37_1.var_.characterEffect1085ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect1085ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1085ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1085ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1085ui_story.fillRatio = var_40_9
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_11 = 0
			local var_40_12 = 0.925

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[668].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(420131009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 37
				local var_40_17 = utf8.len(var_40_15)
				local var_40_18 = var_40_16 <= 0 and var_40_12 or var_40_12 * (var_40_17 / var_40_16)

				if var_40_18 > 0 and var_40_12 < var_40_18 then
					arg_37_1.talkMaxDuration = var_40_18

					if var_40_18 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131009", "story_v_out_420131.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_420131", "420131009", "story_v_out_420131.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_420131", "420131009", "story_v_out_420131.awb")

						arg_37_1:RecordAudio("420131009", var_40_20)
						arg_37_1:RecordAudio("420131009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_420131", "420131009", "story_v_out_420131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_420131", "420131009", "story_v_out_420131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_21 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_21 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_21

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_21 and arg_37_1.time_ < var_40_11 + var_40_21 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play420131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 420131010
		arg_41_1.duration_ = 6.17

		local var_41_0 = {
			zh = 3.5,
			ja = 6.166
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
				arg_41_0:Play420131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1085ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1085ui_story == nil then
				arg_41_1.var_.characterEffect1085ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1085ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1085ui_story then
				arg_41_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["404001ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect404001ui_story == nil then
				arg_41_1.var_.characterEffect404001ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect404001ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_41_1.var_.characterEffect404001ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect404001ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_41_1.var_.characterEffect404001ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_44_11 = 0
			local var_44_12 = 0.4

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_13 = arg_41_1:FormatText(StoryNameCfg[328].name)

				arg_41_1.leftNameTxt_.text = var_44_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(420131010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 16
				local var_44_17 = utf8.len(var_44_15)
				local var_44_18 = var_44_16 <= 0 and var_44_12 or var_44_12 * (var_44_17 / var_44_16)

				if var_44_18 > 0 and var_44_12 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131010", "story_v_out_420131.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_420131", "420131010", "story_v_out_420131.awb") / 1000

					if var_44_19 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_11
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_420131", "420131010", "story_v_out_420131.awb")

						arg_41_1:RecordAudio("420131010", var_44_20)
						arg_41_1:RecordAudio("420131010", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_420131", "420131010", "story_v_out_420131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_420131", "420131010", "story_v_out_420131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_21 and arg_41_1.time_ < var_44_11 + var_44_21 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play420131011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 420131011
		arg_45_1.duration_ = 7.53

		local var_45_0 = {
			zh = 4.766,
			ja = 7.533
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
				arg_45_0:Play420131012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["404001ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect404001ui_story then
				arg_45_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["1085ui_story"]
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1085ui_story == nil then
				arg_45_1.var_.characterEffect1085ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_6 = 0.200000002980232

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 and not isNil(var_48_4) then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6

				if arg_45_1.var_.characterEffect1085ui_story and not isNil(var_48_4) then
					local var_48_8 = Mathf.Lerp(0, 0.5, var_48_7)

					arg_45_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1085ui_story.fillRatio = var_48_8
				end
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1085ui_story then
				local var_48_9 = 0.5

				arg_45_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1085ui_story.fillRatio = var_48_9
			end

			local var_48_10 = 0
			local var_48_11 = 0.425

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_12 = arg_45_1:FormatText(StoryNameCfg[668].name)

				arg_45_1.leftNameTxt_.text = var_48_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(420131011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 17
				local var_48_16 = utf8.len(var_48_14)
				local var_48_17 = var_48_15 <= 0 and var_48_11 or var_48_11 * (var_48_16 / var_48_15)

				if var_48_17 > 0 and var_48_11 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131011", "story_v_out_420131.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_420131", "420131011", "story_v_out_420131.awb") / 1000

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_420131", "420131011", "story_v_out_420131.awb")

						arg_45_1:RecordAudio("420131011", var_48_19)
						arg_45_1:RecordAudio("420131011", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_420131", "420131011", "story_v_out_420131.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_420131", "420131011", "story_v_out_420131.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_20 and arg_45_1.time_ < var_48_10 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play420131012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 420131012
		arg_49_1.duration_ = 7.83

		local var_49_0 = {
			zh = 7.8,
			ja = 7.833
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
				arg_49_0:Play420131013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1085ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1085ui_story == nil then
				arg_49_1.var_.characterEffect1085ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1085ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1085ui_story then
				arg_49_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["404001ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect404001ui_story == nil then
				arg_49_1.var_.characterEffect404001ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect404001ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_49_1.var_.characterEffect404001ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect404001ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_49_1.var_.characterEffect404001ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_52_11 = 0

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_12 = 0
			local var_52_13 = 0.675

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[328].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(420131012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 27
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131012", "story_v_out_420131.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_420131", "420131012", "story_v_out_420131.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_420131", "420131012", "story_v_out_420131.awb")

						arg_49_1:RecordAudio("420131012", var_52_21)
						arg_49_1:RecordAudio("420131012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_420131", "420131012", "story_v_out_420131.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_420131", "420131012", "story_v_out_420131.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play420131013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 420131013
		arg_53_1.duration_ = 18.4

		local var_53_0 = {
			zh = 13.133,
			ja = 18.4
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
				arg_53_0:Play420131014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.25

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[328].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(420131013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131013", "story_v_out_420131.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_420131", "420131013", "story_v_out_420131.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_420131", "420131013", "story_v_out_420131.awb")

						arg_53_1:RecordAudio("420131013", var_56_9)
						arg_53_1:RecordAudio("420131013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_420131", "420131013", "story_v_out_420131.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_420131", "420131013", "story_v_out_420131.awb")
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
	Play420131014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 420131014
		arg_57_1.duration_ = 9.43

		local var_57_0 = {
			zh = 7.666,
			ja = 9.433
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
				arg_57_0:Play420131015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_2 = 0.85

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_3 = 0
			local var_60_4 = 0.85

			if var_60_3 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_5 = arg_57_1:FormatText(StoryNameCfg[328].name)

				arg_57_1.leftNameTxt_.text = var_60_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(420131014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_8 = 34
				local var_60_9 = utf8.len(var_60_7)
				local var_60_10 = var_60_8 <= 0 and var_60_4 or var_60_4 * (var_60_9 / var_60_8)

				if var_60_10 > 0 and var_60_4 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131014", "story_v_out_420131.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_420131", "420131014", "story_v_out_420131.awb") / 1000

					if var_60_11 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_3
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_420131", "420131014", "story_v_out_420131.awb")

						arg_57_1:RecordAudio("420131014", var_60_12)
						arg_57_1:RecordAudio("420131014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_420131", "420131014", "story_v_out_420131.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_420131", "420131014", "story_v_out_420131.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_13 and arg_57_1.time_ < var_60_3 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play420131015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 420131015
		arg_61_1.duration_ = 8

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play420131016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "ST0505a"

			if arg_61_1.bgs_[var_64_0] == nil then
				local var_64_1 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_64_0)
				var_64_1.name = var_64_0
				var_64_1.transform.parent = arg_61_1.stage_.transform
				var_64_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_[var_64_0] = var_64_1
			end

			local var_64_2 = 1

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				local var_64_3 = manager.ui.mainCamera.transform.localPosition
				local var_64_4 = Vector3.New(0, 0, 10) + Vector3.New(var_64_3.x, var_64_3.y, 0)
				local var_64_5 = arg_61_1.bgs_.ST0505a

				var_64_5.transform.localPosition = var_64_4
				var_64_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_6 = var_64_5:GetComponent("SpriteRenderer")

				if var_64_6 and var_64_6.sprite then
					local var_64_7 = (var_64_5.transform.localPosition - var_64_3).z
					local var_64_8 = manager.ui.mainCameraCom_
					local var_64_9 = 2 * var_64_7 * Mathf.Tan(var_64_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_64_10 = var_64_9 * var_64_8.aspect
					local var_64_11 = var_64_6.sprite.bounds.size.x
					local var_64_12 = var_64_6.sprite.bounds.size.y
					local var_64_13 = var_64_10 / var_64_11
					local var_64_14 = var_64_9 / var_64_12
					local var_64_15 = var_64_14 < var_64_13 and var_64_13 or var_64_14

					var_64_5.transform.localScale = Vector3.New(var_64_15, var_64_15, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST0505a" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_16 = 3

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_17 = 0.3

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_18 = 0

			if var_64_18 < arg_61_1.time_ and arg_61_1.time_ <= var_64_18 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_19 = 1

			if var_64_18 <= arg_61_1.time_ and arg_61_1.time_ < var_64_18 + var_64_19 then
				local var_64_20 = (arg_61_1.time_ - var_64_18) / var_64_19
				local var_64_21 = Color.New(0, 0, 0)

				var_64_21.a = Mathf.Lerp(0, 1, var_64_20)
				arg_61_1.mask_.color = var_64_21
			end

			if arg_61_1.time_ >= var_64_18 + var_64_19 and arg_61_1.time_ < var_64_18 + var_64_19 + arg_64_0 then
				local var_64_22 = Color.New(0, 0, 0)

				var_64_22.a = 1
				arg_61_1.mask_.color = var_64_22
			end

			local var_64_23 = 1

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_24 = 2

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 then
				local var_64_25 = (arg_61_1.time_ - var_64_23) / var_64_24
				local var_64_26 = Color.New(0, 0, 0)

				var_64_26.a = Mathf.Lerp(1, 0, var_64_25)
				arg_61_1.mask_.color = var_64_26
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 then
				local var_64_27 = Color.New(0, 0, 0)
				local var_64_28 = 0

				arg_61_1.mask_.enabled = false
				var_64_27.a = var_64_28
				arg_61_1.mask_.color = var_64_27
			end

			local var_64_29 = arg_61_1.actors_["404001ui_story"].transform
			local var_64_30 = 1

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.var_.moveOldPos404001ui_story = var_64_29.localPosition
			end

			local var_64_31 = 0.001

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_31 then
				local var_64_32 = (arg_61_1.time_ - var_64_30) / var_64_31
				local var_64_33 = Vector3.New(0, 100, 0)

				var_64_29.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos404001ui_story, var_64_33, var_64_32)

				local var_64_34 = manager.ui.mainCamera.transform.position - var_64_29.position

				var_64_29.forward = Vector3.New(var_64_34.x, var_64_34.y, var_64_34.z)

				local var_64_35 = var_64_29.localEulerAngles

				var_64_35.z = 0
				var_64_35.x = 0
				var_64_29.localEulerAngles = var_64_35
			end

			if arg_61_1.time_ >= var_64_30 + var_64_31 and arg_61_1.time_ < var_64_30 + var_64_31 + arg_64_0 then
				var_64_29.localPosition = Vector3.New(0, 100, 0)

				local var_64_36 = manager.ui.mainCamera.transform.position - var_64_29.position

				var_64_29.forward = Vector3.New(var_64_36.x, var_64_36.y, var_64_36.z)

				local var_64_37 = var_64_29.localEulerAngles

				var_64_37.z = 0
				var_64_37.x = 0
				var_64_29.localEulerAngles = var_64_37
			end

			local var_64_38 = arg_61_1.actors_["1085ui_story"].transform
			local var_64_39 = 1

			if var_64_39 < arg_61_1.time_ and arg_61_1.time_ <= var_64_39 + arg_64_0 then
				arg_61_1.var_.moveOldPos1085ui_story = var_64_38.localPosition
			end

			local var_64_40 = 0.001

			if var_64_39 <= arg_61_1.time_ and arg_61_1.time_ < var_64_39 + var_64_40 then
				local var_64_41 = (arg_61_1.time_ - var_64_39) / var_64_40
				local var_64_42 = Vector3.New(0, 100, 0)

				var_64_38.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1085ui_story, var_64_42, var_64_41)

				local var_64_43 = manager.ui.mainCamera.transform.position - var_64_38.position

				var_64_38.forward = Vector3.New(var_64_43.x, var_64_43.y, var_64_43.z)

				local var_64_44 = var_64_38.localEulerAngles

				var_64_44.z = 0
				var_64_44.x = 0
				var_64_38.localEulerAngles = var_64_44
			end

			if arg_61_1.time_ >= var_64_39 + var_64_40 and arg_61_1.time_ < var_64_39 + var_64_40 + arg_64_0 then
				var_64_38.localPosition = Vector3.New(0, 100, 0)

				local var_64_45 = manager.ui.mainCamera.transform.position - var_64_38.position

				var_64_38.forward = Vector3.New(var_64_45.x, var_64_45.y, var_64_45.z)

				local var_64_46 = var_64_38.localEulerAngles

				var_64_46.z = 0
				var_64_46.x = 0
				var_64_38.localEulerAngles = var_64_46
			end

			local var_64_47 = arg_61_1.actors_["1085ui_story"]
			local var_64_48 = 1

			if var_64_48 < arg_61_1.time_ and arg_61_1.time_ <= var_64_48 + arg_64_0 and not isNil(var_64_47) and arg_61_1.var_.characterEffect1085ui_story == nil then
				arg_61_1.var_.characterEffect1085ui_story = var_64_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_49 = 0.200000002980232

			if var_64_48 <= arg_61_1.time_ and arg_61_1.time_ < var_64_48 + var_64_49 and not isNil(var_64_47) then
				local var_64_50 = (arg_61_1.time_ - var_64_48) / var_64_49

				if arg_61_1.var_.characterEffect1085ui_story and not isNil(var_64_47) then
					local var_64_51 = Mathf.Lerp(0, 0.5, var_64_50)

					arg_61_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1085ui_story.fillRatio = var_64_51
				end
			end

			if arg_61_1.time_ >= var_64_48 + var_64_49 and arg_61_1.time_ < var_64_48 + var_64_49 + arg_64_0 and not isNil(var_64_47) and arg_61_1.var_.characterEffect1085ui_story then
				local var_64_52 = 0.5

				arg_61_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1085ui_story.fillRatio = var_64_52
			end

			local var_64_53 = 0
			local var_64_54 = 0.2

			if var_64_53 < arg_61_1.time_ and arg_61_1.time_ <= var_64_53 + arg_64_0 then
				local var_64_55 = "play"
				local var_64_56 = "music"

				arg_61_1:AudioAction(var_64_55, var_64_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_64_57 = ""
				local var_64_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_64_58 ~= "" then
					if arg_61_1.bgmTxt_.text ~= var_64_58 and arg_61_1.bgmTxt_.text ~= "" then
						if arg_61_1.bgmTxt2_.text ~= "" then
							arg_61_1.bgmTxt_.text = arg_61_1.bgmTxt2_.text
						end

						arg_61_1.bgmTxt2_.text = var_64_58

						arg_61_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_61_1.bgmTxt_.text = var_64_58
						arg_61_1.bgmTxt2_.text = var_64_58
					end

					if arg_61_1.bgmTimer then
						arg_61_1.bgmTimer:Stop()

						arg_61_1.bgmTimer = nil
					end

					if arg_61_1.settingData.show_music_name == 1 then
						arg_61_1.musicController:SetSelectedState("show")
						arg_61_1.musicAnimator_:Play("open", 0, 0)

						if arg_61_1.settingData.music_time ~= 0 then
							arg_61_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_61_1.settingData.music_time), function()
								if arg_61_1 == nil or isNil(arg_61_1.bgmTxt_) then
									return
								end

								arg_61_1.musicController:SetSelectedState("hide")
								arg_61_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_64_59 = 0.866666666666667
			local var_64_60 = 1

			if var_64_59 < arg_61_1.time_ and arg_61_1.time_ <= var_64_59 + arg_64_0 then
				local var_64_61 = "play"
				local var_64_62 = "effect"

				arg_61_1:AudioAction(var_64_61, var_64_62, "se_story_140", "se_story_140_amb_rain", "")
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_63 = 3
			local var_64_64 = 0.625

			if var_64_63 < arg_61_1.time_ and arg_61_1.time_ <= var_64_63 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_65 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_65:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_61_1.dialogCg_.alpha = arg_66_0
				end))
				var_64_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_66 = arg_61_1:GetWordFromCfg(420131015)
				local var_64_67 = arg_61_1:FormatText(var_64_66.content)

				arg_61_1.text_.text = var_64_67

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_68 = 25
				local var_64_69 = utf8.len(var_64_67)
				local var_64_70 = var_64_68 <= 0 and var_64_64 or var_64_64 * (var_64_69 / var_64_68)

				if var_64_70 > 0 and var_64_64 < var_64_70 then
					arg_61_1.talkMaxDuration = var_64_70
					var_64_63 = var_64_63 + 0.3

					if var_64_70 + var_64_63 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_70 + var_64_63
					end
				end

				arg_61_1.text_.text = var_64_67
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_71 = var_64_63 + 0.3
			local var_64_72 = math.max(var_64_64, arg_61_1.talkMaxDuration)

			if var_64_71 <= arg_61_1.time_ and arg_61_1.time_ < var_64_71 + var_64_72 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_71) / var_64_72

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_71 + var_64_72 and arg_61_1.time_ < var_64_71 + var_64_72 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play420131016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 420131016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play420131017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 1.075

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(420131016)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 43
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_7 and arg_68_1.time_ < var_71_0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play420131017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 420131017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play420131018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.725

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(420131017)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 29
				local var_75_5 = utf8.len(var_75_3)
				local var_75_6 = var_75_4 <= 0 and var_75_1 or var_75_1 * (var_75_5 / var_75_4)

				if var_75_6 > 0 and var_75_1 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_7 and arg_72_1.time_ < var_75_0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play420131018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 420131018
		arg_76_1.duration_ = 2.5

		local var_76_0 = {
			zh = 2.5,
			ja = 1.6
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
				arg_76_0:Play420131019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			local var_79_1 = 0.3

			if arg_76_1.time_ >= var_79_0 + var_79_1 and arg_76_1.time_ < var_79_0 + var_79_1 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_2 = 0
			local var_79_3 = 0.1

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_4 = arg_76_1:FormatText(StoryNameCfg[328].name)

				arg_76_1.leftNameTxt_.text = var_79_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1085")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_5 = arg_76_1:GetWordFromCfg(420131018)
				local var_79_6 = arg_76_1:FormatText(var_79_5.content)

				arg_76_1.text_.text = var_79_6

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 4
				local var_79_8 = utf8.len(var_79_6)
				local var_79_9 = var_79_7 <= 0 and var_79_3 or var_79_3 * (var_79_8 / var_79_7)

				if var_79_9 > 0 and var_79_3 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_6
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131018", "story_v_out_420131.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_420131", "420131018", "story_v_out_420131.awb") / 1000

					if var_79_10 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_2
					end

					if var_79_5.prefab_name ~= "" and arg_76_1.actors_[var_79_5.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_5.prefab_name].transform, "story_v_out_420131", "420131018", "story_v_out_420131.awb")

						arg_76_1:RecordAudio("420131018", var_79_11)
						arg_76_1:RecordAudio("420131018", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_420131", "420131018", "story_v_out_420131.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_420131", "420131018", "story_v_out_420131.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_12 and arg_76_1.time_ < var_79_2 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play420131019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 420131019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play420131020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1085ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1085ui_story == nil then
				arg_80_1.var_.characterEffect1085ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1085ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1085ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1085ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1085ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0.05
			local var_83_7 = 1

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				local var_83_8 = "play"
				local var_83_9 = "effect"

				arg_80_1:AudioAction(var_83_8, var_83_9, "se_story_1311", "se_story_1311_thunder02", "")
			end

			local var_83_10 = 0.866666666666667
			local var_83_11 = 1

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				local var_83_12 = "stop"
				local var_83_13 = "effect"

				arg_80_1:AudioAction(var_83_12, var_83_13, "se_story_140", "se_story_140_amb_rain", "")
			end

			local var_83_14 = 0
			local var_83_15 = 0.425

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_16 = arg_80_1:GetWordFromCfg(420131019)
				local var_83_17 = arg_80_1:FormatText(var_83_16.content)

				arg_80_1.text_.text = var_83_17

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_18 = 17
				local var_83_19 = utf8.len(var_83_17)
				local var_83_20 = var_83_18 <= 0 and var_83_15 or var_83_15 * (var_83_19 / var_83_18)

				if var_83_20 > 0 and var_83_15 < var_83_20 then
					arg_80_1.talkMaxDuration = var_83_20

					if var_83_20 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_14
					end
				end

				arg_80_1.text_.text = var_83_17
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_21 = math.max(var_83_15, arg_80_1.talkMaxDuration)

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_21 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_14) / var_83_21

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_14 + var_83_21 and arg_80_1.time_ < var_83_14 + var_83_21 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play420131020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 420131020
		arg_84_1.duration_ = 11.77

		local var_84_0 = {
			zh = 10.365999999999,
			ja = 11.765999999999
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
				arg_84_0:Play420131021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = "ST76"

			if arg_84_1.bgs_[var_87_0] == nil then
				local var_87_1 = Object.Instantiate(arg_84_1.paintGo_)

				var_87_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_87_0)
				var_87_1.name = var_87_0
				var_87_1.transform.parent = arg_84_1.stage_.transform
				var_87_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.bgs_[var_87_0] = var_87_1
			end

			local var_87_2 = 1.999999999999

			if var_87_2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				local var_87_3 = manager.ui.mainCamera.transform.localPosition
				local var_87_4 = Vector3.New(0, 0, 10) + Vector3.New(var_87_3.x, var_87_3.y, 0)
				local var_87_5 = arg_84_1.bgs_.ST76

				var_87_5.transform.localPosition = var_87_4
				var_87_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_6 = var_87_5:GetComponent("SpriteRenderer")

				if var_87_6 and var_87_6.sprite then
					local var_87_7 = (var_87_5.transform.localPosition - var_87_3).z
					local var_87_8 = manager.ui.mainCameraCom_
					local var_87_9 = 2 * var_87_7 * Mathf.Tan(var_87_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_87_10 = var_87_9 * var_87_8.aspect
					local var_87_11 = var_87_6.sprite.bounds.size.x
					local var_87_12 = var_87_6.sprite.bounds.size.y
					local var_87_13 = var_87_10 / var_87_11
					local var_87_14 = var_87_9 / var_87_12
					local var_87_15 = var_87_14 < var_87_13 and var_87_13 or var_87_14

					var_87_5.transform.localScale = Vector3.New(var_87_15, var_87_15, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "ST76" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_16 = 3.999999999999

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			local var_87_17 = 0.3

			if arg_84_1.time_ >= var_87_16 + var_87_17 and arg_84_1.time_ < var_87_16 + var_87_17 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			local var_87_18 = 0

			if var_87_18 < arg_84_1.time_ and arg_84_1.time_ <= var_87_18 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_19 = 2

			if var_87_18 <= arg_84_1.time_ and arg_84_1.time_ < var_87_18 + var_87_19 then
				local var_87_20 = (arg_84_1.time_ - var_87_18) / var_87_19
				local var_87_21 = Color.New(0, 0, 0)

				var_87_21.a = Mathf.Lerp(0, 1, var_87_20)
				arg_84_1.mask_.color = var_87_21
			end

			if arg_84_1.time_ >= var_87_18 + var_87_19 and arg_84_1.time_ < var_87_18 + var_87_19 + arg_87_0 then
				local var_87_22 = Color.New(0, 0, 0)

				var_87_22.a = 1
				arg_84_1.mask_.color = var_87_22
			end

			local var_87_23 = 1.999999999999

			if var_87_23 < arg_84_1.time_ and arg_84_1.time_ <= var_87_23 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_24 = 2

			if var_87_23 <= arg_84_1.time_ and arg_84_1.time_ < var_87_23 + var_87_24 then
				local var_87_25 = (arg_84_1.time_ - var_87_23) / var_87_24
				local var_87_26 = Color.New(0, 0, 0)

				var_87_26.a = Mathf.Lerp(1, 0, var_87_25)
				arg_84_1.mask_.color = var_87_26
			end

			if arg_84_1.time_ >= var_87_23 + var_87_24 and arg_84_1.time_ < var_87_23 + var_87_24 + arg_87_0 then
				local var_87_27 = Color.New(0, 0, 0)
				local var_87_28 = 0

				arg_84_1.mask_.enabled = false
				var_87_27.a = var_87_28
				arg_84_1.mask_.color = var_87_27
			end

			local var_87_29 = arg_84_1.actors_["1085ui_story"].transform
			local var_87_30 = 3.73333333333333

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1.var_.moveOldPos1085ui_story = var_87_29.localPosition
			end

			local var_87_31 = 0.001

			if var_87_30 <= arg_84_1.time_ and arg_84_1.time_ < var_87_30 + var_87_31 then
				local var_87_32 = (arg_84_1.time_ - var_87_30) / var_87_31
				local var_87_33 = Vector3.New(0, -1.01, -5.83)

				var_87_29.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1085ui_story, var_87_33, var_87_32)

				local var_87_34 = manager.ui.mainCamera.transform.position - var_87_29.position

				var_87_29.forward = Vector3.New(var_87_34.x, var_87_34.y, var_87_34.z)

				local var_87_35 = var_87_29.localEulerAngles

				var_87_35.z = 0
				var_87_35.x = 0
				var_87_29.localEulerAngles = var_87_35
			end

			if arg_84_1.time_ >= var_87_30 + var_87_31 and arg_84_1.time_ < var_87_30 + var_87_31 + arg_87_0 then
				var_87_29.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_87_36 = manager.ui.mainCamera.transform.position - var_87_29.position

				var_87_29.forward = Vector3.New(var_87_36.x, var_87_36.y, var_87_36.z)

				local var_87_37 = var_87_29.localEulerAngles

				var_87_37.z = 0
				var_87_37.x = 0
				var_87_29.localEulerAngles = var_87_37
			end

			local var_87_38 = arg_84_1.actors_["1085ui_story"]
			local var_87_39 = 3.73333333333333

			if var_87_39 < arg_84_1.time_ and arg_84_1.time_ <= var_87_39 + arg_87_0 and not isNil(var_87_38) and arg_84_1.var_.characterEffect1085ui_story == nil then
				arg_84_1.var_.characterEffect1085ui_story = var_87_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_40 = 0.200000002980232

			if var_87_39 <= arg_84_1.time_ and arg_84_1.time_ < var_87_39 + var_87_40 and not isNil(var_87_38) then
				local var_87_41 = (arg_84_1.time_ - var_87_39) / var_87_40

				if arg_84_1.var_.characterEffect1085ui_story and not isNil(var_87_38) then
					arg_84_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_39 + var_87_40 and arg_84_1.time_ < var_87_39 + var_87_40 + arg_87_0 and not isNil(var_87_38) and arg_84_1.var_.characterEffect1085ui_story then
				arg_84_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_87_42 = 3.73333333333333

			if var_87_42 < arg_84_1.time_ and arg_84_1.time_ <= var_87_42 + arg_87_0 then
				arg_84_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_87_43 = 3.73333333333333

			if var_87_43 < arg_84_1.time_ and arg_84_1.time_ <= var_87_43 + arg_87_0 then
				arg_84_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_87_44 = 1.999999999999
			local var_87_45 = 1

			if var_87_44 < arg_84_1.time_ and arg_84_1.time_ <= var_87_44 + arg_87_0 then
				local var_87_46 = "play"
				local var_87_47 = "effect"

				arg_84_1:AudioAction(var_87_46, var_87_47, "se_story_140", "se_story_140_amb_dream01", "")
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_48 = 3.999999999999
			local var_87_49 = 0.425

			if var_87_48 < arg_84_1.time_ and arg_84_1.time_ <= var_87_48 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_50 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_50:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_51 = arg_84_1:FormatText(StoryNameCfg[328].name)

				arg_84_1.leftNameTxt_.text = var_87_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_52 = arg_84_1:GetWordFromCfg(420131020)
				local var_87_53 = arg_84_1:FormatText(var_87_52.content)

				arg_84_1.text_.text = var_87_53

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_54 = 17
				local var_87_55 = utf8.len(var_87_53)
				local var_87_56 = var_87_54 <= 0 and var_87_49 or var_87_49 * (var_87_55 / var_87_54)

				if var_87_56 > 0 and var_87_49 < var_87_56 then
					arg_84_1.talkMaxDuration = var_87_56
					var_87_48 = var_87_48 + 0.3

					if var_87_56 + var_87_48 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_56 + var_87_48
					end
				end

				arg_84_1.text_.text = var_87_53
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131020", "story_v_out_420131.awb") ~= 0 then
					local var_87_57 = manager.audio:GetVoiceLength("story_v_out_420131", "420131020", "story_v_out_420131.awb") / 1000

					if var_87_57 + var_87_48 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_57 + var_87_48
					end

					if var_87_52.prefab_name ~= "" and arg_84_1.actors_[var_87_52.prefab_name] ~= nil then
						local var_87_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_52.prefab_name].transform, "story_v_out_420131", "420131020", "story_v_out_420131.awb")

						arg_84_1:RecordAudio("420131020", var_87_58)
						arg_84_1:RecordAudio("420131020", var_87_58)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_420131", "420131020", "story_v_out_420131.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_420131", "420131020", "story_v_out_420131.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_59 = var_87_48 + 0.3
			local var_87_60 = math.max(var_87_49, arg_84_1.talkMaxDuration)

			if var_87_59 <= arg_84_1.time_ and arg_84_1.time_ < var_87_59 + var_87_60 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_59) / var_87_60

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_59 + var_87_60 and arg_84_1.time_ < var_87_59 + var_87_60 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play420131021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 420131021
		arg_90_1.duration_ = 7.5

		local var_90_0 = {
			zh = 4.833,
			ja = 7.5
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play420131022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.5

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[328].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(420131021)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 20
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131021", "story_v_out_420131.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_420131", "420131021", "story_v_out_420131.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_420131", "420131021", "story_v_out_420131.awb")

						arg_90_1:RecordAudio("420131021", var_93_9)
						arg_90_1:RecordAudio("420131021", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_420131", "420131021", "story_v_out_420131.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_420131", "420131021", "story_v_out_420131.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play420131022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 420131022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play420131023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1085ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos1085ui_story = var_97_0.localPosition
			end

			local var_97_2 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2
				local var_97_4 = Vector3.New(0, 100, 0)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1085ui_story, var_97_4, var_97_3)

				local var_97_5 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_5.x, var_97_5.y, var_97_5.z)

				local var_97_6 = var_97_0.localEulerAngles

				var_97_6.z = 0
				var_97_6.x = 0
				var_97_0.localEulerAngles = var_97_6
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(0, 100, 0)

				local var_97_7 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_7.x, var_97_7.y, var_97_7.z)

				local var_97_8 = var_97_0.localEulerAngles

				var_97_8.z = 0
				var_97_8.x = 0
				var_97_0.localEulerAngles = var_97_8
			end

			local var_97_9 = 0
			local var_97_10 = 1.025

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_11 = arg_94_1:GetWordFromCfg(420131022)
				local var_97_12 = arg_94_1:FormatText(var_97_11.content)

				arg_94_1.text_.text = var_97_12

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 41
				local var_97_14 = utf8.len(var_97_12)
				local var_97_15 = var_97_13 <= 0 and var_97_10 or var_97_10 * (var_97_14 / var_97_13)

				if var_97_15 > 0 and var_97_10 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_9 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_9
					end
				end

				arg_94_1.text_.text = var_97_12
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_10, arg_94_1.talkMaxDuration)

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_9) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_9 + var_97_16 and arg_94_1.time_ < var_97_9 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play420131023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 420131023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play420131024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.825

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(420131023)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 33
				local var_101_5 = utf8.len(var_101_3)
				local var_101_6 = var_101_4 <= 0 and var_101_1 or var_101_1 * (var_101_5 / var_101_4)

				if var_101_6 > 0 and var_101_1 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_7 and arg_98_1.time_ < var_101_0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play420131024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420131024
		arg_102_1.duration_ = 4.63

		local var_102_0 = {
			zh = 3.166,
			ja = 4.633
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
				arg_102_0:Play420131025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1085ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1085ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, -1.01, -5.83)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1085ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["1085ui_story"]
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1085ui_story == nil then
				arg_102_1.var_.characterEffect1085ui_story = var_105_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_11 = 0.200000002980232

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 and not isNil(var_105_9) then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11

				if arg_102_1.var_.characterEffect1085ui_story and not isNil(var_105_9) then
					arg_102_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect1085ui_story then
				arg_102_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_105_13 = 0

			if var_105_13 < arg_102_1.time_ and arg_102_1.time_ <= var_105_13 + arg_105_0 then
				arg_102_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action8_1")
			end

			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_105_15 = 0
			local var_105_16 = 0.225

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_17 = arg_102_1:FormatText(StoryNameCfg[328].name)

				arg_102_1.leftNameTxt_.text = var_105_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_18 = arg_102_1:GetWordFromCfg(420131024)
				local var_105_19 = arg_102_1:FormatText(var_105_18.content)

				arg_102_1.text_.text = var_105_19

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_20 = 9
				local var_105_21 = utf8.len(var_105_19)
				local var_105_22 = var_105_20 <= 0 and var_105_16 or var_105_16 * (var_105_21 / var_105_20)

				if var_105_22 > 0 and var_105_16 < var_105_22 then
					arg_102_1.talkMaxDuration = var_105_22

					if var_105_22 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_22 + var_105_15
					end
				end

				arg_102_1.text_.text = var_105_19
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131024", "story_v_out_420131.awb") ~= 0 then
					local var_105_23 = manager.audio:GetVoiceLength("story_v_out_420131", "420131024", "story_v_out_420131.awb") / 1000

					if var_105_23 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_15
					end

					if var_105_18.prefab_name ~= "" and arg_102_1.actors_[var_105_18.prefab_name] ~= nil then
						local var_105_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_18.prefab_name].transform, "story_v_out_420131", "420131024", "story_v_out_420131.awb")

						arg_102_1:RecordAudio("420131024", var_105_24)
						arg_102_1:RecordAudio("420131024", var_105_24)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_420131", "420131024", "story_v_out_420131.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_420131", "420131024", "story_v_out_420131.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_25 = math.max(var_105_16, arg_102_1.talkMaxDuration)

			if var_105_15 <= arg_102_1.time_ and arg_102_1.time_ < var_105_15 + var_105_25 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_15) / var_105_25

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_15 + var_105_25 and arg_102_1.time_ < var_105_15 + var_105_25 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play420131025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420131025
		arg_106_1.duration_ = 3.43

		local var_106_0 = {
			zh = 3.266,
			ja = 3.433
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
				arg_106_0:Play420131026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action8_2")
			end

			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_109_2 = 0

			if var_109_2 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.allBtn_.enabled = false
			end

			local var_109_3 = 1

			if arg_106_1.time_ >= var_109_2 + var_109_3 and arg_106_1.time_ < var_109_2 + var_109_3 + arg_109_0 then
				arg_106_1.allBtn_.enabled = true
			end

			local var_109_4 = 0
			local var_109_5 = 0.175

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_6 = arg_106_1:FormatText(StoryNameCfg[328].name)

				arg_106_1.leftNameTxt_.text = var_109_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_7 = arg_106_1:GetWordFromCfg(420131025)
				local var_109_8 = arg_106_1:FormatText(var_109_7.content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 7
				local var_109_10 = utf8.len(var_109_8)
				local var_109_11 = var_109_9 <= 0 and var_109_5 or var_109_5 * (var_109_10 / var_109_9)

				if var_109_11 > 0 and var_109_5 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_8
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131025", "story_v_out_420131.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_420131", "420131025", "story_v_out_420131.awb") / 1000

					if var_109_12 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_4
					end

					if var_109_7.prefab_name ~= "" and arg_106_1.actors_[var_109_7.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_7.prefab_name].transform, "story_v_out_420131", "420131025", "story_v_out_420131.awb")

						arg_106_1:RecordAudio("420131025", var_109_13)
						arg_106_1:RecordAudio("420131025", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_420131", "420131025", "story_v_out_420131.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_420131", "420131025", "story_v_out_420131.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_14 and arg_106_1.time_ < var_109_4 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play420131026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 420131026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play420131027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1085ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1085ui_story == nil then
				arg_110_1.var_.characterEffect1085ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1085ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1085ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1085ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1085ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0.05
			local var_113_7 = 1

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				local var_113_8 = "play"
				local var_113_9 = "effect"

				arg_110_1:AudioAction(var_113_8, var_113_9, "se_story_140", "se_story_140_amb_dream02", "")
			end

			local var_113_10 = 0.393
			local var_113_11 = 1

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				local var_113_12 = "play"
				local var_113_13 = "effect"

				arg_110_1:AudioAction(var_113_12, var_113_13, "se_story_140", "se_story_140_bird", "")
			end

			local var_113_14 = 0
			local var_113_15 = 0.675

			if var_113_14 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_16 = arg_110_1:GetWordFromCfg(420131026)
				local var_113_17 = arg_110_1:FormatText(var_113_16.content)

				arg_110_1.text_.text = var_113_17

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_18 = 27
				local var_113_19 = utf8.len(var_113_17)
				local var_113_20 = var_113_18 <= 0 and var_113_15 or var_113_15 * (var_113_19 / var_113_18)

				if var_113_20 > 0 and var_113_15 < var_113_20 then
					arg_110_1.talkMaxDuration = var_113_20

					if var_113_20 + var_113_14 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_14
					end
				end

				arg_110_1.text_.text = var_113_17
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_21 = math.max(var_113_15, arg_110_1.talkMaxDuration)

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_21 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_14) / var_113_21

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_14 + var_113_21 and arg_110_1.time_ < var_113_14 + var_113_21 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play420131027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 420131027
		arg_114_1.duration_ = 7.3

		local var_114_0 = {
			zh = 5.633,
			ja = 7.3
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play420131028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1085ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1085ui_story == nil then
				arg_114_1.var_.characterEffect1085ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1085ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1085ui_story then
				arg_114_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_117_4 = 0
			local var_117_5 = 0.55

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_6 = arg_114_1:FormatText(StoryNameCfg[328].name)

				arg_114_1.leftNameTxt_.text = var_117_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_7 = arg_114_1:GetWordFromCfg(420131027)
				local var_117_8 = arg_114_1:FormatText(var_117_7.content)

				arg_114_1.text_.text = var_117_8

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 22
				local var_117_10 = utf8.len(var_117_8)
				local var_117_11 = var_117_9 <= 0 and var_117_5 or var_117_5 * (var_117_10 / var_117_9)

				if var_117_11 > 0 and var_117_5 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_8
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131027", "story_v_out_420131.awb") ~= 0 then
					local var_117_12 = manager.audio:GetVoiceLength("story_v_out_420131", "420131027", "story_v_out_420131.awb") / 1000

					if var_117_12 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_4
					end

					if var_117_7.prefab_name ~= "" and arg_114_1.actors_[var_117_7.prefab_name] ~= nil then
						local var_117_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_7.prefab_name].transform, "story_v_out_420131", "420131027", "story_v_out_420131.awb")

						arg_114_1:RecordAudio("420131027", var_117_13)
						arg_114_1:RecordAudio("420131027", var_117_13)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_420131", "420131027", "story_v_out_420131.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_420131", "420131027", "story_v_out_420131.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_14 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_14 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_14

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_14 and arg_114_1.time_ < var_117_4 + var_117_14 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play420131028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 420131028
		arg_118_1.duration_ = 5.29

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play420131029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1085ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1085ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, 100, 0)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1085ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, 100, 0)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = 0.333333333333333
			local var_121_10 = 1

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				local var_121_11 = "play"
				local var_121_12 = "effect"

				arg_118_1:AudioAction(var_121_11, var_121_12, "se_story_140", "se_story_140_dream_crash01", "")
			end

			local var_121_13 = 0.333333333333333
			local var_121_14 = 1

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				local var_121_15 = "stop"
				local var_121_16 = "effect"

				arg_118_1:AudioAction(var_121_15, var_121_16, "se_story_140", "se_story_140_amb_dream01", "")
			end

			local var_121_17 = 0.333333333333333
			local var_121_18 = 1

			if var_121_17 < arg_118_1.time_ and arg_118_1.time_ <= var_121_17 + arg_121_0 then
				local var_121_19 = "stop"
				local var_121_20 = "effect"

				arg_118_1:AudioAction(var_121_19, var_121_20, "se_story_140", "se_story_140_amb_dream02", "")
			end

			local var_121_21 = 4.2913333333
			local var_121_22 = 1

			if var_121_21 < arg_118_1.time_ and arg_118_1.time_ <= var_121_21 + arg_121_0 then
				local var_121_23 = "play"
				local var_121_24 = "effect"

				arg_118_1:AudioAction(var_121_23, var_121_24, "se_story_140", "se_story_140_amb_drone01", "")
			end

			local var_121_25 = manager.ui.mainCamera.transform
			local var_121_26 = 0.333333343267441

			if var_121_26 < arg_118_1.time_ and arg_118_1.time_ <= var_121_26 + arg_121_0 then
				arg_118_1.var_.shakeOldPos = var_121_25.localPosition
			end

			local var_121_27 = 0.333333323399226

			if var_121_26 <= arg_118_1.time_ and arg_118_1.time_ < var_121_26 + var_121_27 then
				local var_121_28 = (arg_118_1.time_ - var_121_26) / 0.066
				local var_121_29, var_121_30 = math.modf(var_121_28)

				var_121_25.localPosition = Vector3.New(var_121_30 * 0.13, var_121_30 * 0.13, var_121_30 * 0.13) + arg_118_1.var_.shakeOldPos
			end

			if arg_118_1.time_ >= var_121_26 + var_121_27 and arg_118_1.time_ < var_121_26 + var_121_27 + arg_121_0 then
				var_121_25.localPosition = arg_118_1.var_.shakeOldPos
			end

			local var_121_31 = 0
			local var_121_32 = 1.025

			if var_121_31 < arg_118_1.time_ and arg_118_1.time_ <= var_121_31 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_33 = arg_118_1:GetWordFromCfg(420131028)
				local var_121_34 = arg_118_1:FormatText(var_121_33.content)

				arg_118_1.text_.text = var_121_34

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_35 = 41
				local var_121_36 = utf8.len(var_121_34)
				local var_121_37 = var_121_35 <= 0 and var_121_32 or var_121_32 * (var_121_36 / var_121_35)

				if var_121_37 > 0 and var_121_32 < var_121_37 then
					arg_118_1.talkMaxDuration = var_121_37

					if var_121_37 + var_121_31 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_37 + var_121_31
					end
				end

				arg_118_1.text_.text = var_121_34
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_38 = math.max(var_121_32, arg_118_1.talkMaxDuration)

			if var_121_31 <= arg_118_1.time_ and arg_118_1.time_ < var_121_31 + var_121_38 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_31) / var_121_38

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_31 + var_121_38 and arg_118_1.time_ < var_121_31 + var_121_38 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play420131029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 420131029
		arg_122_1.duration_ = 4.1

		local var_122_0 = {
			zh = 3.266,
			ja = 4.1
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
				arg_122_0:Play420131030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1085ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1085ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(0, -1.01, -5.83)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1085ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_125_10 = arg_122_1.actors_["1085ui_story"]
			local var_125_11 = 0

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 and not isNil(var_125_10) and arg_122_1.var_.characterEffect1085ui_story == nil then
				arg_122_1.var_.characterEffect1085ui_story = var_125_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_12 = 0.200000002980232

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_12 and not isNil(var_125_10) then
				local var_125_13 = (arg_122_1.time_ - var_125_11) / var_125_12

				if arg_122_1.var_.characterEffect1085ui_story and not isNil(var_125_10) then
					arg_122_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_11 + var_125_12 and arg_122_1.time_ < var_125_11 + var_125_12 + arg_125_0 and not isNil(var_125_10) and arg_122_1.var_.characterEffect1085ui_story then
				arg_122_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_125_14 = 0
			local var_125_15 = 0.25

			if var_125_14 < arg_122_1.time_ and arg_122_1.time_ <= var_125_14 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_16 = arg_122_1:FormatText(StoryNameCfg[328].name)

				arg_122_1.leftNameTxt_.text = var_125_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_17 = arg_122_1:GetWordFromCfg(420131029)
				local var_125_18 = arg_122_1:FormatText(var_125_17.content)

				arg_122_1.text_.text = var_125_18

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_19 = 10
				local var_125_20 = utf8.len(var_125_18)
				local var_125_21 = var_125_19 <= 0 and var_125_15 or var_125_15 * (var_125_20 / var_125_19)

				if var_125_21 > 0 and var_125_15 < var_125_21 then
					arg_122_1.talkMaxDuration = var_125_21

					if var_125_21 + var_125_14 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_21 + var_125_14
					end
				end

				arg_122_1.text_.text = var_125_18
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131029", "story_v_out_420131.awb") ~= 0 then
					local var_125_22 = manager.audio:GetVoiceLength("story_v_out_420131", "420131029", "story_v_out_420131.awb") / 1000

					if var_125_22 + var_125_14 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_14
					end

					if var_125_17.prefab_name ~= "" and arg_122_1.actors_[var_125_17.prefab_name] ~= nil then
						local var_125_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_17.prefab_name].transform, "story_v_out_420131", "420131029", "story_v_out_420131.awb")

						arg_122_1:RecordAudio("420131029", var_125_23)
						arg_122_1:RecordAudio("420131029", var_125_23)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_420131", "420131029", "story_v_out_420131.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_420131", "420131029", "story_v_out_420131.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_24 = math.max(var_125_15, arg_122_1.talkMaxDuration)

			if var_125_14 <= arg_122_1.time_ and arg_122_1.time_ < var_125_14 + var_125_24 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_14) / var_125_24

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_14 + var_125_24 and arg_122_1.time_ < var_125_14 + var_125_24 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 420131030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play420131031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1085ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1085ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0, 100, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1085ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, 100, 0)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = 0.034000001847744
			local var_129_10 = 1

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 then
				local var_129_11 = "play"
				local var_129_12 = "effect"

				arg_126_1:AudioAction(var_129_11, var_129_12, "se_story_140", "se_story_140_foley_fall", "")
			end

			local var_129_13 = 0
			local var_129_14 = 1.15

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_15 = arg_126_1:GetWordFromCfg(420131030)
				local var_129_16 = arg_126_1:FormatText(var_129_15.content)

				arg_126_1.text_.text = var_129_16

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_17 = 46
				local var_129_18 = utf8.len(var_129_16)
				local var_129_19 = var_129_17 <= 0 and var_129_14 or var_129_14 * (var_129_18 / var_129_17)

				if var_129_19 > 0 and var_129_14 < var_129_19 then
					arg_126_1.talkMaxDuration = var_129_19

					if var_129_19 + var_129_13 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_13
					end
				end

				arg_126_1.text_.text = var_129_16
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_20 = math.max(var_129_14, arg_126_1.talkMaxDuration)

			if var_129_13 <= arg_126_1.time_ and arg_126_1.time_ < var_129_13 + var_129_20 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_13) / var_129_20

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_13 + var_129_20 and arg_126_1.time_ < var_129_13 + var_129_20 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play420131031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 420131031
		arg_130_1.duration_ = 7

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play420131032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_1 = 1

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_1 then
				local var_133_2 = (arg_130_1.time_ - var_133_0) / var_133_1
				local var_133_3 = Color.New(0, 0, 0)

				var_133_3.a = Mathf.Lerp(0, 1, var_133_2)
				arg_130_1.mask_.color = var_133_3
			end

			if arg_130_1.time_ >= var_133_0 + var_133_1 and arg_130_1.time_ < var_133_0 + var_133_1 + arg_133_0 then
				local var_133_4 = Color.New(0, 0, 0)

				var_133_4.a = 1
				arg_130_1.mask_.color = var_133_4
			end

			local var_133_5 = 1

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_6 = 1

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6
				local var_133_8 = Color.New(0, 0, 0)

				var_133_8.a = Mathf.Lerp(1, 0, var_133_7)
				arg_130_1.mask_.color = var_133_8
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 then
				local var_133_9 = Color.New(0, 0, 0)
				local var_133_10 = 0

				arg_130_1.mask_.enabled = false
				var_133_9.a = var_133_10
				arg_130_1.mask_.color = var_133_9
			end

			local var_133_11 = 1

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				local var_133_12 = manager.ui.mainCamera.transform.localPosition
				local var_133_13 = Vector3.New(0, 0, 10) + Vector3.New(var_133_12.x, var_133_12.y, 0)
				local var_133_14 = arg_130_1.bgs_.ST76

				var_133_14.transform.localPosition = var_133_13
				var_133_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_15 = var_133_14:GetComponent("SpriteRenderer")

				if var_133_15 and var_133_15.sprite then
					local var_133_16 = (var_133_14.transform.localPosition - var_133_12).z
					local var_133_17 = manager.ui.mainCameraCom_
					local var_133_18 = 2 * var_133_16 * Mathf.Tan(var_133_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_133_19 = var_133_18 * var_133_17.aspect
					local var_133_20 = var_133_15.sprite.bounds.size.x
					local var_133_21 = var_133_15.sprite.bounds.size.y
					local var_133_22 = var_133_19 / var_133_20
					local var_133_23 = var_133_18 / var_133_21
					local var_133_24 = var_133_23 < var_133_22 and var_133_22 or var_133_23

					var_133_14.transform.localScale = Vector3.New(var_133_24, var_133_24, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "ST76" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_25 = manager.ui.mainCamera.transform
			local var_133_26 = 1

			if var_133_26 < arg_130_1.time_ and arg_130_1.time_ <= var_133_26 + arg_133_0 then
				local var_133_27 = arg_130_1.var_.effect1031
				local var_133_28
				local var_133_29 = var_133_25

				if not var_133_27 then
					var_133_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_133_29)
					var_133_27.name = "1031"
					arg_130_1.var_.effect1031 = var_133_27
				else
					var_133_27.transform:SetParent(var_133_29)
				end

				var_133_27.transform.localPosition = Vector3.New(0, 0, -2.14)
				var_133_27.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_30 = 2
			local var_133_31 = 1

			if var_133_30 < arg_130_1.time_ and arg_130_1.time_ <= var_133_30 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_32 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_32:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_33 = arg_130_1:GetWordFromCfg(420131031)
				local var_133_34 = arg_130_1:FormatText(var_133_33.content)

				arg_130_1.text_.text = var_133_34

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_35 = 40
				local var_133_36 = utf8.len(var_133_34)
				local var_133_37 = var_133_35 <= 0 and var_133_31 or var_133_31 * (var_133_36 / var_133_35)

				if var_133_37 > 0 and var_133_31 < var_133_37 then
					arg_130_1.talkMaxDuration = var_133_37
					var_133_30 = var_133_30 + 0.3

					if var_133_37 + var_133_30 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_37 + var_133_30
					end
				end

				arg_130_1.text_.text = var_133_34
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_38 = var_133_30 + 0.3
			local var_133_39 = math.max(var_133_31, arg_130_1.talkMaxDuration)

			if var_133_38 <= arg_130_1.time_ and arg_130_1.time_ < var_133_38 + var_133_39 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_38) / var_133_39

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_38 + var_133_39 and arg_130_1.time_ < var_133_38 + var_133_39 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play420131032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 420131032
		arg_136_1.duration_ = 3.2

		local var_136_0 = {
			zh = 3.033,
			ja = 3.2
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
				arg_136_0:Play420131033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1085ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1085ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, -1.01, -5.83)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1085ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["1085ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1085ui_story == nil then
				arg_136_1.var_.characterEffect1085ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect1085ui_story and not isNil(var_139_9) then
					arg_136_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1085ui_story then
				arg_136_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_139_13 = 0
			local var_139_14 = 0.325

			if var_139_13 < arg_136_1.time_ and arg_136_1.time_ <= var_139_13 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_15 = arg_136_1:FormatText(StoryNameCfg[328].name)

				arg_136_1.leftNameTxt_.text = var_139_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_16 = arg_136_1:GetWordFromCfg(420131032)
				local var_139_17 = arg_136_1:FormatText(var_139_16.content)

				arg_136_1.text_.text = var_139_17

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_18 = 13
				local var_139_19 = utf8.len(var_139_17)
				local var_139_20 = var_139_18 <= 0 and var_139_14 or var_139_14 * (var_139_19 / var_139_18)

				if var_139_20 > 0 and var_139_14 < var_139_20 then
					arg_136_1.talkMaxDuration = var_139_20

					if var_139_20 + var_139_13 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_20 + var_139_13
					end
				end

				arg_136_1.text_.text = var_139_17
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131032", "story_v_out_420131.awb") ~= 0 then
					local var_139_21 = manager.audio:GetVoiceLength("story_v_out_420131", "420131032", "story_v_out_420131.awb") / 1000

					if var_139_21 + var_139_13 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_21 + var_139_13
					end

					if var_139_16.prefab_name ~= "" and arg_136_1.actors_[var_139_16.prefab_name] ~= nil then
						local var_139_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_16.prefab_name].transform, "story_v_out_420131", "420131032", "story_v_out_420131.awb")

						arg_136_1:RecordAudio("420131032", var_139_22)
						arg_136_1:RecordAudio("420131032", var_139_22)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_420131", "420131032", "story_v_out_420131.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_420131", "420131032", "story_v_out_420131.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_23 = math.max(var_139_14, arg_136_1.talkMaxDuration)

			if var_139_13 <= arg_136_1.time_ and arg_136_1.time_ < var_139_13 + var_139_23 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_13) / var_139_23

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_13 + var_139_23 and arg_136_1.time_ < var_139_13 + var_139_23 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play420131033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 420131033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play420131034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1085ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1085ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1085ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0.725
			local var_143_10 = 1

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				local var_143_11 = "play"
				local var_143_12 = "effect"

				arg_140_1:AudioAction(var_143_11, var_143_12, "se_story_side_1084", "se_story_1084_run", "")
			end

			local var_143_13 = 0
			local var_143_14 = 0.725

			if var_143_13 < arg_140_1.time_ and arg_140_1.time_ <= var_143_13 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_15 = arg_140_1:GetWordFromCfg(420131033)
				local var_143_16 = arg_140_1:FormatText(var_143_15.content)

				arg_140_1.text_.text = var_143_16

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 29
				local var_143_18 = utf8.len(var_143_16)
				local var_143_19 = var_143_17 <= 0 and var_143_14 or var_143_14 * (var_143_18 / var_143_17)

				if var_143_19 > 0 and var_143_14 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19

					if var_143_19 + var_143_13 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_13
					end
				end

				arg_140_1.text_.text = var_143_16
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_20 = math.max(var_143_14, arg_140_1.talkMaxDuration)

			if var_143_13 <= arg_140_1.time_ and arg_140_1.time_ < var_143_13 + var_143_20 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_13) / var_143_20

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_13 + var_143_20 and arg_140_1.time_ < var_143_13 + var_143_20 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play420131034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 420131034
		arg_144_1.duration_ = 2.33

		local var_144_0 = {
			zh = 2.333,
			ja = 1.7
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
				arg_144_0:Play420131035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1085ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1085ui_story == nil then
				arg_144_1.var_.characterEffect1085ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1085ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1085ui_story then
				arg_144_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["1085ui_story"].transform
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.var_.moveOldPos1085ui_story = var_147_4.localPosition
			end

			local var_147_6 = 0.001

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6
				local var_147_8 = Vector3.New(0, -1.01, -5.83)

				var_147_4.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1085ui_story, var_147_8, var_147_7)

				local var_147_9 = manager.ui.mainCamera.transform.position - var_147_4.position

				var_147_4.forward = Vector3.New(var_147_9.x, var_147_9.y, var_147_9.z)

				local var_147_10 = var_147_4.localEulerAngles

				var_147_10.z = 0
				var_147_10.x = 0
				var_147_4.localEulerAngles = var_147_10
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 then
				var_147_4.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_147_11 = manager.ui.mainCamera.transform.position - var_147_4.position

				var_147_4.forward = Vector3.New(var_147_11.x, var_147_11.y, var_147_11.z)

				local var_147_12 = var_147_4.localEulerAngles

				var_147_12.z = 0
				var_147_12.x = 0
				var_147_4.localEulerAngles = var_147_12
			end

			local var_147_13 = 0
			local var_147_14 = 0.175

			if var_147_13 < arg_144_1.time_ and arg_144_1.time_ <= var_147_13 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_15 = arg_144_1:FormatText(StoryNameCfg[328].name)

				arg_144_1.leftNameTxt_.text = var_147_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_16 = arg_144_1:GetWordFromCfg(420131034)
				local var_147_17 = arg_144_1:FormatText(var_147_16.content)

				arg_144_1.text_.text = var_147_17

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_18 = 7
				local var_147_19 = utf8.len(var_147_17)
				local var_147_20 = var_147_18 <= 0 and var_147_14 or var_147_14 * (var_147_19 / var_147_18)

				if var_147_20 > 0 and var_147_14 < var_147_20 then
					arg_144_1.talkMaxDuration = var_147_20

					if var_147_20 + var_147_13 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_20 + var_147_13
					end
				end

				arg_144_1.text_.text = var_147_17
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131034", "story_v_out_420131.awb") ~= 0 then
					local var_147_21 = manager.audio:GetVoiceLength("story_v_out_420131", "420131034", "story_v_out_420131.awb") / 1000

					if var_147_21 + var_147_13 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_21 + var_147_13
					end

					if var_147_16.prefab_name ~= "" and arg_144_1.actors_[var_147_16.prefab_name] ~= nil then
						local var_147_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_16.prefab_name].transform, "story_v_out_420131", "420131034", "story_v_out_420131.awb")

						arg_144_1:RecordAudio("420131034", var_147_22)
						arg_144_1:RecordAudio("420131034", var_147_22)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_420131", "420131034", "story_v_out_420131.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_420131", "420131034", "story_v_out_420131.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_23 = math.max(var_147_14, arg_144_1.talkMaxDuration)

			if var_147_13 <= arg_144_1.time_ and arg_144_1.time_ < var_147_13 + var_147_23 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_13) / var_147_23

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_13 + var_147_23 and arg_144_1.time_ < var_147_13 + var_147_23 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play420131035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 420131035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play420131036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1085ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1085ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1085ui_story, var_151_4, var_151_3)

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

			local var_151_9 = 0.338
			local var_151_10 = 1

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				local var_151_11 = "play"
				local var_151_12 = "effect"

				arg_148_1:AudioAction(var_151_11, var_151_12, "se_story_140", "se_story_140_dream_crash02", "")
			end

			local var_151_13 = 0
			local var_151_14 = 1

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				local var_151_15 = "stop"
				local var_151_16 = "effect"

				arg_148_1:AudioAction(var_151_15, var_151_16, "se_story_140", "se_story_140_amb_drone01", "")
			end

			local var_151_17 = 1.925
			local var_151_18 = 1

			if var_151_17 < arg_148_1.time_ and arg_148_1.time_ <= var_151_17 + arg_151_0 then
				local var_151_19 = "play"
				local var_151_20 = "effect"

				arg_148_1:AudioAction(var_151_19, var_151_20, "se_story_140", "se_story_140_amb_drone02", "")
			end

			local var_151_21 = manager.ui.mainCamera.transform
			local var_151_22 = 1.925

			if var_151_22 < arg_148_1.time_ and arg_148_1.time_ <= var_151_22 + arg_151_0 then
				arg_148_1.var_.shakeOldPos = var_151_21.localPosition
			end

			local var_151_23 = 0.341666666666667

			if var_151_22 <= arg_148_1.time_ and arg_148_1.time_ < var_151_22 + var_151_23 then
				local var_151_24 = (arg_148_1.time_ - var_151_22) / 0.066
				local var_151_25, var_151_26 = math.modf(var_151_24)

				var_151_21.localPosition = Vector3.New(var_151_26 * 0.13, var_151_26 * 0.13, var_151_26 * 0.13) + arg_148_1.var_.shakeOldPos
			end

			if arg_148_1.time_ >= var_151_22 + var_151_23 and arg_148_1.time_ < var_151_22 + var_151_23 + arg_151_0 then
				var_151_21.localPosition = arg_148_1.var_.shakeOldPos
			end

			local var_151_27 = 0
			local var_151_28 = 0.625

			if var_151_27 < arg_148_1.time_ and arg_148_1.time_ <= var_151_27 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_29 = arg_148_1:GetWordFromCfg(420131035)
				local var_151_30 = arg_148_1:FormatText(var_151_29.content)

				arg_148_1.text_.text = var_151_30

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_31 = 25
				local var_151_32 = utf8.len(var_151_30)
				local var_151_33 = var_151_31 <= 0 and var_151_28 or var_151_28 * (var_151_32 / var_151_31)

				if var_151_33 > 0 and var_151_28 < var_151_33 then
					arg_148_1.talkMaxDuration = var_151_33

					if var_151_33 + var_151_27 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_33 + var_151_27
					end
				end

				arg_148_1.text_.text = var_151_30
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_34 = math.max(var_151_28, arg_148_1.talkMaxDuration)

			if var_151_27 <= arg_148_1.time_ and arg_148_1.time_ < var_151_27 + var_151_34 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_27) / var_151_34

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_27 + var_151_34 and arg_148_1.time_ < var_151_27 + var_151_34 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 420131036
		arg_152_1.duration_ = 9.66

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play420131037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = manager.ui.mainCamera.transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				local var_155_2 = arg_152_1.var_.effect1036
				local var_155_3
				local var_155_4 = var_155_0

				if not var_155_2 then
					var_155_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), var_155_4)
					var_155_2.name = "1036"
					arg_152_1.var_.effect1036 = var_155_2
				else
					var_155_2.transform:SetParent(var_155_4)
				end

				var_155_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_155_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_155_5 = 0.15
			local var_155_6 = 1

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				local var_155_7 = "play"
				local var_155_8 = "effect"

				arg_152_1:AudioAction(var_155_7, var_155_8, "se_story_140", "se_story_140_dream_crash03", "")
			end

			local var_155_9 = 0.15
			local var_155_10 = 1

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				local var_155_11 = "stop"
				local var_155_12 = "effect"

				arg_152_1:AudioAction(var_155_11, var_155_12, "se_story_140", "se_story_140_amb_drone02", "")
			end

			local var_155_13 = 6.456
			local var_155_14 = 1

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				local var_155_15 = "play"
				local var_155_16 = "effect"

				arg_152_1:AudioAction(var_155_15, var_155_16, "se_story_140", "se_story_140_amb_storm", "")
			end

			local var_155_17 = 8.661
			local var_155_18 = 1

			if var_155_17 < arg_152_1.time_ and arg_152_1.time_ <= var_155_17 + arg_155_0 then
				local var_155_19 = "play"
				local var_155_20 = "effect"

				arg_152_1:AudioAction(var_155_19, var_155_20, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_155_21 = 0
			local var_155_22 = 1.1

			if var_155_21 < arg_152_1.time_ and arg_152_1.time_ <= var_155_21 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_23 = arg_152_1:GetWordFromCfg(420131036)
				local var_155_24 = arg_152_1:FormatText(var_155_23.content)

				arg_152_1.text_.text = var_155_24

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_25 = 44
				local var_155_26 = utf8.len(var_155_24)
				local var_155_27 = var_155_25 <= 0 and var_155_22 or var_155_22 * (var_155_26 / var_155_25)

				if var_155_27 > 0 and var_155_22 < var_155_27 then
					arg_152_1.talkMaxDuration = var_155_27

					if var_155_27 + var_155_21 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_27 + var_155_21
					end
				end

				arg_152_1.text_.text = var_155_24
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_28 = math.max(var_155_22, arg_152_1.talkMaxDuration)

			if var_155_21 <= arg_152_1.time_ and arg_152_1.time_ < var_155_21 + var_155_28 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_21) / var_155_28

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_21 + var_155_28 and arg_152_1.time_ < var_155_21 + var_155_28 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play420131037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 420131037
		arg_156_1.duration_ = 6.4

		local var_156_0 = {
			zh = 3.8,
			ja = 6.4
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
				arg_156_0:Play420131038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1085ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1085ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0, -1.01, -5.83)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1085ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1085ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1085ui_story == nil then
				arg_156_1.var_.characterEffect1085ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1085ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1085ui_story then
				arg_156_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action8_1")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_159_15 = 0
			local var_159_16 = 0.325

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_17 = arg_156_1:FormatText(StoryNameCfg[328].name)

				arg_156_1.leftNameTxt_.text = var_159_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_18 = arg_156_1:GetWordFromCfg(420131037)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_20 = 13
				local var_159_21 = utf8.len(var_159_19)
				local var_159_22 = var_159_20 <= 0 and var_159_16 or var_159_16 * (var_159_21 / var_159_20)

				if var_159_22 > 0 and var_159_16 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131037", "story_v_out_420131.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_out_420131", "420131037", "story_v_out_420131.awb") / 1000

					if var_159_23 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_out_420131", "420131037", "story_v_out_420131.awb")

						arg_156_1:RecordAudio("420131037", var_159_24)
						arg_156_1:RecordAudio("420131037", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_420131", "420131037", "story_v_out_420131.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_420131", "420131037", "story_v_out_420131.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_25 and arg_156_1.time_ < var_159_15 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play420131038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 420131038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play420131039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1085ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1085ui_story = var_163_0.localPosition
			end

			local var_163_2 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2
				local var_163_4 = Vector3.New(0, 100, 0)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1085ui_story, var_163_4, var_163_3)

				local var_163_5 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_5.x, var_163_5.y, var_163_5.z)

				local var_163_6 = var_163_0.localEulerAngles

				var_163_6.z = 0
				var_163_6.x = 0
				var_163_0.localEulerAngles = var_163_6
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, 100, 0)

				local var_163_7 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_7.x, var_163_7.y, var_163_7.z)

				local var_163_8 = var_163_0.localEulerAngles

				var_163_8.z = 0
				var_163_8.x = 0
				var_163_0.localEulerAngles = var_163_8
			end

			local var_163_9 = 0
			local var_163_10 = 1.275

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_11 = arg_160_1:GetWordFromCfg(420131038)
				local var_163_12 = arg_160_1:FormatText(var_163_11.content)

				arg_160_1.text_.text = var_163_12

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 51
				local var_163_14 = utf8.len(var_163_12)
				local var_163_15 = var_163_13 <= 0 and var_163_10 or var_163_10 * (var_163_14 / var_163_13)

				if var_163_15 > 0 and var_163_10 < var_163_15 then
					arg_160_1.talkMaxDuration = var_163_15

					if var_163_15 + var_163_9 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_15 + var_163_9
					end
				end

				arg_160_1.text_.text = var_163_12
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_10, arg_160_1.talkMaxDuration)

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_9) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_9 + var_163_16 and arg_160_1.time_ < var_163_9 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play420131039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 420131039
		arg_164_1.duration_ = 5.83

		local var_164_0 = {
			zh = 3.6,
			ja = 5.833
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
				arg_164_0:Play420131040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1085ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1085ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, -1.01, -5.83)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1085ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["1085ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1085ui_story == nil then
				arg_164_1.var_.characterEffect1085ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect1085ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1085ui_story then
				arg_164_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action8_2")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_167_15 = 0
			local var_167_16 = 0.275

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[328].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(420131039)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 11
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131039", "story_v_out_420131.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_out_420131", "420131039", "story_v_out_420131.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_out_420131", "420131039", "story_v_out_420131.awb")

						arg_164_1:RecordAudio("420131039", var_167_24)
						arg_164_1:RecordAudio("420131039", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_420131", "420131039", "story_v_out_420131.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_420131", "420131039", "story_v_out_420131.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play420131040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 420131040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play420131041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1085ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1085ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(0, 100, 0)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1085ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, 100, 0)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = 0.333333333333333
			local var_171_10 = 1

			if var_171_9 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 then
				local var_171_11 = "play"
				local var_171_12 = "effect"

				arg_168_1:AudioAction(var_171_11, var_171_12, "se_story_140", "se_story_140_dream_water", "")
			end

			local var_171_13 = 0
			local var_171_14 = 0.825

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_15 = arg_168_1:GetWordFromCfg(420131040)
				local var_171_16 = arg_168_1:FormatText(var_171_15.content)

				arg_168_1.text_.text = var_171_16

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_17 = 33
				local var_171_18 = utf8.len(var_171_16)
				local var_171_19 = var_171_17 <= 0 and var_171_14 or var_171_14 * (var_171_18 / var_171_17)

				if var_171_19 > 0 and var_171_14 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19

					if var_171_19 + var_171_13 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_13
					end
				end

				arg_168_1.text_.text = var_171_16
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_20 = math.max(var_171_14, arg_168_1.talkMaxDuration)

			if var_171_13 <= arg_168_1.time_ and arg_168_1.time_ < var_171_13 + var_171_20 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_13) / var_171_20

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_13 + var_171_20 and arg_168_1.time_ < var_171_13 + var_171_20 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 420131041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play420131042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.05
			local var_175_1 = 1

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				local var_175_2 = "play"
				local var_175_3 = "effect"

				arg_172_1:AudioAction(var_175_2, var_175_3, "se_story_140", "se_story_140_dream_crash04", "")
			end

			local var_175_4 = 2.11
			local var_175_5 = 1

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				local var_175_6 = "stop"
				local var_175_7 = "effect"

				arg_172_1:AudioAction(var_175_6, var_175_7, "se_story_140", "se_story_140_amb_storm", "")
			end

			local var_175_8 = 2.11
			local var_175_9 = 1

			if var_175_8 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 then
				local var_175_10 = "stop"
				local var_175_11 = "effect"

				arg_172_1:AudioAction(var_175_10, var_175_11, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_175_12 = 0
			local var_175_13 = 1

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_14 = arg_172_1:GetWordFromCfg(420131041)
				local var_175_15 = arg_172_1:FormatText(var_175_14.content)

				arg_172_1.text_.text = var_175_15

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_16 = 40
				local var_175_17 = utf8.len(var_175_15)
				local var_175_18 = var_175_16 <= 0 and var_175_13 or var_175_13 * (var_175_17 / var_175_16)

				if var_175_18 > 0 and var_175_13 < var_175_18 then
					arg_172_1.talkMaxDuration = var_175_18

					if var_175_18 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_18 + var_175_12
					end
				end

				arg_172_1.text_.text = var_175_15
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_19 = math.max(var_175_13, arg_172_1.talkMaxDuration)

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_19 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_12) / var_175_19

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_12 + var_175_19 and arg_172_1.time_ < var_175_12 + var_175_19 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play420131042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 420131042
		arg_176_1.duration_ = 2.3

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play420131043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = "STwhite"

			if arg_176_1.bgs_[var_179_0] == nil then
				local var_179_1 = Object.Instantiate(arg_176_1.paintGo_)

				var_179_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_179_0)
				var_179_1.name = var_179_0
				var_179_1.transform.parent = arg_176_1.stage_.transform
				var_179_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_176_1.bgs_[var_179_0] = var_179_1
			end

			local var_179_2 = 0

			if var_179_2 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				local var_179_3 = manager.ui.mainCamera.transform.localPosition
				local var_179_4 = Vector3.New(0, 0, 10) + Vector3.New(var_179_3.x, var_179_3.y, 0)
				local var_179_5 = arg_176_1.bgs_.STwhite

				var_179_5.transform.localPosition = var_179_4
				var_179_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_179_6 = var_179_5:GetComponent("SpriteRenderer")

				if var_179_6 and var_179_6.sprite then
					local var_179_7 = (var_179_5.transform.localPosition - var_179_3).z
					local var_179_8 = manager.ui.mainCameraCom_
					local var_179_9 = 2 * var_179_7 * Mathf.Tan(var_179_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_179_10 = var_179_9 * var_179_8.aspect
					local var_179_11 = var_179_6.sprite.bounds.size.x
					local var_179_12 = var_179_6.sprite.bounds.size.y
					local var_179_13 = var_179_10 / var_179_11
					local var_179_14 = var_179_9 / var_179_12
					local var_179_15 = var_179_14 < var_179_13 and var_179_13 or var_179_14

					var_179_5.transform.localScale = Vector3.New(var_179_15, var_179_15, 0)
				end

				for iter_179_0, iter_179_1 in pairs(arg_176_1.bgs_) do
					if iter_179_0 ~= "STwhite" then
						iter_179_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_179_16 = 1.999999999999

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			local var_179_17 = 0.3

			if arg_176_1.time_ >= var_179_16 + var_179_17 and arg_176_1.time_ < var_179_16 + var_179_17 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end

			local var_179_18 = 0

			if var_179_18 < arg_176_1.time_ and arg_176_1.time_ <= var_179_18 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_19 = 2

			if var_179_18 <= arg_176_1.time_ and arg_176_1.time_ < var_179_18 + var_179_19 then
				local var_179_20 = (arg_176_1.time_ - var_179_18) / var_179_19
				local var_179_21 = Color.New(0, 0, 0)

				var_179_21.a = Mathf.Lerp(1, 0, var_179_20)
				arg_176_1.mask_.color = var_179_21
			end

			if arg_176_1.time_ >= var_179_18 + var_179_19 and arg_176_1.time_ < var_179_18 + var_179_19 + arg_179_0 then
				local var_179_22 = Color.New(0, 0, 0)
				local var_179_23 = 0

				arg_176_1.mask_.enabled = false
				var_179_22.a = var_179_23
				arg_176_1.mask_.color = var_179_22
			end

			local var_179_24 = manager.ui.mainCamera.transform
			local var_179_25 = 0

			if var_179_25 < arg_176_1.time_ and arg_176_1.time_ <= var_179_25 + arg_179_0 then
				local var_179_26 = arg_176_1.var_.effect1036

				if var_179_26 then
					Object.Destroy(var_179_26)

					arg_176_1.var_.effect1036 = nil
				end
			end

			local var_179_27 = 0

			if var_179_27 < arg_176_1.time_ and arg_176_1.time_ <= var_179_27 + arg_179_0 then
				arg_176_1.fswbg_:SetActive(true)
				arg_176_1.dialog_:SetActive(false)

				arg_176_1.fswtw_.percent = 0

				local var_179_28 = arg_176_1:GetWordFromCfg(420131042)
				local var_179_29 = arg_176_1:FormatText(var_179_28.content)

				arg_176_1.fswt_.text = var_179_29

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.fswt_)

				arg_176_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_176_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_176_1.fswtw_:SetDirty()

				arg_176_1.typewritterCharCountI18N = 0

				SetActive(arg_176_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_176_1:ShowNextGo(false)
			end

			local var_179_30 = 0.666666666666667

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1.var_.oldValueTypewriter = arg_176_1.fswtw_.percent

				SetActive(arg_176_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_176_1:ShowNextGo(false)
			end

			local var_179_31 = 5
			local var_179_32 = 0.633333333332333
			local var_179_33 = arg_176_1:GetWordFromCfg(420131042)
			local var_179_34 = arg_176_1:FormatText(var_179_33.content)
			local var_179_35, var_179_36 = arg_176_1:GetPercentByPara(var_179_34, 1)

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				local var_179_37 = var_179_31 <= 0 and var_179_32 or var_179_32 * ((var_179_36 - arg_176_1.typewritterCharCountI18N) / var_179_31)

				if var_179_37 > 0 and var_179_32 < var_179_37 then
					arg_176_1.talkMaxDuration = var_179_37

					if var_179_37 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_37 + var_179_30
					end
				end
			end

			local var_179_38 = 0.633333333332333
			local var_179_39 = math.max(var_179_38, arg_176_1.talkMaxDuration)

			if var_179_30 <= arg_176_1.time_ and arg_176_1.time_ < var_179_30 + var_179_39 then
				local var_179_40 = (arg_176_1.time_ - var_179_30) / var_179_39

				arg_176_1.fswtw_.percent = Mathf.Lerp(arg_176_1.var_.oldValueTypewriter, var_179_35, var_179_40)
				arg_176_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_176_1.fswtw_:SetDirty()
			end

			if arg_176_1.time_ >= var_179_30 + var_179_39 and arg_176_1.time_ < var_179_30 + var_179_39 + arg_179_0 then
				arg_176_1.fswtw_.percent = var_179_35

				arg_176_1.fswtw_:SetDirty()
				arg_176_1:ShowNextGo(true)

				arg_176_1.typewritterCharCountI18N = var_179_36
			end

			local var_179_41 = 0

			if var_179_41 < arg_176_1.time_ and arg_176_1.time_ <= var_179_41 + arg_179_0 then
				local var_179_42 = arg_176_1.fswbg_.transform:Find("textbox/adapt/content") or arg_176_1.fswbg_.transform:Find("textbox/content")
				local var_179_43 = arg_176_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_179_44 = var_179_42:GetComponent("Text")
				local var_179_45 = var_179_42:GetComponent("RectTransform")

				var_179_44.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_179_45.offsetMin = Vector2.New(0, -130)
				var_179_45.offsetMax = Vector2.New(0, 0)
			end

			local var_179_46 = 0
			local var_179_47 = 0.9

			if var_179_46 < arg_176_1.time_ and arg_176_1.time_ <= var_179_46 + arg_179_0 then
				local var_179_48 = "play"
				local var_179_49 = "music"

				arg_176_1:AudioAction(var_179_48, var_179_49, "story_v_out_420131", "420131042", "story_v_out_420131.awb")

				local var_179_50 = ""
				local var_179_51 = manager.audio:GetAudioName("story_v_out_420131", "420131042")

				if var_179_51 ~= "" then
					if arg_176_1.bgmTxt_.text ~= var_179_51 and arg_176_1.bgmTxt_.text ~= "" then
						if arg_176_1.bgmTxt2_.text ~= "" then
							arg_176_1.bgmTxt_.text = arg_176_1.bgmTxt2_.text
						end

						arg_176_1.bgmTxt2_.text = var_179_51

						arg_176_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_176_1.bgmTxt_.text = var_179_51
						arg_176_1.bgmTxt2_.text = var_179_51
					end

					if arg_176_1.bgmTimer then
						arg_176_1.bgmTimer:Stop()

						arg_176_1.bgmTimer = nil
					end

					if arg_176_1.settingData.show_music_name == 1 then
						arg_176_1.musicController:SetSelectedState("show")
						arg_176_1.musicAnimator_:Play("open", 0, 0)

						if arg_176_1.settingData.music_time ~= 0 then
							arg_176_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_176_1.settingData.music_time), function()
								if arg_176_1 == nil or isNil(arg_176_1.bgmTxt_) then
									return
								end

								arg_176_1.musicController:SetSelectedState("hide")
								arg_176_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_179_52 = 0

			if var_179_52 < arg_176_1.time_ and arg_176_1.time_ <= var_179_52 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			local var_179_53 = 2.15281499968842

			if arg_176_1.time_ >= var_179_52 + var_179_53 and arg_176_1.time_ < var_179_52 + var_179_53 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end

			local var_179_54 = manager.ui.mainCamera.transform
			local var_179_55 = 0

			if var_179_55 < arg_176_1.time_ and arg_176_1.time_ <= var_179_55 + arg_179_0 then
				local var_179_56 = arg_176_1.var_.effect1031

				if var_179_56 then
					Object.Destroy(var_179_56)

					arg_176_1.var_.effect1031 = nil
				end
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play420131043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 420131043
		arg_181_1.duration_ = 7

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play420131044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = "ST0505"

			if arg_181_1.bgs_[var_184_0] == nil then
				local var_184_1 = Object.Instantiate(arg_181_1.paintGo_)

				var_184_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_184_0)
				var_184_1.name = var_184_0
				var_184_1.transform.parent = arg_181_1.stage_.transform
				var_184_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.bgs_[var_184_0] = var_184_1
			end

			local var_184_2 = 0

			if var_184_2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				local var_184_3 = manager.ui.mainCamera.transform.localPosition
				local var_184_4 = Vector3.New(0, 0, 10) + Vector3.New(var_184_3.x, var_184_3.y, 0)
				local var_184_5 = arg_181_1.bgs_.ST0505

				var_184_5.transform.localPosition = var_184_4
				var_184_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_6 = var_184_5:GetComponent("SpriteRenderer")

				if var_184_6 and var_184_6.sprite then
					local var_184_7 = (var_184_5.transform.localPosition - var_184_3).z
					local var_184_8 = manager.ui.mainCameraCom_
					local var_184_9 = 2 * var_184_7 * Mathf.Tan(var_184_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_184_10 = var_184_9 * var_184_8.aspect
					local var_184_11 = var_184_6.sprite.bounds.size.x
					local var_184_12 = var_184_6.sprite.bounds.size.y
					local var_184_13 = var_184_10 / var_184_11
					local var_184_14 = var_184_9 / var_184_12
					local var_184_15 = var_184_14 < var_184_13 and var_184_13 or var_184_14

					var_184_5.transform.localScale = Vector3.New(var_184_15, var_184_15, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "ST0505" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_16 = 1.999999999999

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			local var_184_17 = 0.3

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			local var_184_18 = 0

			if var_184_18 < arg_181_1.time_ and arg_181_1.time_ <= var_184_18 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_19 = 1.999999999999

			if var_184_18 <= arg_181_1.time_ and arg_181_1.time_ < var_184_18 + var_184_19 then
				local var_184_20 = (arg_181_1.time_ - var_184_18) / var_184_19
				local var_184_21 = Color.New(1, 1, 1)

				var_184_21.a = Mathf.Lerp(1, 0, var_184_20)
				arg_181_1.mask_.color = var_184_21
			end

			if arg_181_1.time_ >= var_184_18 + var_184_19 and arg_181_1.time_ < var_184_18 + var_184_19 + arg_184_0 then
				local var_184_22 = Color.New(1, 1, 1)
				local var_184_23 = 0

				arg_181_1.mask_.enabled = false
				var_184_22.a = var_184_23
				arg_181_1.mask_.color = var_184_22
			end

			local var_184_24 = 0.133333333333333
			local var_184_25 = 1

			if var_184_24 < arg_181_1.time_ and arg_181_1.time_ <= var_184_24 + arg_184_0 then
				local var_184_26 = "play"
				local var_184_27 = "effect"

				arg_181_1:AudioAction(var_184_26, var_184_27, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_184_28 = 0

			if var_184_28 < arg_181_1.time_ and arg_181_1.time_ <= var_184_28 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(false)
				arg_181_1.dialog_:SetActive(false)
				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_181_1:ShowNextGo(false)
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_29 = 1.999999999999
			local var_184_30 = 0.65

			if var_184_29 < arg_181_1.time_ and arg_181_1.time_ <= var_184_29 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_31 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_31:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_32 = arg_181_1:GetWordFromCfg(420131043)
				local var_184_33 = arg_181_1:FormatText(var_184_32.content)

				arg_181_1.text_.text = var_184_33

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_34 = 26
				local var_184_35 = utf8.len(var_184_33)
				local var_184_36 = var_184_34 <= 0 and var_184_30 or var_184_30 * (var_184_35 / var_184_34)

				if var_184_36 > 0 and var_184_30 < var_184_36 then
					arg_181_1.talkMaxDuration = var_184_36
					var_184_29 = var_184_29 + 0.3

					if var_184_36 + var_184_29 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_36 + var_184_29
					end
				end

				arg_181_1.text_.text = var_184_33
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_37 = var_184_29 + 0.3
			local var_184_38 = math.max(var_184_30, arg_181_1.talkMaxDuration)

			if var_184_37 <= arg_181_1.time_ and arg_181_1.time_ < var_184_37 + var_184_38 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_37) / var_184_38

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_37 + var_184_38 and arg_181_1.time_ < var_184_37 + var_184_38 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play420131044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 420131044
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play420131045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.8

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(420131044)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 32
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play420131045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 420131045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play420131046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.25

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(420131045)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 50
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play420131046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 420131046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play420131047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.125

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(420131046)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 5
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play420131047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 420131047
		arg_199_1.duration_ = 2

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play420131048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1085ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1085ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, -1.01, -5.83)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1085ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["1085ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1085ui_story == nil then
				arg_199_1.var_.characterEffect1085ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect1085ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1085ui_story then
				arg_199_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_202_15 = 0
			local var_202_16 = 0.05

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[328].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(420131047)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 2
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131047", "story_v_out_420131.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_420131", "420131047", "story_v_out_420131.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_420131", "420131047", "story_v_out_420131.awb")

						arg_199_1:RecordAudio("420131047", var_202_24)
						arg_199_1:RecordAudio("420131047", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_420131", "420131047", "story_v_out_420131.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_420131", "420131047", "story_v_out_420131.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 420131048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play420131049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1085ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1085ui_story == nil then
				arg_203_1.var_.characterEffect1085ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1085ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1085ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1085ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1085ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.775

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(420131048)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 31
				local var_206_11 = utf8.len(var_206_9)
				local var_206_12 = var_206_10 <= 0 and var_206_7 or var_206_7 * (var_206_11 / var_206_10)

				if var_206_12 > 0 and var_206_7 < var_206_12 then
					arg_203_1.talkMaxDuration = var_206_12

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_13 and arg_203_1.time_ < var_206_6 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play420131049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 420131049
		arg_207_1.duration_ = 7.87

		local var_207_0 = {
			zh = 5.4,
			ja = 7.866
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
				arg_207_0:Play420131050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1085ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1085ui_story == nil then
				arg_207_1.var_.characterEffect1085ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1085ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1085ui_story then
				arg_207_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_210_4 = 0
			local var_210_5 = 0.375

			if var_210_4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_6 = arg_207_1:FormatText(StoryNameCfg[328].name)

				arg_207_1.leftNameTxt_.text = var_210_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:GetWordFromCfg(420131049)
				local var_210_8 = arg_207_1:FormatText(var_210_7.content)

				arg_207_1.text_.text = var_210_8

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 15
				local var_210_10 = utf8.len(var_210_8)
				local var_210_11 = var_210_9 <= 0 and var_210_5 or var_210_5 * (var_210_10 / var_210_9)

				if var_210_11 > 0 and var_210_5 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_8
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131049", "story_v_out_420131.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_420131", "420131049", "story_v_out_420131.awb") / 1000

					if var_210_12 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_4
					end

					if var_210_7.prefab_name ~= "" and arg_207_1.actors_[var_210_7.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_7.prefab_name].transform, "story_v_out_420131", "420131049", "story_v_out_420131.awb")

						arg_207_1:RecordAudio("420131049", var_210_13)
						arg_207_1:RecordAudio("420131049", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_420131", "420131049", "story_v_out_420131.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_420131", "420131049", "story_v_out_420131.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_14 and arg_207_1.time_ < var_210_4 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play420131050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 420131050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play420131051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1085ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1085ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1085ui_story, var_214_4, var_214_3)

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

			local var_214_9 = 0.133333333333333
			local var_214_10 = 1

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				local var_214_11 = "play"
				local var_214_12 = "effect"

				arg_211_1:AudioAction(var_214_11, var_214_12, "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_214_13 = 0
			local var_214_14 = 1.15

			if var_214_13 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_15 = arg_211_1:GetWordFromCfg(420131050)
				local var_214_16 = arg_211_1:FormatText(var_214_15.content)

				arg_211_1.text_.text = var_214_16

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_17 = 46
				local var_214_18 = utf8.len(var_214_16)
				local var_214_19 = var_214_17 <= 0 and var_214_14 or var_214_14 * (var_214_18 / var_214_17)

				if var_214_19 > 0 and var_214_14 < var_214_19 then
					arg_211_1.talkMaxDuration = var_214_19

					if var_214_19 + var_214_13 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_19 + var_214_13
					end
				end

				arg_211_1.text_.text = var_214_16
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_20 = math.max(var_214_14, arg_211_1.talkMaxDuration)

			if var_214_13 <= arg_211_1.time_ and arg_211_1.time_ < var_214_13 + var_214_20 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_13) / var_214_20

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_13 + var_214_20 and arg_211_1.time_ < var_214_13 + var_214_20 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 420131051
		arg_215_1.duration_ = 4.73

		local var_215_0 = {
			zh = 3.733,
			ja = 4.733
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
				arg_215_0:Play420131052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["404001ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos404001ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -1.55, -5.5)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos404001ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["404001ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect404001ui_story == nil then
				arg_215_1.var_.characterEffect404001ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect404001ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect404001ui_story then
				arg_215_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_218_15 = 0
			local var_218_16 = 0.475

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[668].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(420131051)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131051", "story_v_out_420131.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_420131", "420131051", "story_v_out_420131.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_420131", "420131051", "story_v_out_420131.awb")

						arg_215_1:RecordAudio("420131051", var_218_24)
						arg_215_1:RecordAudio("420131051", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_420131", "420131051", "story_v_out_420131.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_420131", "420131051", "story_v_out_420131.awb")
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
				actorName = "404001ui_story",
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
	Play420131052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 420131052
		arg_219_1.duration_ = 12.77

		local var_219_0 = {
			zh = 7.9,
			ja = 12.766
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
				arg_219_0:Play420131053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["404001ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos404001ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos404001ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = "1043ui_story"

			if arg_219_1.actors_[var_222_9] == nil then
				local var_222_10 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_222_10) then
					local var_222_11 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_219_1.stage_.transform)

					var_222_11.name = var_222_9
					var_222_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_219_1.actors_[var_222_9] = var_222_11

					local var_222_12 = var_222_11:GetComponentInChildren(typeof(CharacterEffect))

					var_222_12.enabled = true

					local var_222_13 = GameObjectTools.GetOrAddComponent(var_222_11, typeof(DynamicBoneHelper))

					if var_222_13 then
						var_222_13:EnableDynamicBone(false)
					end

					arg_219_1:ShowWeapon(var_222_12.transform, false)

					arg_219_1.var_[var_222_9 .. "Animator"] = var_222_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_219_1.var_[var_222_9 .. "Animator"].applyRootMotion = true
					arg_219_1.var_[var_222_9 .. "LipSync"] = var_222_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_222_14 = arg_219_1.actors_["1043ui_story"].transform
			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.var_.moveOldPos1043ui_story = var_222_14.localPosition
			end

			local var_222_16 = 0.001

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_16 then
				local var_222_17 = (arg_219_1.time_ - var_222_15) / var_222_16
				local var_222_18 = Vector3.New(0.81, -1.01, -5.73)

				var_222_14.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1043ui_story, var_222_18, var_222_17)

				local var_222_19 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_19.x, var_222_19.y, var_222_19.z)

				local var_222_20 = var_222_14.localEulerAngles

				var_222_20.z = 0
				var_222_20.x = 0
				var_222_14.localEulerAngles = var_222_20
			end

			if arg_219_1.time_ >= var_222_15 + var_222_16 and arg_219_1.time_ < var_222_15 + var_222_16 + arg_222_0 then
				var_222_14.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_222_21 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_21.x, var_222_21.y, var_222_21.z)

				local var_222_22 = var_222_14.localEulerAngles

				var_222_22.z = 0
				var_222_22.x = 0
				var_222_14.localEulerAngles = var_222_22
			end

			local var_222_23 = arg_219_1.actors_["1043ui_story"]
			local var_222_24 = 0

			if var_222_24 < arg_219_1.time_ and arg_219_1.time_ <= var_222_24 + arg_222_0 and not isNil(var_222_23) and arg_219_1.var_.characterEffect1043ui_story == nil then
				arg_219_1.var_.characterEffect1043ui_story = var_222_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_25 = 0.200000002980232

			if var_222_24 <= arg_219_1.time_ and arg_219_1.time_ < var_222_24 + var_222_25 and not isNil(var_222_23) then
				local var_222_26 = (arg_219_1.time_ - var_222_24) / var_222_25

				if arg_219_1.var_.characterEffect1043ui_story and not isNil(var_222_23) then
					arg_219_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_24 + var_222_25 and arg_219_1.time_ < var_222_24 + var_222_25 + arg_222_0 and not isNil(var_222_23) and arg_219_1.var_.characterEffect1043ui_story then
				arg_219_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_222_27 = arg_219_1.actors_["404001ui_story"]
			local var_222_28 = 0

			if var_222_28 < arg_219_1.time_ and arg_219_1.time_ <= var_222_28 + arg_222_0 and not isNil(var_222_27) and arg_219_1.var_.characterEffect404001ui_story == nil then
				arg_219_1.var_.characterEffect404001ui_story = var_222_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_29 = 0.200000002980232

			if var_222_28 <= arg_219_1.time_ and arg_219_1.time_ < var_222_28 + var_222_29 and not isNil(var_222_27) then
				local var_222_30 = (arg_219_1.time_ - var_222_28) / var_222_29

				if arg_219_1.var_.characterEffect404001ui_story and not isNil(var_222_27) then
					local var_222_31 = Mathf.Lerp(0, 0.5, var_222_30)

					arg_219_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_219_1.var_.characterEffect404001ui_story.fillRatio = var_222_31
				end
			end

			if arg_219_1.time_ >= var_222_28 + var_222_29 and arg_219_1.time_ < var_222_28 + var_222_29 + arg_222_0 and not isNil(var_222_27) and arg_219_1.var_.characterEffect404001ui_story then
				local var_222_32 = 0.5

				arg_219_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_219_1.var_.characterEffect404001ui_story.fillRatio = var_222_32
			end

			local var_222_33 = 0

			if var_222_33 < arg_219_1.time_ and arg_219_1.time_ <= var_222_33 + arg_222_0 then
				arg_219_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			local var_222_34 = 0

			if var_222_34 < arg_219_1.time_ and arg_219_1.time_ <= var_222_34 + arg_222_0 then
				arg_219_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_222_35 = 0

			if var_222_35 < arg_219_1.time_ and arg_219_1.time_ <= var_222_35 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			local var_222_36 = 0.833333333333333

			if arg_219_1.time_ >= var_222_35 + var_222_36 and arg_219_1.time_ < var_222_35 + var_222_36 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_37 = 0
			local var_222_38 = 0.725

			if var_222_37 < arg_219_1.time_ and arg_219_1.time_ <= var_222_37 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_39 = arg_219_1:FormatText(StoryNameCfg[1156].name)

				arg_219_1.leftNameTxt_.text = var_222_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_40 = arg_219_1:GetWordFromCfg(420131052)
				local var_222_41 = arg_219_1:FormatText(var_222_40.content)

				arg_219_1.text_.text = var_222_41

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_42 = 29
				local var_222_43 = utf8.len(var_222_41)
				local var_222_44 = var_222_42 <= 0 and var_222_38 or var_222_38 * (var_222_43 / var_222_42)

				if var_222_44 > 0 and var_222_38 < var_222_44 then
					arg_219_1.talkMaxDuration = var_222_44

					if var_222_44 + var_222_37 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_44 + var_222_37
					end
				end

				arg_219_1.text_.text = var_222_41
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131052", "story_v_out_420131.awb") ~= 0 then
					local var_222_45 = manager.audio:GetVoiceLength("story_v_out_420131", "420131052", "story_v_out_420131.awb") / 1000

					if var_222_45 + var_222_37 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_45 + var_222_37
					end

					if var_222_40.prefab_name ~= "" and arg_219_1.actors_[var_222_40.prefab_name] ~= nil then
						local var_222_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_40.prefab_name].transform, "story_v_out_420131", "420131052", "story_v_out_420131.awb")

						arg_219_1:RecordAudio("420131052", var_222_46)
						arg_219_1:RecordAudio("420131052", var_222_46)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_420131", "420131052", "story_v_out_420131.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_420131", "420131052", "story_v_out_420131.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_47 = math.max(var_222_38, arg_219_1.talkMaxDuration)

			if var_222_37 <= arg_219_1.time_ and arg_219_1.time_ < var_222_37 + var_222_47 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_37) / var_222_47

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_37 + var_222_47 and arg_219_1.time_ < var_222_37 + var_222_47 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_219_1:InitPlayNodeList()
	end,
	Play420131053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 420131053
		arg_223_1.duration_ = 9.5

		local var_223_0 = {
			zh = 8.7,
			ja = 9.5
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
				arg_223_0:Play420131054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["404001ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect404001ui_story == nil then
				arg_223_1.var_.characterEffect404001ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect404001ui_story and not isNil(var_226_0) then
					arg_223_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect404001ui_story then
				arg_223_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_226_4 = "1042ui_story"

			if arg_223_1.actors_[var_226_4] == nil then
				local var_226_5 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_226_5) then
					local var_226_6 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_223_1.stage_.transform)

					var_226_6.name = var_226_4
					var_226_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_223_1.actors_[var_226_4] = var_226_6

					local var_226_7 = var_226_6:GetComponentInChildren(typeof(CharacterEffect))

					var_226_7.enabled = true

					local var_226_8 = GameObjectTools.GetOrAddComponent(var_226_6, typeof(DynamicBoneHelper))

					if var_226_8 then
						var_226_8:EnableDynamicBone(false)
					end

					arg_223_1:ShowWeapon(var_226_7.transform, false)

					arg_223_1.var_[var_226_4 .. "Animator"] = var_226_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_223_1.var_[var_226_4 .. "Animator"].applyRootMotion = true
					arg_223_1.var_[var_226_4 .. "LipSync"] = var_226_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_226_9 = arg_223_1.actors_["1042ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1042ui_story == nil then
				arg_223_1.var_.characterEffect1042ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1042ui_story and not isNil(var_226_9) then
					local var_226_13 = Mathf.Lerp(0, 0.5, var_226_12)

					arg_223_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1042ui_story.fillRatio = var_226_13
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1042ui_story then
				local var_226_14 = 0.5

				arg_223_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1042ui_story.fillRatio = var_226_14
			end

			local var_226_15 = 0

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2", "EmotionTimelineAnimator")
			end

			local var_226_16 = 0
			local var_226_17 = 0.95

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_18 = arg_223_1:FormatText(StoryNameCfg[668].name)

				arg_223_1.leftNameTxt_.text = var_226_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_19 = arg_223_1:GetWordFromCfg(420131053)
				local var_226_20 = arg_223_1:FormatText(var_226_19.content)

				arg_223_1.text_.text = var_226_20

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_21 = 38
				local var_226_22 = utf8.len(var_226_20)
				local var_226_23 = var_226_21 <= 0 and var_226_17 or var_226_17 * (var_226_22 / var_226_21)

				if var_226_23 > 0 and var_226_17 < var_226_23 then
					arg_223_1.talkMaxDuration = var_226_23

					if var_226_23 + var_226_16 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_16
					end
				end

				arg_223_1.text_.text = var_226_20
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131053", "story_v_out_420131.awb") ~= 0 then
					local var_226_24 = manager.audio:GetVoiceLength("story_v_out_420131", "420131053", "story_v_out_420131.awb") / 1000

					if var_226_24 + var_226_16 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_24 + var_226_16
					end

					if var_226_19.prefab_name ~= "" and arg_223_1.actors_[var_226_19.prefab_name] ~= nil then
						local var_226_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_19.prefab_name].transform, "story_v_out_420131", "420131053", "story_v_out_420131.awb")

						arg_223_1:RecordAudio("420131053", var_226_25)
						arg_223_1:RecordAudio("420131053", var_226_25)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_420131", "420131053", "story_v_out_420131.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_420131", "420131053", "story_v_out_420131.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_26 = math.max(var_226_17, arg_223_1.talkMaxDuration)

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_26 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_16) / var_226_26

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_16 + var_226_26 and arg_223_1.time_ < var_226_16 + var_226_26 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play420131054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 420131054
		arg_227_1.duration_ = 11.3

		local var_227_0 = {
			zh = 9.333,
			ja = 11.3
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
				arg_227_0:Play420131055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1042ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1042ui_story == nil then
				arg_227_1.var_.characterEffect1042ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1042ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1042ui_story then
				arg_227_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_230_4 = arg_227_1.actors_["404001ui_story"]
			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect404001ui_story == nil then
				arg_227_1.var_.characterEffect404001ui_story = var_230_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_6 = 0.200000002980232

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_6 and not isNil(var_230_4) then
				local var_230_7 = (arg_227_1.time_ - var_230_5) / var_230_6

				if arg_227_1.var_.characterEffect404001ui_story and not isNil(var_230_4) then
					local var_230_8 = Mathf.Lerp(0, 0.5, var_230_7)

					arg_227_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_227_1.var_.characterEffect404001ui_story.fillRatio = var_230_8
				end
			end

			if arg_227_1.time_ >= var_230_5 + var_230_6 and arg_227_1.time_ < var_230_5 + var_230_6 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect404001ui_story then
				local var_230_9 = 0.5

				arg_227_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_227_1.var_.characterEffect404001ui_story.fillRatio = var_230_9
			end

			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			local var_230_11 = 0

			if var_230_11 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_230_12 = 0
			local var_230_13 = 1.05

			if var_230_12 < arg_227_1.time_ and arg_227_1.time_ <= var_230_12 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_14 = arg_227_1:FormatText(StoryNameCfg[1156].name)

				arg_227_1.leftNameTxt_.text = var_230_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_15 = arg_227_1:GetWordFromCfg(420131054)
				local var_230_16 = arg_227_1:FormatText(var_230_15.content)

				arg_227_1.text_.text = var_230_16

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_17 = 42
				local var_230_18 = utf8.len(var_230_16)
				local var_230_19 = var_230_17 <= 0 and var_230_13 or var_230_13 * (var_230_18 / var_230_17)

				if var_230_19 > 0 and var_230_13 < var_230_19 then
					arg_227_1.talkMaxDuration = var_230_19

					if var_230_19 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_19 + var_230_12
					end
				end

				arg_227_1.text_.text = var_230_16
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131054", "story_v_out_420131.awb") ~= 0 then
					local var_230_20 = manager.audio:GetVoiceLength("story_v_out_420131", "420131054", "story_v_out_420131.awb") / 1000

					if var_230_20 + var_230_12 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_20 + var_230_12
					end

					if var_230_15.prefab_name ~= "" and arg_227_1.actors_[var_230_15.prefab_name] ~= nil then
						local var_230_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_15.prefab_name].transform, "story_v_out_420131", "420131054", "story_v_out_420131.awb")

						arg_227_1:RecordAudio("420131054", var_230_21)
						arg_227_1:RecordAudio("420131054", var_230_21)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_420131", "420131054", "story_v_out_420131.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_420131", "420131054", "story_v_out_420131.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_22 = math.max(var_230_13, arg_227_1.talkMaxDuration)

			if var_230_12 <= arg_227_1.time_ and arg_227_1.time_ < var_230_12 + var_230_22 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_12) / var_230_22

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_12 + var_230_22 and arg_227_1.time_ < var_230_12 + var_230_22 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play420131055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 420131055
		arg_231_1.duration_ = 2.57

		local var_231_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_231_0:Play420131056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["404001ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos404001ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, 100, 0)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos404001ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, 100, 0)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["1043ui_story"].transform
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.var_.moveOldPos1043ui_story = var_234_9.localPosition
			end

			local var_234_11 = 0.001

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11
				local var_234_13 = Vector3.New(0, 100, 0)

				var_234_9.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1043ui_story, var_234_13, var_234_12)

				local var_234_14 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_14.x, var_234_14.y, var_234_14.z)

				local var_234_15 = var_234_9.localEulerAngles

				var_234_15.z = 0
				var_234_15.x = 0
				var_234_9.localEulerAngles = var_234_15
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 then
				var_234_9.localPosition = Vector3.New(0, 100, 0)

				local var_234_16 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_16.x, var_234_16.y, var_234_16.z)

				local var_234_17 = var_234_9.localEulerAngles

				var_234_17.z = 0
				var_234_17.x = 0
				var_234_9.localEulerAngles = var_234_17
			end

			local var_234_18 = arg_231_1.actors_["1085ui_story"].transform
			local var_234_19 = 0

			if var_234_19 < arg_231_1.time_ and arg_231_1.time_ <= var_234_19 + arg_234_0 then
				arg_231_1.var_.moveOldPos1085ui_story = var_234_18.localPosition
			end

			local var_234_20 = 0.001

			if var_234_19 <= arg_231_1.time_ and arg_231_1.time_ < var_234_19 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_19) / var_234_20
				local var_234_22 = Vector3.New(0, -1.01, -5.83)

				var_234_18.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1085ui_story, var_234_22, var_234_21)

				local var_234_23 = manager.ui.mainCamera.transform.position - var_234_18.position

				var_234_18.forward = Vector3.New(var_234_23.x, var_234_23.y, var_234_23.z)

				local var_234_24 = var_234_18.localEulerAngles

				var_234_24.z = 0
				var_234_24.x = 0
				var_234_18.localEulerAngles = var_234_24
			end

			if arg_231_1.time_ >= var_234_19 + var_234_20 and arg_231_1.time_ < var_234_19 + var_234_20 + arg_234_0 then
				var_234_18.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_234_25 = manager.ui.mainCamera.transform.position - var_234_18.position

				var_234_18.forward = Vector3.New(var_234_25.x, var_234_25.y, var_234_25.z)

				local var_234_26 = var_234_18.localEulerAngles

				var_234_26.z = 0
				var_234_26.x = 0
				var_234_18.localEulerAngles = var_234_26
			end

			local var_234_27 = arg_231_1.actors_["1085ui_story"]
			local var_234_28 = 0

			if var_234_28 < arg_231_1.time_ and arg_231_1.time_ <= var_234_28 + arg_234_0 and not isNil(var_234_27) and arg_231_1.var_.characterEffect1085ui_story == nil then
				arg_231_1.var_.characterEffect1085ui_story = var_234_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_29 = 0.200000002980232

			if var_234_28 <= arg_231_1.time_ and arg_231_1.time_ < var_234_28 + var_234_29 and not isNil(var_234_27) then
				local var_234_30 = (arg_231_1.time_ - var_234_28) / var_234_29

				if arg_231_1.var_.characterEffect1085ui_story and not isNil(var_234_27) then
					arg_231_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_28 + var_234_29 and arg_231_1.time_ < var_234_28 + var_234_29 + arg_234_0 and not isNil(var_234_27) and arg_231_1.var_.characterEffect1085ui_story then
				arg_231_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_234_31 = 0

			if var_234_31 < arg_231_1.time_ and arg_231_1.time_ <= var_234_31 + arg_234_0 then
				arg_231_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_234_32 = 0

			if var_234_32 < arg_231_1.time_ and arg_231_1.time_ <= var_234_32 + arg_234_0 then
				arg_231_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_234_33 = 0
			local var_234_34 = 0.175

			if var_234_33 < arg_231_1.time_ and arg_231_1.time_ <= var_234_33 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_35 = arg_231_1:FormatText(StoryNameCfg[328].name)

				arg_231_1.leftNameTxt_.text = var_234_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_36 = arg_231_1:GetWordFromCfg(420131055)
				local var_234_37 = arg_231_1:FormatText(var_234_36.content)

				arg_231_1.text_.text = var_234_37

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_38 = 7
				local var_234_39 = utf8.len(var_234_37)
				local var_234_40 = var_234_38 <= 0 and var_234_34 or var_234_34 * (var_234_39 / var_234_38)

				if var_234_40 > 0 and var_234_34 < var_234_40 then
					arg_231_1.talkMaxDuration = var_234_40

					if var_234_40 + var_234_33 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_40 + var_234_33
					end
				end

				arg_231_1.text_.text = var_234_37
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131055", "story_v_out_420131.awb") ~= 0 then
					local var_234_41 = manager.audio:GetVoiceLength("story_v_out_420131", "420131055", "story_v_out_420131.awb") / 1000

					if var_234_41 + var_234_33 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_41 + var_234_33
					end

					if var_234_36.prefab_name ~= "" and arg_231_1.actors_[var_234_36.prefab_name] ~= nil then
						local var_234_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_36.prefab_name].transform, "story_v_out_420131", "420131055", "story_v_out_420131.awb")

						arg_231_1:RecordAudio("420131055", var_234_42)
						arg_231_1:RecordAudio("420131055", var_234_42)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_420131", "420131055", "story_v_out_420131.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_420131", "420131055", "story_v_out_420131.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_43 = math.max(var_234_34, arg_231_1.talkMaxDuration)

			if var_234_33 <= arg_231_1.time_ and arg_231_1.time_ < var_234_33 + var_234_43 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_33) / var_234_43

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_33 + var_234_43 and arg_231_1.time_ < var_234_33 + var_234_43 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play420131056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 420131056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play420131057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1085ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1085ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0, 100, 0)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1085ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, 100, 0)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = 0
			local var_238_10 = 1.05

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_11 = arg_235_1:GetWordFromCfg(420131056)
				local var_238_12 = arg_235_1:FormatText(var_238_11.content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 42
				local var_238_14 = utf8.len(var_238_12)
				local var_238_15 = var_238_13 <= 0 and var_238_10 or var_238_10 * (var_238_14 / var_238_13)

				if var_238_15 > 0 and var_238_10 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_9 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_9
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_10, arg_235_1.talkMaxDuration)

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_9) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_9 + var_238_16 and arg_235_1.time_ < var_238_9 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 420131057
		arg_239_1.duration_ = 10.7

		local var_239_0 = {
			zh = 10.633,
			ja = 10.7
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
				arg_239_0:Play420131058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["404001ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos404001ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -1.55, -5.5)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos404001ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["404001ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect404001ui_story == nil then
				arg_239_1.var_.characterEffect404001ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect404001ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect404001ui_story then
				arg_239_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_242_14 = 0
			local var_242_15 = 1.15

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_16 = arg_239_1:FormatText(StoryNameCfg[668].name)

				arg_239_1.leftNameTxt_.text = var_242_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_17 = arg_239_1:GetWordFromCfg(420131057)
				local var_242_18 = arg_239_1:FormatText(var_242_17.content)

				arg_239_1.text_.text = var_242_18

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_19 = 46
				local var_242_20 = utf8.len(var_242_18)
				local var_242_21 = var_242_19 <= 0 and var_242_15 or var_242_15 * (var_242_20 / var_242_19)

				if var_242_21 > 0 and var_242_15 < var_242_21 then
					arg_239_1.talkMaxDuration = var_242_21

					if var_242_21 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_21 + var_242_14
					end
				end

				arg_239_1.text_.text = var_242_18
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131057", "story_v_out_420131.awb") ~= 0 then
					local var_242_22 = manager.audio:GetVoiceLength("story_v_out_420131", "420131057", "story_v_out_420131.awb") / 1000

					if var_242_22 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_14
					end

					if var_242_17.prefab_name ~= "" and arg_239_1.actors_[var_242_17.prefab_name] ~= nil then
						local var_242_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_17.prefab_name].transform, "story_v_out_420131", "420131057", "story_v_out_420131.awb")

						arg_239_1:RecordAudio("420131057", var_242_23)
						arg_239_1:RecordAudio("420131057", var_242_23)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_420131", "420131057", "story_v_out_420131.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_420131", "420131057", "story_v_out_420131.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_24 = math.max(var_242_15, arg_239_1.talkMaxDuration)

			if var_242_14 <= arg_239_1.time_ and arg_239_1.time_ < var_242_14 + var_242_24 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_14) / var_242_24

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_14 + var_242_24 and arg_239_1.time_ < var_242_14 + var_242_24 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play420131058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 420131058
		arg_243_1.duration_ = 8.07

		local var_243_0 = {
			zh = 4.9,
			ja = 8.066
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
				arg_243_0:Play420131059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["404001ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos404001ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos404001ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1043ui_story"].transform
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 then
				arg_243_1.var_.moveOldPos1043ui_story = var_246_9.localPosition

				local var_246_11 = "1043ui_story"

				arg_243_1:ShowWeapon(arg_243_1.var_[var_246_11 .. "Animator"].transform, false)
			end

			local var_246_12 = 0.001

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_12 then
				local var_246_13 = (arg_243_1.time_ - var_246_10) / var_246_12
				local var_246_14 = Vector3.New(0.81, -1.01, -5.73)

				var_246_9.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1043ui_story, var_246_14, var_246_13)

				local var_246_15 = manager.ui.mainCamera.transform.position - var_246_9.position

				var_246_9.forward = Vector3.New(var_246_15.x, var_246_15.y, var_246_15.z)

				local var_246_16 = var_246_9.localEulerAngles

				var_246_16.z = 0
				var_246_16.x = 0
				var_246_9.localEulerAngles = var_246_16
			end

			if arg_243_1.time_ >= var_246_10 + var_246_12 and arg_243_1.time_ < var_246_10 + var_246_12 + arg_246_0 then
				var_246_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_246_17 = manager.ui.mainCamera.transform.position - var_246_9.position

				var_246_9.forward = Vector3.New(var_246_17.x, var_246_17.y, var_246_17.z)

				local var_246_18 = var_246_9.localEulerAngles

				var_246_18.z = 0
				var_246_18.x = 0
				var_246_9.localEulerAngles = var_246_18
			end

			local var_246_19 = arg_243_1.actors_["1043ui_story"]
			local var_246_20 = 0

			if var_246_20 < arg_243_1.time_ and arg_243_1.time_ <= var_246_20 + arg_246_0 and not isNil(var_246_19) and arg_243_1.var_.characterEffect1043ui_story == nil then
				arg_243_1.var_.characterEffect1043ui_story = var_246_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_21 = 0.200000002980232

			if var_246_20 <= arg_243_1.time_ and arg_243_1.time_ < var_246_20 + var_246_21 and not isNil(var_246_19) then
				local var_246_22 = (arg_243_1.time_ - var_246_20) / var_246_21

				if arg_243_1.var_.characterEffect1043ui_story and not isNil(var_246_19) then
					arg_243_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_20 + var_246_21 and arg_243_1.time_ < var_246_20 + var_246_21 + arg_246_0 and not isNil(var_246_19) and arg_243_1.var_.characterEffect1043ui_story then
				arg_243_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_246_23 = arg_243_1.actors_["404001ui_story"]
			local var_246_24 = 0

			if var_246_24 < arg_243_1.time_ and arg_243_1.time_ <= var_246_24 + arg_246_0 and not isNil(var_246_23) and arg_243_1.var_.characterEffect404001ui_story == nil then
				arg_243_1.var_.characterEffect404001ui_story = var_246_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_25 = 0.200000002980232

			if var_246_24 <= arg_243_1.time_ and arg_243_1.time_ < var_246_24 + var_246_25 and not isNil(var_246_23) then
				local var_246_26 = (arg_243_1.time_ - var_246_24) / var_246_25

				if arg_243_1.var_.characterEffect404001ui_story and not isNil(var_246_23) then
					local var_246_27 = Mathf.Lerp(0, 0.5, var_246_26)

					arg_243_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_243_1.var_.characterEffect404001ui_story.fillRatio = var_246_27
				end
			end

			if arg_243_1.time_ >= var_246_24 + var_246_25 and arg_243_1.time_ < var_246_24 + var_246_25 + arg_246_0 and not isNil(var_246_23) and arg_243_1.var_.characterEffect404001ui_story then
				local var_246_28 = 0.5

				arg_243_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_243_1.var_.characterEffect404001ui_story.fillRatio = var_246_28
			end

			local var_246_29 = 0

			if var_246_29 < arg_243_1.time_ and arg_243_1.time_ <= var_246_29 + arg_246_0 then
				arg_243_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_246_30 = 0

			if var_246_30 < arg_243_1.time_ and arg_243_1.time_ <= var_246_30 + arg_246_0 then
				arg_243_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_246_31 = 0
			local var_246_32 = 0.625

			if var_246_31 < arg_243_1.time_ and arg_243_1.time_ <= var_246_31 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_33 = arg_243_1:FormatText(StoryNameCfg[1156].name)

				arg_243_1.leftNameTxt_.text = var_246_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_34 = arg_243_1:GetWordFromCfg(420131058)
				local var_246_35 = arg_243_1:FormatText(var_246_34.content)

				arg_243_1.text_.text = var_246_35

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_36 = 25
				local var_246_37 = utf8.len(var_246_35)
				local var_246_38 = var_246_36 <= 0 and var_246_32 or var_246_32 * (var_246_37 / var_246_36)

				if var_246_38 > 0 and var_246_32 < var_246_38 then
					arg_243_1.talkMaxDuration = var_246_38

					if var_246_38 + var_246_31 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_38 + var_246_31
					end
				end

				arg_243_1.text_.text = var_246_35
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131058", "story_v_out_420131.awb") ~= 0 then
					local var_246_39 = manager.audio:GetVoiceLength("story_v_out_420131", "420131058", "story_v_out_420131.awb") / 1000

					if var_246_39 + var_246_31 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_39 + var_246_31
					end

					if var_246_34.prefab_name ~= "" and arg_243_1.actors_[var_246_34.prefab_name] ~= nil then
						local var_246_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_34.prefab_name].transform, "story_v_out_420131", "420131058", "story_v_out_420131.awb")

						arg_243_1:RecordAudio("420131058", var_246_40)
						arg_243_1:RecordAudio("420131058", var_246_40)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_420131", "420131058", "story_v_out_420131.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_420131", "420131058", "story_v_out_420131.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_41 = math.max(var_246_32, arg_243_1.talkMaxDuration)

			if var_246_31 <= arg_243_1.time_ and arg_243_1.time_ < var_246_31 + var_246_41 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_31) / var_246_41

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_31 + var_246_41 and arg_243_1.time_ < var_246_31 + var_246_41 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_243_1:InitPlayNodeList()
	end,
	Play420131059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 420131059
		arg_247_1.duration_ = 4.6

		local var_247_0 = {
			zh = 3.366,
			ja = 4.6
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
				arg_247_0:Play420131060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["404001ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect404001ui_story == nil then
				arg_247_1.var_.characterEffect404001ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect404001ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect404001ui_story then
				arg_247_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["1043ui_story"]
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1043ui_story == nil then
				arg_247_1.var_.characterEffect1043ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_6 = 0.200000002980232

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 and not isNil(var_250_4) then
				local var_250_7 = (arg_247_1.time_ - var_250_5) / var_250_6

				if arg_247_1.var_.characterEffect1043ui_story and not isNil(var_250_4) then
					local var_250_8 = Mathf.Lerp(0, 0.5, var_250_7)

					arg_247_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1043ui_story.fillRatio = var_250_8
				end
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1043ui_story then
				local var_250_9 = 0.5

				arg_247_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1043ui_story.fillRatio = var_250_9
			end

			local var_250_10 = 0
			local var_250_11 = 0.375

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_12 = arg_247_1:FormatText(StoryNameCfg[668].name)

				arg_247_1.leftNameTxt_.text = var_250_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_13 = arg_247_1:GetWordFromCfg(420131059)
				local var_250_14 = arg_247_1:FormatText(var_250_13.content)

				arg_247_1.text_.text = var_250_14

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_15 = 15
				local var_250_16 = utf8.len(var_250_14)
				local var_250_17 = var_250_15 <= 0 and var_250_11 or var_250_11 * (var_250_16 / var_250_15)

				if var_250_17 > 0 and var_250_11 < var_250_17 then
					arg_247_1.talkMaxDuration = var_250_17

					if var_250_17 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_17 + var_250_10
					end
				end

				arg_247_1.text_.text = var_250_14
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131059", "story_v_out_420131.awb") ~= 0 then
					local var_250_18 = manager.audio:GetVoiceLength("story_v_out_420131", "420131059", "story_v_out_420131.awb") / 1000

					if var_250_18 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_18 + var_250_10
					end

					if var_250_13.prefab_name ~= "" and arg_247_1.actors_[var_250_13.prefab_name] ~= nil then
						local var_250_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_13.prefab_name].transform, "story_v_out_420131", "420131059", "story_v_out_420131.awb")

						arg_247_1:RecordAudio("420131059", var_250_19)
						arg_247_1:RecordAudio("420131059", var_250_19)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_420131", "420131059", "story_v_out_420131.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_420131", "420131059", "story_v_out_420131.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_20 = math.max(var_250_11, arg_247_1.talkMaxDuration)

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_20 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_10) / var_250_20

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_10 + var_250_20 and arg_247_1.time_ < var_250_10 + var_250_20 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play420131060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 420131060
		arg_251_1.duration_ = 4.87

		local var_251_0 = {
			zh = 2.133,
			ja = 4.866
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
				arg_251_0:Play420131061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1043ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1043ui_story == nil then
				arg_251_1.var_.characterEffect1043ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1043ui_story and not isNil(var_254_0) then
					arg_251_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1043ui_story then
				arg_251_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_254_4 = arg_251_1.actors_["404001ui_story"]
			local var_254_5 = 0

			if var_254_5 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect404001ui_story == nil then
				arg_251_1.var_.characterEffect404001ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_6 = 0.200000002980232

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_6 and not isNil(var_254_4) then
				local var_254_7 = (arg_251_1.time_ - var_254_5) / var_254_6

				if arg_251_1.var_.characterEffect404001ui_story and not isNil(var_254_4) then
					local var_254_8 = Mathf.Lerp(0, 0.5, var_254_7)

					arg_251_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_251_1.var_.characterEffect404001ui_story.fillRatio = var_254_8
				end
			end

			if arg_251_1.time_ >= var_254_5 + var_254_6 and arg_251_1.time_ < var_254_5 + var_254_6 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect404001ui_story then
				local var_254_9 = 0.5

				arg_251_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_251_1.var_.characterEffect404001ui_story.fillRatio = var_254_9
			end

			local var_254_10 = 0
			local var_254_11 = 0.3

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_12 = arg_251_1:FormatText(StoryNameCfg[1156].name)

				arg_251_1.leftNameTxt_.text = var_254_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_13 = arg_251_1:GetWordFromCfg(420131060)
				local var_254_14 = arg_251_1:FormatText(var_254_13.content)

				arg_251_1.text_.text = var_254_14

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_15 = 12
				local var_254_16 = utf8.len(var_254_14)
				local var_254_17 = var_254_15 <= 0 and var_254_11 or var_254_11 * (var_254_16 / var_254_15)

				if var_254_17 > 0 and var_254_11 < var_254_17 then
					arg_251_1.talkMaxDuration = var_254_17

					if var_254_17 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_17 + var_254_10
					end
				end

				arg_251_1.text_.text = var_254_14
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131060", "story_v_out_420131.awb") ~= 0 then
					local var_254_18 = manager.audio:GetVoiceLength("story_v_out_420131", "420131060", "story_v_out_420131.awb") / 1000

					if var_254_18 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_18 + var_254_10
					end

					if var_254_13.prefab_name ~= "" and arg_251_1.actors_[var_254_13.prefab_name] ~= nil then
						local var_254_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_13.prefab_name].transform, "story_v_out_420131", "420131060", "story_v_out_420131.awb")

						arg_251_1:RecordAudio("420131060", var_254_19)
						arg_251_1:RecordAudio("420131060", var_254_19)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_420131", "420131060", "story_v_out_420131.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_420131", "420131060", "story_v_out_420131.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_20 = math.max(var_254_11, arg_251_1.talkMaxDuration)

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_20 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_10) / var_254_20

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_10 + var_254_20 and arg_251_1.time_ < var_254_10 + var_254_20 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play420131061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 420131061
		arg_255_1.duration_ = 2.37

		local var_255_0 = {
			zh = 1.533,
			ja = 2.366
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
				arg_255_0:Play420131062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["404001ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect404001ui_story == nil then
				arg_255_1.var_.characterEffect404001ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect404001ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect404001ui_story then
				arg_255_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["1043ui_story"]
			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1043ui_story == nil then
				arg_255_1.var_.characterEffect1043ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_6 = 0.200000002980232

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_6 and not isNil(var_258_4) then
				local var_258_7 = (arg_255_1.time_ - var_258_5) / var_258_6

				if arg_255_1.var_.characterEffect1043ui_story and not isNil(var_258_4) then
					local var_258_8 = Mathf.Lerp(0, 0.5, var_258_7)

					arg_255_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1043ui_story.fillRatio = var_258_8
				end
			end

			if arg_255_1.time_ >= var_258_5 + var_258_6 and arg_255_1.time_ < var_258_5 + var_258_6 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1043ui_story then
				local var_258_9 = 0.5

				arg_255_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1043ui_story.fillRatio = var_258_9
			end

			local var_258_10 = 0
			local var_258_11 = 0.15

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_12 = arg_255_1:FormatText(StoryNameCfg[668].name)

				arg_255_1.leftNameTxt_.text = var_258_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(420131061)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 6
				local var_258_16 = utf8.len(var_258_14)
				local var_258_17 = var_258_15 <= 0 and var_258_11 or var_258_11 * (var_258_16 / var_258_15)

				if var_258_17 > 0 and var_258_11 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_10
					end
				end

				arg_255_1.text_.text = var_258_14
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131061", "story_v_out_420131.awb") ~= 0 then
					local var_258_18 = manager.audio:GetVoiceLength("story_v_out_420131", "420131061", "story_v_out_420131.awb") / 1000

					if var_258_18 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_10
					end

					if var_258_13.prefab_name ~= "" and arg_255_1.actors_[var_258_13.prefab_name] ~= nil then
						local var_258_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_13.prefab_name].transform, "story_v_out_420131", "420131061", "story_v_out_420131.awb")

						arg_255_1:RecordAudio("420131061", var_258_19)
						arg_255_1:RecordAudio("420131061", var_258_19)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_420131", "420131061", "story_v_out_420131.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_420131", "420131061", "story_v_out_420131.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_20 = math.max(var_258_11, arg_255_1.talkMaxDuration)

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_20 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_10) / var_258_20

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_10 + var_258_20 and arg_255_1.time_ < var_258_10 + var_258_20 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play420131062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 420131062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play420131063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["404001ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos404001ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(0, 100, 0)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos404001ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, 100, 0)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["1043ui_story"].transform
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.var_.moveOldPos1043ui_story = var_262_9.localPosition
			end

			local var_262_11 = 0.001

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11
				local var_262_13 = Vector3.New(0, 100, 0)

				var_262_9.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1043ui_story, var_262_13, var_262_12)

				local var_262_14 = manager.ui.mainCamera.transform.position - var_262_9.position

				var_262_9.forward = Vector3.New(var_262_14.x, var_262_14.y, var_262_14.z)

				local var_262_15 = var_262_9.localEulerAngles

				var_262_15.z = 0
				var_262_15.x = 0
				var_262_9.localEulerAngles = var_262_15
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 then
				var_262_9.localPosition = Vector3.New(0, 100, 0)

				local var_262_16 = manager.ui.mainCamera.transform.position - var_262_9.position

				var_262_9.forward = Vector3.New(var_262_16.x, var_262_16.y, var_262_16.z)

				local var_262_17 = var_262_9.localEulerAngles

				var_262_17.z = 0
				var_262_17.x = 0
				var_262_9.localEulerAngles = var_262_17
			end

			local var_262_18 = arg_259_1.actors_["404001ui_story"]
			local var_262_19 = 0

			if var_262_19 < arg_259_1.time_ and arg_259_1.time_ <= var_262_19 + arg_262_0 and not isNil(var_262_18) and arg_259_1.var_.characterEffect404001ui_story == nil then
				arg_259_1.var_.characterEffect404001ui_story = var_262_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_20 = 0.200000002980232

			if var_262_19 <= arg_259_1.time_ and arg_259_1.time_ < var_262_19 + var_262_20 and not isNil(var_262_18) then
				local var_262_21 = (arg_259_1.time_ - var_262_19) / var_262_20

				if arg_259_1.var_.characterEffect404001ui_story and not isNil(var_262_18) then
					local var_262_22 = Mathf.Lerp(0, 0.5, var_262_21)

					arg_259_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_259_1.var_.characterEffect404001ui_story.fillRatio = var_262_22
				end
			end

			if arg_259_1.time_ >= var_262_19 + var_262_20 and arg_259_1.time_ < var_262_19 + var_262_20 + arg_262_0 and not isNil(var_262_18) and arg_259_1.var_.characterEffect404001ui_story then
				local var_262_23 = 0.5

				arg_259_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_259_1.var_.characterEffect404001ui_story.fillRatio = var_262_23
			end

			local var_262_24 = 0.05
			local var_262_25 = 1

			if var_262_24 < arg_259_1.time_ and arg_259_1.time_ <= var_262_24 + arg_262_0 then
				local var_262_26 = "play"
				local var_262_27 = "effect"

				arg_259_1:AudioAction(var_262_26, var_262_27, "se_story_140", "se_story_140_foley_paperbag03", "")
			end

			local var_262_28 = 0
			local var_262_29 = 1.25

			if var_262_28 < arg_259_1.time_ and arg_259_1.time_ <= var_262_28 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_30 = arg_259_1:GetWordFromCfg(420131062)
				local var_262_31 = arg_259_1:FormatText(var_262_30.content)

				arg_259_1.text_.text = var_262_31

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_32 = 50
				local var_262_33 = utf8.len(var_262_31)
				local var_262_34 = var_262_32 <= 0 and var_262_29 or var_262_29 * (var_262_33 / var_262_32)

				if var_262_34 > 0 and var_262_29 < var_262_34 then
					arg_259_1.talkMaxDuration = var_262_34

					if var_262_34 + var_262_28 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_34 + var_262_28
					end
				end

				arg_259_1.text_.text = var_262_31
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_35 = math.max(var_262_29, arg_259_1.talkMaxDuration)

			if var_262_28 <= arg_259_1.time_ and arg_259_1.time_ < var_262_28 + var_262_35 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_28) / var_262_35

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_28 + var_262_35 and arg_259_1.time_ < var_262_28 + var_262_35 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_259_1:InitPlayNodeList()
	end,
	Play420131063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 420131063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play420131064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 1.1

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

				local var_266_2 = arg_263_1:GetWordFromCfg(420131063)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 44
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
	Play420131064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 420131064
		arg_267_1.duration_ = 2.8

		local var_267_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_267_0:Play420131065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1085ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1085ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0, -1.01, -5.83)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1085ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = arg_267_1.actors_["1085ui_story"]
			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect1085ui_story == nil then
				arg_267_1.var_.characterEffect1085ui_story = var_270_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.200000002980232

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 and not isNil(var_270_9) then
				local var_270_12 = (arg_267_1.time_ - var_270_10) / var_270_11

				if arg_267_1.var_.characterEffect1085ui_story and not isNil(var_270_9) then
					arg_267_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect1085ui_story then
				arg_267_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_270_13 = 0

			if var_270_13 < arg_267_1.time_ and arg_267_1.time_ <= var_270_13 + arg_270_0 then
				arg_267_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_270_14 = 0

			if var_270_14 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 then
				arg_267_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_270_15 = 0
			local var_270_16 = 0.2

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				local var_270_17 = "play"
				local var_270_18 = "music"

				arg_267_1:AudioAction(var_270_17, var_270_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_270_19 = ""
				local var_270_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_270_20 ~= "" then
					if arg_267_1.bgmTxt_.text ~= var_270_20 and arg_267_1.bgmTxt_.text ~= "" then
						if arg_267_1.bgmTxt2_.text ~= "" then
							arg_267_1.bgmTxt_.text = arg_267_1.bgmTxt2_.text
						end

						arg_267_1.bgmTxt2_.text = var_270_20

						arg_267_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_267_1.bgmTxt_.text = var_270_20
						arg_267_1.bgmTxt2_.text = var_270_20
					end

					if arg_267_1.bgmTimer then
						arg_267_1.bgmTimer:Stop()

						arg_267_1.bgmTimer = nil
					end

					if arg_267_1.settingData.show_music_name == 1 then
						arg_267_1.musicController:SetSelectedState("show")
						arg_267_1.musicAnimator_:Play("open", 0, 0)

						if arg_267_1.settingData.music_time ~= 0 then
							arg_267_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_267_1.settingData.music_time), function()
								if arg_267_1 == nil or isNil(arg_267_1.bgmTxt_) then
									return
								end

								arg_267_1.musicController:SetSelectedState("hide")
								arg_267_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_270_21 = 0.333333333333333
			local var_270_22 = 1

			if var_270_21 < arg_267_1.time_ and arg_267_1.time_ <= var_270_21 + arg_270_0 then
				local var_270_23 = "play"
				local var_270_24 = "music"

				arg_267_1:AudioAction(var_270_23, var_270_24, "bgm_activity_4_0_story_loop_intense", "bgm_activity_4_0_story_loop_intense", "bgm_activity_4_0_story_loop_intense.awb")

				local var_270_25 = ""
				local var_270_26 = manager.audio:GetAudioName("bgm_activity_4_0_story_loop_intense", "bgm_activity_4_0_story_loop_intense")

				if var_270_26 ~= "" then
					if arg_267_1.bgmTxt_.text ~= var_270_26 and arg_267_1.bgmTxt_.text ~= "" then
						if arg_267_1.bgmTxt2_.text ~= "" then
							arg_267_1.bgmTxt_.text = arg_267_1.bgmTxt2_.text
						end

						arg_267_1.bgmTxt2_.text = var_270_26

						arg_267_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_267_1.bgmTxt_.text = var_270_26
						arg_267_1.bgmTxt2_.text = var_270_26
					end

					if arg_267_1.bgmTimer then
						arg_267_1.bgmTimer:Stop()

						arg_267_1.bgmTimer = nil
					end

					if arg_267_1.settingData.show_music_name == 1 then
						arg_267_1.musicController:SetSelectedState("show")
						arg_267_1.musicAnimator_:Play("open", 0, 0)

						if arg_267_1.settingData.music_time ~= 0 then
							arg_267_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_267_1.settingData.music_time), function()
								if arg_267_1 == nil or isNil(arg_267_1.bgmTxt_) then
									return
								end

								arg_267_1.musicController:SetSelectedState("hide")
								arg_267_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_270_27 = 0
			local var_270_28 = 0.175

			if var_270_27 < arg_267_1.time_ and arg_267_1.time_ <= var_270_27 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_29 = arg_267_1:FormatText(StoryNameCfg[328].name)

				arg_267_1.leftNameTxt_.text = var_270_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_30 = arg_267_1:GetWordFromCfg(420131064)
				local var_270_31 = arg_267_1:FormatText(var_270_30.content)

				arg_267_1.text_.text = var_270_31

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_32 = 7
				local var_270_33 = utf8.len(var_270_31)
				local var_270_34 = var_270_32 <= 0 and var_270_28 or var_270_28 * (var_270_33 / var_270_32)

				if var_270_34 > 0 and var_270_28 < var_270_34 then
					arg_267_1.talkMaxDuration = var_270_34

					if var_270_34 + var_270_27 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_34 + var_270_27
					end
				end

				arg_267_1.text_.text = var_270_31
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131064", "story_v_out_420131.awb") ~= 0 then
					local var_270_35 = manager.audio:GetVoiceLength("story_v_out_420131", "420131064", "story_v_out_420131.awb") / 1000

					if var_270_35 + var_270_27 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_35 + var_270_27
					end

					if var_270_30.prefab_name ~= "" and arg_267_1.actors_[var_270_30.prefab_name] ~= nil then
						local var_270_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_30.prefab_name].transform, "story_v_out_420131", "420131064", "story_v_out_420131.awb")

						arg_267_1:RecordAudio("420131064", var_270_36)
						arg_267_1:RecordAudio("420131064", var_270_36)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_420131", "420131064", "story_v_out_420131.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_420131", "420131064", "story_v_out_420131.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_37 = math.max(var_270_28, arg_267_1.talkMaxDuration)

			if var_270_27 <= arg_267_1.time_ and arg_267_1.time_ < var_270_27 + var_270_37 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_27) / var_270_37

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_27 + var_270_37 and arg_267_1.time_ < var_270_27 + var_270_37 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420131065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 420131065
		arg_273_1.duration_ = 5.6

		local var_273_0 = {
			zh = 4.3,
			ja = 5.6
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play420131066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["404001ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos404001ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0, -1.55, -5.5)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos404001ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1085ui_story"].transform
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1.var_.moveOldPos1085ui_story = var_276_9.localPosition
			end

			local var_276_11 = 0.001

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11
				local var_276_13 = Vector3.New(0, 100, 0)

				var_276_9.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1085ui_story, var_276_13, var_276_12)

				local var_276_14 = manager.ui.mainCamera.transform.position - var_276_9.position

				var_276_9.forward = Vector3.New(var_276_14.x, var_276_14.y, var_276_14.z)

				local var_276_15 = var_276_9.localEulerAngles

				var_276_15.z = 0
				var_276_15.x = 0
				var_276_9.localEulerAngles = var_276_15
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 then
				var_276_9.localPosition = Vector3.New(0, 100, 0)

				local var_276_16 = manager.ui.mainCamera.transform.position - var_276_9.position

				var_276_9.forward = Vector3.New(var_276_16.x, var_276_16.y, var_276_16.z)

				local var_276_17 = var_276_9.localEulerAngles

				var_276_17.z = 0
				var_276_17.x = 0
				var_276_9.localEulerAngles = var_276_17
			end

			local var_276_18 = arg_273_1.actors_["1085ui_story"]
			local var_276_19 = 0

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 and not isNil(var_276_18) and arg_273_1.var_.characterEffect1085ui_story == nil then
				arg_273_1.var_.characterEffect1085ui_story = var_276_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_20 = 0.200000002980232

			if var_276_19 <= arg_273_1.time_ and arg_273_1.time_ < var_276_19 + var_276_20 and not isNil(var_276_18) then
				local var_276_21 = (arg_273_1.time_ - var_276_19) / var_276_20

				if arg_273_1.var_.characterEffect1085ui_story and not isNil(var_276_18) then
					local var_276_22 = Mathf.Lerp(0, 0.5, var_276_21)

					arg_273_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1085ui_story.fillRatio = var_276_22
				end
			end

			if arg_273_1.time_ >= var_276_19 + var_276_20 and arg_273_1.time_ < var_276_19 + var_276_20 + arg_276_0 and not isNil(var_276_18) and arg_273_1.var_.characterEffect1085ui_story then
				local var_276_23 = 0.5

				arg_273_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1085ui_story.fillRatio = var_276_23
			end

			local var_276_24 = 0

			if var_276_24 < arg_273_1.time_ and arg_273_1.time_ <= var_276_24 + arg_276_0 then
				arg_273_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_25 = arg_273_1.actors_["1043ui_story"]
			local var_276_26 = 0

			if var_276_26 < arg_273_1.time_ and arg_273_1.time_ <= var_276_26 + arg_276_0 and not isNil(var_276_25) and arg_273_1.var_.characterEffect1043ui_story == nil then
				arg_273_1.var_.characterEffect1043ui_story = var_276_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_27 = 0.200000002980232

			if var_276_26 <= arg_273_1.time_ and arg_273_1.time_ < var_276_26 + var_276_27 and not isNil(var_276_25) then
				local var_276_28 = (arg_273_1.time_ - var_276_26) / var_276_27

				if arg_273_1.var_.characterEffect1043ui_story and not isNil(var_276_25) then
					local var_276_29 = Mathf.Lerp(0, 0.5, var_276_28)

					arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1043ui_story.fillRatio = var_276_29
				end
			end

			if arg_273_1.time_ >= var_276_26 + var_276_27 and arg_273_1.time_ < var_276_26 + var_276_27 + arg_276_0 and not isNil(var_276_25) and arg_273_1.var_.characterEffect1043ui_story then
				local var_276_30 = 0.5

				arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1043ui_story.fillRatio = var_276_30
			end

			local var_276_31 = arg_273_1.actors_["404001ui_story"]
			local var_276_32 = 0

			if var_276_32 < arg_273_1.time_ and arg_273_1.time_ <= var_276_32 + arg_276_0 and not isNil(var_276_31) and arg_273_1.var_.characterEffect404001ui_story == nil then
				arg_273_1.var_.characterEffect404001ui_story = var_276_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_33 = 0.200000002980232

			if var_276_32 <= arg_273_1.time_ and arg_273_1.time_ < var_276_32 + var_276_33 and not isNil(var_276_31) then
				local var_276_34 = (arg_273_1.time_ - var_276_32) / var_276_33

				if arg_273_1.var_.characterEffect404001ui_story and not isNil(var_276_31) then
					arg_273_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_32 + var_276_33 and arg_273_1.time_ < var_276_32 + var_276_33 + arg_276_0 and not isNil(var_276_31) and arg_273_1.var_.characterEffect404001ui_story then
				arg_273_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_276_35 = 0
			local var_276_36 = 0.425

			if var_276_35 < arg_273_1.time_ and arg_273_1.time_ <= var_276_35 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_37 = arg_273_1:FormatText(StoryNameCfg[668].name)

				arg_273_1.leftNameTxt_.text = var_276_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_38 = arg_273_1:GetWordFromCfg(420131065)
				local var_276_39 = arg_273_1:FormatText(var_276_38.content)

				arg_273_1.text_.text = var_276_39

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_40 = 17
				local var_276_41 = utf8.len(var_276_39)
				local var_276_42 = var_276_40 <= 0 and var_276_36 or var_276_36 * (var_276_41 / var_276_40)

				if var_276_42 > 0 and var_276_36 < var_276_42 then
					arg_273_1.talkMaxDuration = var_276_42

					if var_276_42 + var_276_35 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_42 + var_276_35
					end
				end

				arg_273_1.text_.text = var_276_39
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131065", "story_v_out_420131.awb") ~= 0 then
					local var_276_43 = manager.audio:GetVoiceLength("story_v_out_420131", "420131065", "story_v_out_420131.awb") / 1000

					if var_276_43 + var_276_35 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_43 + var_276_35
					end

					if var_276_38.prefab_name ~= "" and arg_273_1.actors_[var_276_38.prefab_name] ~= nil then
						local var_276_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_38.prefab_name].transform, "story_v_out_420131", "420131065", "story_v_out_420131.awb")

						arg_273_1:RecordAudio("420131065", var_276_44)
						arg_273_1:RecordAudio("420131065", var_276_44)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_420131", "420131065", "story_v_out_420131.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_420131", "420131065", "story_v_out_420131.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_45 = math.max(var_276_36, arg_273_1.talkMaxDuration)

			if var_276_35 <= arg_273_1.time_ and arg_273_1.time_ < var_276_35 + var_276_45 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_35) / var_276_45

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_35 + var_276_45 and arg_273_1.time_ < var_276_35 + var_276_45 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play420131066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 420131066
		arg_277_1.duration_ = 5.73

		local var_277_0 = {
			zh = 3.966,
			ja = 5.733
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play420131067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["404001ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos404001ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos404001ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1043ui_story"].transform
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1.var_.moveOldPos1043ui_story = var_280_9.localPosition
			end

			local var_280_11 = 0.001

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11
				local var_280_13 = Vector3.New(0.81, -1.01, -5.73)

				var_280_9.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1043ui_story, var_280_13, var_280_12)

				local var_280_14 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_14.x, var_280_14.y, var_280_14.z)

				local var_280_15 = var_280_9.localEulerAngles

				var_280_15.z = 0
				var_280_15.x = 0
				var_280_9.localEulerAngles = var_280_15
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 then
				var_280_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_280_16 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_16.x, var_280_16.y, var_280_16.z)

				local var_280_17 = var_280_9.localEulerAngles

				var_280_17.z = 0
				var_280_17.x = 0
				var_280_9.localEulerAngles = var_280_17
			end

			local var_280_18 = arg_277_1.actors_["1043ui_story"]
			local var_280_19 = 0

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 and not isNil(var_280_18) and arg_277_1.var_.characterEffect1043ui_story == nil then
				arg_277_1.var_.characterEffect1043ui_story = var_280_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_20 = 0.200000002980232

			if var_280_19 <= arg_277_1.time_ and arg_277_1.time_ < var_280_19 + var_280_20 and not isNil(var_280_18) then
				local var_280_21 = (arg_277_1.time_ - var_280_19) / var_280_20

				if arg_277_1.var_.characterEffect1043ui_story and not isNil(var_280_18) then
					arg_277_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_19 + var_280_20 and arg_277_1.time_ < var_280_19 + var_280_20 + arg_280_0 and not isNil(var_280_18) and arg_277_1.var_.characterEffect1043ui_story then
				arg_277_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_280_22 = arg_277_1.actors_["404001ui_story"]
			local var_280_23 = 0

			if var_280_23 < arg_277_1.time_ and arg_277_1.time_ <= var_280_23 + arg_280_0 and not isNil(var_280_22) and arg_277_1.var_.characterEffect404001ui_story == nil then
				arg_277_1.var_.characterEffect404001ui_story = var_280_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_24 = 0.200000002980232

			if var_280_23 <= arg_277_1.time_ and arg_277_1.time_ < var_280_23 + var_280_24 and not isNil(var_280_22) then
				local var_280_25 = (arg_277_1.time_ - var_280_23) / var_280_24

				if arg_277_1.var_.characterEffect404001ui_story and not isNil(var_280_22) then
					local var_280_26 = Mathf.Lerp(0, 0.5, var_280_25)

					arg_277_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_277_1.var_.characterEffect404001ui_story.fillRatio = var_280_26
				end
			end

			if arg_277_1.time_ >= var_280_23 + var_280_24 and arg_277_1.time_ < var_280_23 + var_280_24 + arg_280_0 and not isNil(var_280_22) and arg_277_1.var_.characterEffect404001ui_story then
				local var_280_27 = 0.5

				arg_277_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_277_1.var_.characterEffect404001ui_story.fillRatio = var_280_27
			end

			local var_280_28 = 0

			if var_280_28 < arg_277_1.time_ and arg_277_1.time_ <= var_280_28 + arg_280_0 then
				arg_277_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_280_29 = 0

			if var_280_29 < arg_277_1.time_ and arg_277_1.time_ <= var_280_29 + arg_280_0 then
				arg_277_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_280_30 = 0
			local var_280_31 = 0.4

			if var_280_30 < arg_277_1.time_ and arg_277_1.time_ <= var_280_30 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_32 = arg_277_1:FormatText(StoryNameCfg[1156].name)

				arg_277_1.leftNameTxt_.text = var_280_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_33 = arg_277_1:GetWordFromCfg(420131066)
				local var_280_34 = arg_277_1:FormatText(var_280_33.content)

				arg_277_1.text_.text = var_280_34

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_35 = 16
				local var_280_36 = utf8.len(var_280_34)
				local var_280_37 = var_280_35 <= 0 and var_280_31 or var_280_31 * (var_280_36 / var_280_35)

				if var_280_37 > 0 and var_280_31 < var_280_37 then
					arg_277_1.talkMaxDuration = var_280_37

					if var_280_37 + var_280_30 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_37 + var_280_30
					end
				end

				arg_277_1.text_.text = var_280_34
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131066", "story_v_out_420131.awb") ~= 0 then
					local var_280_38 = manager.audio:GetVoiceLength("story_v_out_420131", "420131066", "story_v_out_420131.awb") / 1000

					if var_280_38 + var_280_30 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_38 + var_280_30
					end

					if var_280_33.prefab_name ~= "" and arg_277_1.actors_[var_280_33.prefab_name] ~= nil then
						local var_280_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_33.prefab_name].transform, "story_v_out_420131", "420131066", "story_v_out_420131.awb")

						arg_277_1:RecordAudio("420131066", var_280_39)
						arg_277_1:RecordAudio("420131066", var_280_39)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_420131", "420131066", "story_v_out_420131.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_420131", "420131066", "story_v_out_420131.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_40 = math.max(var_280_31, arg_277_1.talkMaxDuration)

			if var_280_30 <= arg_277_1.time_ and arg_277_1.time_ < var_280_30 + var_280_40 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_30) / var_280_40

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_30 + var_280_40 and arg_277_1.time_ < var_280_30 + var_280_40 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_277_1:InitPlayNodeList()
	end,
	Play420131067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 420131067
		arg_281_1.duration_ = 7.47

		local var_281_0 = {
			zh = 4.933,
			ja = 7.466
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play420131068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1043ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1043ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 100, 0)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1043ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 100, 0)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["1085ui_story"].transform
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.var_.moveOldPos1085ui_story = var_284_9.localPosition
			end

			local var_284_11 = 0.001

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11
				local var_284_13 = Vector3.New(0, -1.01, -5.83)

				var_284_9.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1085ui_story, var_284_13, var_284_12)

				local var_284_14 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_14.x, var_284_14.y, var_284_14.z)

				local var_284_15 = var_284_9.localEulerAngles

				var_284_15.z = 0
				var_284_15.x = 0
				var_284_9.localEulerAngles = var_284_15
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 then
				var_284_9.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_284_16 = manager.ui.mainCamera.transform.position - var_284_9.position

				var_284_9.forward = Vector3.New(var_284_16.x, var_284_16.y, var_284_16.z)

				local var_284_17 = var_284_9.localEulerAngles

				var_284_17.z = 0
				var_284_17.x = 0
				var_284_9.localEulerAngles = var_284_17
			end

			local var_284_18 = arg_281_1.actors_["1085ui_story"]
			local var_284_19 = 0

			if var_284_19 < arg_281_1.time_ and arg_281_1.time_ <= var_284_19 + arg_284_0 and not isNil(var_284_18) and arg_281_1.var_.characterEffect1085ui_story == nil then
				arg_281_1.var_.characterEffect1085ui_story = var_284_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_20 = 0.200000002980232

			if var_284_19 <= arg_281_1.time_ and arg_281_1.time_ < var_284_19 + var_284_20 and not isNil(var_284_18) then
				local var_284_21 = (arg_281_1.time_ - var_284_19) / var_284_20

				if arg_281_1.var_.characterEffect1085ui_story and not isNil(var_284_18) then
					arg_281_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_19 + var_284_20 and arg_281_1.time_ < var_284_19 + var_284_20 + arg_284_0 and not isNil(var_284_18) and arg_281_1.var_.characterEffect1085ui_story then
				arg_281_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_284_22 = arg_281_1.actors_["1043ui_story"]
			local var_284_23 = 0

			if var_284_23 < arg_281_1.time_ and arg_281_1.time_ <= var_284_23 + arg_284_0 and not isNil(var_284_22) and arg_281_1.var_.characterEffect1043ui_story == nil then
				arg_281_1.var_.characterEffect1043ui_story = var_284_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_24 = 0.200000002980232

			if var_284_23 <= arg_281_1.time_ and arg_281_1.time_ < var_284_23 + var_284_24 and not isNil(var_284_22) then
				local var_284_25 = (arg_281_1.time_ - var_284_23) / var_284_24

				if arg_281_1.var_.characterEffect1043ui_story and not isNil(var_284_22) then
					local var_284_26 = Mathf.Lerp(0, 0.5, var_284_25)

					arg_281_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1043ui_story.fillRatio = var_284_26
				end
			end

			if arg_281_1.time_ >= var_284_23 + var_284_24 and arg_281_1.time_ < var_284_23 + var_284_24 + arg_284_0 and not isNil(var_284_22) and arg_281_1.var_.characterEffect1043ui_story then
				local var_284_27 = 0.5

				arg_281_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1043ui_story.fillRatio = var_284_27
			end

			local var_284_28 = 0

			if var_284_28 < arg_281_1.time_ and arg_281_1.time_ <= var_284_28 + arg_284_0 then
				arg_281_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_284_29 = 0

			if var_284_29 < arg_281_1.time_ and arg_281_1.time_ <= var_284_29 + arg_284_0 then
				arg_281_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_284_30 = arg_281_1.actors_["404001ui_story"].transform
			local var_284_31 = 0

			if var_284_31 < arg_281_1.time_ and arg_281_1.time_ <= var_284_31 + arg_284_0 then
				arg_281_1.var_.moveOldPos404001ui_story = var_284_30.localPosition
			end

			local var_284_32 = 0.001

			if var_284_31 <= arg_281_1.time_ and arg_281_1.time_ < var_284_31 + var_284_32 then
				local var_284_33 = (arg_281_1.time_ - var_284_31) / var_284_32
				local var_284_34 = Vector3.New(0, 100, 0)

				var_284_30.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos404001ui_story, var_284_34, var_284_33)

				local var_284_35 = manager.ui.mainCamera.transform.position - var_284_30.position

				var_284_30.forward = Vector3.New(var_284_35.x, var_284_35.y, var_284_35.z)

				local var_284_36 = var_284_30.localEulerAngles

				var_284_36.z = 0
				var_284_36.x = 0
				var_284_30.localEulerAngles = var_284_36
			end

			if arg_281_1.time_ >= var_284_31 + var_284_32 and arg_281_1.time_ < var_284_31 + var_284_32 + arg_284_0 then
				var_284_30.localPosition = Vector3.New(0, 100, 0)

				local var_284_37 = manager.ui.mainCamera.transform.position - var_284_30.position

				var_284_30.forward = Vector3.New(var_284_37.x, var_284_37.y, var_284_37.z)

				local var_284_38 = var_284_30.localEulerAngles

				var_284_38.z = 0
				var_284_38.x = 0
				var_284_30.localEulerAngles = var_284_38
			end

			local var_284_39 = 0
			local var_284_40 = 0.4

			if var_284_39 < arg_281_1.time_ and arg_281_1.time_ <= var_284_39 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_41 = arg_281_1:FormatText(StoryNameCfg[328].name)

				arg_281_1.leftNameTxt_.text = var_284_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_42 = arg_281_1:GetWordFromCfg(420131067)
				local var_284_43 = arg_281_1:FormatText(var_284_42.content)

				arg_281_1.text_.text = var_284_43

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_44 = 16
				local var_284_45 = utf8.len(var_284_43)
				local var_284_46 = var_284_44 <= 0 and var_284_40 or var_284_40 * (var_284_45 / var_284_44)

				if var_284_46 > 0 and var_284_40 < var_284_46 then
					arg_281_1.talkMaxDuration = var_284_46

					if var_284_46 + var_284_39 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_46 + var_284_39
					end
				end

				arg_281_1.text_.text = var_284_43
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131067", "story_v_out_420131.awb") ~= 0 then
					local var_284_47 = manager.audio:GetVoiceLength("story_v_out_420131", "420131067", "story_v_out_420131.awb") / 1000

					if var_284_47 + var_284_39 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_47 + var_284_39
					end

					if var_284_42.prefab_name ~= "" and arg_281_1.actors_[var_284_42.prefab_name] ~= nil then
						local var_284_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_42.prefab_name].transform, "story_v_out_420131", "420131067", "story_v_out_420131.awb")

						arg_281_1:RecordAudio("420131067", var_284_48)
						arg_281_1:RecordAudio("420131067", var_284_48)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_420131", "420131067", "story_v_out_420131.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_420131", "420131067", "story_v_out_420131.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_49 = math.max(var_284_40, arg_281_1.talkMaxDuration)

			if var_284_39 <= arg_281_1.time_ and arg_281_1.time_ < var_284_39 + var_284_49 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_39) / var_284_49

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_39 + var_284_49 and arg_281_1.time_ < var_284_39 + var_284_49 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
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

		arg_281_1:InitPlayNodeList()
	end,
	Play420131068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 420131068
		arg_285_1.duration_ = 7.4

		local var_285_0 = {
			zh = 3.966,
			ja = 7.4
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play420131069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["404001ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect404001ui_story == nil then
				arg_285_1.var_.characterEffect404001ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect404001ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect404001ui_story then
				arg_285_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["1085ui_story"]
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1085ui_story == nil then
				arg_285_1.var_.characterEffect1085ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 and not isNil(var_288_4) then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6

				if arg_285_1.var_.characterEffect1085ui_story and not isNil(var_288_4) then
					local var_288_8 = Mathf.Lerp(0, 0.5, var_288_7)

					arg_285_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1085ui_story.fillRatio = var_288_8
				end
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1085ui_story then
				local var_288_9 = 0.5

				arg_285_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1085ui_story.fillRatio = var_288_9
			end

			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_288_11 = arg_285_1.actors_["404001ui_story"].transform
			local var_288_12 = 0

			if var_288_12 < arg_285_1.time_ and arg_285_1.time_ <= var_288_12 + arg_288_0 then
				arg_285_1.var_.moveOldPos404001ui_story = var_288_11.localPosition
			end

			local var_288_13 = 0.001

			if var_288_12 <= arg_285_1.time_ and arg_285_1.time_ < var_288_12 + var_288_13 then
				local var_288_14 = (arg_285_1.time_ - var_288_12) / var_288_13
				local var_288_15 = Vector3.New(0, -1.55, -5.5)

				var_288_11.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos404001ui_story, var_288_15, var_288_14)

				local var_288_16 = manager.ui.mainCamera.transform.position - var_288_11.position

				var_288_11.forward = Vector3.New(var_288_16.x, var_288_16.y, var_288_16.z)

				local var_288_17 = var_288_11.localEulerAngles

				var_288_17.z = 0
				var_288_17.x = 0
				var_288_11.localEulerAngles = var_288_17
			end

			if arg_285_1.time_ >= var_288_12 + var_288_13 and arg_285_1.time_ < var_288_12 + var_288_13 + arg_288_0 then
				var_288_11.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_288_18 = manager.ui.mainCamera.transform.position - var_288_11.position

				var_288_11.forward = Vector3.New(var_288_18.x, var_288_18.y, var_288_18.z)

				local var_288_19 = var_288_11.localEulerAngles

				var_288_19.z = 0
				var_288_19.x = 0
				var_288_11.localEulerAngles = var_288_19
			end

			local var_288_20 = arg_285_1.actors_["1085ui_story"].transform
			local var_288_21 = 0

			if var_288_21 < arg_285_1.time_ and arg_285_1.time_ <= var_288_21 + arg_288_0 then
				arg_285_1.var_.moveOldPos1085ui_story = var_288_20.localPosition
			end

			local var_288_22 = 0.001

			if var_288_21 <= arg_285_1.time_ and arg_285_1.time_ < var_288_21 + var_288_22 then
				local var_288_23 = (arg_285_1.time_ - var_288_21) / var_288_22
				local var_288_24 = Vector3.New(0, 100, 0)

				var_288_20.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1085ui_story, var_288_24, var_288_23)

				local var_288_25 = manager.ui.mainCamera.transform.position - var_288_20.position

				var_288_20.forward = Vector3.New(var_288_25.x, var_288_25.y, var_288_25.z)

				local var_288_26 = var_288_20.localEulerAngles

				var_288_26.z = 0
				var_288_26.x = 0
				var_288_20.localEulerAngles = var_288_26
			end

			if arg_285_1.time_ >= var_288_21 + var_288_22 and arg_285_1.time_ < var_288_21 + var_288_22 + arg_288_0 then
				var_288_20.localPosition = Vector3.New(0, 100, 0)

				local var_288_27 = manager.ui.mainCamera.transform.position - var_288_20.position

				var_288_20.forward = Vector3.New(var_288_27.x, var_288_27.y, var_288_27.z)

				local var_288_28 = var_288_20.localEulerAngles

				var_288_28.z = 0
				var_288_28.x = 0
				var_288_20.localEulerAngles = var_288_28
			end

			local var_288_29 = 0
			local var_288_30 = 0.475

			if var_288_29 < arg_285_1.time_ and arg_285_1.time_ <= var_288_29 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_31 = arg_285_1:FormatText(StoryNameCfg[668].name)

				arg_285_1.leftNameTxt_.text = var_288_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_32 = arg_285_1:GetWordFromCfg(420131068)
				local var_288_33 = arg_285_1:FormatText(var_288_32.content)

				arg_285_1.text_.text = var_288_33

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_34 = 19
				local var_288_35 = utf8.len(var_288_33)
				local var_288_36 = var_288_34 <= 0 and var_288_30 or var_288_30 * (var_288_35 / var_288_34)

				if var_288_36 > 0 and var_288_30 < var_288_36 then
					arg_285_1.talkMaxDuration = var_288_36

					if var_288_36 + var_288_29 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_36 + var_288_29
					end
				end

				arg_285_1.text_.text = var_288_33
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131068", "story_v_out_420131.awb") ~= 0 then
					local var_288_37 = manager.audio:GetVoiceLength("story_v_out_420131", "420131068", "story_v_out_420131.awb") / 1000

					if var_288_37 + var_288_29 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_37 + var_288_29
					end

					if var_288_32.prefab_name ~= "" and arg_285_1.actors_[var_288_32.prefab_name] ~= nil then
						local var_288_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_32.prefab_name].transform, "story_v_out_420131", "420131068", "story_v_out_420131.awb")

						arg_285_1:RecordAudio("420131068", var_288_38)
						arg_285_1:RecordAudio("420131068", var_288_38)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_420131", "420131068", "story_v_out_420131.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_420131", "420131068", "story_v_out_420131.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_39 = math.max(var_288_30, arg_285_1.talkMaxDuration)

			if var_288_29 <= arg_285_1.time_ and arg_285_1.time_ < var_288_29 + var_288_39 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_29) / var_288_39

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_29 + var_288_39 and arg_285_1.time_ < var_288_29 + var_288_39 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play420131069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 420131069
		arg_289_1.duration_ = 7.67

		local var_289_0 = {
			zh = 5.466,
			ja = 7.666
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play420131070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1085ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1085ui_story == nil then
				arg_289_1.var_.characterEffect1085ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1085ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1085ui_story then
				arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_292_4 = arg_289_1.actors_["404001ui_story"]
			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect404001ui_story == nil then
				arg_289_1.var_.characterEffect404001ui_story = var_292_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.200000002980232

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 and not isNil(var_292_4) then
				local var_292_7 = (arg_289_1.time_ - var_292_5) / var_292_6

				if arg_289_1.var_.characterEffect404001ui_story and not isNil(var_292_4) then
					local var_292_8 = Mathf.Lerp(0, 0.5, var_292_7)

					arg_289_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_289_1.var_.characterEffect404001ui_story.fillRatio = var_292_8
				end
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect404001ui_story then
				local var_292_9 = 0.5

				arg_289_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_289_1.var_.characterEffect404001ui_story.fillRatio = var_292_9
			end

			local var_292_10 = arg_289_1.actors_["1085ui_story"].transform
			local var_292_11 = 0

			if var_292_11 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1.var_.moveOldPos1085ui_story = var_292_10.localPosition
			end

			local var_292_12 = 0.001

			if var_292_11 <= arg_289_1.time_ and arg_289_1.time_ < var_292_11 + var_292_12 then
				local var_292_13 = (arg_289_1.time_ - var_292_11) / var_292_12
				local var_292_14 = Vector3.New(0.75, -1.01, -5.83)

				var_292_10.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1085ui_story, var_292_14, var_292_13)

				local var_292_15 = manager.ui.mainCamera.transform.position - var_292_10.position

				var_292_10.forward = Vector3.New(var_292_15.x, var_292_15.y, var_292_15.z)

				local var_292_16 = var_292_10.localEulerAngles

				var_292_16.z = 0
				var_292_16.x = 0
				var_292_10.localEulerAngles = var_292_16
			end

			if arg_289_1.time_ >= var_292_11 + var_292_12 and arg_289_1.time_ < var_292_11 + var_292_12 + arg_292_0 then
				var_292_10.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_292_17 = manager.ui.mainCamera.transform.position - var_292_10.position

				var_292_10.forward = Vector3.New(var_292_17.x, var_292_17.y, var_292_17.z)

				local var_292_18 = var_292_10.localEulerAngles

				var_292_18.z = 0
				var_292_18.x = 0
				var_292_10.localEulerAngles = var_292_18
			end

			local var_292_19 = arg_289_1.actors_["404001ui_story"].transform
			local var_292_20 = 0

			if var_292_20 < arg_289_1.time_ and arg_289_1.time_ <= var_292_20 + arg_292_0 then
				arg_289_1.var_.moveOldPos404001ui_story = var_292_19.localPosition
			end

			local var_292_21 = 0.001

			if var_292_20 <= arg_289_1.time_ and arg_289_1.time_ < var_292_20 + var_292_21 then
				local var_292_22 = (arg_289_1.time_ - var_292_20) / var_292_21
				local var_292_23 = Vector3.New(-0.8, -1.55, -5.5)

				var_292_19.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos404001ui_story, var_292_23, var_292_22)

				local var_292_24 = manager.ui.mainCamera.transform.position - var_292_19.position

				var_292_19.forward = Vector3.New(var_292_24.x, var_292_24.y, var_292_24.z)

				local var_292_25 = var_292_19.localEulerAngles

				var_292_25.z = 0
				var_292_25.x = 0
				var_292_19.localEulerAngles = var_292_25
			end

			if arg_289_1.time_ >= var_292_20 + var_292_21 and arg_289_1.time_ < var_292_20 + var_292_21 + arg_292_0 then
				var_292_19.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_292_26 = manager.ui.mainCamera.transform.position - var_292_19.position

				var_292_19.forward = Vector3.New(var_292_26.x, var_292_26.y, var_292_26.z)

				local var_292_27 = var_292_19.localEulerAngles

				var_292_27.z = 0
				var_292_27.x = 0
				var_292_19.localEulerAngles = var_292_27
			end

			local var_292_28 = 0

			if var_292_28 < arg_289_1.time_ and arg_289_1.time_ <= var_292_28 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_292_29 = 0

			if var_292_29 < arg_289_1.time_ and arg_289_1.time_ <= var_292_29 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_292_30 = 0
			local var_292_31 = 0.45

			if var_292_30 < arg_289_1.time_ and arg_289_1.time_ <= var_292_30 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_32 = arg_289_1:FormatText(StoryNameCfg[328].name)

				arg_289_1.leftNameTxt_.text = var_292_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_33 = arg_289_1:GetWordFromCfg(420131069)
				local var_292_34 = arg_289_1:FormatText(var_292_33.content)

				arg_289_1.text_.text = var_292_34

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_35 = 18
				local var_292_36 = utf8.len(var_292_34)
				local var_292_37 = var_292_35 <= 0 and var_292_31 or var_292_31 * (var_292_36 / var_292_35)

				if var_292_37 > 0 and var_292_31 < var_292_37 then
					arg_289_1.talkMaxDuration = var_292_37

					if var_292_37 + var_292_30 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_37 + var_292_30
					end
				end

				arg_289_1.text_.text = var_292_34
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131069", "story_v_out_420131.awb") ~= 0 then
					local var_292_38 = manager.audio:GetVoiceLength("story_v_out_420131", "420131069", "story_v_out_420131.awb") / 1000

					if var_292_38 + var_292_30 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_38 + var_292_30
					end

					if var_292_33.prefab_name ~= "" and arg_289_1.actors_[var_292_33.prefab_name] ~= nil then
						local var_292_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_33.prefab_name].transform, "story_v_out_420131", "420131069", "story_v_out_420131.awb")

						arg_289_1:RecordAudio("420131069", var_292_39)
						arg_289_1:RecordAudio("420131069", var_292_39)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_420131", "420131069", "story_v_out_420131.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_420131", "420131069", "story_v_out_420131.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_40 = math.max(var_292_31, arg_289_1.talkMaxDuration)

			if var_292_30 <= arg_289_1.time_ and arg_289_1.time_ < var_292_30 + var_292_40 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_30) / var_292_40

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_30 + var_292_40 and arg_289_1.time_ < var_292_30 + var_292_40 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_289_1:InitPlayNodeList()
	end,
	Play420131070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 420131070
		arg_293_1.duration_ = 7

		local var_293_0 = {
			zh = 6.133,
			ja = 7
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play420131071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["404001ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect404001ui_story == nil then
				arg_293_1.var_.characterEffect404001ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect404001ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect404001ui_story then
				arg_293_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_296_4 = arg_293_1.actors_["1085ui_story"]
			local var_296_5 = 0

			if var_296_5 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1085ui_story == nil then
				arg_293_1.var_.characterEffect1085ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_6 = 0.200000002980232

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_6 and not isNil(var_296_4) then
				local var_296_7 = (arg_293_1.time_ - var_296_5) / var_296_6

				if arg_293_1.var_.characterEffect1085ui_story and not isNil(var_296_4) then
					local var_296_8 = Mathf.Lerp(0, 0.5, var_296_7)

					arg_293_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1085ui_story.fillRatio = var_296_8
				end
			end

			if arg_293_1.time_ >= var_296_5 + var_296_6 and arg_293_1.time_ < var_296_5 + var_296_6 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1085ui_story then
				local var_296_9 = 0.5

				arg_293_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1085ui_story.fillRatio = var_296_9
			end

			local var_296_10 = 0
			local var_296_11 = 0.375

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_12 = arg_293_1:FormatText(StoryNameCfg[668].name)

				arg_293_1.leftNameTxt_.text = var_296_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_13 = arg_293_1:GetWordFromCfg(420131070)
				local var_296_14 = arg_293_1:FormatText(var_296_13.content)

				arg_293_1.text_.text = var_296_14

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_15 = 15
				local var_296_16 = utf8.len(var_296_14)
				local var_296_17 = var_296_15 <= 0 and var_296_11 or var_296_11 * (var_296_16 / var_296_15)

				if var_296_17 > 0 and var_296_11 < var_296_17 then
					arg_293_1.talkMaxDuration = var_296_17

					if var_296_17 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_17 + var_296_10
					end
				end

				arg_293_1.text_.text = var_296_14
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131070", "story_v_out_420131.awb") ~= 0 then
					local var_296_18 = manager.audio:GetVoiceLength("story_v_out_420131", "420131070", "story_v_out_420131.awb") / 1000

					if var_296_18 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_18 + var_296_10
					end

					if var_296_13.prefab_name ~= "" and arg_293_1.actors_[var_296_13.prefab_name] ~= nil then
						local var_296_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_13.prefab_name].transform, "story_v_out_420131", "420131070", "story_v_out_420131.awb")

						arg_293_1:RecordAudio("420131070", var_296_19)
						arg_293_1:RecordAudio("420131070", var_296_19)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_420131", "420131070", "story_v_out_420131.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_420131", "420131070", "story_v_out_420131.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_20 = math.max(var_296_11, arg_293_1.talkMaxDuration)

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_20 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_10) / var_296_20

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_10 + var_296_20 and arg_293_1.time_ < var_296_10 + var_296_20 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play420131071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 420131071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play420131072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["404001ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos404001ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, 100, 0)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos404001ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, 100, 0)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["1085ui_story"].transform
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.var_.moveOldPos1085ui_story = var_300_9.localPosition
			end

			local var_300_11 = 0.001

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11
				local var_300_13 = Vector3.New(0, 100, 0)

				var_300_9.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1085ui_story, var_300_13, var_300_12)

				local var_300_14 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_14.x, var_300_14.y, var_300_14.z)

				local var_300_15 = var_300_9.localEulerAngles

				var_300_15.z = 0
				var_300_15.x = 0
				var_300_9.localEulerAngles = var_300_15
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 then
				var_300_9.localPosition = Vector3.New(0, 100, 0)

				local var_300_16 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_16.x, var_300_16.y, var_300_16.z)

				local var_300_17 = var_300_9.localEulerAngles

				var_300_17.z = 0
				var_300_17.x = 0
				var_300_9.localEulerAngles = var_300_17
			end

			local var_300_18 = 0
			local var_300_19 = 0.7

			if var_300_18 < arg_297_1.time_ and arg_297_1.time_ <= var_300_18 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_20 = arg_297_1:GetWordFromCfg(420131071)
				local var_300_21 = arg_297_1:FormatText(var_300_20.content)

				arg_297_1.text_.text = var_300_21

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_22 = 28
				local var_300_23 = utf8.len(var_300_21)
				local var_300_24 = var_300_22 <= 0 and var_300_19 or var_300_19 * (var_300_23 / var_300_22)

				if var_300_24 > 0 and var_300_19 < var_300_24 then
					arg_297_1.talkMaxDuration = var_300_24

					if var_300_24 + var_300_18 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_18
					end
				end

				arg_297_1.text_.text = var_300_21
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_25 = math.max(var_300_19, arg_297_1.talkMaxDuration)

			if var_300_18 <= arg_297_1.time_ and arg_297_1.time_ < var_300_18 + var_300_25 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_18) / var_300_25

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_18 + var_300_25 and arg_297_1.time_ < var_300_18 + var_300_25 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play420131072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 420131072
		arg_301_1.duration_ = 11.8

		local var_301_0 = {
			zh = 8.633,
			ja = 11.8
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play420131073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["404001ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos404001ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, -1.55, -5.5)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos404001ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["404001ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect404001ui_story == nil then
				arg_301_1.var_.characterEffect404001ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect404001ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect404001ui_story then
				arg_301_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_304_15 = 0
			local var_304_16 = 1.1

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[668].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(420131072)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 44
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131072", "story_v_out_420131.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_out_420131", "420131072", "story_v_out_420131.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_out_420131", "420131072", "story_v_out_420131.awb")

						arg_301_1:RecordAudio("420131072", var_304_24)
						arg_301_1:RecordAudio("420131072", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_420131", "420131072", "story_v_out_420131.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_420131", "420131072", "story_v_out_420131.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play420131073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 420131073
		arg_305_1.duration_ = 6.13

		local var_305_0 = {
			zh = 3.8,
			ja = 6.133
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play420131074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.45

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[668].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(420131073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 18
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131073", "story_v_out_420131.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_420131", "420131073", "story_v_out_420131.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_420131", "420131073", "story_v_out_420131.awb")

						arg_305_1:RecordAudio("420131073", var_308_9)
						arg_305_1:RecordAudio("420131073", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_420131", "420131073", "story_v_out_420131.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_420131", "420131073", "story_v_out_420131.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play420131074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 420131074
		arg_309_1.duration_ = 2

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play420131075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["404001ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos404001ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(-0.8, -1.55, -5.5)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos404001ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(-0.8, -1.55, -5.5)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["1043ui_story"].transform
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				arg_309_1.var_.moveOldPos1043ui_story = var_312_9.localPosition

				local var_312_11 = "1043ui_story"

				arg_309_1:ShowWeapon(arg_309_1.var_[var_312_11 .. "Animator"].transform, false)
			end

			local var_312_12 = 0.001

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_12 then
				local var_312_13 = (arg_309_1.time_ - var_312_10) / var_312_12
				local var_312_14 = Vector3.New(0.81, -1.01, -5.73)

				var_312_9.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1043ui_story, var_312_14, var_312_13)

				local var_312_15 = manager.ui.mainCamera.transform.position - var_312_9.position

				var_312_9.forward = Vector3.New(var_312_15.x, var_312_15.y, var_312_15.z)

				local var_312_16 = var_312_9.localEulerAngles

				var_312_16.z = 0
				var_312_16.x = 0
				var_312_9.localEulerAngles = var_312_16
			end

			if arg_309_1.time_ >= var_312_10 + var_312_12 and arg_309_1.time_ < var_312_10 + var_312_12 + arg_312_0 then
				var_312_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_312_17 = manager.ui.mainCamera.transform.position - var_312_9.position

				var_312_9.forward = Vector3.New(var_312_17.x, var_312_17.y, var_312_17.z)

				local var_312_18 = var_312_9.localEulerAngles

				var_312_18.z = 0
				var_312_18.x = 0
				var_312_9.localEulerAngles = var_312_18
			end

			local var_312_19 = arg_309_1.actors_["1043ui_story"]
			local var_312_20 = 0

			if var_312_20 < arg_309_1.time_ and arg_309_1.time_ <= var_312_20 + arg_312_0 and not isNil(var_312_19) and arg_309_1.var_.characterEffect1043ui_story == nil then
				arg_309_1.var_.characterEffect1043ui_story = var_312_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_21 = 0.200000002980232

			if var_312_20 <= arg_309_1.time_ and arg_309_1.time_ < var_312_20 + var_312_21 and not isNil(var_312_19) then
				local var_312_22 = (arg_309_1.time_ - var_312_20) / var_312_21

				if arg_309_1.var_.characterEffect1043ui_story and not isNil(var_312_19) then
					arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_20 + var_312_21 and arg_309_1.time_ < var_312_20 + var_312_21 + arg_312_0 and not isNil(var_312_19) and arg_309_1.var_.characterEffect1043ui_story then
				arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_312_23 = arg_309_1.actors_["404001ui_story"]
			local var_312_24 = 0

			if var_312_24 < arg_309_1.time_ and arg_309_1.time_ <= var_312_24 + arg_312_0 and not isNil(var_312_23) and arg_309_1.var_.characterEffect404001ui_story == nil then
				arg_309_1.var_.characterEffect404001ui_story = var_312_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_25 = 0.200000002980232

			if var_312_24 <= arg_309_1.time_ and arg_309_1.time_ < var_312_24 + var_312_25 and not isNil(var_312_23) then
				local var_312_26 = (arg_309_1.time_ - var_312_24) / var_312_25

				if arg_309_1.var_.characterEffect404001ui_story and not isNil(var_312_23) then
					local var_312_27 = Mathf.Lerp(0, 0.5, var_312_26)

					arg_309_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_309_1.var_.characterEffect404001ui_story.fillRatio = var_312_27
				end
			end

			if arg_309_1.time_ >= var_312_24 + var_312_25 and arg_309_1.time_ < var_312_24 + var_312_25 + arg_312_0 and not isNil(var_312_23) and arg_309_1.var_.characterEffect404001ui_story then
				local var_312_28 = 0.5

				arg_309_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_309_1.var_.characterEffect404001ui_story.fillRatio = var_312_28
			end

			local var_312_29 = 0

			if var_312_29 < arg_309_1.time_ and arg_309_1.time_ <= var_312_29 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action3_1")
			end

			local var_312_30 = 0

			if var_312_30 < arg_309_1.time_ and arg_309_1.time_ <= var_312_30 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_312_31 = 0
			local var_312_32 = 0.1

			if var_312_31 < arg_309_1.time_ and arg_309_1.time_ <= var_312_31 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_33 = arg_309_1:FormatText(StoryNameCfg[1156].name)

				arg_309_1.leftNameTxt_.text = var_312_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_34 = arg_309_1:GetWordFromCfg(420131074)
				local var_312_35 = arg_309_1:FormatText(var_312_34.content)

				arg_309_1.text_.text = var_312_35

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_36 = 4
				local var_312_37 = utf8.len(var_312_35)
				local var_312_38 = var_312_36 <= 0 and var_312_32 or var_312_32 * (var_312_37 / var_312_36)

				if var_312_38 > 0 and var_312_32 < var_312_38 then
					arg_309_1.talkMaxDuration = var_312_38

					if var_312_38 + var_312_31 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_38 + var_312_31
					end
				end

				arg_309_1.text_.text = var_312_35
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131074", "story_v_out_420131.awb") ~= 0 then
					local var_312_39 = manager.audio:GetVoiceLength("story_v_out_420131", "420131074", "story_v_out_420131.awb") / 1000

					if var_312_39 + var_312_31 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_39 + var_312_31
					end

					if var_312_34.prefab_name ~= "" and arg_309_1.actors_[var_312_34.prefab_name] ~= nil then
						local var_312_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_34.prefab_name].transform, "story_v_out_420131", "420131074", "story_v_out_420131.awb")

						arg_309_1:RecordAudio("420131074", var_312_40)
						arg_309_1:RecordAudio("420131074", var_312_40)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_420131", "420131074", "story_v_out_420131.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_420131", "420131074", "story_v_out_420131.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_41 = math.max(var_312_32, arg_309_1.talkMaxDuration)

			if var_312_31 <= arg_309_1.time_ and arg_309_1.time_ < var_312_31 + var_312_41 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_31) / var_312_41

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_31 + var_312_41 and arg_309_1.time_ < var_312_31 + var_312_41 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_309_1:InitPlayNodeList()
	end,
	Play420131075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 420131075
		arg_313_1.duration_ = 1.4

		local var_313_0 = {
			zh = 1.1,
			ja = 1.4
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play420131076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["404001ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect404001ui_story == nil then
				arg_313_1.var_.characterEffect404001ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect404001ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect404001ui_story then
				arg_313_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_316_4 = arg_313_1.actors_["1043ui_story"]
			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_6 and not isNil(var_316_4) then
				local var_316_7 = (arg_313_1.time_ - var_316_5) / var_316_6

				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_4) then
					local var_316_8 = Mathf.Lerp(0, 0.5, var_316_7)

					arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1043ui_story.fillRatio = var_316_8
				end
			end

			if arg_313_1.time_ >= var_316_5 + var_316_6 and arg_313_1.time_ < var_316_5 + var_316_6 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect1043ui_story then
				local var_316_9 = 0.5

				arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1043ui_story.fillRatio = var_316_9
			end

			local var_316_10 = 0
			local var_316_11 = 0.125

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_12 = arg_313_1:FormatText(StoryNameCfg[668].name)

				arg_313_1.leftNameTxt_.text = var_316_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_13 = arg_313_1:GetWordFromCfg(420131075)
				local var_316_14 = arg_313_1:FormatText(var_316_13.content)

				arg_313_1.text_.text = var_316_14

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_15 = 5
				local var_316_16 = utf8.len(var_316_14)
				local var_316_17 = var_316_15 <= 0 and var_316_11 or var_316_11 * (var_316_16 / var_316_15)

				if var_316_17 > 0 and var_316_11 < var_316_17 then
					arg_313_1.talkMaxDuration = var_316_17

					if var_316_17 + var_316_10 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_17 + var_316_10
					end
				end

				arg_313_1.text_.text = var_316_14
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131075", "story_v_out_420131.awb") ~= 0 then
					local var_316_18 = manager.audio:GetVoiceLength("story_v_out_420131", "420131075", "story_v_out_420131.awb") / 1000

					if var_316_18 + var_316_10 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_18 + var_316_10
					end

					if var_316_13.prefab_name ~= "" and arg_313_1.actors_[var_316_13.prefab_name] ~= nil then
						local var_316_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_13.prefab_name].transform, "story_v_out_420131", "420131075", "story_v_out_420131.awb")

						arg_313_1:RecordAudio("420131075", var_316_19)
						arg_313_1:RecordAudio("420131075", var_316_19)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_420131", "420131075", "story_v_out_420131.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_420131", "420131075", "story_v_out_420131.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_20 = math.max(var_316_11, arg_313_1.talkMaxDuration)

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_20 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_10) / var_316_20

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_10 + var_316_20 and arg_313_1.time_ < var_316_10 + var_316_20 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play420131076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 420131076
		arg_317_1.duration_ = 8.4

		local var_317_0 = {
			zh = 6.266,
			ja = 8.4
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play420131077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1043ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1043ui_story == nil then
				arg_317_1.var_.characterEffect1043ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1043ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1043ui_story then
				arg_317_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_320_4 = arg_317_1.actors_["404001ui_story"]
			local var_320_5 = 0

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect404001ui_story == nil then
				arg_317_1.var_.characterEffect404001ui_story = var_320_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_6 = 0.200000002980232

			if var_320_5 <= arg_317_1.time_ and arg_317_1.time_ < var_320_5 + var_320_6 and not isNil(var_320_4) then
				local var_320_7 = (arg_317_1.time_ - var_320_5) / var_320_6

				if arg_317_1.var_.characterEffect404001ui_story and not isNil(var_320_4) then
					local var_320_8 = Mathf.Lerp(0, 0.5, var_320_7)

					arg_317_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_317_1.var_.characterEffect404001ui_story.fillRatio = var_320_8
				end
			end

			if arg_317_1.time_ >= var_320_5 + var_320_6 and arg_317_1.time_ < var_320_5 + var_320_6 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect404001ui_story then
				local var_320_9 = 0.5

				arg_317_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_317_1.var_.characterEffect404001ui_story.fillRatio = var_320_9
			end

			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 then
				arg_317_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043actionlink/1043action435")
			end

			local var_320_11 = 0

			if var_320_11 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_320_12 = 0
			local var_320_13 = 0.8

			if var_320_12 < arg_317_1.time_ and arg_317_1.time_ <= var_320_12 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_14 = arg_317_1:FormatText(StoryNameCfg[1156].name)

				arg_317_1.leftNameTxt_.text = var_320_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_15 = arg_317_1:GetWordFromCfg(420131076)
				local var_320_16 = arg_317_1:FormatText(var_320_15.content)

				arg_317_1.text_.text = var_320_16

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_17 = 32
				local var_320_18 = utf8.len(var_320_16)
				local var_320_19 = var_320_17 <= 0 and var_320_13 or var_320_13 * (var_320_18 / var_320_17)

				if var_320_19 > 0 and var_320_13 < var_320_19 then
					arg_317_1.talkMaxDuration = var_320_19

					if var_320_19 + var_320_12 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_19 + var_320_12
					end
				end

				arg_317_1.text_.text = var_320_16
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131076", "story_v_out_420131.awb") ~= 0 then
					local var_320_20 = manager.audio:GetVoiceLength("story_v_out_420131", "420131076", "story_v_out_420131.awb") / 1000

					if var_320_20 + var_320_12 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_20 + var_320_12
					end

					if var_320_15.prefab_name ~= "" and arg_317_1.actors_[var_320_15.prefab_name] ~= nil then
						local var_320_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_15.prefab_name].transform, "story_v_out_420131", "420131076", "story_v_out_420131.awb")

						arg_317_1:RecordAudio("420131076", var_320_21)
						arg_317_1:RecordAudio("420131076", var_320_21)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_420131", "420131076", "story_v_out_420131.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_420131", "420131076", "story_v_out_420131.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_22 = math.max(var_320_13, arg_317_1.talkMaxDuration)

			if var_320_12 <= arg_317_1.time_ and arg_317_1.time_ < var_320_12 + var_320_22 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_12) / var_320_22

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_12 + var_320_22 and arg_317_1.time_ < var_320_12 + var_320_22 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play420131077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 420131077
		arg_321_1.duration_ = 4.7

		local var_321_0 = {
			zh = 4.233,
			ja = 4.7
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
			arg_321_1.auto_ = false
		end

		function arg_321_1.playNext_(arg_323_0)
			arg_321_1.onStoryFinished_()
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_324_1 = 0
			local var_324_2 = 0.45

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_3 = arg_321_1:FormatText(StoryNameCfg[1156].name)

				arg_321_1.leftNameTxt_.text = var_324_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(420131077)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_6 = 18
				local var_324_7 = utf8.len(var_324_5)
				local var_324_8 = var_324_6 <= 0 and var_324_2 or var_324_2 * (var_324_7 / var_324_6)

				if var_324_8 > 0 and var_324_2 < var_324_8 then
					arg_321_1.talkMaxDuration = var_324_8

					if var_324_8 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420131", "420131077", "story_v_out_420131.awb") ~= 0 then
					local var_324_9 = manager.audio:GetVoiceLength("story_v_out_420131", "420131077", "story_v_out_420131.awb") / 1000

					if var_324_9 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_1
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_out_420131", "420131077", "story_v_out_420131.awb")

						arg_321_1:RecordAudio("420131077", var_324_10)
						arg_321_1:RecordAudio("420131077", var_324_10)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_420131", "420131077", "story_v_out_420131.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_420131", "420131077", "story_v_out_420131.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_11 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_11 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_11

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_11 and arg_321_1.time_ < var_324_1 + var_324_11 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0504a",
		"TextureConfig/Background/ST0505a",
		"TextureConfig/Background/ST76",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST0505"
	},
	voices = {
		"story_v_out_420131.awb"
	}
}
