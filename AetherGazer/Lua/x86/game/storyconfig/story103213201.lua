return {
	Play321321001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321321001
		arg_1_1.duration_ = 5.4

		local var_1_0 = {
			zh = 3.799999999999,
			ja = 5.4
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
				arg_1_0:Play321321002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L08f"

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
				local var_4_5 = arg_1_1.bgs_.L08f

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
					if iter_4_0 ~= "L08f" then
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

			local var_4_24 = "1061ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1061ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1061ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.18, -6.15)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1061ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1061ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1061ui_story == nil then
				arg_1_1.var_.characterEffect1061ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1061ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1061ui_story then
				arg_1_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

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

			local var_4_56 = 0.1
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 2
			local var_4_61 = 0.25

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[612].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(321321001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 10
				local var_4_67 = utf8.len(var_4_65)
				local var_4_68 = var_4_66 <= 0 and var_4_61 or var_4_61 * (var_4_67 / var_4_66)

				if var_4_68 > 0 and var_4_61 < var_4_68 then
					arg_1_1.talkMaxDuration = var_4_68
					var_4_60 = var_4_60 + 0.3

					if var_4_68 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_60
					end
				end

				arg_1_1.text_.text = var_4_65
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321001", "story_v_out_321321.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_321321", "321321001", "story_v_out_321321.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_321321", "321321001", "story_v_out_321321.awb")

						arg_1_1:RecordAudio("321321001", var_4_70)
						arg_1_1:RecordAudio("321321001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321321", "321321001", "story_v_out_321321.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321321", "321321001", "story_v_out_321321.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_71 = var_4_60 + 0.3
			local var_4_72 = math.max(var_4_61, arg_1_1.talkMaxDuration)

			if var_4_71 <= arg_1_1.time_ and arg_1_1.time_ < var_4_71 + var_4_72 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_71) / var_4_72

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_71 + var_4_72 and arg_1_1.time_ < var_4_71 + var_4_72 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play321321002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321321002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321321003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1061ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, 100, 0)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = arg_9_1.actors_["1061ui_story"]
			local var_12_10 = 0

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1061ui_story == nil then
				arg_9_1.var_.characterEffect1061ui_story = var_12_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_11 and not isNil(var_12_9) then
				local var_12_12 = (arg_9_1.time_ - var_12_10) / var_12_11

				if arg_9_1.var_.characterEffect1061ui_story and not isNil(var_12_9) then
					local var_12_13 = Mathf.Lerp(0, 0.5, var_12_12)

					arg_9_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1061ui_story.fillRatio = var_12_13
				end
			end

			if arg_9_1.time_ >= var_12_10 + var_12_11 and arg_9_1.time_ < var_12_10 + var_12_11 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1061ui_story then
				local var_12_14 = 0.5

				arg_9_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1061ui_story.fillRatio = var_12_14
			end

			local var_12_15 = 0
			local var_12_16 = 1.625

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_17 = arg_9_1:GetWordFromCfg(321321002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 65
				local var_12_20 = utf8.len(var_12_18)
				local var_12_21 = var_12_19 <= 0 and var_12_16 or var_12_16 * (var_12_20 / var_12_19)

				if var_12_21 > 0 and var_12_16 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_18
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_22 and arg_9_1.time_ < var_12_15 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321321003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321321003
		arg_13_1.duration_ = 3.2

		local var_13_0 = {
			zh = 3.2,
			ja = 2.4
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
				arg_13_0:Play321321004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1061ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1061ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1061ui_story == nil then
				arg_13_1.var_.characterEffect1061ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1061ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1061ui_story then
				arg_13_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_15 = 0
			local var_16_16 = 0.2

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[612].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(321321003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 8
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321003", "story_v_out_321321.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_321321", "321321003", "story_v_out_321321.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_321321", "321321003", "story_v_out_321321.awb")

						arg_13_1:RecordAudio("321321003", var_16_24)
						arg_13_1:RecordAudio("321321003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321321", "321321003", "story_v_out_321321.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321321", "321321003", "story_v_out_321321.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321321004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321321004
		arg_17_1.duration_ = 5.43

		local var_17_0 = {
			zh = 4.133,
			ja = 5.433
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
				arg_17_0:Play321321005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1156ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["1156ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1156ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.9, -1.1, -6.18)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1156ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["1061ui_story"].transform
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061ui_story = var_20_14.localPosition
			end

			local var_20_16 = 0.001

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16
				local var_20_18 = Vector3.New(-0.7, -1.18, -6.15)

				var_20_14.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061ui_story, var_20_18, var_20_17)

				local var_20_19 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_19.x, var_20_19.y, var_20_19.z)

				local var_20_20 = var_20_14.localEulerAngles

				var_20_20.z = 0
				var_20_20.x = 0
				var_20_14.localEulerAngles = var_20_20
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				var_20_14.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_20_21 = manager.ui.mainCamera.transform.position - var_20_14.position

				var_20_14.forward = Vector3.New(var_20_21.x, var_20_21.y, var_20_21.z)

				local var_20_22 = var_20_14.localEulerAngles

				var_20_22.z = 0
				var_20_22.x = 0
				var_20_14.localEulerAngles = var_20_22
			end

			local var_20_23 = arg_17_1.actors_["1156ui_story"]
			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect1156ui_story == nil then
				arg_17_1.var_.characterEffect1156ui_story = var_20_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_25 = 0.200000002980232

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_25 and not isNil(var_20_23) then
				local var_20_26 = (arg_17_1.time_ - var_20_24) / var_20_25

				if arg_17_1.var_.characterEffect1156ui_story and not isNil(var_20_23) then
					arg_17_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_24 + var_20_25 and arg_17_1.time_ < var_20_24 + var_20_25 + arg_20_0 and not isNil(var_20_23) and arg_17_1.var_.characterEffect1156ui_story then
				arg_17_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_20_27 = arg_17_1.actors_["1061ui_story"]
			local var_20_28 = 0

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 and not isNil(var_20_27) and arg_17_1.var_.characterEffect1061ui_story == nil then
				arg_17_1.var_.characterEffect1061ui_story = var_20_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_29 = 0.200000002980232

			if var_20_28 <= arg_17_1.time_ and arg_17_1.time_ < var_20_28 + var_20_29 and not isNil(var_20_27) then
				local var_20_30 = (arg_17_1.time_ - var_20_28) / var_20_29

				if arg_17_1.var_.characterEffect1061ui_story and not isNil(var_20_27) then
					local var_20_31 = Mathf.Lerp(0, 0.5, var_20_30)

					arg_17_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1061ui_story.fillRatio = var_20_31
				end
			end

			if arg_17_1.time_ >= var_20_28 + var_20_29 and arg_17_1.time_ < var_20_28 + var_20_29 + arg_20_0 and not isNil(var_20_27) and arg_17_1.var_.characterEffect1061ui_story then
				local var_20_32 = 0.5

				arg_17_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1061ui_story.fillRatio = var_20_32
			end

			local var_20_33 = 0

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				arg_17_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_20_34 = 0

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_20_35 = 0
			local var_20_36 = 0.55

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_37 = arg_17_1:FormatText(StoryNameCfg[605].name)

				arg_17_1.leftNameTxt_.text = var_20_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_38 = arg_17_1:GetWordFromCfg(321321004)
				local var_20_39 = arg_17_1:FormatText(var_20_38.content)

				arg_17_1.text_.text = var_20_39

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_40 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321004", "story_v_out_321321.awb") ~= 0 then
					local var_20_43 = manager.audio:GetVoiceLength("story_v_out_321321", "321321004", "story_v_out_321321.awb") / 1000

					if var_20_43 + var_20_35 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_43 + var_20_35
					end

					if var_20_38.prefab_name ~= "" and arg_17_1.actors_[var_20_38.prefab_name] ~= nil then
						local var_20_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_38.prefab_name].transform, "story_v_out_321321", "321321004", "story_v_out_321321.awb")

						arg_17_1:RecordAudio("321321004", var_20_44)
						arg_17_1:RecordAudio("321321004", var_20_44)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321321", "321321004", "story_v_out_321321.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321321", "321321004", "story_v_out_321321.awb")
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
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321321005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321321005
		arg_21_1.duration_ = 3.93

		local var_21_0 = {
			zh = 1.966,
			ja = 3.933
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
				arg_21_0:Play321321006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1061ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1061ui_story == nil then
				arg_21_1.var_.characterEffect1061ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1061ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1061ui_story then
				arg_21_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["1156ui_story"]
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1156ui_story == nil then
				arg_21_1.var_.characterEffect1156ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 and not isNil(var_24_4) then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6

				if arg_21_1.var_.characterEffect1156ui_story and not isNil(var_24_4) then
					local var_24_8 = Mathf.Lerp(0, 0.5, var_24_7)

					arg_21_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1156ui_story.fillRatio = var_24_8
				end
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1156ui_story then
				local var_24_9 = 0.5

				arg_21_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1156ui_story.fillRatio = var_24_9
			end

			local var_24_10 = 0
			local var_24_11 = 0.225

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_12 = arg_21_1:FormatText(StoryNameCfg[612].name)

				arg_21_1.leftNameTxt_.text = var_24_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(321321005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 9
				local var_24_16 = utf8.len(var_24_14)
				local var_24_17 = var_24_15 <= 0 and var_24_11 or var_24_11 * (var_24_16 / var_24_15)

				if var_24_17 > 0 and var_24_11 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321005", "story_v_out_321321.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321005", "story_v_out_321321.awb") / 1000

					if var_24_18 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_10
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_321321", "321321005", "story_v_out_321321.awb")

						arg_21_1:RecordAudio("321321005", var_24_19)
						arg_21_1:RecordAudio("321321005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321321", "321321005", "story_v_out_321321.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321321", "321321005", "story_v_out_321321.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_20 and arg_21_1.time_ < var_24_10 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321321006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321321006
		arg_25_1.duration_ = 2.73

		local var_25_0 = {
			zh = 2.666,
			ja = 2.733
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
				arg_25_0:Play321321007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1156ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1156ui_story == nil then
				arg_25_1.var_.characterEffect1156ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1156ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1156ui_story then
				arg_25_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["1061ui_story"]
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1061ui_story == nil then
				arg_25_1.var_.characterEffect1061ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 and not isNil(var_28_4) then
				local var_28_7 = (arg_25_1.time_ - var_28_5) / var_28_6

				if arg_25_1.var_.characterEffect1061ui_story and not isNil(var_28_4) then
					local var_28_8 = Mathf.Lerp(0, 0.5, var_28_7)

					arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1061ui_story.fillRatio = var_28_8
				end
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1061ui_story then
				local var_28_9 = 0.5

				arg_25_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1061ui_story.fillRatio = var_28_9
			end

			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action12_1")
			end

			local var_28_11 = 0

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_28_12 = 0
			local var_28_13 = 0.225

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_14 = arg_25_1:FormatText(StoryNameCfg[605].name)

				arg_25_1.leftNameTxt_.text = var_28_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(321321006)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 9
				local var_28_18 = utf8.len(var_28_16)
				local var_28_19 = var_28_17 <= 0 and var_28_13 or var_28_13 * (var_28_18 / var_28_17)

				if var_28_19 > 0 and var_28_13 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321006", "story_v_out_321321.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_321321", "321321006", "story_v_out_321321.awb") / 1000

					if var_28_20 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_12
					end

					if var_28_15.prefab_name ~= "" and arg_25_1.actors_[var_28_15.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_15.prefab_name].transform, "story_v_out_321321", "321321006", "story_v_out_321321.awb")

						arg_25_1:RecordAudio("321321006", var_28_21)
						arg_25_1:RecordAudio("321321006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321321", "321321006", "story_v_out_321321.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321321", "321321006", "story_v_out_321321.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_22 and arg_25_1.time_ < var_28_12 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321321007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321321007
		arg_29_1.duration_ = 7.9

		local var_29_0 = {
			zh = 7.9,
			ja = 7.5
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
				arg_29_0:Play321321008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1061ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1061ui_story == nil then
				arg_29_1.var_.characterEffect1061ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1061ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1061ui_story then
				arg_29_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["1156ui_story"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1156ui_story == nil then
				arg_29_1.var_.characterEffect1156ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.characterEffect1156ui_story and not isNil(var_32_4) then
					local var_32_8 = Mathf.Lerp(0, 0.5, var_32_7)

					arg_29_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1156ui_story.fillRatio = var_32_8
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1156ui_story then
				local var_32_9 = 0.5

				arg_29_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1156ui_story.fillRatio = var_32_9
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action12_2")
			end

			local var_32_11 = 0

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_32_12 = 0
			local var_32_13 = 1

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[612].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(321321007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321007", "story_v_out_321321.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_321321", "321321007", "story_v_out_321321.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_321321", "321321007", "story_v_out_321321.awb")

						arg_29_1:RecordAudio("321321007", var_32_21)
						arg_29_1:RecordAudio("321321007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321321", "321321007", "story_v_out_321321.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321321", "321321007", "story_v_out_321321.awb")
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
	Play321321008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321321008
		arg_33_1.duration_ = 10.13

		local var_33_0 = {
			zh = 8.266,
			ja = 10.133
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
				arg_33_0:Play321321009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_2 = 0
			local var_36_3 = 1.025

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_4 = arg_33_1:FormatText(StoryNameCfg[612].name)

				arg_33_1.leftNameTxt_.text = var_36_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:GetWordFromCfg(321321008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 41
				local var_36_8 = utf8.len(var_36_6)
				local var_36_9 = var_36_7 <= 0 and var_36_3 or var_36_3 * (var_36_8 / var_36_7)

				if var_36_9 > 0 and var_36_3 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321008", "story_v_out_321321.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_321321", "321321008", "story_v_out_321321.awb") / 1000

					if var_36_10 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_2
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_321321", "321321008", "story_v_out_321321.awb")

						arg_33_1:RecordAudio("321321008", var_36_11)
						arg_33_1:RecordAudio("321321008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321321", "321321008", "story_v_out_321321.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321321", "321321008", "story_v_out_321321.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_12 and arg_33_1.time_ < var_36_2 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321321009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321321009
		arg_37_1.duration_ = 5.33

		local var_37_0 = {
			zh = 3.633,
			ja = 5.333
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
				arg_37_0:Play321321010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.5

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[612].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(321321009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 20
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321009", "story_v_out_321321.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_321321", "321321009", "story_v_out_321321.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_321321", "321321009", "story_v_out_321321.awb")

						arg_37_1:RecordAudio("321321009", var_40_9)
						arg_37_1:RecordAudio("321321009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321321", "321321009", "story_v_out_321321.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321321", "321321009", "story_v_out_321321.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321321010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321321010
		arg_41_1.duration_ = 6.3

		local var_41_0 = {
			zh = 5.4,
			ja = 6.3
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
				arg_41_0:Play321321011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1061ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = "10104ui_story"

			if arg_41_1.actors_[var_44_9] == nil then
				local var_44_10 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_44_10) then
					local var_44_11 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_41_1.stage_.transform)

					var_44_11.name = var_44_9
					var_44_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_41_1.actors_[var_44_9] = var_44_11

					local var_44_12 = var_44_11:GetComponentInChildren(typeof(CharacterEffect))

					var_44_12.enabled = true

					local var_44_13 = GameObjectTools.GetOrAddComponent(var_44_11, typeof(DynamicBoneHelper))

					if var_44_13 then
						var_44_13:EnableDynamicBone(false)
					end

					arg_41_1:ShowWeapon(var_44_12.transform, false)

					arg_41_1.var_[var_44_9 .. "Animator"] = var_44_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_41_1.var_[var_44_9 .. "Animator"].applyRootMotion = true
					arg_41_1.var_[var_44_9 .. "LipSync"] = var_44_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_44_14 = arg_41_1.actors_["10104ui_story"].transform
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.var_.moveOldPos10104ui_story = var_44_14.localPosition
			end

			local var_44_16 = 0.001

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16
				local var_44_18 = Vector3.New(0.99, -1.12, -5.99)

				var_44_14.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10104ui_story, var_44_18, var_44_17)

				local var_44_19 = manager.ui.mainCamera.transform.position - var_44_14.position

				var_44_14.forward = Vector3.New(var_44_19.x, var_44_19.y, var_44_19.z)

				local var_44_20 = var_44_14.localEulerAngles

				var_44_20.z = 0
				var_44_20.x = 0
				var_44_14.localEulerAngles = var_44_20
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 then
				var_44_14.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_44_21 = manager.ui.mainCamera.transform.position - var_44_14.position

				var_44_14.forward = Vector3.New(var_44_21.x, var_44_21.y, var_44_21.z)

				local var_44_22 = var_44_14.localEulerAngles

				var_44_22.z = 0
				var_44_22.x = 0
				var_44_14.localEulerAngles = var_44_22
			end

			local var_44_23 = arg_41_1.actors_["1156ui_story"].transform
			local var_44_24 = 0

			if var_44_24 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 then
				arg_41_1.var_.moveOldPos1156ui_story = var_44_23.localPosition
			end

			local var_44_25 = 0.001

			if var_44_24 <= arg_41_1.time_ and arg_41_1.time_ < var_44_24 + var_44_25 then
				local var_44_26 = (arg_41_1.time_ - var_44_24) / var_44_25
				local var_44_27 = Vector3.New(0, 100, 0)

				var_44_23.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1156ui_story, var_44_27, var_44_26)

				local var_44_28 = manager.ui.mainCamera.transform.position - var_44_23.position

				var_44_23.forward = Vector3.New(var_44_28.x, var_44_28.y, var_44_28.z)

				local var_44_29 = var_44_23.localEulerAngles

				var_44_29.z = 0
				var_44_29.x = 0
				var_44_23.localEulerAngles = var_44_29
			end

			if arg_41_1.time_ >= var_44_24 + var_44_25 and arg_41_1.time_ < var_44_24 + var_44_25 + arg_44_0 then
				var_44_23.localPosition = Vector3.New(0, 100, 0)

				local var_44_30 = manager.ui.mainCamera.transform.position - var_44_23.position

				var_44_23.forward = Vector3.New(var_44_30.x, var_44_30.y, var_44_30.z)

				local var_44_31 = var_44_23.localEulerAngles

				var_44_31.z = 0
				var_44_31.x = 0
				var_44_23.localEulerAngles = var_44_31
			end

			local var_44_32 = arg_41_1.actors_["10104ui_story"]
			local var_44_33 = 0

			if var_44_33 < arg_41_1.time_ and arg_41_1.time_ <= var_44_33 + arg_44_0 and not isNil(var_44_32) and arg_41_1.var_.characterEffect10104ui_story == nil then
				arg_41_1.var_.characterEffect10104ui_story = var_44_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_34 = 0.200000002980232

			if var_44_33 <= arg_41_1.time_ and arg_41_1.time_ < var_44_33 + var_44_34 and not isNil(var_44_32) then
				local var_44_35 = (arg_41_1.time_ - var_44_33) / var_44_34

				if arg_41_1.var_.characterEffect10104ui_story and not isNil(var_44_32) then
					arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_33 + var_44_34 and arg_41_1.time_ < var_44_33 + var_44_34 + arg_44_0 and not isNil(var_44_32) and arg_41_1.var_.characterEffect10104ui_story then
				arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_44_36 = arg_41_1.actors_["1061ui_story"]
			local var_44_37 = 0

			if var_44_37 < arg_41_1.time_ and arg_41_1.time_ <= var_44_37 + arg_44_0 and not isNil(var_44_36) and arg_41_1.var_.characterEffect1061ui_story == nil then
				arg_41_1.var_.characterEffect1061ui_story = var_44_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_38 = 0.200000002980232

			if var_44_37 <= arg_41_1.time_ and arg_41_1.time_ < var_44_37 + var_44_38 and not isNil(var_44_36) then
				local var_44_39 = (arg_41_1.time_ - var_44_37) / var_44_38

				if arg_41_1.var_.characterEffect1061ui_story and not isNil(var_44_36) then
					local var_44_40 = Mathf.Lerp(0, 0.5, var_44_39)

					arg_41_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1061ui_story.fillRatio = var_44_40
				end
			end

			if arg_41_1.time_ >= var_44_37 + var_44_38 and arg_41_1.time_ < var_44_37 + var_44_38 + arg_44_0 and not isNil(var_44_36) and arg_41_1.var_.characterEffect1061ui_story then
				local var_44_41 = 0.5

				arg_41_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1061ui_story.fillRatio = var_44_41
			end

			local var_44_42 = 0

			if var_44_42 < arg_41_1.time_ and arg_41_1.time_ <= var_44_42 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_44_43 = 0

			if var_44_43 < arg_41_1.time_ and arg_41_1.time_ <= var_44_43 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_44_44 = 0
			local var_44_45 = 0.6

			if var_44_44 < arg_41_1.time_ and arg_41_1.time_ <= var_44_44 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_46 = arg_41_1:FormatText(StoryNameCfg[1030].name)

				arg_41_1.leftNameTxt_.text = var_44_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_47 = arg_41_1:GetWordFromCfg(321321010)
				local var_44_48 = arg_41_1:FormatText(var_44_47.content)

				arg_41_1.text_.text = var_44_48

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_49 = 24
				local var_44_50 = utf8.len(var_44_48)
				local var_44_51 = var_44_49 <= 0 and var_44_45 or var_44_45 * (var_44_50 / var_44_49)

				if var_44_51 > 0 and var_44_45 < var_44_51 then
					arg_41_1.talkMaxDuration = var_44_51

					if var_44_51 + var_44_44 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_51 + var_44_44
					end
				end

				arg_41_1.text_.text = var_44_48
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321010", "story_v_out_321321.awb") ~= 0 then
					local var_44_52 = manager.audio:GetVoiceLength("story_v_out_321321", "321321010", "story_v_out_321321.awb") / 1000

					if var_44_52 + var_44_44 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_52 + var_44_44
					end

					if var_44_47.prefab_name ~= "" and arg_41_1.actors_[var_44_47.prefab_name] ~= nil then
						local var_44_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_47.prefab_name].transform, "story_v_out_321321", "321321010", "story_v_out_321321.awb")

						arg_41_1:RecordAudio("321321010", var_44_53)
						arg_41_1:RecordAudio("321321010", var_44_53)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321321", "321321010", "story_v_out_321321.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321321", "321321010", "story_v_out_321321.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_54 = math.max(var_44_45, arg_41_1.talkMaxDuration)

			if var_44_44 <= arg_41_1.time_ and arg_41_1.time_ < var_44_44 + var_44_54 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_44) / var_44_54

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_44 + var_44_54 and arg_41_1.time_ < var_44_44 + var_44_54 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play321321011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321321011
		arg_45_1.duration_ = 6.67

		local var_45_0 = {
			zh = 5.5,
			ja = 6.666
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
				arg_45_0:Play321321012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.625

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1030].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(321321011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321011", "story_v_out_321321.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_321321", "321321011", "story_v_out_321321.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_321321", "321321011", "story_v_out_321321.awb")

						arg_45_1:RecordAudio("321321011", var_48_9)
						arg_45_1:RecordAudio("321321011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321321", "321321011", "story_v_out_321321.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321321", "321321011", "story_v_out_321321.awb")
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
	Play321321012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321321012
		arg_49_1.duration_ = 11.43

		local var_49_0 = {
			zh = 9.2,
			ja = 11.433
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
				arg_49_0:Play321321013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1061ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1061ui_story == nil then
				arg_49_1.var_.characterEffect1061ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1061ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1061ui_story then
				arg_49_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["10104ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect10104ui_story == nil then
				arg_49_1.var_.characterEffect10104ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect10104ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10104ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect10104ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10104ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0
			local var_52_11 = 0.925

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[612].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(321321012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321012", "story_v_out_321321.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321012", "story_v_out_321321.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_321321", "321321012", "story_v_out_321321.awb")

						arg_49_1:RecordAudio("321321012", var_52_19)
						arg_49_1:RecordAudio("321321012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321321", "321321012", "story_v_out_321321.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321321", "321321012", "story_v_out_321321.awb")
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
	Play321321013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321321013
		arg_53_1.duration_ = 6.5

		local var_53_0 = {
			zh = 5.133,
			ja = 6.5
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
				arg_53_0:Play321321014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1061ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["10104ui_story"].transform
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.var_.moveOldPos10104ui_story = var_56_9.localPosition
			end

			local var_56_11 = 0.001

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11
				local var_56_13 = Vector3.New(0.99, -1.12, -5.99)

				var_56_9.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10104ui_story, var_56_13, var_56_12)

				local var_56_14 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_14.x, var_56_14.y, var_56_14.z)

				local var_56_15 = var_56_9.localEulerAngles

				var_56_15.z = 0
				var_56_15.x = 0
				var_56_9.localEulerAngles = var_56_15
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
				var_56_9.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_56_16 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_16.x, var_56_16.y, var_56_16.z)

				local var_56_17 = var_56_9.localEulerAngles

				var_56_17.z = 0
				var_56_17.x = 0
				var_56_9.localEulerAngles = var_56_17
			end

			local var_56_18 = 0

			if var_56_18 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_20 = 0
			local var_56_21 = 0.725

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_22 = arg_53_1:FormatText(StoryNameCfg[612].name)

				arg_53_1.leftNameTxt_.text = var_56_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_23 = arg_53_1:GetWordFromCfg(321321013)
				local var_56_24 = arg_53_1:FormatText(var_56_23.content)

				arg_53_1.text_.text = var_56_24

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_25 = 29
				local var_56_26 = utf8.len(var_56_24)
				local var_56_27 = var_56_25 <= 0 and var_56_21 or var_56_21 * (var_56_26 / var_56_25)

				if var_56_27 > 0 and var_56_21 < var_56_27 then
					arg_53_1.talkMaxDuration = var_56_27

					if var_56_27 + var_56_20 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_27 + var_56_20
					end
				end

				arg_53_1.text_.text = var_56_24
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321013", "story_v_out_321321.awb") ~= 0 then
					local var_56_28 = manager.audio:GetVoiceLength("story_v_out_321321", "321321013", "story_v_out_321321.awb") / 1000

					if var_56_28 + var_56_20 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_28 + var_56_20
					end

					if var_56_23.prefab_name ~= "" and arg_53_1.actors_[var_56_23.prefab_name] ~= nil then
						local var_56_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_23.prefab_name].transform, "story_v_out_321321", "321321013", "story_v_out_321321.awb")

						arg_53_1:RecordAudio("321321013", var_56_29)
						arg_53_1:RecordAudio("321321013", var_56_29)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321321", "321321013", "story_v_out_321321.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321321", "321321013", "story_v_out_321321.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_30 = math.max(var_56_21, arg_53_1.talkMaxDuration)

			if var_56_20 <= arg_53_1.time_ and arg_53_1.time_ < var_56_20 + var_56_30 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_20) / var_56_30

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_20 + var_56_30 and arg_53_1.time_ < var_56_20 + var_56_30 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321321014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321321014
		arg_57_1.duration_ = 5.53

		local var_57_0 = {
			zh = 4.6,
			ja = 5.533
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
				arg_57_0:Play321321015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1061ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1061ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1061ui_story, var_60_4, var_60_3)

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

			local var_60_9 = arg_57_1.actors_["10104ui_story"].transform
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.var_.moveOldPos10104ui_story = var_60_9.localPosition
			end

			local var_60_11 = 0.001

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11
				local var_60_13 = Vector3.New(0.02, -1.12, -5.99)

				var_60_9.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10104ui_story, var_60_13, var_60_12)

				local var_60_14 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_14.x, var_60_14.y, var_60_14.z)

				local var_60_15 = var_60_9.localEulerAngles

				var_60_15.z = 0
				var_60_15.x = 0
				var_60_9.localEulerAngles = var_60_15
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 then
				var_60_9.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_60_16 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_16.x, var_60_16.y, var_60_16.z)

				local var_60_17 = var_60_9.localEulerAngles

				var_60_17.z = 0
				var_60_17.x = 0
				var_60_9.localEulerAngles = var_60_17
			end

			local var_60_18 = arg_57_1.actors_["10104ui_story"]
			local var_60_19 = 0

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 and not isNil(var_60_18) and arg_57_1.var_.characterEffect10104ui_story == nil then
				arg_57_1.var_.characterEffect10104ui_story = var_60_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_20 = 0.200000002980232

			if var_60_19 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_20 and not isNil(var_60_18) then
				local var_60_21 = (arg_57_1.time_ - var_60_19) / var_60_20

				if arg_57_1.var_.characterEffect10104ui_story and not isNil(var_60_18) then
					arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_19 + var_60_20 and arg_57_1.time_ < var_60_19 + var_60_20 + arg_60_0 and not isNil(var_60_18) and arg_57_1.var_.characterEffect10104ui_story then
				arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_60_22 = arg_57_1.actors_["1061ui_story"]
			local var_60_23 = 0

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.characterEffect1061ui_story == nil then
				arg_57_1.var_.characterEffect1061ui_story = var_60_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_24 = 0.200000002980232

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 and not isNil(var_60_22) then
				local var_60_25 = (arg_57_1.time_ - var_60_23) / var_60_24

				if arg_57_1.var_.characterEffect1061ui_story and not isNil(var_60_22) then
					local var_60_26 = Mathf.Lerp(0, 0.5, var_60_25)

					arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1061ui_story.fillRatio = var_60_26
				end
			end

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.characterEffect1061ui_story then
				local var_60_27 = 0.5

				arg_57_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1061ui_story.fillRatio = var_60_27
			end

			local var_60_28 = 0
			local var_60_29 = 0.55

			if var_60_28 < arg_57_1.time_ and arg_57_1.time_ <= var_60_28 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_30 = arg_57_1:FormatText(StoryNameCfg[1030].name)

				arg_57_1.leftNameTxt_.text = var_60_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_31 = arg_57_1:GetWordFromCfg(321321014)
				local var_60_32 = arg_57_1:FormatText(var_60_31.content)

				arg_57_1.text_.text = var_60_32

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_33 = 22
				local var_60_34 = utf8.len(var_60_32)
				local var_60_35 = var_60_33 <= 0 and var_60_29 or var_60_29 * (var_60_34 / var_60_33)

				if var_60_35 > 0 and var_60_29 < var_60_35 then
					arg_57_1.talkMaxDuration = var_60_35

					if var_60_35 + var_60_28 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_35 + var_60_28
					end
				end

				arg_57_1.text_.text = var_60_32
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321014", "story_v_out_321321.awb") ~= 0 then
					local var_60_36 = manager.audio:GetVoiceLength("story_v_out_321321", "321321014", "story_v_out_321321.awb") / 1000

					if var_60_36 + var_60_28 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_36 + var_60_28
					end

					if var_60_31.prefab_name ~= "" and arg_57_1.actors_[var_60_31.prefab_name] ~= nil then
						local var_60_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_31.prefab_name].transform, "story_v_out_321321", "321321014", "story_v_out_321321.awb")

						arg_57_1:RecordAudio("321321014", var_60_37)
						arg_57_1:RecordAudio("321321014", var_60_37)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321321", "321321014", "story_v_out_321321.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321321", "321321014", "story_v_out_321321.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_38 = math.max(var_60_29, arg_57_1.talkMaxDuration)

			if var_60_28 <= arg_57_1.time_ and arg_57_1.time_ < var_60_28 + var_60_38 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_28) / var_60_38

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_28 + var_60_38 and arg_57_1.time_ < var_60_28 + var_60_38 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321321015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321321015
		arg_61_1.duration_ = 1.2

		local var_61_0 = {
			zh = 0.999999999999,
			ja = 1.2
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
				arg_61_0:Play321321016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = "2078ui_story"

			if arg_61_1.actors_[var_64_0] == nil then
				local var_64_1 = Asset.Load("Char/" .. "2078ui_story")

				if not isNil(var_64_1) then
					local var_64_2 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_61_1.stage_.transform)

					var_64_2.name = var_64_0
					var_64_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_61_1.actors_[var_64_0] = var_64_2

					local var_64_3 = var_64_2:GetComponentInChildren(typeof(CharacterEffect))

					var_64_3.enabled = true

					local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_2, typeof(DynamicBoneHelper))

					if var_64_4 then
						var_64_4:EnableDynamicBone(false)
					end

					arg_61_1:ShowWeapon(var_64_3.transform, false)

					arg_61_1.var_[var_64_0 .. "Animator"] = var_64_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_61_1.var_[var_64_0 .. "Animator"].applyRootMotion = true
					arg_61_1.var_[var_64_0 .. "LipSync"] = var_64_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_64_5 = arg_61_1.actors_["2078ui_story"].transform
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.var_.moveOldPos2078ui_story = var_64_5.localPosition
			end

			local var_64_7 = 0.001

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7
				local var_64_9 = Vector3.New(0, -1.28, -5.6)

				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos2078ui_story, var_64_9, var_64_8)

				local var_64_10 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_10.x, var_64_10.y, var_64_10.z)

				local var_64_11 = var_64_5.localEulerAngles

				var_64_11.z = 0
				var_64_11.x = 0
				var_64_5.localEulerAngles = var_64_11
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_64_12 = manager.ui.mainCamera.transform.position - var_64_5.position

				var_64_5.forward = Vector3.New(var_64_12.x, var_64_12.y, var_64_12.z)

				local var_64_13 = var_64_5.localEulerAngles

				var_64_13.z = 0
				var_64_13.x = 0
				var_64_5.localEulerAngles = var_64_13
			end

			local var_64_14 = arg_61_1.actors_["10104ui_story"].transform
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.var_.moveOldPos10104ui_story = var_64_14.localPosition
			end

			local var_64_16 = 0.001

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16
				local var_64_18 = Vector3.New(0, 100, 0)

				var_64_14.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10104ui_story, var_64_18, var_64_17)

				local var_64_19 = manager.ui.mainCamera.transform.position - var_64_14.position

				var_64_14.forward = Vector3.New(var_64_19.x, var_64_19.y, var_64_19.z)

				local var_64_20 = var_64_14.localEulerAngles

				var_64_20.z = 0
				var_64_20.x = 0
				var_64_14.localEulerAngles = var_64_20
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 then
				var_64_14.localPosition = Vector3.New(0, 100, 0)

				local var_64_21 = manager.ui.mainCamera.transform.position - var_64_14.position

				var_64_14.forward = Vector3.New(var_64_21.x, var_64_21.y, var_64_21.z)

				local var_64_22 = var_64_14.localEulerAngles

				var_64_22.z = 0
				var_64_22.x = 0
				var_64_14.localEulerAngles = var_64_22
			end

			local var_64_23 = arg_61_1.actors_["2078ui_story"]
			local var_64_24 = 0

			if var_64_24 < arg_61_1.time_ and arg_61_1.time_ <= var_64_24 + arg_64_0 and not isNil(var_64_23) and arg_61_1.var_.characterEffect2078ui_story == nil then
				arg_61_1.var_.characterEffect2078ui_story = var_64_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_25 = 0.200000002980232

			if var_64_24 <= arg_61_1.time_ and arg_61_1.time_ < var_64_24 + var_64_25 and not isNil(var_64_23) then
				local var_64_26 = (arg_61_1.time_ - var_64_24) / var_64_25

				if arg_61_1.var_.characterEffect2078ui_story and not isNil(var_64_23) then
					arg_61_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_24 + var_64_25 and arg_61_1.time_ < var_64_24 + var_64_25 + arg_64_0 and not isNil(var_64_23) and arg_61_1.var_.characterEffect2078ui_story then
				arg_61_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_64_27 = arg_61_1.actors_["10104ui_story"]
			local var_64_28 = 0

			if var_64_28 < arg_61_1.time_ and arg_61_1.time_ <= var_64_28 + arg_64_0 and not isNil(var_64_27) and arg_61_1.var_.characterEffect10104ui_story == nil then
				arg_61_1.var_.characterEffect10104ui_story = var_64_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_29 = 0.200000002980232

			if var_64_28 <= arg_61_1.time_ and arg_61_1.time_ < var_64_28 + var_64_29 and not isNil(var_64_27) then
				local var_64_30 = (arg_61_1.time_ - var_64_28) / var_64_29

				if arg_61_1.var_.characterEffect10104ui_story and not isNil(var_64_27) then
					local var_64_31 = Mathf.Lerp(0, 0.5, var_64_30)

					arg_61_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10104ui_story.fillRatio = var_64_31
				end
			end

			if arg_61_1.time_ >= var_64_28 + var_64_29 and arg_61_1.time_ < var_64_28 + var_64_29 + arg_64_0 and not isNil(var_64_27) and arg_61_1.var_.characterEffect10104ui_story then
				local var_64_32 = 0.5

				arg_61_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10104ui_story.fillRatio = var_64_32
			end

			local var_64_33 = 0

			if var_64_33 < arg_61_1.time_ and arg_61_1.time_ <= var_64_33 + arg_64_0 then
				arg_61_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_64_34 = 0

			if var_64_34 < arg_61_1.time_ and arg_61_1.time_ <= var_64_34 + arg_64_0 then
				arg_61_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_35 = 0
			local var_64_36 = 0.075

			if var_64_35 < arg_61_1.time_ and arg_61_1.time_ <= var_64_35 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_37 = arg_61_1:FormatText(StoryNameCfg[1175].name)

				arg_61_1.leftNameTxt_.text = var_64_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_38 = arg_61_1:GetWordFromCfg(321321015)
				local var_64_39 = arg_61_1:FormatText(var_64_38.content)

				arg_61_1.text_.text = var_64_39

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_40 = 3
				local var_64_41 = utf8.len(var_64_39)
				local var_64_42 = var_64_40 <= 0 and var_64_36 or var_64_36 * (var_64_41 / var_64_40)

				if var_64_42 > 0 and var_64_36 < var_64_42 then
					arg_61_1.talkMaxDuration = var_64_42

					if var_64_42 + var_64_35 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_42 + var_64_35
					end
				end

				arg_61_1.text_.text = var_64_39
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321015", "story_v_out_321321.awb") ~= 0 then
					local var_64_43 = manager.audio:GetVoiceLength("story_v_out_321321", "321321015", "story_v_out_321321.awb") / 1000

					if var_64_43 + var_64_35 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_43 + var_64_35
					end

					if var_64_38.prefab_name ~= "" and arg_61_1.actors_[var_64_38.prefab_name] ~= nil then
						local var_64_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_38.prefab_name].transform, "story_v_out_321321", "321321015", "story_v_out_321321.awb")

						arg_61_1:RecordAudio("321321015", var_64_44)
						arg_61_1:RecordAudio("321321015", var_64_44)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321321", "321321015", "story_v_out_321321.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321321", "321321015", "story_v_out_321321.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_45 = math.max(var_64_36, arg_61_1.talkMaxDuration)

			if var_64_35 <= arg_61_1.time_ and arg_61_1.time_ < var_64_35 + var_64_45 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_35) / var_64_45

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_35 + var_64_45 and arg_61_1.time_ < var_64_35 + var_64_45 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play321321016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321321016
		arg_65_1.duration_ = 7.1

		local var_65_0 = {
			zh = 6.733,
			ja = 7.1
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
				arg_65_0:Play321321017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10104ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10104ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0.02, -1.12, -5.99)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10104ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["2078ui_story"].transform
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.var_.moveOldPos2078ui_story = var_68_9.localPosition
			end

			local var_68_11 = 0.001

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11
				local var_68_13 = Vector3.New(0, 100, 0)

				var_68_9.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2078ui_story, var_68_13, var_68_12)

				local var_68_14 = manager.ui.mainCamera.transform.position - var_68_9.position

				var_68_9.forward = Vector3.New(var_68_14.x, var_68_14.y, var_68_14.z)

				local var_68_15 = var_68_9.localEulerAngles

				var_68_15.z = 0
				var_68_15.x = 0
				var_68_9.localEulerAngles = var_68_15
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 then
				var_68_9.localPosition = Vector3.New(0, 100, 0)

				local var_68_16 = manager.ui.mainCamera.transform.position - var_68_9.position

				var_68_9.forward = Vector3.New(var_68_16.x, var_68_16.y, var_68_16.z)

				local var_68_17 = var_68_9.localEulerAngles

				var_68_17.z = 0
				var_68_17.x = 0
				var_68_9.localEulerAngles = var_68_17
			end

			local var_68_18 = arg_65_1.actors_["10104ui_story"]
			local var_68_19 = 0

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 and not isNil(var_68_18) and arg_65_1.var_.characterEffect10104ui_story == nil then
				arg_65_1.var_.characterEffect10104ui_story = var_68_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_20 = 0.200000002980232

			if var_68_19 <= arg_65_1.time_ and arg_65_1.time_ < var_68_19 + var_68_20 and not isNil(var_68_18) then
				local var_68_21 = (arg_65_1.time_ - var_68_19) / var_68_20

				if arg_65_1.var_.characterEffect10104ui_story and not isNil(var_68_18) then
					arg_65_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_19 + var_68_20 and arg_65_1.time_ < var_68_19 + var_68_20 + arg_68_0 and not isNil(var_68_18) and arg_65_1.var_.characterEffect10104ui_story then
				arg_65_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_68_22 = arg_65_1.actors_["2078ui_story"]
			local var_68_23 = 0

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.characterEffect2078ui_story == nil then
				arg_65_1.var_.characterEffect2078ui_story = var_68_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_24 = 0.200000002980232

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 and not isNil(var_68_22) then
				local var_68_25 = (arg_65_1.time_ - var_68_23) / var_68_24

				if arg_65_1.var_.characterEffect2078ui_story and not isNil(var_68_22) then
					local var_68_26 = Mathf.Lerp(0, 0.5, var_68_25)

					arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_65_1.var_.characterEffect2078ui_story.fillRatio = var_68_26
				end
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 and not isNil(var_68_22) and arg_65_1.var_.characterEffect2078ui_story then
				local var_68_27 = 0.5

				arg_65_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_65_1.var_.characterEffect2078ui_story.fillRatio = var_68_27
			end

			local var_68_28 = 0
			local var_68_29 = 0.8

			if var_68_28 < arg_65_1.time_ and arg_65_1.time_ <= var_68_28 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_30 = arg_65_1:FormatText(StoryNameCfg[1030].name)

				arg_65_1.leftNameTxt_.text = var_68_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_31 = arg_65_1:GetWordFromCfg(321321016)
				local var_68_32 = arg_65_1:FormatText(var_68_31.content)

				arg_65_1.text_.text = var_68_32

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_33 = 32
				local var_68_34 = utf8.len(var_68_32)
				local var_68_35 = var_68_33 <= 0 and var_68_29 or var_68_29 * (var_68_34 / var_68_33)

				if var_68_35 > 0 and var_68_29 < var_68_35 then
					arg_65_1.talkMaxDuration = var_68_35

					if var_68_35 + var_68_28 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_35 + var_68_28
					end
				end

				arg_65_1.text_.text = var_68_32
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321016", "story_v_out_321321.awb") ~= 0 then
					local var_68_36 = manager.audio:GetVoiceLength("story_v_out_321321", "321321016", "story_v_out_321321.awb") / 1000

					if var_68_36 + var_68_28 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_36 + var_68_28
					end

					if var_68_31.prefab_name ~= "" and arg_65_1.actors_[var_68_31.prefab_name] ~= nil then
						local var_68_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_31.prefab_name].transform, "story_v_out_321321", "321321016", "story_v_out_321321.awb")

						arg_65_1:RecordAudio("321321016", var_68_37)
						arg_65_1:RecordAudio("321321016", var_68_37)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321321", "321321016", "story_v_out_321321.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321321", "321321016", "story_v_out_321321.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_38 = math.max(var_68_29, arg_65_1.talkMaxDuration)

			if var_68_28 <= arg_65_1.time_ and arg_65_1.time_ < var_68_28 + var_68_38 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_28) / var_68_38

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_28 + var_68_38 and arg_65_1.time_ < var_68_28 + var_68_38 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_65_1:InitPlayNodeList()
	end,
	Play321321017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321321017
		arg_69_1.duration_ = 1.23

		local var_69_0 = {
			zh = 1.233,
			ja = 0.999999999999
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
				arg_69_0:Play321321018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10104ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10104ui_story == nil then
				arg_69_1.var_.characterEffect10104ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10104ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10104ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10104ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10104ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.125

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[1184].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(321321017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 5
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321017", "story_v_out_321321.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_321321", "321321017", "story_v_out_321321.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_321321", "321321017", "story_v_out_321321.awb")

						arg_69_1:RecordAudio("321321017", var_72_15)
						arg_69_1:RecordAudio("321321017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321321", "321321017", "story_v_out_321321.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321321", "321321017", "story_v_out_321321.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_16 and arg_69_1.time_ < var_72_6 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play321321018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321321018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play321321019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10104ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10104ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10104ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = 0.133333333333333
			local var_76_10 = 1

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				local var_76_11 = "play"
				local var_76_12 = "effect"

				arg_73_1:AudioAction(var_76_11, var_76_12, "se_story_141", "se_story_141_footstep_soldier", "")
			end

			local var_76_13 = 0
			local var_76_14 = 0.8

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_15 = arg_73_1:GetWordFromCfg(321321018)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 32
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_14 or var_76_14 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_14 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_13 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_13
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_20 = math.max(var_76_14, arg_73_1.talkMaxDuration)

			if var_76_13 <= arg_73_1.time_ and arg_73_1.time_ < var_76_13 + var_76_20 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_13) / var_76_20

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_13 + var_76_20 and arg_73_1.time_ < var_76_13 + var_76_20 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321321019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321321019
		arg_77_1.duration_ = 11.83

		local var_77_0 = {
			zh = 7.733,
			ja = 11.833
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
				arg_77_0:Play321321020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10104ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10104ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0.02, -1.12, -5.99)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10104ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10104ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10104ui_story == nil then
				arg_77_1.var_.characterEffect10104ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect10104ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10104ui_story then
				arg_77_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_15 = 0
			local var_80_16 = 0.8

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[1030].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(321321019)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 32
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321019", "story_v_out_321321.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_321321", "321321019", "story_v_out_321321.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_321321", "321321019", "story_v_out_321321.awb")

						arg_77_1:RecordAudio("321321019", var_80_24)
						arg_77_1:RecordAudio("321321019", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321321", "321321019", "story_v_out_321321.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321321", "321321019", "story_v_out_321321.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321321020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321321020
		arg_81_1.duration_ = 9.93

		local var_81_0 = {
			zh = 8.8,
			ja = 9.933
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
				arg_81_0:Play321321021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.05

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1030].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(321321020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321020", "story_v_out_321321.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_321321", "321321020", "story_v_out_321321.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_321321", "321321020", "story_v_out_321321.awb")

						arg_81_1:RecordAudio("321321020", var_84_9)
						arg_81_1:RecordAudio("321321020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321321", "321321020", "story_v_out_321321.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321321", "321321020", "story_v_out_321321.awb")
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
	Play321321021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321321021
		arg_85_1.duration_ = 6.5

		local var_85_0 = {
			zh = 6,
			ja = 6.5
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
				arg_85_0:Play321321022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.725

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[1030].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(321321021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321021", "story_v_out_321321.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_321321", "321321021", "story_v_out_321321.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_321321", "321321021", "story_v_out_321321.awb")

						arg_85_1:RecordAudio("321321021", var_88_9)
						arg_85_1:RecordAudio("321321021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321321", "321321021", "story_v_out_321321.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321321", "321321021", "story_v_out_321321.awb")
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
	Play321321022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321321022
		arg_89_1.duration_ = 10.67

		local var_89_0 = {
			zh = 6.833,
			ja = 10.666
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
				arg_89_0:Play321321023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10104ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10104ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0.02, -1.12, -5.99)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10104ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_92_11 = 0
			local var_92_12 = 0.825

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_13 = arg_89_1:FormatText(StoryNameCfg[1030].name)

				arg_89_1.leftNameTxt_.text = var_92_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_14 = arg_89_1:GetWordFromCfg(321321022)
				local var_92_15 = arg_89_1:FormatText(var_92_14.content)

				arg_89_1.text_.text = var_92_15

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 33
				local var_92_17 = utf8.len(var_92_15)
				local var_92_18 = var_92_16 <= 0 and var_92_12 or var_92_12 * (var_92_17 / var_92_16)

				if var_92_18 > 0 and var_92_12 < var_92_18 then
					arg_89_1.talkMaxDuration = var_92_18

					if var_92_18 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_15
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321022", "story_v_out_321321.awb") ~= 0 then
					local var_92_19 = manager.audio:GetVoiceLength("story_v_out_321321", "321321022", "story_v_out_321321.awb") / 1000

					if var_92_19 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_11
					end

					if var_92_14.prefab_name ~= "" and arg_89_1.actors_[var_92_14.prefab_name] ~= nil then
						local var_92_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_14.prefab_name].transform, "story_v_out_321321", "321321022", "story_v_out_321321.awb")

						arg_89_1:RecordAudio("321321022", var_92_20)
						arg_89_1:RecordAudio("321321022", var_92_20)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321321", "321321022", "story_v_out_321321.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321321", "321321022", "story_v_out_321321.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_21 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_21 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_21

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_21 and arg_89_1.time_ < var_92_11 + var_92_21 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321321023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321321023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play321321024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10104ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10104ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10104ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["10104ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10104ui_story == nil then
				arg_93_1.var_.characterEffect10104ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect10104ui_story and not isNil(var_96_9) then
					local var_96_13 = Mathf.Lerp(0, 0.5, var_96_12)

					arg_93_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10104ui_story.fillRatio = var_96_13
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10104ui_story then
				local var_96_14 = 0.5

				arg_93_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10104ui_story.fillRatio = var_96_14
			end

			local var_96_15 = 0
			local var_96_16 = 1.55

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(321321023)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 62
				local var_96_20 = utf8.len(var_96_18)
				local var_96_21 = var_96_19 <= 0 and var_96_16 or var_96_16 * (var_96_20 / var_96_19)

				if var_96_21 > 0 and var_96_16 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_22 and arg_93_1.time_ < var_96_15 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play321321024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321321024
		arg_97_1.duration_ = 16.97

		local var_97_0 = {
			zh = 10,
			ja = 16.966
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
				arg_97_0:Play321321025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10104ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10104ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0.02, -1.12, -5.99)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10104ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10104ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10104ui_story == nil then
				arg_97_1.var_.characterEffect10104ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10104ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10104ui_story then
				arg_97_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104actionlink/10104action426")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_15 = 0
			local var_100_16 = 1.2

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[1030].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(321321024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 48
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321024", "story_v_out_321321.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_321321", "321321024", "story_v_out_321321.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_321321", "321321024", "story_v_out_321321.awb")

						arg_97_1:RecordAudio("321321024", var_100_24)
						arg_97_1:RecordAudio("321321024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321321", "321321024", "story_v_out_321321.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321321", "321321024", "story_v_out_321321.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321321025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321321025
		arg_101_1.duration_ = 13.8

		local var_101_0 = {
			zh = 11.666,
			ja = 13.8
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
				arg_101_0:Play321321026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.025

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[1030].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(321321025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321025", "story_v_out_321321.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_321321", "321321025", "story_v_out_321321.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_321321", "321321025", "story_v_out_321321.awb")

						arg_101_1:RecordAudio("321321025", var_104_9)
						arg_101_1:RecordAudio("321321025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321321", "321321025", "story_v_out_321321.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321321", "321321025", "story_v_out_321321.awb")
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
	Play321321026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321321026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321321027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10104ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10104ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10104ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10104ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10104ui_story == nil then
				arg_105_1.var_.characterEffect10104ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect10104ui_story and not isNil(var_108_9) then
					local var_108_13 = Mathf.Lerp(0, 0.5, var_108_12)

					arg_105_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10104ui_story.fillRatio = var_108_13
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10104ui_story then
				local var_108_14 = 0.5

				arg_105_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10104ui_story.fillRatio = var_108_14
			end

			local var_108_15 = 0
			local var_108_16 = 0.975

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_17 = arg_105_1:GetWordFromCfg(321321026)
				local var_108_18 = arg_105_1:FormatText(var_108_17.content)

				arg_105_1.text_.text = var_108_18

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_19 = 39
				local var_108_20 = utf8.len(var_108_18)
				local var_108_21 = var_108_19 <= 0 and var_108_16 or var_108_16 * (var_108_20 / var_108_19)

				if var_108_21 > 0 and var_108_16 < var_108_21 then
					arg_105_1.talkMaxDuration = var_108_21

					if var_108_21 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_21 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_18
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_22 and arg_105_1.time_ < var_108_15 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321321027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321321027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321321028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(321321027)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 40
				local var_112_5 = utf8.len(var_112_3)
				local var_112_6 = var_112_4 <= 0 and var_112_1 or var_112_1 * (var_112_5 / var_112_4)

				if var_112_6 > 0 and var_112_1 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_7 and arg_109_1.time_ < var_112_0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321321028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321321028
		arg_113_1.duration_ = 10

		local var_113_0 = {
			zh = 7.5,
			ja = 10
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
				arg_113_0:Play321321029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10104ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10104ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0.02, -1.12, -5.99)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10104ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["10104ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10104ui_story == nil then
				arg_113_1.var_.characterEffect10104ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect10104ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10104ui_story then
				arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_116_14 = 0
			local var_116_15 = 0.975

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_16 = arg_113_1:FormatText(StoryNameCfg[1030].name)

				arg_113_1.leftNameTxt_.text = var_116_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_17 = arg_113_1:GetWordFromCfg(321321028)
				local var_116_18 = arg_113_1:FormatText(var_116_17.content)

				arg_113_1.text_.text = var_116_18

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 39
				local var_116_20 = utf8.len(var_116_18)
				local var_116_21 = var_116_19 <= 0 and var_116_15 or var_116_15 * (var_116_20 / var_116_19)

				if var_116_21 > 0 and var_116_15 < var_116_21 then
					arg_113_1.talkMaxDuration = var_116_21

					if var_116_21 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_21 + var_116_14
					end
				end

				arg_113_1.text_.text = var_116_18
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321028", "story_v_out_321321.awb") ~= 0 then
					local var_116_22 = manager.audio:GetVoiceLength("story_v_out_321321", "321321028", "story_v_out_321321.awb") / 1000

					if var_116_22 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_14
					end

					if var_116_17.prefab_name ~= "" and arg_113_1.actors_[var_116_17.prefab_name] ~= nil then
						local var_116_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_17.prefab_name].transform, "story_v_out_321321", "321321028", "story_v_out_321321.awb")

						arg_113_1:RecordAudio("321321028", var_116_23)
						arg_113_1:RecordAudio("321321028", var_116_23)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321321", "321321028", "story_v_out_321321.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321321", "321321028", "story_v_out_321321.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_24 = math.max(var_116_15, arg_113_1.talkMaxDuration)

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_24 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_14) / var_116_24

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_24 and arg_113_1.time_ < var_116_14 + var_116_24 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play321321029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321321029
		arg_117_1.duration_ = 9.37

		local var_117_0 = {
			zh = 8.066,
			ja = 9.366
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
				arg_117_0:Play321321030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10104ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10104ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(-0.88, -1.12, -5.99)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10104ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = "1211ui_story"

			if arg_117_1.actors_[var_120_9] == nil then
				local var_120_10 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_120_10) then
					local var_120_11 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_117_1.stage_.transform)

					var_120_11.name = var_120_9
					var_120_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_117_1.actors_[var_120_9] = var_120_11

					local var_120_12 = var_120_11:GetComponentInChildren(typeof(CharacterEffect))

					var_120_12.enabled = true

					local var_120_13 = GameObjectTools.GetOrAddComponent(var_120_11, typeof(DynamicBoneHelper))

					if var_120_13 then
						var_120_13:EnableDynamicBone(false)
					end

					arg_117_1:ShowWeapon(var_120_12.transform, false)

					arg_117_1.var_[var_120_9 .. "Animator"] = var_120_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_117_1.var_[var_120_9 .. "Animator"].applyRootMotion = true
					arg_117_1.var_[var_120_9 .. "LipSync"] = var_120_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_120_14 = arg_117_1.actors_["1211ui_story"].transform
			local var_120_15 = 0

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.var_.moveOldPos1211ui_story = var_120_14.localPosition
			end

			local var_120_16 = 0.001

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 then
				local var_120_17 = (arg_117_1.time_ - var_120_15) / var_120_16
				local var_120_18 = Vector3.New(0.7, -0.67, -6.07)

				var_120_14.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1211ui_story, var_120_18, var_120_17)

				local var_120_19 = manager.ui.mainCamera.transform.position - var_120_14.position

				var_120_14.forward = Vector3.New(var_120_19.x, var_120_19.y, var_120_19.z)

				local var_120_20 = var_120_14.localEulerAngles

				var_120_20.z = 0
				var_120_20.x = 0
				var_120_14.localEulerAngles = var_120_20
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 then
				var_120_14.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_120_21 = manager.ui.mainCamera.transform.position - var_120_14.position

				var_120_14.forward = Vector3.New(var_120_21.x, var_120_21.y, var_120_21.z)

				local var_120_22 = var_120_14.localEulerAngles

				var_120_22.z = 0
				var_120_22.x = 0
				var_120_14.localEulerAngles = var_120_22
			end

			local var_120_23 = arg_117_1.actors_["1211ui_story"]
			local var_120_24 = 0

			if var_120_24 < arg_117_1.time_ and arg_117_1.time_ <= var_120_24 + arg_120_0 and not isNil(var_120_23) and arg_117_1.var_.characterEffect1211ui_story == nil then
				arg_117_1.var_.characterEffect1211ui_story = var_120_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_25 = 0.200000002980232

			if var_120_24 <= arg_117_1.time_ and arg_117_1.time_ < var_120_24 + var_120_25 and not isNil(var_120_23) then
				local var_120_26 = (arg_117_1.time_ - var_120_24) / var_120_25

				if arg_117_1.var_.characterEffect1211ui_story and not isNil(var_120_23) then
					arg_117_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_24 + var_120_25 and arg_117_1.time_ < var_120_24 + var_120_25 + arg_120_0 and not isNil(var_120_23) and arg_117_1.var_.characterEffect1211ui_story then
				arg_117_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_120_27 = arg_117_1.actors_["10104ui_story"]
			local var_120_28 = 0

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 and not isNil(var_120_27) and arg_117_1.var_.characterEffect10104ui_story == nil then
				arg_117_1.var_.characterEffect10104ui_story = var_120_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_29 = 0.200000002980232

			if var_120_28 <= arg_117_1.time_ and arg_117_1.time_ < var_120_28 + var_120_29 and not isNil(var_120_27) then
				local var_120_30 = (arg_117_1.time_ - var_120_28) / var_120_29

				if arg_117_1.var_.characterEffect10104ui_story and not isNil(var_120_27) then
					local var_120_31 = Mathf.Lerp(0, 0.5, var_120_30)

					arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10104ui_story.fillRatio = var_120_31
				end
			end

			if arg_117_1.time_ >= var_120_28 + var_120_29 and arg_117_1.time_ < var_120_28 + var_120_29 + arg_120_0 and not isNil(var_120_27) and arg_117_1.var_.characterEffect10104ui_story then
				local var_120_32 = 0.5

				arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10104ui_story.fillRatio = var_120_32
			end

			local var_120_33 = 0

			if var_120_33 < arg_117_1.time_ and arg_117_1.time_ <= var_120_33 + arg_120_0 then
				arg_117_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_120_34 = 0

			if var_120_34 < arg_117_1.time_ and arg_117_1.time_ <= var_120_34 + arg_120_0 then
				arg_117_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_120_35 = 0
			local var_120_36 = 1.125

			if var_120_35 < arg_117_1.time_ and arg_117_1.time_ <= var_120_35 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_37 = arg_117_1:FormatText(StoryNameCfg[37].name)

				arg_117_1.leftNameTxt_.text = var_120_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_38 = arg_117_1:GetWordFromCfg(321321029)
				local var_120_39 = arg_117_1:FormatText(var_120_38.content)

				arg_117_1.text_.text = var_120_39

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_40 = 45
				local var_120_41 = utf8.len(var_120_39)
				local var_120_42 = var_120_40 <= 0 and var_120_36 or var_120_36 * (var_120_41 / var_120_40)

				if var_120_42 > 0 and var_120_36 < var_120_42 then
					arg_117_1.talkMaxDuration = var_120_42

					if var_120_42 + var_120_35 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_42 + var_120_35
					end
				end

				arg_117_1.text_.text = var_120_39
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321029", "story_v_out_321321.awb") ~= 0 then
					local var_120_43 = manager.audio:GetVoiceLength("story_v_out_321321", "321321029", "story_v_out_321321.awb") / 1000

					if var_120_43 + var_120_35 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_43 + var_120_35
					end

					if var_120_38.prefab_name ~= "" and arg_117_1.actors_[var_120_38.prefab_name] ~= nil then
						local var_120_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_38.prefab_name].transform, "story_v_out_321321", "321321029", "story_v_out_321321.awb")

						arg_117_1:RecordAudio("321321029", var_120_44)
						arg_117_1:RecordAudio("321321029", var_120_44)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321321", "321321029", "story_v_out_321321.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321321", "321321029", "story_v_out_321321.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_45 = math.max(var_120_36, arg_117_1.talkMaxDuration)

			if var_120_35 <= arg_117_1.time_ and arg_117_1.time_ < var_120_35 + var_120_45 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_35) / var_120_45

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_35 + var_120_45 and arg_117_1.time_ < var_120_35 + var_120_45 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321321030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321321030
		arg_121_1.duration_ = 7.2

		local var_121_0 = {
			zh = 5.8,
			ja = 7.2
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
				arg_121_0:Play321321031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10104ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10104ui_story == nil then
				arg_121_1.var_.characterEffect10104ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10104ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10104ui_story then
				arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1211ui_story"]
			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1211ui_story == nil then
				arg_121_1.var_.characterEffect1211ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_6 and not isNil(var_124_4) then
				local var_124_7 = (arg_121_1.time_ - var_124_5) / var_124_6

				if arg_121_1.var_.characterEffect1211ui_story and not isNil(var_124_4) then
					local var_124_8 = Mathf.Lerp(0, 0.5, var_124_7)

					arg_121_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1211ui_story.fillRatio = var_124_8
				end
			end

			if arg_121_1.time_ >= var_124_5 + var_124_6 and arg_121_1.time_ < var_124_5 + var_124_6 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1211ui_story then
				local var_124_9 = 0.5

				arg_121_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1211ui_story.fillRatio = var_124_9
			end

			local var_124_10 = 0
			local var_124_11 = 0.725

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_12 = arg_121_1:FormatText(StoryNameCfg[1030].name)

				arg_121_1.leftNameTxt_.text = var_124_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(321321030)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_15 = 29
				local var_124_16 = utf8.len(var_124_14)
				local var_124_17 = var_124_15 <= 0 and var_124_11 or var_124_11 * (var_124_16 / var_124_15)

				if var_124_17 > 0 and var_124_11 < var_124_17 then
					arg_121_1.talkMaxDuration = var_124_17

					if var_124_17 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_10
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321030", "story_v_out_321321.awb") ~= 0 then
					local var_124_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321030", "story_v_out_321321.awb") / 1000

					if var_124_18 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_10
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_321321", "321321030", "story_v_out_321321.awb")

						arg_121_1:RecordAudio("321321030", var_124_19)
						arg_121_1:RecordAudio("321321030", var_124_19)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_321321", "321321030", "story_v_out_321321.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_321321", "321321030", "story_v_out_321321.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = math.max(var_124_11, arg_121_1.talkMaxDuration)

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_10) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_10 + var_124_20 and arg_121_1.time_ < var_124_10 + var_124_20 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play321321031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321321031
		arg_125_1.duration_ = 2.97

		local var_125_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_125_0:Play321321032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10104ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10104ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(-0.88, -1.12, -5.99)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10104ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1211ui_story"].transform
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.var_.moveOldPos1211ui_story = var_128_9.localPosition
			end

			local var_128_11 = 0.001

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11
				local var_128_13 = Vector3.New(0, 100, 0)

				var_128_9.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1211ui_story, var_128_13, var_128_12)

				local var_128_14 = manager.ui.mainCamera.transform.position - var_128_9.position

				var_128_9.forward = Vector3.New(var_128_14.x, var_128_14.y, var_128_14.z)

				local var_128_15 = var_128_9.localEulerAngles

				var_128_15.z = 0
				var_128_15.x = 0
				var_128_9.localEulerAngles = var_128_15
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 then
				var_128_9.localPosition = Vector3.New(0, 100, 0)

				local var_128_16 = manager.ui.mainCamera.transform.position - var_128_9.position

				var_128_9.forward = Vector3.New(var_128_16.x, var_128_16.y, var_128_16.z)

				local var_128_17 = var_128_9.localEulerAngles

				var_128_17.z = 0
				var_128_17.x = 0
				var_128_9.localEulerAngles = var_128_17
			end

			local var_128_18 = arg_125_1.actors_["1061ui_story"].transform
			local var_128_19 = 0

			if var_128_19 < arg_125_1.time_ and arg_125_1.time_ <= var_128_19 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061ui_story = var_128_18.localPosition
			end

			local var_128_20 = 0.001

			if var_128_19 <= arg_125_1.time_ and arg_125_1.time_ < var_128_19 + var_128_20 then
				local var_128_21 = (arg_125_1.time_ - var_128_19) / var_128_20
				local var_128_22 = Vector3.New(0.7, -1.18, -6.15)

				var_128_18.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061ui_story, var_128_22, var_128_21)

				local var_128_23 = manager.ui.mainCamera.transform.position - var_128_18.position

				var_128_18.forward = Vector3.New(var_128_23.x, var_128_23.y, var_128_23.z)

				local var_128_24 = var_128_18.localEulerAngles

				var_128_24.z = 0
				var_128_24.x = 0
				var_128_18.localEulerAngles = var_128_24
			end

			if arg_125_1.time_ >= var_128_19 + var_128_20 and arg_125_1.time_ < var_128_19 + var_128_20 + arg_128_0 then
				var_128_18.localPosition = Vector3.New(0.7, -1.18, -6.15)

				local var_128_25 = manager.ui.mainCamera.transform.position - var_128_18.position

				var_128_18.forward = Vector3.New(var_128_25.x, var_128_25.y, var_128_25.z)

				local var_128_26 = var_128_18.localEulerAngles

				var_128_26.z = 0
				var_128_26.x = 0
				var_128_18.localEulerAngles = var_128_26
			end

			local var_128_27 = arg_125_1.actors_["1061ui_story"]
			local var_128_28 = 0

			if var_128_28 < arg_125_1.time_ and arg_125_1.time_ <= var_128_28 + arg_128_0 and not isNil(var_128_27) and arg_125_1.var_.characterEffect1061ui_story == nil then
				arg_125_1.var_.characterEffect1061ui_story = var_128_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_29 = 0.200000002980232

			if var_128_28 <= arg_125_1.time_ and arg_125_1.time_ < var_128_28 + var_128_29 and not isNil(var_128_27) then
				local var_128_30 = (arg_125_1.time_ - var_128_28) / var_128_29

				if arg_125_1.var_.characterEffect1061ui_story and not isNil(var_128_27) then
					arg_125_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_28 + var_128_29 and arg_125_1.time_ < var_128_28 + var_128_29 + arg_128_0 and not isNil(var_128_27) and arg_125_1.var_.characterEffect1061ui_story then
				arg_125_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_128_31 = arg_125_1.actors_["10104ui_story"]
			local var_128_32 = 0

			if var_128_32 < arg_125_1.time_ and arg_125_1.time_ <= var_128_32 + arg_128_0 and not isNil(var_128_31) and arg_125_1.var_.characterEffect10104ui_story == nil then
				arg_125_1.var_.characterEffect10104ui_story = var_128_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_33 = 0.200000002980232

			if var_128_32 <= arg_125_1.time_ and arg_125_1.time_ < var_128_32 + var_128_33 and not isNil(var_128_31) then
				local var_128_34 = (arg_125_1.time_ - var_128_32) / var_128_33

				if arg_125_1.var_.characterEffect10104ui_story and not isNil(var_128_31) then
					local var_128_35 = Mathf.Lerp(0, 0.5, var_128_34)

					arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10104ui_story.fillRatio = var_128_35
				end
			end

			if arg_125_1.time_ >= var_128_32 + var_128_33 and arg_125_1.time_ < var_128_32 + var_128_33 + arg_128_0 and not isNil(var_128_31) and arg_125_1.var_.characterEffect10104ui_story then
				local var_128_36 = 0.5

				arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10104ui_story.fillRatio = var_128_36
			end

			local var_128_37 = 0

			if var_128_37 < arg_125_1.time_ and arg_125_1.time_ <= var_128_37 + arg_128_0 then
				arg_125_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_128_38 = 0

			if var_128_38 < arg_125_1.time_ and arg_125_1.time_ <= var_128_38 + arg_128_0 then
				arg_125_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_39 = 0
			local var_128_40 = 0.175

			if var_128_39 < arg_125_1.time_ and arg_125_1.time_ <= var_128_39 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_41 = arg_125_1:FormatText(StoryNameCfg[612].name)

				arg_125_1.leftNameTxt_.text = var_128_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_42 = arg_125_1:GetWordFromCfg(321321031)
				local var_128_43 = arg_125_1:FormatText(var_128_42.content)

				arg_125_1.text_.text = var_128_43

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_44 = 7
				local var_128_45 = utf8.len(var_128_43)
				local var_128_46 = var_128_44 <= 0 and var_128_40 or var_128_40 * (var_128_45 / var_128_44)

				if var_128_46 > 0 and var_128_40 < var_128_46 then
					arg_125_1.talkMaxDuration = var_128_46

					if var_128_46 + var_128_39 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_46 + var_128_39
					end
				end

				arg_125_1.text_.text = var_128_43
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321031", "story_v_out_321321.awb") ~= 0 then
					local var_128_47 = manager.audio:GetVoiceLength("story_v_out_321321", "321321031", "story_v_out_321321.awb") / 1000

					if var_128_47 + var_128_39 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_47 + var_128_39
					end

					if var_128_42.prefab_name ~= "" and arg_125_1.actors_[var_128_42.prefab_name] ~= nil then
						local var_128_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_42.prefab_name].transform, "story_v_out_321321", "321321031", "story_v_out_321321.awb")

						arg_125_1:RecordAudio("321321031", var_128_48)
						arg_125_1:RecordAudio("321321031", var_128_48)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321321", "321321031", "story_v_out_321321.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321321", "321321031", "story_v_out_321321.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_49 = math.max(var_128_40, arg_125_1.talkMaxDuration)

			if var_128_39 <= arg_125_1.time_ and arg_125_1.time_ < var_128_39 + var_128_49 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_39) / var_128_49

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_39 + var_128_49 and arg_125_1.time_ < var_128_39 + var_128_49 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321321032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321321032
		arg_129_1.duration_ = 1.73

		local var_129_0 = {
			zh = 1.166,
			ja = 1.733
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
				arg_129_0:Play321321033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10104ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10104ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(-0.88, -1.12, -5.99)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10104ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1061ui_story"].transform
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1.var_.moveOldPos1061ui_story = var_132_9.localPosition
			end

			local var_132_11 = 0.001

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11
				local var_132_13 = Vector3.New(0.7, -1.18, -6.15)

				var_132_9.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1061ui_story, var_132_13, var_132_12)

				local var_132_14 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_14.x, var_132_14.y, var_132_14.z)

				local var_132_15 = var_132_9.localEulerAngles

				var_132_15.z = 0
				var_132_15.x = 0
				var_132_9.localEulerAngles = var_132_15
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 then
				var_132_9.localPosition = Vector3.New(0.7, -1.18, -6.15)

				local var_132_16 = manager.ui.mainCamera.transform.position - var_132_9.position

				var_132_9.forward = Vector3.New(var_132_16.x, var_132_16.y, var_132_16.z)

				local var_132_17 = var_132_9.localEulerAngles

				var_132_17.z = 0
				var_132_17.x = 0
				var_132_9.localEulerAngles = var_132_17
			end

			local var_132_18 = arg_129_1.actors_["10104ui_story"]
			local var_132_19 = 0

			if var_132_19 < arg_129_1.time_ and arg_129_1.time_ <= var_132_19 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect10104ui_story == nil then
				arg_129_1.var_.characterEffect10104ui_story = var_132_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_20 = 0.200000002980232

			if var_132_19 <= arg_129_1.time_ and arg_129_1.time_ < var_132_19 + var_132_20 and not isNil(var_132_18) then
				local var_132_21 = (arg_129_1.time_ - var_132_19) / var_132_20

				if arg_129_1.var_.characterEffect10104ui_story and not isNil(var_132_18) then
					arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_19 + var_132_20 and arg_129_1.time_ < var_132_19 + var_132_20 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect10104ui_story then
				arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_132_22 = arg_129_1.actors_["1061ui_story"]
			local var_132_23 = 0

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 and not isNil(var_132_22) and arg_129_1.var_.characterEffect1061ui_story == nil then
				arg_129_1.var_.characterEffect1061ui_story = var_132_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_24 = 0.200000002980232

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_24 and not isNil(var_132_22) then
				local var_132_25 = (arg_129_1.time_ - var_132_23) / var_132_24

				if arg_129_1.var_.characterEffect1061ui_story and not isNil(var_132_22) then
					local var_132_26 = Mathf.Lerp(0, 0.5, var_132_25)

					arg_129_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1061ui_story.fillRatio = var_132_26
				end
			end

			if arg_129_1.time_ >= var_132_23 + var_132_24 and arg_129_1.time_ < var_132_23 + var_132_24 + arg_132_0 and not isNil(var_132_22) and arg_129_1.var_.characterEffect1061ui_story then
				local var_132_27 = 0.5

				arg_129_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1061ui_story.fillRatio = var_132_27
			end

			local var_132_28 = 0
			local var_132_29 = 0.125

			if var_132_28 < arg_129_1.time_ and arg_129_1.time_ <= var_132_28 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_30 = arg_129_1:FormatText(StoryNameCfg[1030].name)

				arg_129_1.leftNameTxt_.text = var_132_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_31 = arg_129_1:GetWordFromCfg(321321032)
				local var_132_32 = arg_129_1:FormatText(var_132_31.content)

				arg_129_1.text_.text = var_132_32

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_33 = 5
				local var_132_34 = utf8.len(var_132_32)
				local var_132_35 = var_132_33 <= 0 and var_132_29 or var_132_29 * (var_132_34 / var_132_33)

				if var_132_35 > 0 and var_132_29 < var_132_35 then
					arg_129_1.talkMaxDuration = var_132_35

					if var_132_35 + var_132_28 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_35 + var_132_28
					end
				end

				arg_129_1.text_.text = var_132_32
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321032", "story_v_out_321321.awb") ~= 0 then
					local var_132_36 = manager.audio:GetVoiceLength("story_v_out_321321", "321321032", "story_v_out_321321.awb") / 1000

					if var_132_36 + var_132_28 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_36 + var_132_28
					end

					if var_132_31.prefab_name ~= "" and arg_129_1.actors_[var_132_31.prefab_name] ~= nil then
						local var_132_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_31.prefab_name].transform, "story_v_out_321321", "321321032", "story_v_out_321321.awb")

						arg_129_1:RecordAudio("321321032", var_132_37)
						arg_129_1:RecordAudio("321321032", var_132_37)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321321", "321321032", "story_v_out_321321.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321321", "321321032", "story_v_out_321321.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_38 = math.max(var_132_29, arg_129_1.talkMaxDuration)

			if var_132_28 <= arg_129_1.time_ and arg_129_1.time_ < var_132_28 + var_132_38 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_28) / var_132_38

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_28 + var_132_38 and arg_129_1.time_ < var_132_28 + var_132_38 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play321321033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321321033
		arg_133_1.duration_ = 4.97

		local var_133_0 = {
			zh = 3.233,
			ja = 4.966
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
				arg_133_0:Play321321034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1061ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1061ui_story == nil then
				arg_133_1.var_.characterEffect1061ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1061ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1061ui_story then
				arg_133_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["10104ui_story"]
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10104ui_story == nil then
				arg_133_1.var_.characterEffect10104ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 and not isNil(var_136_4) then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6

				if arg_133_1.var_.characterEffect10104ui_story and not isNil(var_136_4) then
					local var_136_8 = Mathf.Lerp(0, 0.5, var_136_7)

					arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10104ui_story.fillRatio = var_136_8
				end
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10104ui_story then
				local var_136_9 = 0.5

				arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10104ui_story.fillRatio = var_136_9
			end

			local var_136_10 = 0
			local var_136_11 = 0.3

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_12 = arg_133_1:FormatText(StoryNameCfg[612].name)

				arg_133_1.leftNameTxt_.text = var_136_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_13 = arg_133_1:GetWordFromCfg(321321033)
				local var_136_14 = arg_133_1:FormatText(var_136_13.content)

				arg_133_1.text_.text = var_136_14

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_15 = 12
				local var_136_16 = utf8.len(var_136_14)
				local var_136_17 = var_136_15 <= 0 and var_136_11 or var_136_11 * (var_136_16 / var_136_15)

				if var_136_17 > 0 and var_136_11 < var_136_17 then
					arg_133_1.talkMaxDuration = var_136_17

					if var_136_17 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_17 + var_136_10
					end
				end

				arg_133_1.text_.text = var_136_14
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321033", "story_v_out_321321.awb") ~= 0 then
					local var_136_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321033", "story_v_out_321321.awb") / 1000

					if var_136_18 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_10
					end

					if var_136_13.prefab_name ~= "" and arg_133_1.actors_[var_136_13.prefab_name] ~= nil then
						local var_136_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_13.prefab_name].transform, "story_v_out_321321", "321321033", "story_v_out_321321.awb")

						arg_133_1:RecordAudio("321321033", var_136_19)
						arg_133_1:RecordAudio("321321033", var_136_19)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321321", "321321033", "story_v_out_321321.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321321", "321321033", "story_v_out_321321.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_20 = math.max(var_136_11, arg_133_1.talkMaxDuration)

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_20 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_10) / var_136_20

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_10 + var_136_20 and arg_133_1.time_ < var_136_10 + var_136_20 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321321034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321321034
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play321321035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = "L11f"

			if arg_137_1.bgs_[var_140_0] == nil then
				local var_140_1 = Object.Instantiate(arg_137_1.paintGo_)

				var_140_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_140_0)
				var_140_1.name = var_140_0
				var_140_1.transform.parent = arg_137_1.stage_.transform
				var_140_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.bgs_[var_140_0] = var_140_1
			end

			local var_140_2 = 2

			if var_140_2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				local var_140_3 = manager.ui.mainCamera.transform.localPosition
				local var_140_4 = Vector3.New(0, 0, 10) + Vector3.New(var_140_3.x, var_140_3.y, 0)
				local var_140_5 = arg_137_1.bgs_.L11f

				var_140_5.transform.localPosition = var_140_4
				var_140_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_6 = var_140_5:GetComponent("SpriteRenderer")

				if var_140_6 and var_140_6.sprite then
					local var_140_7 = (var_140_5.transform.localPosition - var_140_3).z
					local var_140_8 = manager.ui.mainCameraCom_
					local var_140_9 = 2 * var_140_7 * Mathf.Tan(var_140_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_140_10 = var_140_9 * var_140_8.aspect
					local var_140_11 = var_140_6.sprite.bounds.size.x
					local var_140_12 = var_140_6.sprite.bounds.size.y
					local var_140_13 = var_140_10 / var_140_11
					local var_140_14 = var_140_9 / var_140_12
					local var_140_15 = var_140_14 < var_140_13 and var_140_13 or var_140_14

					var_140_5.transform.localScale = Vector3.New(var_140_15, var_140_15, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "L11f" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_16 = 3.999999999999

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_17 = 0.3

			if arg_137_1.time_ >= var_140_16 + var_140_17 and arg_137_1.time_ < var_140_16 + var_140_17 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_18 = 0

			if var_140_18 < arg_137_1.time_ and arg_137_1.time_ <= var_140_18 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_19 = 2

			if var_140_18 <= arg_137_1.time_ and arg_137_1.time_ < var_140_18 + var_140_19 then
				local var_140_20 = (arg_137_1.time_ - var_140_18) / var_140_19
				local var_140_21 = Color.New(0, 0, 0)

				var_140_21.a = Mathf.Lerp(0, 1, var_140_20)
				arg_137_1.mask_.color = var_140_21
			end

			if arg_137_1.time_ >= var_140_18 + var_140_19 and arg_137_1.time_ < var_140_18 + var_140_19 + arg_140_0 then
				local var_140_22 = Color.New(0, 0, 0)

				var_140_22.a = 1
				arg_137_1.mask_.color = var_140_22
			end

			local var_140_23 = 2

			if var_140_23 < arg_137_1.time_ and arg_137_1.time_ <= var_140_23 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_24 = 2

			if var_140_23 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_24 then
				local var_140_25 = (arg_137_1.time_ - var_140_23) / var_140_24
				local var_140_26 = Color.New(0, 0, 0)

				var_140_26.a = Mathf.Lerp(1, 0, var_140_25)
				arg_137_1.mask_.color = var_140_26
			end

			if arg_137_1.time_ >= var_140_23 + var_140_24 and arg_137_1.time_ < var_140_23 + var_140_24 + arg_140_0 then
				local var_140_27 = Color.New(0, 0, 0)
				local var_140_28 = 0

				arg_137_1.mask_.enabled = false
				var_140_27.a = var_140_28
				arg_137_1.mask_.color = var_140_27
			end

			local var_140_29 = arg_137_1.actors_["10104ui_story"].transform
			local var_140_30 = 1.96599999815226

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1.var_.moveOldPos10104ui_story = var_140_29.localPosition
			end

			local var_140_31 = 0.001

			if var_140_30 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_31 then
				local var_140_32 = (arg_137_1.time_ - var_140_30) / var_140_31
				local var_140_33 = Vector3.New(0, 100, 0)

				var_140_29.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10104ui_story, var_140_33, var_140_32)

				local var_140_34 = manager.ui.mainCamera.transform.position - var_140_29.position

				var_140_29.forward = Vector3.New(var_140_34.x, var_140_34.y, var_140_34.z)

				local var_140_35 = var_140_29.localEulerAngles

				var_140_35.z = 0
				var_140_35.x = 0
				var_140_29.localEulerAngles = var_140_35
			end

			if arg_137_1.time_ >= var_140_30 + var_140_31 and arg_137_1.time_ < var_140_30 + var_140_31 + arg_140_0 then
				var_140_29.localPosition = Vector3.New(0, 100, 0)

				local var_140_36 = manager.ui.mainCamera.transform.position - var_140_29.position

				var_140_29.forward = Vector3.New(var_140_36.x, var_140_36.y, var_140_36.z)

				local var_140_37 = var_140_29.localEulerAngles

				var_140_37.z = 0
				var_140_37.x = 0
				var_140_29.localEulerAngles = var_140_37
			end

			local var_140_38 = arg_137_1.actors_["1061ui_story"].transform
			local var_140_39 = 1.96599999815226

			if var_140_39 < arg_137_1.time_ and arg_137_1.time_ <= var_140_39 + arg_140_0 then
				arg_137_1.var_.moveOldPos1061ui_story = var_140_38.localPosition
			end

			local var_140_40 = 0.001

			if var_140_39 <= arg_137_1.time_ and arg_137_1.time_ < var_140_39 + var_140_40 then
				local var_140_41 = (arg_137_1.time_ - var_140_39) / var_140_40
				local var_140_42 = Vector3.New(0, 100, 0)

				var_140_38.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1061ui_story, var_140_42, var_140_41)

				local var_140_43 = manager.ui.mainCamera.transform.position - var_140_38.position

				var_140_38.forward = Vector3.New(var_140_43.x, var_140_43.y, var_140_43.z)

				local var_140_44 = var_140_38.localEulerAngles

				var_140_44.z = 0
				var_140_44.x = 0
				var_140_38.localEulerAngles = var_140_44
			end

			if arg_137_1.time_ >= var_140_39 + var_140_40 and arg_137_1.time_ < var_140_39 + var_140_40 + arg_140_0 then
				var_140_38.localPosition = Vector3.New(0, 100, 0)

				local var_140_45 = manager.ui.mainCamera.transform.position - var_140_38.position

				var_140_38.forward = Vector3.New(var_140_45.x, var_140_45.y, var_140_45.z)

				local var_140_46 = var_140_38.localEulerAngles

				var_140_46.z = 0
				var_140_46.x = 0
				var_140_38.localEulerAngles = var_140_46
			end

			local var_140_47 = arg_137_1.actors_["1061ui_story"]
			local var_140_48 = 1.96599999815226

			if var_140_48 < arg_137_1.time_ and arg_137_1.time_ <= var_140_48 + arg_140_0 and not isNil(var_140_47) and arg_137_1.var_.characterEffect1061ui_story == nil then
				arg_137_1.var_.characterEffect1061ui_story = var_140_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_49 = 0.034000001847744

			if var_140_48 <= arg_137_1.time_ and arg_137_1.time_ < var_140_48 + var_140_49 and not isNil(var_140_47) then
				local var_140_50 = (arg_137_1.time_ - var_140_48) / var_140_49

				if arg_137_1.var_.characterEffect1061ui_story and not isNil(var_140_47) then
					local var_140_51 = Mathf.Lerp(0, 0.5, var_140_50)

					arg_137_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1061ui_story.fillRatio = var_140_51
				end
			end

			if arg_137_1.time_ >= var_140_48 + var_140_49 and arg_137_1.time_ < var_140_48 + var_140_49 + arg_140_0 and not isNil(var_140_47) and arg_137_1.var_.characterEffect1061ui_story then
				local var_140_52 = 0.5

				arg_137_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1061ui_story.fillRatio = var_140_52
			end

			local var_140_53 = arg_137_1.bgs_.L11f.transform
			local var_140_54 = 2

			if var_140_54 < arg_137_1.time_ and arg_137_1.time_ <= var_140_54 + arg_140_0 then
				arg_137_1.var_.moveOldPosL11f = var_140_53.localPosition
			end

			local var_140_55 = 4

			if var_140_54 <= arg_137_1.time_ and arg_137_1.time_ < var_140_54 + var_140_55 then
				local var_140_56 = (arg_137_1.time_ - var_140_54) / var_140_55
				local var_140_57 = Vector3.New(0, 1, 9.5)

				var_140_53.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPosL11f, var_140_57, var_140_56)
			end

			if arg_137_1.time_ >= var_140_54 + var_140_55 and arg_137_1.time_ < var_140_54 + var_140_55 + arg_140_0 then
				var_140_53.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_140_58 = 4

			if var_140_58 < arg_137_1.time_ and arg_137_1.time_ <= var_140_58 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			local var_140_59 = 2

			if arg_137_1.time_ >= var_140_58 + var_140_59 and arg_137_1.time_ < var_140_58 + var_140_59 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_60 = 0.633333333333333
			local var_140_61 = 1

			if var_140_60 < arg_137_1.time_ and arg_137_1.time_ <= var_140_60 + arg_140_0 then
				local var_140_62 = "stop"
				local var_140_63 = "effect"

				arg_137_1:AudioAction(var_140_62, var_140_63, "se_story_141", "se_story_140_amb_drain", "")
			end

			local var_140_64 = 1.8
			local var_140_65 = 1

			if var_140_64 < arg_137_1.time_ and arg_137_1.time_ <= var_140_64 + arg_140_0 then
				local var_140_66 = "play"
				local var_140_67 = "effect"

				arg_137_1:AudioAction(var_140_66, var_140_67, "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_68 = 4
			local var_140_69 = 1.525

			if var_140_68 < arg_137_1.time_ and arg_137_1.time_ <= var_140_68 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_70 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_70:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_71 = arg_137_1:GetWordFromCfg(321321034)
				local var_140_72 = arg_137_1:FormatText(var_140_71.content)

				arg_137_1.text_.text = var_140_72

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_73 = 61
				local var_140_74 = utf8.len(var_140_72)
				local var_140_75 = var_140_73 <= 0 and var_140_69 or var_140_69 * (var_140_74 / var_140_73)

				if var_140_75 > 0 and var_140_69 < var_140_75 then
					arg_137_1.talkMaxDuration = var_140_75
					var_140_68 = var_140_68 + 0.3

					if var_140_75 + var_140_68 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_75 + var_140_68
					end
				end

				arg_137_1.text_.text = var_140_72
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_76 = var_140_68 + 0.3
			local var_140_77 = math.max(var_140_69, arg_137_1.talkMaxDuration)

			if var_140_76 <= arg_137_1.time_ and arg_137_1.time_ < var_140_76 + var_140_77 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_76) / var_140_77

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_76 + var_140_77 and arg_137_1.time_ < var_140_76 + var_140_77 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "L11f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play321321035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321321035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321321036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.55

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(321321035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 62
				local var_146_5 = utf8.len(var_146_3)
				local var_146_6 = var_146_4 <= 0 and var_146_1 or var_146_1 * (var_146_5 / var_146_4)

				if var_146_6 > 0 and var_146_1 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_7 and arg_143_1.time_ < var_146_0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321321036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321321036
		arg_147_1.duration_ = 4.23

		local var_147_0 = {
			zh = 2.933,
			ja = 4.233
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
				arg_147_0:Play321321037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = "404001ui_story"

			if arg_147_1.actors_[var_150_0] == nil then
				local var_150_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_150_1) then
					local var_150_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_147_1.stage_.transform)

					var_150_2.name = var_150_0
					var_150_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_147_1.actors_[var_150_0] = var_150_2

					local var_150_3 = var_150_2:GetComponentInChildren(typeof(CharacterEffect))

					var_150_3.enabled = true

					local var_150_4 = GameObjectTools.GetOrAddComponent(var_150_2, typeof(DynamicBoneHelper))

					if var_150_4 then
						var_150_4:EnableDynamicBone(false)
					end

					arg_147_1:ShowWeapon(var_150_3.transform, false)

					arg_147_1.var_[var_150_0 .. "Animator"] = var_150_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_147_1.var_[var_150_0 .. "Animator"].applyRootMotion = true
					arg_147_1.var_[var_150_0 .. "LipSync"] = var_150_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_150_5 = arg_147_1.actors_["404001ui_story"].transform
			local var_150_6 = 0

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.var_.moveOldPos404001ui_story = var_150_5.localPosition
			end

			local var_150_7 = 0.001

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_7 then
				local var_150_8 = (arg_147_1.time_ - var_150_6) / var_150_7
				local var_150_9 = Vector3.New(0, -1.55, -5.5)

				var_150_5.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos404001ui_story, var_150_9, var_150_8)

				local var_150_10 = manager.ui.mainCamera.transform.position - var_150_5.position

				var_150_5.forward = Vector3.New(var_150_10.x, var_150_10.y, var_150_10.z)

				local var_150_11 = var_150_5.localEulerAngles

				var_150_11.z = 0
				var_150_11.x = 0
				var_150_5.localEulerAngles = var_150_11
			end

			if arg_147_1.time_ >= var_150_6 + var_150_7 and arg_147_1.time_ < var_150_6 + var_150_7 + arg_150_0 then
				var_150_5.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_150_12 = manager.ui.mainCamera.transform.position - var_150_5.position

				var_150_5.forward = Vector3.New(var_150_12.x, var_150_12.y, var_150_12.z)

				local var_150_13 = var_150_5.localEulerAngles

				var_150_13.z = 0
				var_150_13.x = 0
				var_150_5.localEulerAngles = var_150_13
			end

			local var_150_14 = arg_147_1.actors_["404001ui_story"]
			local var_150_15 = 0

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.characterEffect404001ui_story == nil then
				arg_147_1.var_.characterEffect404001ui_story = var_150_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_16 = 0.200000002980232

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_16 and not isNil(var_150_14) then
				local var_150_17 = (arg_147_1.time_ - var_150_15) / var_150_16

				if arg_147_1.var_.characterEffect404001ui_story and not isNil(var_150_14) then
					arg_147_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_15 + var_150_16 and arg_147_1.time_ < var_150_15 + var_150_16 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.characterEffect404001ui_story then
				arg_147_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_150_18 = 0

			if var_150_18 < arg_147_1.time_ and arg_147_1.time_ <= var_150_18 + arg_150_0 then
				arg_147_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_150_19 = 0

			if var_150_19 < arg_147_1.time_ and arg_147_1.time_ <= var_150_19 + arg_150_0 then
				arg_147_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_150_20 = 0
			local var_150_21 = 0.275

			if var_150_20 < arg_147_1.time_ and arg_147_1.time_ <= var_150_20 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_22 = arg_147_1:FormatText(StoryNameCfg[668].name)

				arg_147_1.leftNameTxt_.text = var_150_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_23 = arg_147_1:GetWordFromCfg(321321036)
				local var_150_24 = arg_147_1:FormatText(var_150_23.content)

				arg_147_1.text_.text = var_150_24

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_25 = 11
				local var_150_26 = utf8.len(var_150_24)
				local var_150_27 = var_150_25 <= 0 and var_150_21 or var_150_21 * (var_150_26 / var_150_25)

				if var_150_27 > 0 and var_150_21 < var_150_27 then
					arg_147_1.talkMaxDuration = var_150_27

					if var_150_27 + var_150_20 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_27 + var_150_20
					end
				end

				arg_147_1.text_.text = var_150_24
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321036", "story_v_out_321321.awb") ~= 0 then
					local var_150_28 = manager.audio:GetVoiceLength("story_v_out_321321", "321321036", "story_v_out_321321.awb") / 1000

					if var_150_28 + var_150_20 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_28 + var_150_20
					end

					if var_150_23.prefab_name ~= "" and arg_147_1.actors_[var_150_23.prefab_name] ~= nil then
						local var_150_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_23.prefab_name].transform, "story_v_out_321321", "321321036", "story_v_out_321321.awb")

						arg_147_1:RecordAudio("321321036", var_150_29)
						arg_147_1:RecordAudio("321321036", var_150_29)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321321", "321321036", "story_v_out_321321.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321321", "321321036", "story_v_out_321321.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_30 = math.max(var_150_21, arg_147_1.talkMaxDuration)

			if var_150_20 <= arg_147_1.time_ and arg_147_1.time_ < var_150_20 + var_150_30 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_20) / var_150_30

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_20 + var_150_30 and arg_147_1.time_ < var_150_20 + var_150_30 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play321321037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321321037
		arg_151_1.duration_ = 7.47

		local var_151_0 = {
			zh = 6.533,
			ja = 7.466
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
				arg_151_0:Play321321038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1211ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1211ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1211ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["404001ui_story"].transform
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1.var_.moveOldPos404001ui_story = var_154_9.localPosition
			end

			local var_154_11 = 0.001

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11
				local var_154_13 = Vector3.New(0.8, -1.55, -5.5)

				var_154_9.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos404001ui_story, var_154_13, var_154_12)

				local var_154_14 = manager.ui.mainCamera.transform.position - var_154_9.position

				var_154_9.forward = Vector3.New(var_154_14.x, var_154_14.y, var_154_14.z)

				local var_154_15 = var_154_9.localEulerAngles

				var_154_15.z = 0
				var_154_15.x = 0
				var_154_9.localEulerAngles = var_154_15
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 then
				var_154_9.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_154_16 = manager.ui.mainCamera.transform.position - var_154_9.position

				var_154_9.forward = Vector3.New(var_154_16.x, var_154_16.y, var_154_16.z)

				local var_154_17 = var_154_9.localEulerAngles

				var_154_17.z = 0
				var_154_17.x = 0
				var_154_9.localEulerAngles = var_154_17
			end

			local var_154_18 = arg_151_1.actors_["1211ui_story"]
			local var_154_19 = 0

			if var_154_19 < arg_151_1.time_ and arg_151_1.time_ <= var_154_19 + arg_154_0 and not isNil(var_154_18) and arg_151_1.var_.characterEffect1211ui_story == nil then
				arg_151_1.var_.characterEffect1211ui_story = var_154_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_20 = 0.200000002980232

			if var_154_19 <= arg_151_1.time_ and arg_151_1.time_ < var_154_19 + var_154_20 and not isNil(var_154_18) then
				local var_154_21 = (arg_151_1.time_ - var_154_19) / var_154_20

				if arg_151_1.var_.characterEffect1211ui_story and not isNil(var_154_18) then
					arg_151_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_19 + var_154_20 and arg_151_1.time_ < var_154_19 + var_154_20 + arg_154_0 and not isNil(var_154_18) and arg_151_1.var_.characterEffect1211ui_story then
				arg_151_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_154_22 = arg_151_1.actors_["404001ui_story"]
			local var_154_23 = 0

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 and not isNil(var_154_22) and arg_151_1.var_.characterEffect404001ui_story == nil then
				arg_151_1.var_.characterEffect404001ui_story = var_154_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_24 = 0.200000002980232

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_24 and not isNil(var_154_22) then
				local var_154_25 = (arg_151_1.time_ - var_154_23) / var_154_24

				if arg_151_1.var_.characterEffect404001ui_story and not isNil(var_154_22) then
					local var_154_26 = Mathf.Lerp(0, 0.5, var_154_25)

					arg_151_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_151_1.var_.characterEffect404001ui_story.fillRatio = var_154_26
				end
			end

			if arg_151_1.time_ >= var_154_23 + var_154_24 and arg_151_1.time_ < var_154_23 + var_154_24 + arg_154_0 and not isNil(var_154_22) and arg_151_1.var_.characterEffect404001ui_story then
				local var_154_27 = 0.5

				arg_151_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_151_1.var_.characterEffect404001ui_story.fillRatio = var_154_27
			end

			local var_154_28 = 0

			if var_154_28 < arg_151_1.time_ and arg_151_1.time_ <= var_154_28 + arg_154_0 then
				arg_151_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			local var_154_29 = 0

			if var_154_29 < arg_151_1.time_ and arg_151_1.time_ <= var_154_29 + arg_154_0 then
				arg_151_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_154_30 = 0
			local var_154_31 = 0.675

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_32 = arg_151_1:FormatText(StoryNameCfg[37].name)

				arg_151_1.leftNameTxt_.text = var_154_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_33 = arg_151_1:GetWordFromCfg(321321037)
				local var_154_34 = arg_151_1:FormatText(var_154_33.content)

				arg_151_1.text_.text = var_154_34

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_35 = 27
				local var_154_36 = utf8.len(var_154_34)
				local var_154_37 = var_154_35 <= 0 and var_154_31 or var_154_31 * (var_154_36 / var_154_35)

				if var_154_37 > 0 and var_154_31 < var_154_37 then
					arg_151_1.talkMaxDuration = var_154_37

					if var_154_37 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_37 + var_154_30
					end
				end

				arg_151_1.text_.text = var_154_34
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321037", "story_v_out_321321.awb") ~= 0 then
					local var_154_38 = manager.audio:GetVoiceLength("story_v_out_321321", "321321037", "story_v_out_321321.awb") / 1000

					if var_154_38 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_38 + var_154_30
					end

					if var_154_33.prefab_name ~= "" and arg_151_1.actors_[var_154_33.prefab_name] ~= nil then
						local var_154_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_33.prefab_name].transform, "story_v_out_321321", "321321037", "story_v_out_321321.awb")

						arg_151_1:RecordAudio("321321037", var_154_39)
						arg_151_1:RecordAudio("321321037", var_154_39)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321321", "321321037", "story_v_out_321321.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321321", "321321037", "story_v_out_321321.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_40 = math.max(var_154_31, arg_151_1.talkMaxDuration)

			if var_154_30 <= arg_151_1.time_ and arg_151_1.time_ < var_154_30 + var_154_40 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_30) / var_154_40

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_30 + var_154_40 and arg_151_1.time_ < var_154_30 + var_154_40 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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

		arg_151_1:InitPlayNodeList()
	end,
	Play321321038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321321038
		arg_155_1.duration_ = 11.5

		local var_155_0 = {
			zh = 5.5,
			ja = 11.5
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
				arg_155_0:Play321321039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1061ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1061ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0.7, -1.18, -6.15)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1061ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0.7, -1.18, -6.15)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["1211ui_story"].transform
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.var_.moveOldPos1211ui_story = var_158_9.localPosition
			end

			local var_158_11 = 0.001

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11
				local var_158_13 = Vector3.New(-0.7, -0.67, -6.07)

				var_158_9.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1211ui_story, var_158_13, var_158_12)

				local var_158_14 = manager.ui.mainCamera.transform.position - var_158_9.position

				var_158_9.forward = Vector3.New(var_158_14.x, var_158_14.y, var_158_14.z)

				local var_158_15 = var_158_9.localEulerAngles

				var_158_15.z = 0
				var_158_15.x = 0
				var_158_9.localEulerAngles = var_158_15
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 then
				var_158_9.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_158_16 = manager.ui.mainCamera.transform.position - var_158_9.position

				var_158_9.forward = Vector3.New(var_158_16.x, var_158_16.y, var_158_16.z)

				local var_158_17 = var_158_9.localEulerAngles

				var_158_17.z = 0
				var_158_17.x = 0
				var_158_9.localEulerAngles = var_158_17
			end

			local var_158_18 = arg_155_1.actors_["404001ui_story"].transform
			local var_158_19 = 0

			if var_158_19 < arg_155_1.time_ and arg_155_1.time_ <= var_158_19 + arg_158_0 then
				arg_155_1.var_.moveOldPos404001ui_story = var_158_18.localPosition
			end

			local var_158_20 = 0.001

			if var_158_19 <= arg_155_1.time_ and arg_155_1.time_ < var_158_19 + var_158_20 then
				local var_158_21 = (arg_155_1.time_ - var_158_19) / var_158_20
				local var_158_22 = Vector3.New(0, 100, 0)

				var_158_18.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos404001ui_story, var_158_22, var_158_21)

				local var_158_23 = manager.ui.mainCamera.transform.position - var_158_18.position

				var_158_18.forward = Vector3.New(var_158_23.x, var_158_23.y, var_158_23.z)

				local var_158_24 = var_158_18.localEulerAngles

				var_158_24.z = 0
				var_158_24.x = 0
				var_158_18.localEulerAngles = var_158_24
			end

			if arg_155_1.time_ >= var_158_19 + var_158_20 and arg_155_1.time_ < var_158_19 + var_158_20 + arg_158_0 then
				var_158_18.localPosition = Vector3.New(0, 100, 0)

				local var_158_25 = manager.ui.mainCamera.transform.position - var_158_18.position

				var_158_18.forward = Vector3.New(var_158_25.x, var_158_25.y, var_158_25.z)

				local var_158_26 = var_158_18.localEulerAngles

				var_158_26.z = 0
				var_158_26.x = 0
				var_158_18.localEulerAngles = var_158_26
			end

			local var_158_27 = arg_155_1.actors_["1061ui_story"]
			local var_158_28 = 0

			if var_158_28 < arg_155_1.time_ and arg_155_1.time_ <= var_158_28 + arg_158_0 and not isNil(var_158_27) and arg_155_1.var_.characterEffect1061ui_story == nil then
				arg_155_1.var_.characterEffect1061ui_story = var_158_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_29 = 0.200000002980232

			if var_158_28 <= arg_155_1.time_ and arg_155_1.time_ < var_158_28 + var_158_29 and not isNil(var_158_27) then
				local var_158_30 = (arg_155_1.time_ - var_158_28) / var_158_29

				if arg_155_1.var_.characterEffect1061ui_story and not isNil(var_158_27) then
					arg_155_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_28 + var_158_29 and arg_155_1.time_ < var_158_28 + var_158_29 + arg_158_0 and not isNil(var_158_27) and arg_155_1.var_.characterEffect1061ui_story then
				arg_155_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_158_31 = arg_155_1.actors_["1211ui_story"]
			local var_158_32 = 0

			if var_158_32 < arg_155_1.time_ and arg_155_1.time_ <= var_158_32 + arg_158_0 and not isNil(var_158_31) and arg_155_1.var_.characterEffect1211ui_story == nil then
				arg_155_1.var_.characterEffect1211ui_story = var_158_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_33 = 0.200000002980232

			if var_158_32 <= arg_155_1.time_ and arg_155_1.time_ < var_158_32 + var_158_33 and not isNil(var_158_31) then
				local var_158_34 = (arg_155_1.time_ - var_158_32) / var_158_33

				if arg_155_1.var_.characterEffect1211ui_story and not isNil(var_158_31) then
					local var_158_35 = Mathf.Lerp(0, 0.5, var_158_34)

					arg_155_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1211ui_story.fillRatio = var_158_35
				end
			end

			if arg_155_1.time_ >= var_158_32 + var_158_33 and arg_155_1.time_ < var_158_32 + var_158_33 + arg_158_0 and not isNil(var_158_31) and arg_155_1.var_.characterEffect1211ui_story then
				local var_158_36 = 0.5

				arg_155_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1211ui_story.fillRatio = var_158_36
			end

			local var_158_37 = 0

			if var_158_37 < arg_155_1.time_ and arg_155_1.time_ <= var_158_37 + arg_158_0 then
				arg_155_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_158_38 = 0

			if var_158_38 < arg_155_1.time_ and arg_155_1.time_ <= var_158_38 + arg_158_0 then
				arg_155_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_158_39 = 0
			local var_158_40 = 0.675

			if var_158_39 < arg_155_1.time_ and arg_155_1.time_ <= var_158_39 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_41 = arg_155_1:FormatText(StoryNameCfg[612].name)

				arg_155_1.leftNameTxt_.text = var_158_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_42 = arg_155_1:GetWordFromCfg(321321038)
				local var_158_43 = arg_155_1:FormatText(var_158_42.content)

				arg_155_1.text_.text = var_158_43

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_44 = 27
				local var_158_45 = utf8.len(var_158_43)
				local var_158_46 = var_158_44 <= 0 and var_158_40 or var_158_40 * (var_158_45 / var_158_44)

				if var_158_46 > 0 and var_158_40 < var_158_46 then
					arg_155_1.talkMaxDuration = var_158_46

					if var_158_46 + var_158_39 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_46 + var_158_39
					end
				end

				arg_155_1.text_.text = var_158_43
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321038", "story_v_out_321321.awb") ~= 0 then
					local var_158_47 = manager.audio:GetVoiceLength("story_v_out_321321", "321321038", "story_v_out_321321.awb") / 1000

					if var_158_47 + var_158_39 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_47 + var_158_39
					end

					if var_158_42.prefab_name ~= "" and arg_155_1.actors_[var_158_42.prefab_name] ~= nil then
						local var_158_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_42.prefab_name].transform, "story_v_out_321321", "321321038", "story_v_out_321321.awb")

						arg_155_1:RecordAudio("321321038", var_158_48)
						arg_155_1:RecordAudio("321321038", var_158_48)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321321", "321321038", "story_v_out_321321.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321321", "321321038", "story_v_out_321321.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_49 = math.max(var_158_40, arg_155_1.talkMaxDuration)

			if var_158_39 <= arg_155_1.time_ and arg_155_1.time_ < var_158_39 + var_158_49 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_39) / var_158_49

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_39 + var_158_49 and arg_155_1.time_ < var_158_39 + var_158_49 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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

		arg_155_1:InitPlayNodeList()
	end,
	Play321321039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321321039
		arg_159_1.duration_ = 2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321321040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10104ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10104ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(-0.88, -1.12, -5.99)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10104ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1061ui_story"].transform
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.var_.moveOldPos1061ui_story = var_162_9.localPosition
			end

			local var_162_11 = 0.001

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11
				local var_162_13 = Vector3.New(0.7, -1.18, -6.15)

				var_162_9.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1061ui_story, var_162_13, var_162_12)

				local var_162_14 = manager.ui.mainCamera.transform.position - var_162_9.position

				var_162_9.forward = Vector3.New(var_162_14.x, var_162_14.y, var_162_14.z)

				local var_162_15 = var_162_9.localEulerAngles

				var_162_15.z = 0
				var_162_15.x = 0
				var_162_9.localEulerAngles = var_162_15
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 then
				var_162_9.localPosition = Vector3.New(0.7, -1.18, -6.15)

				local var_162_16 = manager.ui.mainCamera.transform.position - var_162_9.position

				var_162_9.forward = Vector3.New(var_162_16.x, var_162_16.y, var_162_16.z)

				local var_162_17 = var_162_9.localEulerAngles

				var_162_17.z = 0
				var_162_17.x = 0
				var_162_9.localEulerAngles = var_162_17
			end

			local var_162_18 = arg_159_1.actors_["1211ui_story"].transform
			local var_162_19 = 0

			if var_162_19 < arg_159_1.time_ and arg_159_1.time_ <= var_162_19 + arg_162_0 then
				arg_159_1.var_.moveOldPos1211ui_story = var_162_18.localPosition
			end

			local var_162_20 = 0.001

			if var_162_19 <= arg_159_1.time_ and arg_159_1.time_ < var_162_19 + var_162_20 then
				local var_162_21 = (arg_159_1.time_ - var_162_19) / var_162_20
				local var_162_22 = Vector3.New(0, 100, 0)

				var_162_18.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1211ui_story, var_162_22, var_162_21)

				local var_162_23 = manager.ui.mainCamera.transform.position - var_162_18.position

				var_162_18.forward = Vector3.New(var_162_23.x, var_162_23.y, var_162_23.z)

				local var_162_24 = var_162_18.localEulerAngles

				var_162_24.z = 0
				var_162_24.x = 0
				var_162_18.localEulerAngles = var_162_24
			end

			if arg_159_1.time_ >= var_162_19 + var_162_20 and arg_159_1.time_ < var_162_19 + var_162_20 + arg_162_0 then
				var_162_18.localPosition = Vector3.New(0, 100, 0)

				local var_162_25 = manager.ui.mainCamera.transform.position - var_162_18.position

				var_162_18.forward = Vector3.New(var_162_25.x, var_162_25.y, var_162_25.z)

				local var_162_26 = var_162_18.localEulerAngles

				var_162_26.z = 0
				var_162_26.x = 0
				var_162_18.localEulerAngles = var_162_26
			end

			local var_162_27 = arg_159_1.actors_["10104ui_story"]
			local var_162_28 = 0

			if var_162_28 < arg_159_1.time_ and arg_159_1.time_ <= var_162_28 + arg_162_0 and not isNil(var_162_27) and arg_159_1.var_.characterEffect10104ui_story == nil then
				arg_159_1.var_.characterEffect10104ui_story = var_162_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_29 = 0.200000002980232

			if var_162_28 <= arg_159_1.time_ and arg_159_1.time_ < var_162_28 + var_162_29 and not isNil(var_162_27) then
				local var_162_30 = (arg_159_1.time_ - var_162_28) / var_162_29

				if arg_159_1.var_.characterEffect10104ui_story and not isNil(var_162_27) then
					arg_159_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_28 + var_162_29 and arg_159_1.time_ < var_162_28 + var_162_29 + arg_162_0 and not isNil(var_162_27) and arg_159_1.var_.characterEffect10104ui_story then
				arg_159_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_162_31 = arg_159_1.actors_["1061ui_story"]
			local var_162_32 = 0

			if var_162_32 < arg_159_1.time_ and arg_159_1.time_ <= var_162_32 + arg_162_0 and not isNil(var_162_31) and arg_159_1.var_.characterEffect1061ui_story == nil then
				arg_159_1.var_.characterEffect1061ui_story = var_162_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_33 = 0.200000002980232

			if var_162_32 <= arg_159_1.time_ and arg_159_1.time_ < var_162_32 + var_162_33 and not isNil(var_162_31) then
				local var_162_34 = (arg_159_1.time_ - var_162_32) / var_162_33

				if arg_159_1.var_.characterEffect1061ui_story and not isNil(var_162_31) then
					local var_162_35 = Mathf.Lerp(0, 0.5, var_162_34)

					arg_159_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1061ui_story.fillRatio = var_162_35
				end
			end

			if arg_159_1.time_ >= var_162_32 + var_162_33 and arg_159_1.time_ < var_162_32 + var_162_33 + arg_162_0 and not isNil(var_162_31) and arg_159_1.var_.characterEffect1061ui_story then
				local var_162_36 = 0.5

				arg_159_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1061ui_story.fillRatio = var_162_36
			end

			local var_162_37 = 0

			if var_162_37 < arg_159_1.time_ and arg_159_1.time_ <= var_162_37 + arg_162_0 then
				arg_159_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_162_38 = 0

			if var_162_38 < arg_159_1.time_ and arg_159_1.time_ <= var_162_38 + arg_162_0 then
				arg_159_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_162_39 = 0
			local var_162_40 = 0.15

			if var_162_39 < arg_159_1.time_ and arg_159_1.time_ <= var_162_39 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_41 = arg_159_1:FormatText(StoryNameCfg[1030].name)

				arg_159_1.leftNameTxt_.text = var_162_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_42 = arg_159_1:GetWordFromCfg(321321039)
				local var_162_43 = arg_159_1:FormatText(var_162_42.content)

				arg_159_1.text_.text = var_162_43

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_44 = 6
				local var_162_45 = utf8.len(var_162_43)
				local var_162_46 = var_162_44 <= 0 and var_162_40 or var_162_40 * (var_162_45 / var_162_44)

				if var_162_46 > 0 and var_162_40 < var_162_46 then
					arg_159_1.talkMaxDuration = var_162_46

					if var_162_46 + var_162_39 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_46 + var_162_39
					end
				end

				arg_159_1.text_.text = var_162_43
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321039", "story_v_out_321321.awb") ~= 0 then
					local var_162_47 = manager.audio:GetVoiceLength("story_v_out_321321", "321321039", "story_v_out_321321.awb") / 1000

					if var_162_47 + var_162_39 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_47 + var_162_39
					end

					if var_162_42.prefab_name ~= "" and arg_159_1.actors_[var_162_42.prefab_name] ~= nil then
						local var_162_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_42.prefab_name].transform, "story_v_out_321321", "321321039", "story_v_out_321321.awb")

						arg_159_1:RecordAudio("321321039", var_162_48)
						arg_159_1:RecordAudio("321321039", var_162_48)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321321", "321321039", "story_v_out_321321.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321321", "321321039", "story_v_out_321321.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_49 = math.max(var_162_40, arg_159_1.talkMaxDuration)

			if var_162_39 <= arg_159_1.time_ and arg_159_1.time_ < var_162_39 + var_162_49 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_39) / var_162_49

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_39 + var_162_49 and arg_159_1.time_ < var_162_39 + var_162_49 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321321040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321321040
		arg_163_1.duration_ = 4.5

		local var_163_0 = {
			zh = 2.6,
			ja = 4.5
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
				arg_163_0:Play321321041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1061ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1061ui_story == nil then
				arg_163_1.var_.characterEffect1061ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1061ui_story and not isNil(var_166_0) then
					arg_163_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1061ui_story then
				arg_163_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["10104ui_story"]
			local var_166_5 = 0

			if var_166_5 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect10104ui_story == nil then
				arg_163_1.var_.characterEffect10104ui_story = var_166_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_6 = 0.200000002980232

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_6 and not isNil(var_166_4) then
				local var_166_7 = (arg_163_1.time_ - var_166_5) / var_166_6

				if arg_163_1.var_.characterEffect10104ui_story and not isNil(var_166_4) then
					local var_166_8 = Mathf.Lerp(0, 0.5, var_166_7)

					arg_163_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10104ui_story.fillRatio = var_166_8
				end
			end

			if arg_163_1.time_ >= var_166_5 + var_166_6 and arg_163_1.time_ < var_166_5 + var_166_6 + arg_166_0 and not isNil(var_166_4) and arg_163_1.var_.characterEffect10104ui_story then
				local var_166_9 = 0.5

				arg_163_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10104ui_story.fillRatio = var_166_9
			end

			local var_166_10 = 0
			local var_166_11 = 0.35

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_12 = arg_163_1:FormatText(StoryNameCfg[612].name)

				arg_163_1.leftNameTxt_.text = var_166_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(321321040)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_15 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321040", "story_v_out_321321.awb") ~= 0 then
					local var_166_18 = manager.audio:GetVoiceLength("story_v_out_321321", "321321040", "story_v_out_321321.awb") / 1000

					if var_166_18 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_10
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_321321", "321321040", "story_v_out_321321.awb")

						arg_163_1:RecordAudio("321321040", var_166_19)
						arg_163_1:RecordAudio("321321040", var_166_19)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_321321", "321321040", "story_v_out_321321.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_321321", "321321040", "story_v_out_321321.awb")
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
	Play321321041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321321041
		arg_167_1.duration_ = 7.57

		local var_167_0 = {
			zh = 6.433,
			ja = 7.566
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
				arg_167_0:Play321321042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["404001ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos404001ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, -1.55, -5.5)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos404001ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["404001ui_story"]
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect404001ui_story == nil then
				arg_167_1.var_.characterEffect404001ui_story = var_170_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 and not isNil(var_170_9) then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11

				if arg_167_1.var_.characterEffect404001ui_story and not isNil(var_170_9) then
					arg_167_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 and not isNil(var_170_9) and arg_167_1.var_.characterEffect404001ui_story then
				arg_167_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_170_13 = arg_167_1.actors_["1061ui_story"]
			local var_170_14 = 0

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 and not isNil(var_170_13) and arg_167_1.var_.characterEffect1061ui_story == nil then
				arg_167_1.var_.characterEffect1061ui_story = var_170_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_15 = 0.200000002980232

			if var_170_14 <= arg_167_1.time_ and arg_167_1.time_ < var_170_14 + var_170_15 and not isNil(var_170_13) then
				local var_170_16 = (arg_167_1.time_ - var_170_14) / var_170_15

				if arg_167_1.var_.characterEffect1061ui_story and not isNil(var_170_13) then
					local var_170_17 = Mathf.Lerp(0, 0.5, var_170_16)

					arg_167_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1061ui_story.fillRatio = var_170_17
				end
			end

			if arg_167_1.time_ >= var_170_14 + var_170_15 and arg_167_1.time_ < var_170_14 + var_170_15 + arg_170_0 and not isNil(var_170_13) and arg_167_1.var_.characterEffect1061ui_story then
				local var_170_18 = 0.5

				arg_167_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1061ui_story.fillRatio = var_170_18
			end

			local var_170_19 = 0

			if var_170_19 < arg_167_1.time_ and arg_167_1.time_ <= var_170_19 + arg_170_0 then
				arg_167_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_170_20 = 0

			if var_170_20 < arg_167_1.time_ and arg_167_1.time_ <= var_170_20 + arg_170_0 then
				arg_167_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_170_21 = arg_167_1.actors_["1061ui_story"].transform
			local var_170_22 = 0

			if var_170_22 < arg_167_1.time_ and arg_167_1.time_ <= var_170_22 + arg_170_0 then
				arg_167_1.var_.moveOldPos1061ui_story = var_170_21.localPosition
			end

			local var_170_23 = 0.1

			if var_170_22 <= arg_167_1.time_ and arg_167_1.time_ < var_170_22 + var_170_23 then
				local var_170_24 = (arg_167_1.time_ - var_170_22) / var_170_23
				local var_170_25 = Vector3.New(0, 100, 0)

				var_170_21.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1061ui_story, var_170_25, var_170_24)

				local var_170_26 = manager.ui.mainCamera.transform.position - var_170_21.position

				var_170_21.forward = Vector3.New(var_170_26.x, var_170_26.y, var_170_26.z)

				local var_170_27 = var_170_21.localEulerAngles

				var_170_27.z = 0
				var_170_27.x = 0
				var_170_21.localEulerAngles = var_170_27
			end

			if arg_167_1.time_ >= var_170_22 + var_170_23 and arg_167_1.time_ < var_170_22 + var_170_23 + arg_170_0 then
				var_170_21.localPosition = Vector3.New(0, 100, 0)

				local var_170_28 = manager.ui.mainCamera.transform.position - var_170_21.position

				var_170_21.forward = Vector3.New(var_170_28.x, var_170_28.y, var_170_28.z)

				local var_170_29 = var_170_21.localEulerAngles

				var_170_29.z = 0
				var_170_29.x = 0
				var_170_21.localEulerAngles = var_170_29
			end

			local var_170_30 = arg_167_1.actors_["10104ui_story"].transform
			local var_170_31 = 0

			if var_170_31 < arg_167_1.time_ and arg_167_1.time_ <= var_170_31 + arg_170_0 then
				arg_167_1.var_.moveOldPos10104ui_story = var_170_30.localPosition
			end

			local var_170_32 = 0.1

			if var_170_31 <= arg_167_1.time_ and arg_167_1.time_ < var_170_31 + var_170_32 then
				local var_170_33 = (arg_167_1.time_ - var_170_31) / var_170_32
				local var_170_34 = Vector3.New(0, 100, 0)

				var_170_30.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10104ui_story, var_170_34, var_170_33)

				local var_170_35 = manager.ui.mainCamera.transform.position - var_170_30.position

				var_170_30.forward = Vector3.New(var_170_35.x, var_170_35.y, var_170_35.z)

				local var_170_36 = var_170_30.localEulerAngles

				var_170_36.z = 0
				var_170_36.x = 0
				var_170_30.localEulerAngles = var_170_36
			end

			if arg_167_1.time_ >= var_170_31 + var_170_32 and arg_167_1.time_ < var_170_31 + var_170_32 + arg_170_0 then
				var_170_30.localPosition = Vector3.New(0, 100, 0)

				local var_170_37 = manager.ui.mainCamera.transform.position - var_170_30.position

				var_170_30.forward = Vector3.New(var_170_37.x, var_170_37.y, var_170_37.z)

				local var_170_38 = var_170_30.localEulerAngles

				var_170_38.z = 0
				var_170_38.x = 0
				var_170_30.localEulerAngles = var_170_38
			end

			local var_170_39 = 0
			local var_170_40 = 0.875

			if var_170_39 < arg_167_1.time_ and arg_167_1.time_ <= var_170_39 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_41 = arg_167_1:FormatText(StoryNameCfg[668].name)

				arg_167_1.leftNameTxt_.text = var_170_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_42 = arg_167_1:GetWordFromCfg(321321041)
				local var_170_43 = arg_167_1:FormatText(var_170_42.content)

				arg_167_1.text_.text = var_170_43

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_44 = 35
				local var_170_45 = utf8.len(var_170_43)
				local var_170_46 = var_170_44 <= 0 and var_170_40 or var_170_40 * (var_170_45 / var_170_44)

				if var_170_46 > 0 and var_170_40 < var_170_46 then
					arg_167_1.talkMaxDuration = var_170_46

					if var_170_46 + var_170_39 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_46 + var_170_39
					end
				end

				arg_167_1.text_.text = var_170_43
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321041", "story_v_out_321321.awb") ~= 0 then
					local var_170_47 = manager.audio:GetVoiceLength("story_v_out_321321", "321321041", "story_v_out_321321.awb") / 1000

					if var_170_47 + var_170_39 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_47 + var_170_39
					end

					if var_170_42.prefab_name ~= "" and arg_167_1.actors_[var_170_42.prefab_name] ~= nil then
						local var_170_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_42.prefab_name].transform, "story_v_out_321321", "321321041", "story_v_out_321321.awb")

						arg_167_1:RecordAudio("321321041", var_170_48)
						arg_167_1:RecordAudio("321321041", var_170_48)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321321", "321321041", "story_v_out_321321.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321321", "321321041", "story_v_out_321321.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_49 = math.max(var_170_40, arg_167_1.talkMaxDuration)

			if var_170_39 <= arg_167_1.time_ and arg_167_1.time_ < var_170_39 + var_170_49 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_39) / var_170_49

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_39 + var_170_49 and arg_167_1.time_ < var_170_39 + var_170_49 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play321321042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321321042
		arg_171_1.duration_ = 3.17

		local var_171_0 = {
			zh = 1.533,
			ja = 3.166
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
				arg_171_0:Play321321043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.175

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[668].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(321321042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 7
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321042", "story_v_out_321321.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_321321", "321321042", "story_v_out_321321.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_321321", "321321042", "story_v_out_321321.awb")

						arg_171_1:RecordAudio("321321042", var_174_9)
						arg_171_1:RecordAudio("321321042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_321321", "321321042", "story_v_out_321321.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_321321", "321321042", "story_v_out_321321.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play321321043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321321043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321321044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["404001ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos404001ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos404001ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["404001ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect404001ui_story == nil then
				arg_175_1.var_.characterEffect404001ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect404001ui_story and not isNil(var_178_9) then
					local var_178_13 = Mathf.Lerp(0, 0.5, var_178_12)

					arg_175_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_175_1.var_.characterEffect404001ui_story.fillRatio = var_178_13
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect404001ui_story then
				local var_178_14 = 0.5

				arg_175_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_175_1.var_.characterEffect404001ui_story.fillRatio = var_178_14
			end

			local var_178_15 = 0.8
			local var_178_16 = 1

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				local var_178_17 = "play"
				local var_178_18 = "effect"

				arg_175_1:AudioAction(var_178_17, var_178_18, "se_story_141", "se_story_141_footstep_back", "")
			end

			local var_178_19 = 0
			local var_178_20 = 1.45

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_21 = arg_175_1:GetWordFromCfg(321321043)
				local var_178_22 = arg_175_1:FormatText(var_178_21.content)

				arg_175_1.text_.text = var_178_22

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_23 = 58
				local var_178_24 = utf8.len(var_178_22)
				local var_178_25 = var_178_23 <= 0 and var_178_20 or var_178_20 * (var_178_24 / var_178_23)

				if var_178_25 > 0 and var_178_20 < var_178_25 then
					arg_175_1.talkMaxDuration = var_178_25

					if var_178_25 + var_178_19 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_25 + var_178_19
					end
				end

				arg_175_1.text_.text = var_178_22
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_26 = math.max(var_178_20, arg_175_1.talkMaxDuration)

			if var_178_19 <= arg_175_1.time_ and arg_175_1.time_ < var_178_19 + var_178_26 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_19) / var_178_26

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_19 + var_178_26 and arg_175_1.time_ < var_178_19 + var_178_26 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play321321044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321321044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play321321045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.05
			local var_182_1 = 1

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				local var_182_2 = "play"
				local var_182_3 = "effect"

				arg_179_1:AudioAction(var_182_2, var_182_3, "se_story_122_01", "se_story_122_01_jump", "")
			end

			local var_182_4 = 0
			local var_182_5 = 1

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(321321044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_8 = 40
				local var_182_9 = utf8.len(var_182_7)
				local var_182_10 = var_182_8 <= 0 and var_182_5 or var_182_5 * (var_182_9 / var_182_8)

				if var_182_10 > 0 and var_182_5 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_11 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_11 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_11

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_11 and arg_179_1.time_ < var_182_4 + var_182_11 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play321321045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321321045
		arg_183_1.duration_ = 6.27

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play321321046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = manager.ui.mainCamera.transform
			local var_186_1 = 0.5333333

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.shakeOldPos = var_186_0.localPosition
			end

			local var_186_2 = 0.9666667

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / 0.066
				local var_186_4, var_186_5 = math.modf(var_186_3)

				var_186_0.localPosition = Vector3.New(var_186_5 * 0.13, var_186_5 * 0.13, var_186_5 * 0.13) + arg_183_1.var_.shakeOldPos
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = arg_183_1.var_.shakeOldPos
			end

			local var_186_6 = 0

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_7 = 1.5

			if arg_183_1.time_ >= var_186_6 + var_186_7 and arg_183_1.time_ < var_186_6 + var_186_7 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_8 = manager.ui.mainCamera.transform
			local var_186_9 = 0

			if var_186_9 < arg_183_1.time_ and arg_183_1.time_ <= var_186_9 + arg_186_0 then
				local var_186_10 = arg_183_1.var_.effectbaiqnzhanqi1
				local var_186_11
				local var_186_12 = var_186_8

				if not var_186_10 then
					var_186_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_186_12)
					var_186_10.name = "baiqnzhanqi1"
					arg_183_1.var_.effectbaiqnzhanqi1 = var_186_10
				else
					var_186_10.transform:SetParent(var_186_12)
				end

				var_186_10.transform.localPosition = Vector3.New(0, 0, 0.4)
				var_186_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_186_13 = manager.ui.mainCamera.transform
			local var_186_14 = 2

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				local var_186_15 = arg_183_1.var_.effectbaiqnzhanqi1

				if var_186_15 then
					Object.Destroy(var_186_15)

					arg_183_1.var_.effectbaiqnzhanqi1 = nil
				end
			end

			local var_186_16 = 0
			local var_186_17 = 1

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				local var_186_18 = "play"
				local var_186_19 = "effect"

				arg_183_1:AudioAction(var_186_18, var_186_19, "se_story_122_03", "se_story_122_03_swordlightbroken", "")
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_20 = 1.26666666666667
			local var_186_21 = 1.5

			if var_186_20 < arg_183_1.time_ and arg_183_1.time_ <= var_186_20 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_22 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_22:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_23 = arg_183_1:GetWordFromCfg(321321045)
				local var_186_24 = arg_183_1:FormatText(var_186_23.content)

				arg_183_1.text_.text = var_186_24

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_25 = 60
				local var_186_26 = utf8.len(var_186_24)
				local var_186_27 = var_186_25 <= 0 and var_186_21 or var_186_21 * (var_186_26 / var_186_25)

				if var_186_27 > 0 and var_186_21 < var_186_27 then
					arg_183_1.talkMaxDuration = var_186_27
					var_186_20 = var_186_20 + 0.3

					if var_186_27 + var_186_20 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_27 + var_186_20
					end
				end

				arg_183_1.text_.text = var_186_24
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_28 = var_186_20 + 0.3
			local var_186_29 = math.max(var_186_21, arg_183_1.talkMaxDuration)

			if var_186_28 <= arg_183_1.time_ and arg_183_1.time_ < var_186_28 + var_186_29 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_28) / var_186_29

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_28 + var_186_29 and arg_183_1.time_ < var_186_28 + var_186_29 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play321321046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321321046
		arg_189_1.duration_ = 4.17

		local var_189_0 = {
			zh = 2.766,
			ja = 4.166
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
				arg_189_0:Play321321047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1211ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1211ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, -0.67, -6.07)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1211ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1211ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1211ui_story == nil then
				arg_189_1.var_.characterEffect1211ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1211ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1211ui_story then
				arg_189_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_192_15 = 0
			local var_192_16 = 0.325

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[37].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(321321046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 13
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321321", "321321046", "story_v_out_321321.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_321321", "321321046", "story_v_out_321321.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_321321", "321321046", "story_v_out_321321.awb")

						arg_189_1:RecordAudio("321321046", var_192_24)
						arg_189_1:RecordAudio("321321046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321321", "321321046", "story_v_out_321321.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321321", "321321046", "story_v_out_321321.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321321047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321321047
		arg_193_1.duration_ = 5.92

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321321048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1211ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, 100, 0)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, 100, 0)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1211ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1211ui_story == nil then
				arg_193_1.var_.characterEffect1211ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.034000001847744

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1211ui_story and not isNil(var_196_9) then
					local var_196_13 = Mathf.Lerp(0, 0.5, var_196_12)

					arg_193_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1211ui_story.fillRatio = var_196_13
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1211ui_story then
				local var_196_14 = 0.5

				arg_193_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1211ui_story.fillRatio = var_196_14
			end

			local var_196_15 = manager.ui.mainCamera.transform
			local var_196_16 = 0.3

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.var_.shakeOldPos = var_196_15.localPosition
			end

			local var_196_17 = 1

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / 0.066
				local var_196_19, var_196_20 = math.modf(var_196_18)

				var_196_15.localPosition = Vector3.New(var_196_20 * 0.13, var_196_20 * 0.13, var_196_20 * 0.13) + arg_193_1.var_.shakeOldPos
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				var_196_15.localPosition = arg_193_1.var_.shakeOldPos
			end

			local var_196_21 = 0

			if var_196_21 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			local var_196_22 = 0.924999997019768

			if arg_193_1.time_ >= var_196_21 + var_196_22 and arg_193_1.time_ < var_196_21 + var_196_22 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_23 = manager.ui.mainCamera.transform
			local var_196_24 = 0.3

			if var_196_24 < arg_193_1.time_ and arg_193_1.time_ <= var_196_24 + arg_196_0 then
				local var_196_25 = arg_193_1.var_.effectzhanduanshihai1
				local var_196_26
				local var_196_27 = var_196_23

				if not var_196_25 then
					var_196_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), var_196_27)
					var_196_25.name = "zhanduanshihai1"
					arg_193_1.var_.effectzhanduanshihai1 = var_196_25
				else
					var_196_25.transform:SetParent(var_196_27)
				end

				var_196_25.transform.localPosition = Vector3.New(0, 0, 0)
				var_196_25.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_196_28 = manager.ui.mainCamera.transform
			local var_196_29 = 2.3

			if var_196_29 < arg_193_1.time_ and arg_193_1.time_ <= var_196_29 + arg_196_0 then
				local var_196_30 = arg_193_1.var_.effectzhanduanshihai1

				if var_196_30 then
					Object.Destroy(var_196_30)

					arg_193_1.var_.effectzhanduanshihai1 = nil
				end
			end

			local var_196_31 = 0.3
			local var_196_32 = 1

			if var_196_31 < arg_193_1.time_ and arg_193_1.time_ <= var_196_31 + arg_196_0 then
				local var_196_33 = "play"
				local var_196_34 = "effect"

				arg_193_1:AudioAction(var_196_33, var_196_34, "se_story_222_00", "se_story_222_00_monsterdeath", "")
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_35 = 0.924999997019768
			local var_196_36 = 1.125

			if var_196_35 < arg_193_1.time_ and arg_193_1.time_ <= var_196_35 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_37 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_37:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_38 = arg_193_1:GetWordFromCfg(321321047)
				local var_196_39 = arg_193_1:FormatText(var_196_38.content)

				arg_193_1.text_.text = var_196_39

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_40 = 45
				local var_196_41 = utf8.len(var_196_39)
				local var_196_42 = var_196_40 <= 0 and var_196_36 or var_196_36 * (var_196_41 / var_196_40)

				if var_196_42 > 0 and var_196_36 < var_196_42 then
					arg_193_1.talkMaxDuration = var_196_42
					var_196_35 = var_196_35 + 0.3

					if var_196_42 + var_196_35 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_42 + var_196_35
					end
				end

				arg_193_1.text_.text = var_196_39
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_43 = var_196_35 + 0.3
			local var_196_44 = math.max(var_196_36, arg_193_1.talkMaxDuration)

			if var_196_43 <= arg_193_1.time_ and arg_193_1.time_ < var_196_43 + var_196_44 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_43) / var_196_44

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_43 + var_196_44 and arg_193_1.time_ < var_196_43 + var_196_44 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play321321048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 321321048
		arg_199_1.duration_ = 8.73

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play321321049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = "STblack"

			if arg_199_1.bgs_[var_202_0] == nil then
				local var_202_1 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_202_0)
				var_202_1.name = var_202_0
				var_202_1.transform.parent = arg_199_1.stage_.transform
				var_202_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_[var_202_0] = var_202_1
			end

			local var_202_2 = 2

			if var_202_2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				local var_202_3 = manager.ui.mainCamera.transform.localPosition
				local var_202_4 = Vector3.New(0, 0, 10) + Vector3.New(var_202_3.x, var_202_3.y, 0)
				local var_202_5 = arg_199_1.bgs_.STblack

				var_202_5.transform.localPosition = var_202_4
				var_202_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_6 = var_202_5:GetComponent("SpriteRenderer")

				if var_202_6 and var_202_6.sprite then
					local var_202_7 = (var_202_5.transform.localPosition - var_202_3).z
					local var_202_8 = manager.ui.mainCameraCom_
					local var_202_9 = 2 * var_202_7 * Mathf.Tan(var_202_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_202_10 = var_202_9 * var_202_8.aspect
					local var_202_11 = var_202_6.sprite.bounds.size.x
					local var_202_12 = var_202_6.sprite.bounds.size.y
					local var_202_13 = var_202_10 / var_202_11
					local var_202_14 = var_202_9 / var_202_12
					local var_202_15 = var_202_14 < var_202_13 and var_202_13 or var_202_14

					var_202_5.transform.localScale = Vector3.New(var_202_15, var_202_15, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "STblack" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_16 = 0

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_17 = 2

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 then
				local var_202_18 = (arg_199_1.time_ - var_202_16) / var_202_17
				local var_202_19 = Color.New(0.3301887, 0.08877714, 0.08877714)

				var_202_19.a = Mathf.Lerp(0, 1, var_202_18)
				arg_199_1.mask_.color = var_202_19
			end

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 then
				local var_202_20 = Color.New(0.3301887, 0.08877714, 0.08877714)

				var_202_20.a = 1
				arg_199_1.mask_.color = var_202_20
			end

			local var_202_21 = 2

			if var_202_21 < arg_199_1.time_ and arg_199_1.time_ <= var_202_21 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_22 = 2

			if var_202_21 <= arg_199_1.time_ and arg_199_1.time_ < var_202_21 + var_202_22 then
				local var_202_23 = (arg_199_1.time_ - var_202_21) / var_202_22
				local var_202_24 = Color.New(0.3301887, 0.08877714, 0.08877714)

				var_202_24.a = Mathf.Lerp(1, 0, var_202_23)
				arg_199_1.mask_.color = var_202_24
			end

			if arg_199_1.time_ >= var_202_21 + var_202_22 and arg_199_1.time_ < var_202_21 + var_202_22 + arg_202_0 then
				local var_202_25 = Color.New(0.3301887, 0.08877714, 0.08877714)
				local var_202_26 = 0

				arg_199_1.mask_.enabled = false
				var_202_25.a = var_202_26
				arg_199_1.mask_.color = var_202_25
			end

			local var_202_27 = 1.83333333333333
			local var_202_28 = 1

			if var_202_27 < arg_199_1.time_ and arg_199_1.time_ <= var_202_27 + arg_202_0 then
				local var_202_29 = "play"
				local var_202_30 = "effect"

				arg_199_1:AudioAction(var_202_29, var_202_30, "se_story_141", "se_story_141_baqin_flag", "")
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_31 = 3.73333333333333
			local var_202_32 = 1.4

			if var_202_31 < arg_199_1.time_ and arg_199_1.time_ <= var_202_31 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_33 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_33:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_34 = arg_199_1:GetWordFromCfg(321321048)
				local var_202_35 = arg_199_1:FormatText(var_202_34.content)

				arg_199_1.text_.text = var_202_35

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_36 = 56
				local var_202_37 = utf8.len(var_202_35)
				local var_202_38 = var_202_36 <= 0 and var_202_32 or var_202_32 * (var_202_37 / var_202_36)

				if var_202_38 > 0 and var_202_32 < var_202_38 then
					arg_199_1.talkMaxDuration = var_202_38
					var_202_31 = var_202_31 + 0.3

					if var_202_38 + var_202_31 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_38 + var_202_31
					end
				end

				arg_199_1.text_.text = var_202_35
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_39 = var_202_31 + 0.3
			local var_202_40 = math.max(var_202_32, arg_199_1.talkMaxDuration)

			if var_202_39 <= arg_199_1.time_ and arg_199_1.time_ < var_202_39 + var_202_40 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_39) / var_202_40

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_39 + var_202_40 and arg_199_1.time_ < var_202_39 + var_202_40 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play321321049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321321049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(321321049)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 40
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L08f",
		"TextureConfig/Background/L11f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_321321.awb"
	}
}
