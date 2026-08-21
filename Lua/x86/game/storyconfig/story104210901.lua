return {
	Play421091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421091001
		arg_1_1.duration_ = 5.47

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D12a"

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
				local var_4_5 = arg_1_1.bgs_.D12a

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
					if iter_4_0 ~= "D12a" then
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

			local var_4_24 = "10102ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10102ui_story"].transform
			local var_4_30 = 1.86666666666667

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10102ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.985, -6.275)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10102ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["10102ui_story"]
			local var_4_39 = 1.86666666666667

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10102ui_story == nil then
				arg_1_1.var_.characterEffect10102ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect10102ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10102ui_story then
				arg_1_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_4_42 = 1.86666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_4_43 = 1.86666666666667

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.1
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_4_48 = 0
			local var_4_49 = 0.3

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_53 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_53 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_53

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_53
						arg_1_1.bgmTxt2_.text = var_4_53
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

			local var_4_54 = 0.433333333333333
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_59 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_59 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_59

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_59
						arg_1_1.bgmTxt2_.text = var_4_59
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

			local var_4_60 = 2
			local var_4_61 = 0.425

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

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(421091001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091001", "story_v_out_421091.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_421091", "421091001", "story_v_out_421091.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_421091", "421091001", "story_v_out_421091.awb")

						arg_1_1:RecordAudio("421091001", var_4_70)
						arg_1_1:RecordAudio("421091001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421091", "421091001", "story_v_out_421091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421091", "421091001", "story_v_out_421091.awb")
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play421091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10102ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10102ui_story == nil then
				arg_9_1.var_.characterEffect10102ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect10102ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10102ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10102ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10102ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.375

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(421091002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 15
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_7 or var_12_7 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_7 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_14 and arg_9_1.time_ < var_12_6 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play421091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421091003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 2.733,
			ja = 3.433
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
				arg_13_0:Play421091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10102ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10102ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -0.985, -6.275)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10102ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["10102ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10102ui_story == nil then
				arg_13_1.var_.characterEffect10102ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect10102ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect10102ui_story then
				arg_13_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_15 = 0
			local var_16_16 = 0.4

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(421091003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091003", "story_v_out_421091.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091003", "story_v_out_421091.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_421091", "421091003", "story_v_out_421091.awb")

						arg_13_1:RecordAudio("421091003", var_16_24)
						arg_13_1:RecordAudio("421091003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421091", "421091003", "story_v_out_421091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421091", "421091003", "story_v_out_421091.awb")
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
				actorName = "10102ui_story",
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
	Play421091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421091004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play421091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10102ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = 0
			local var_20_10 = 0.45

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_11 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_11

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

				local var_20_12 = arg_17_1:GetWordFromCfg(421091004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_14 = 18
				local var_20_15 = utf8.len(var_20_13)
				local var_20_16 = var_20_14 <= 0 and var_20_10 or var_20_10 * (var_20_15 / var_20_14)

				if var_20_16 > 0 and var_20_10 < var_20_16 then
					arg_17_1.talkMaxDuration = var_20_16

					if var_20_16 + var_20_9 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_9
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_17 = math.max(var_20_10, arg_17_1.talkMaxDuration)

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_17 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_9) / var_20_17

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_9 + var_20_17 and arg_17_1.time_ < var_20_9 + var_20_17 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421091005
		arg_21_1.duration_ = 5.2

		local var_21_0 = {
			zh = 3.6,
			ja = 5.2
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
				arg_21_0:Play421091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10102ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10102ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10102ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = "1047ui_story"

			if arg_21_1.actors_[var_24_9] == nil then
				local var_24_10 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_24_10) then
					local var_24_11 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_21_1.stage_.transform)

					var_24_11.name = var_24_9
					var_24_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_9] = var_24_11

					local var_24_12 = var_24_11:GetComponentInChildren(typeof(CharacterEffect))

					var_24_12.enabled = true

					local var_24_13 = GameObjectTools.GetOrAddComponent(var_24_11, typeof(DynamicBoneHelper))

					if var_24_13 then
						var_24_13:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_12.transform, false)

					arg_21_1.var_[var_24_9 .. "Animator"] = var_24_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_9 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_9 .. "LipSync"] = var_24_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_14 = arg_21_1.actors_["1047ui_story"].transform
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = var_24_14.localPosition
			end

			local var_24_16 = 0.001

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16
				local var_24_18 = Vector3.New(0, -1.13, -6.2)

				var_24_14.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, var_24_18, var_24_17)

				local var_24_19 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_19.x, var_24_19.y, var_24_19.z)

				local var_24_20 = var_24_14.localEulerAngles

				var_24_20.z = 0
				var_24_20.x = 0
				var_24_14.localEulerAngles = var_24_20
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 then
				var_24_14.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_24_21 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_21.x, var_24_21.y, var_24_21.z)

				local var_24_22 = var_24_14.localEulerAngles

				var_24_22.z = 0
				var_24_22.x = 0
				var_24_14.localEulerAngles = var_24_22
			end

			local var_24_23 = arg_21_1.actors_["1047ui_story"]
			local var_24_24 = 0

			if var_24_24 < arg_21_1.time_ and arg_21_1.time_ <= var_24_24 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_25 = 0.200000002980232

			if var_24_24 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 and not isNil(var_24_23) then
				local var_24_26 = (arg_21_1.time_ - var_24_24) / var_24_25

				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_23) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_29 = 0
			local var_24_30 = 0.4

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_31 = arg_21_1:FormatText(StoryNameCfg[1296].name)

				arg_21_1.leftNameTxt_.text = var_24_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_32 = arg_21_1:GetWordFromCfg(421091005)
				local var_24_33 = arg_21_1:FormatText(var_24_32.content)

				arg_21_1.text_.text = var_24_33

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_34 = 16
				local var_24_35 = utf8.len(var_24_33)
				local var_24_36 = var_24_34 <= 0 and var_24_30 or var_24_30 * (var_24_35 / var_24_34)

				if var_24_36 > 0 and var_24_30 < var_24_36 then
					arg_21_1.talkMaxDuration = var_24_36

					if var_24_36 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_29
					end
				end

				arg_21_1.text_.text = var_24_33
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091005", "story_v_out_421091.awb") ~= 0 then
					local var_24_37 = manager.audio:GetVoiceLength("story_v_out_421091", "421091005", "story_v_out_421091.awb") / 1000

					if var_24_37 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_29
					end

					if var_24_32.prefab_name ~= "" and arg_21_1.actors_[var_24_32.prefab_name] ~= nil then
						local var_24_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_32.prefab_name].transform, "story_v_out_421091", "421091005", "story_v_out_421091.awb")

						arg_21_1:RecordAudio("421091005", var_24_38)
						arg_21_1:RecordAudio("421091005", var_24_38)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421091", "421091005", "story_v_out_421091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421091", "421091005", "story_v_out_421091.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_39 = math.max(var_24_30, arg_21_1.talkMaxDuration)

			if var_24_29 <= arg_21_1.time_ and arg_21_1.time_ < var_24_29 + var_24_39 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_29) / var_24_39

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_29 + var_24_39 and arg_21_1.time_ < var_24_29 + var_24_39 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play421091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421091006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1047ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1047ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1047ui_story == nil then
				arg_25_1.var_.characterEffect1047ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1047ui_story and not isNil(var_28_9) then
					local var_28_13 = Mathf.Lerp(0, 0.5, var_28_12)

					arg_25_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1047ui_story.fillRatio = var_28_13
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1047ui_story then
				local var_28_14 = 0.5

				arg_25_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1047ui_story.fillRatio = var_28_14
			end

			local var_28_15 = 0
			local var_28_16 = 0.75

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(421091006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 30
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_16 or var_28_16 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_16 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_22 and arg_25_1.time_ < var_28_15 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421091007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play421091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.5

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(421091007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 20
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
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play421091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421091008
		arg_33_1.duration_ = 4.03

		local var_33_0 = {
			zh = 2.033,
			ja = 4.033
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
				arg_33_0:Play421091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1047ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1047ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -1.13, -6.2)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1047ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1047ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1047ui_story == nil then
				arg_33_1.var_.characterEffect1047ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1047ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1047ui_story then
				arg_33_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_36_15 = 0
			local var_36_16 = 0.25

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[1296].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(421091008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 10
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091008", "story_v_out_421091.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091008", "story_v_out_421091.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_421091", "421091008", "story_v_out_421091.awb")

						arg_33_1:RecordAudio("421091008", var_36_24)
						arg_33_1:RecordAudio("421091008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421091", "421091008", "story_v_out_421091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421091", "421091008", "story_v_out_421091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421091009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play421091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1047ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1047ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1047ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1047ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1047ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.3

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				local var_40_8 = "play"
				local var_40_9 = "music"

				arg_37_1:AudioAction(var_40_8, var_40_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_40_10 = ""
				local var_40_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_40_11 ~= "" then
					if arg_37_1.bgmTxt_.text ~= var_40_11 and arg_37_1.bgmTxt_.text ~= "" then
						if arg_37_1.bgmTxt2_.text ~= "" then
							arg_37_1.bgmTxt_.text = arg_37_1.bgmTxt2_.text
						end

						arg_37_1.bgmTxt2_.text = var_40_11

						arg_37_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_37_1.bgmTxt_.text = var_40_11
						arg_37_1.bgmTxt2_.text = var_40_11
					end

					if arg_37_1.bgmTimer then
						arg_37_1.bgmTimer:Stop()

						arg_37_1.bgmTimer = nil
					end

					if arg_37_1.settingData.show_music_name == 1 then
						arg_37_1.musicController:SetSelectedState("show")
						arg_37_1.musicAnimator_:Play("open", 0, 0)

						if arg_37_1.settingData.music_time ~= 0 then
							arg_37_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_37_1.settingData.music_time), function()
								if arg_37_1 == nil or isNil(arg_37_1.bgmTxt_) then
									return
								end

								arg_37_1.musicController:SetSelectedState("hide")
								arg_37_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_40_12 = 0
			local var_40_13 = 0.1

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_15 = arg_37_1:GetWordFromCfg(421091009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 4
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
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_20 and arg_37_1.time_ < var_40_12 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play421091010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 421091010
		arg_42_1.duration_ = 9

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play421091011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 2

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				local var_45_1 = manager.ui.mainCamera.transform.localPosition
				local var_45_2 = Vector3.New(0, 0, 10) + Vector3.New(var_45_1.x, var_45_1.y, 0)
				local var_45_3 = arg_42_1.bgs_.D12a

				var_45_3.transform.localPosition = var_45_2
				var_45_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_4 = var_45_3:GetComponent("SpriteRenderer")

				if var_45_4 and var_45_4.sprite then
					local var_45_5 = (var_45_3.transform.localPosition - var_45_1).z
					local var_45_6 = manager.ui.mainCameraCom_
					local var_45_7 = 2 * var_45_5 * Mathf.Tan(var_45_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_45_8 = var_45_7 * var_45_6.aspect
					local var_45_9 = var_45_4.sprite.bounds.size.x
					local var_45_10 = var_45_4.sprite.bounds.size.y
					local var_45_11 = var_45_8 / var_45_9
					local var_45_12 = var_45_7 / var_45_10
					local var_45_13 = var_45_12 < var_45_11 and var_45_11 or var_45_12

					var_45_3.transform.localScale = Vector3.New(var_45_13, var_45_13, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "D12a" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_14 = 4

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_15 = 0.3

			if arg_42_1.time_ >= var_45_14 + var_45_15 and arg_42_1.time_ < var_45_14 + var_45_15 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_16 = 0

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_17 = 2

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_17 then
				local var_45_18 = (arg_42_1.time_ - var_45_16) / var_45_17
				local var_45_19 = Color.New(0, 0, 0)

				var_45_19.a = Mathf.Lerp(0, 1, var_45_18)
				arg_42_1.mask_.color = var_45_19
			end

			if arg_42_1.time_ >= var_45_16 + var_45_17 and arg_42_1.time_ < var_45_16 + var_45_17 + arg_45_0 then
				local var_45_20 = Color.New(0, 0, 0)

				var_45_20.a = 1
				arg_42_1.mask_.color = var_45_20
			end

			local var_45_21 = 2

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_22 = 2

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_22 then
				local var_45_23 = (arg_42_1.time_ - var_45_21) / var_45_22
				local var_45_24 = Color.New(0, 0, 0)

				var_45_24.a = Mathf.Lerp(1, 0, var_45_23)
				arg_42_1.mask_.color = var_45_24
			end

			if arg_42_1.time_ >= var_45_21 + var_45_22 and arg_42_1.time_ < var_45_21 + var_45_22 + arg_45_0 then
				local var_45_25 = Color.New(0, 0, 0)
				local var_45_26 = 0

				arg_42_1.mask_.enabled = false
				var_45_25.a = var_45_26
				arg_42_1.mask_.color = var_45_25
			end

			local var_45_27 = arg_42_1.actors_["1047ui_story"].transform
			local var_45_28 = 1.96599999815226

			if var_45_28 < arg_42_1.time_ and arg_42_1.time_ <= var_45_28 + arg_45_0 then
				arg_42_1.var_.moveOldPos1047ui_story = var_45_27.localPosition
			end

			local var_45_29 = 0.001

			if var_45_28 <= arg_42_1.time_ and arg_42_1.time_ < var_45_28 + var_45_29 then
				local var_45_30 = (arg_42_1.time_ - var_45_28) / var_45_29
				local var_45_31 = Vector3.New(0, 100, 0)

				var_45_27.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1047ui_story, var_45_31, var_45_30)

				local var_45_32 = manager.ui.mainCamera.transform.position - var_45_27.position

				var_45_27.forward = Vector3.New(var_45_32.x, var_45_32.y, var_45_32.z)

				local var_45_33 = var_45_27.localEulerAngles

				var_45_33.z = 0
				var_45_33.x = 0
				var_45_27.localEulerAngles = var_45_33
			end

			if arg_42_1.time_ >= var_45_28 + var_45_29 and arg_42_1.time_ < var_45_28 + var_45_29 + arg_45_0 then
				var_45_27.localPosition = Vector3.New(0, 100, 0)

				local var_45_34 = manager.ui.mainCamera.transform.position - var_45_27.position

				var_45_27.forward = Vector3.New(var_45_34.x, var_45_34.y, var_45_34.z)

				local var_45_35 = var_45_27.localEulerAngles

				var_45_35.z = 0
				var_45_35.x = 0
				var_45_27.localEulerAngles = var_45_35
			end

			local var_45_36 = 0
			local var_45_37 = 0.3

			if var_45_36 < arg_42_1.time_ and arg_42_1.time_ <= var_45_36 + arg_45_0 then
				local var_45_38 = "play"
				local var_45_39 = "music"

				arg_42_1:AudioAction(var_45_38, var_45_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_45_40 = ""
				local var_45_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_45_41 ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_41 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_41

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_41
						arg_42_1.bgmTxt2_.text = var_45_41
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_42 = 1.53333333333333
			local var_45_43 = 1

			if var_45_42 < arg_42_1.time_ and arg_42_1.time_ <= var_45_42 + arg_45_0 then
				local var_45_44 = "play"
				local var_45_45 = "music"

				arg_42_1:AudioAction(var_45_44, var_45_45, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_45_46 = ""
				local var_45_47 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_45_47 ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_47 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_47

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_47
						arg_42_1.bgmTxt2_.text = var_45_47
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_48 = 1.53333333333333
			local var_45_49 = 1

			if var_45_48 < arg_42_1.time_ and arg_42_1.time_ <= var_45_48 + arg_45_0 then
				local var_45_50 = "play"
				local var_45_51 = "effect"

				arg_42_1:AudioAction(var_45_50, var_45_51, "se_story_140", "se_story_140_amb_dream01", "")
			end

			local var_45_52 = 0.1
			local var_45_53 = 1

			if var_45_52 < arg_42_1.time_ and arg_42_1.time_ <= var_45_52 + arg_45_0 then
				local var_45_54 = "stop"
				local var_45_55 = "effect"

				arg_42_1:AudioAction(var_45_54, var_45_55, "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_56 = 4
			local var_45_57 = 1.275

			if var_45_56 < arg_42_1.time_ and arg_42_1.time_ <= var_45_56 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_58 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_58:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_42_1.dialogCg_.alpha = arg_48_0
				end))
				var_45_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_59 = arg_42_1:GetWordFromCfg(421091010)
				local var_45_60 = arg_42_1:FormatText(var_45_59.content)

				arg_42_1.text_.text = var_45_60

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_61 = 51
				local var_45_62 = utf8.len(var_45_60)
				local var_45_63 = var_45_61 <= 0 and var_45_57 or var_45_57 * (var_45_62 / var_45_61)

				if var_45_63 > 0 and var_45_57 < var_45_63 then
					arg_42_1.talkMaxDuration = var_45_63
					var_45_56 = var_45_56 + 0.3

					if var_45_63 + var_45_56 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_63 + var_45_56
					end
				end

				arg_42_1.text_.text = var_45_60
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_64 = var_45_56 + 0.3
			local var_45_65 = math.max(var_45_57, arg_42_1.talkMaxDuration)

			if var_45_64 <= arg_42_1.time_ and arg_42_1.time_ < var_45_64 + var_45_65 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_64) / var_45_65

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_64 + var_45_65 and arg_42_1.time_ < var_45_64 + var_45_65 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play421091011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 421091011
		arg_50_1.duration_ = 3.2

		local var_50_0 = {
			zh = 2.5,
			ja = 3.2
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
				arg_50_0:Play421091012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10102ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos10102ui_story = var_53_0.localPosition
			end

			local var_53_2 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2
				local var_53_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10102ui_story, var_53_4, var_53_3)

				local var_53_5 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_5.x, var_53_5.y, var_53_5.z)

				local var_53_6 = var_53_0.localEulerAngles

				var_53_6.z = 0
				var_53_6.x = 0
				var_53_0.localEulerAngles = var_53_6
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_53_7 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_7.x, var_53_7.y, var_53_7.z)

				local var_53_8 = var_53_0.localEulerAngles

				var_53_8.z = 0
				var_53_8.x = 0
				var_53_0.localEulerAngles = var_53_8
			end

			local var_53_9 = arg_50_1.actors_["10102ui_story"]
			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect10102ui_story == nil then
				arg_50_1.var_.characterEffect10102ui_story = var_53_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_11 = 0.200000002980232

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_11 and not isNil(var_53_9) then
				local var_53_12 = (arg_50_1.time_ - var_53_10) / var_53_11

				if arg_50_1.var_.characterEffect10102ui_story and not isNil(var_53_9) then
					arg_50_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_10 + var_53_11 and arg_50_1.time_ < var_53_10 + var_53_11 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect10102ui_story then
				arg_50_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_53_13 = 0

			if var_53_13 < arg_50_1.time_ and arg_50_1.time_ <= var_53_13 + arg_53_0 then
				arg_50_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_53_14 = 0

			if var_53_14 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_15 = 0
			local var_53_16 = 0.325

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_17 = arg_50_1:FormatText(StoryNameCfg[6].name)

				arg_50_1.leftNameTxt_.text = var_53_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_18 = arg_50_1:GetWordFromCfg(421091011)
				local var_53_19 = arg_50_1:FormatText(var_53_18.content)

				arg_50_1.text_.text = var_53_19

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_20 = 13
				local var_53_21 = utf8.len(var_53_19)
				local var_53_22 = var_53_20 <= 0 and var_53_16 or var_53_16 * (var_53_21 / var_53_20)

				if var_53_22 > 0 and var_53_16 < var_53_22 then
					arg_50_1.talkMaxDuration = var_53_22

					if var_53_22 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_22 + var_53_15
					end
				end

				arg_50_1.text_.text = var_53_19
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091011", "story_v_out_421091.awb") ~= 0 then
					local var_53_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091011", "story_v_out_421091.awb") / 1000

					if var_53_23 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_15
					end

					if var_53_18.prefab_name ~= "" and arg_50_1.actors_[var_53_18.prefab_name] ~= nil then
						local var_53_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_18.prefab_name].transform, "story_v_out_421091", "421091011", "story_v_out_421091.awb")

						arg_50_1:RecordAudio("421091011", var_53_24)
						arg_50_1:RecordAudio("421091011", var_53_24)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_421091", "421091011", "story_v_out_421091.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_421091", "421091011", "story_v_out_421091.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_25 = math.max(var_53_16, arg_50_1.talkMaxDuration)

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_25 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_15) / var_53_25

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_15 + var_53_25 and arg_50_1.time_ < var_53_15 + var_53_25 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play421091012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 421091012
		arg_54_1.duration_ = 4.27

		local var_54_0 = {
			zh = 2.466,
			ja = 4.266
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play421091013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "10143ui_story"

			if arg_54_1.actors_[var_57_0] == nil then
				local var_57_1 = Asset.Load("Char/" .. "10143ui_story")

				if not isNil(var_57_1) then
					local var_57_2 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_54_1.stage_.transform)

					var_57_2.name = var_57_0
					var_57_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_54_1.actors_[var_57_0] = var_57_2

					local var_57_3 = var_57_2:GetComponentInChildren(typeof(CharacterEffect))

					var_57_3.enabled = true

					local var_57_4 = GameObjectTools.GetOrAddComponent(var_57_2, typeof(DynamicBoneHelper))

					if var_57_4 then
						var_57_4:EnableDynamicBone(false)
					end

					arg_54_1:ShowWeapon(var_57_3.transform, false)

					arg_54_1.var_[var_57_0 .. "Animator"] = var_57_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_54_1.var_[var_57_0 .. "Animator"].applyRootMotion = true
					arg_54_1.var_[var_57_0 .. "LipSync"] = var_57_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_57_5 = arg_54_1.actors_["10143ui_story"].transform
			local var_57_6 = 0

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.var_.moveOldPos10143ui_story = var_57_5.localPosition
			end

			local var_57_7 = 0.001

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_7 then
				local var_57_8 = (arg_54_1.time_ - var_57_6) / var_57_7
				local var_57_9 = Vector3.New(0.78, -1.06, -6)

				var_57_5.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10143ui_story, var_57_9, var_57_8)

				local var_57_10 = manager.ui.mainCamera.transform.position - var_57_5.position

				var_57_5.forward = Vector3.New(var_57_10.x, var_57_10.y, var_57_10.z)

				local var_57_11 = var_57_5.localEulerAngles

				var_57_11.z = 0
				var_57_11.x = 0
				var_57_5.localEulerAngles = var_57_11
			end

			if arg_54_1.time_ >= var_57_6 + var_57_7 and arg_54_1.time_ < var_57_6 + var_57_7 + arg_57_0 then
				var_57_5.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_57_12 = manager.ui.mainCamera.transform.position - var_57_5.position

				var_57_5.forward = Vector3.New(var_57_12.x, var_57_12.y, var_57_12.z)

				local var_57_13 = var_57_5.localEulerAngles

				var_57_13.z = 0
				var_57_13.x = 0
				var_57_5.localEulerAngles = var_57_13
			end

			local var_57_14 = arg_54_1.actors_["10143ui_story"]
			local var_57_15 = 0

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect10143ui_story == nil then
				arg_54_1.var_.characterEffect10143ui_story = var_57_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_16 = 0.200000002980232

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_16 and not isNil(var_57_14) then
				local var_57_17 = (arg_54_1.time_ - var_57_15) / var_57_16

				if arg_54_1.var_.characterEffect10143ui_story and not isNil(var_57_14) then
					arg_54_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_15 + var_57_16 and arg_54_1.time_ < var_57_15 + var_57_16 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect10143ui_story then
				arg_54_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_57_18 = arg_54_1.actors_["10102ui_story"]
			local var_57_19 = 0

			if var_57_19 < arg_54_1.time_ and arg_54_1.time_ <= var_57_19 + arg_57_0 and not isNil(var_57_18) and arg_54_1.var_.characterEffect10102ui_story == nil then
				arg_54_1.var_.characterEffect10102ui_story = var_57_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_20 = 0.200000002980232

			if var_57_19 <= arg_54_1.time_ and arg_54_1.time_ < var_57_19 + var_57_20 and not isNil(var_57_18) then
				local var_57_21 = (arg_54_1.time_ - var_57_19) / var_57_20

				if arg_54_1.var_.characterEffect10102ui_story and not isNil(var_57_18) then
					local var_57_22 = Mathf.Lerp(0, 0.5, var_57_21)

					arg_54_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10102ui_story.fillRatio = var_57_22
				end
			end

			if arg_54_1.time_ >= var_57_19 + var_57_20 and arg_54_1.time_ < var_57_19 + var_57_20 + arg_57_0 and not isNil(var_57_18) and arg_54_1.var_.characterEffect10102ui_story then
				local var_57_23 = 0.5

				arg_54_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10102ui_story.fillRatio = var_57_23
			end

			local var_57_24 = 0

			if var_57_24 < arg_54_1.time_ and arg_54_1.time_ <= var_57_24 + arg_57_0 then
				arg_54_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_57_25 = 0

			if var_57_25 < arg_54_1.time_ and arg_54_1.time_ <= var_57_25 + arg_57_0 then
				arg_54_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_57_26 = 0
			local var_57_27 = 0.35

			if var_57_26 < arg_54_1.time_ and arg_54_1.time_ <= var_57_26 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_28 = arg_54_1:FormatText(StoryNameCfg[1307].name)

				arg_54_1.leftNameTxt_.text = var_57_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_29 = arg_54_1:GetWordFromCfg(421091012)
				local var_57_30 = arg_54_1:FormatText(var_57_29.content)

				arg_54_1.text_.text = var_57_30

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_31 = 14
				local var_57_32 = utf8.len(var_57_30)
				local var_57_33 = var_57_31 <= 0 and var_57_27 or var_57_27 * (var_57_32 / var_57_31)

				if var_57_33 > 0 and var_57_27 < var_57_33 then
					arg_54_1.talkMaxDuration = var_57_33

					if var_57_33 + var_57_26 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_33 + var_57_26
					end
				end

				arg_54_1.text_.text = var_57_30
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091012", "story_v_out_421091.awb") ~= 0 then
					local var_57_34 = manager.audio:GetVoiceLength("story_v_out_421091", "421091012", "story_v_out_421091.awb") / 1000

					if var_57_34 + var_57_26 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_34 + var_57_26
					end

					if var_57_29.prefab_name ~= "" and arg_54_1.actors_[var_57_29.prefab_name] ~= nil then
						local var_57_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_29.prefab_name].transform, "story_v_out_421091", "421091012", "story_v_out_421091.awb")

						arg_54_1:RecordAudio("421091012", var_57_35)
						arg_54_1:RecordAudio("421091012", var_57_35)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_421091", "421091012", "story_v_out_421091.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_421091", "421091012", "story_v_out_421091.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_36 = math.max(var_57_27, arg_54_1.talkMaxDuration)

			if var_57_26 <= arg_54_1.time_ and arg_54_1.time_ < var_57_26 + var_57_36 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_26) / var_57_36

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_26 + var_57_36 and arg_54_1.time_ < var_57_26 + var_57_36 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play421091013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 421091013
		arg_58_1.duration_ = 2.87

		local var_58_0 = {
			zh = 2.7,
			ja = 2.866
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play421091014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1047ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos1047ui_story = var_61_0.localPosition
			end

			local var_61_2 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1047ui_story, var_61_4, var_61_3)

				local var_61_5 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_5.x, var_61_5.y, var_61_5.z)

				local var_61_6 = var_61_0.localEulerAngles

				var_61_6.z = 0
				var_61_6.x = 0
				var_61_0.localEulerAngles = var_61_6
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_61_7 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_7.x, var_61_7.y, var_61_7.z)

				local var_61_8 = var_61_0.localEulerAngles

				var_61_8.z = 0
				var_61_8.x = 0
				var_61_0.localEulerAngles = var_61_8
			end

			local var_61_9 = arg_58_1.actors_["10102ui_story"].transform
			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.var_.moveOldPos10102ui_story = var_61_9.localPosition
			end

			local var_61_11 = 0.001

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 then
				local var_61_12 = (arg_58_1.time_ - var_61_10) / var_61_11
				local var_61_13 = Vector3.New(0, 100, 0)

				var_61_9.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10102ui_story, var_61_13, var_61_12)

				local var_61_14 = manager.ui.mainCamera.transform.position - var_61_9.position

				var_61_9.forward = Vector3.New(var_61_14.x, var_61_14.y, var_61_14.z)

				local var_61_15 = var_61_9.localEulerAngles

				var_61_15.z = 0
				var_61_15.x = 0
				var_61_9.localEulerAngles = var_61_15
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 then
				var_61_9.localPosition = Vector3.New(0, 100, 0)

				local var_61_16 = manager.ui.mainCamera.transform.position - var_61_9.position

				var_61_9.forward = Vector3.New(var_61_16.x, var_61_16.y, var_61_16.z)

				local var_61_17 = var_61_9.localEulerAngles

				var_61_17.z = 0
				var_61_17.x = 0
				var_61_9.localEulerAngles = var_61_17
			end

			local var_61_18 = arg_58_1.actors_["1047ui_story"]
			local var_61_19 = 0

			if var_61_19 < arg_58_1.time_ and arg_58_1.time_ <= var_61_19 + arg_61_0 and not isNil(var_61_18) and arg_58_1.var_.characterEffect1047ui_story == nil then
				arg_58_1.var_.characterEffect1047ui_story = var_61_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_20 = 0.200000002980232

			if var_61_19 <= arg_58_1.time_ and arg_58_1.time_ < var_61_19 + var_61_20 and not isNil(var_61_18) then
				local var_61_21 = (arg_58_1.time_ - var_61_19) / var_61_20

				if arg_58_1.var_.characterEffect1047ui_story and not isNil(var_61_18) then
					arg_58_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_19 + var_61_20 and arg_58_1.time_ < var_61_19 + var_61_20 + arg_61_0 and not isNil(var_61_18) and arg_58_1.var_.characterEffect1047ui_story then
				arg_58_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_61_22 = arg_58_1.actors_["10143ui_story"]
			local var_61_23 = 0

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 and not isNil(var_61_22) and arg_58_1.var_.characterEffect10143ui_story == nil then
				arg_58_1.var_.characterEffect10143ui_story = var_61_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_24 = 0.200000002980232

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_24 and not isNil(var_61_22) then
				local var_61_25 = (arg_58_1.time_ - var_61_23) / var_61_24

				if arg_58_1.var_.characterEffect10143ui_story and not isNil(var_61_22) then
					local var_61_26 = Mathf.Lerp(0, 0.5, var_61_25)

					arg_58_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_58_1.var_.characterEffect10143ui_story.fillRatio = var_61_26
				end
			end

			if arg_58_1.time_ >= var_61_23 + var_61_24 and arg_58_1.time_ < var_61_23 + var_61_24 + arg_61_0 and not isNil(var_61_22) and arg_58_1.var_.characterEffect10143ui_story then
				local var_61_27 = 0.5

				arg_58_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_58_1.var_.characterEffect10143ui_story.fillRatio = var_61_27
			end

			local var_61_28 = 0

			if var_61_28 < arg_58_1.time_ and arg_58_1.time_ <= var_61_28 + arg_61_0 then
				arg_58_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_61_29 = 0

			if var_61_29 < arg_58_1.time_ and arg_58_1.time_ <= var_61_29 + arg_61_0 then
				arg_58_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_61_30 = 0
			local var_61_31 = 0.375

			if var_61_30 < arg_58_1.time_ and arg_58_1.time_ <= var_61_30 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_32 = arg_58_1:FormatText(StoryNameCfg[1296].name)

				arg_58_1.leftNameTxt_.text = var_61_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_33 = arg_58_1:GetWordFromCfg(421091013)
				local var_61_34 = arg_58_1:FormatText(var_61_33.content)

				arg_58_1.text_.text = var_61_34

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_35 = 15
				local var_61_36 = utf8.len(var_61_34)
				local var_61_37 = var_61_35 <= 0 and var_61_31 or var_61_31 * (var_61_36 / var_61_35)

				if var_61_37 > 0 and var_61_31 < var_61_37 then
					arg_58_1.talkMaxDuration = var_61_37

					if var_61_37 + var_61_30 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_37 + var_61_30
					end
				end

				arg_58_1.text_.text = var_61_34
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091013", "story_v_out_421091.awb") ~= 0 then
					local var_61_38 = manager.audio:GetVoiceLength("story_v_out_421091", "421091013", "story_v_out_421091.awb") / 1000

					if var_61_38 + var_61_30 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_38 + var_61_30
					end

					if var_61_33.prefab_name ~= "" and arg_58_1.actors_[var_61_33.prefab_name] ~= nil then
						local var_61_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_33.prefab_name].transform, "story_v_out_421091", "421091013", "story_v_out_421091.awb")

						arg_58_1:RecordAudio("421091013", var_61_39)
						arg_58_1:RecordAudio("421091013", var_61_39)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_421091", "421091013", "story_v_out_421091.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_421091", "421091013", "story_v_out_421091.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_40 = math.max(var_61_31, arg_58_1.talkMaxDuration)

			if var_61_30 <= arg_58_1.time_ and arg_58_1.time_ < var_61_30 + var_61_40 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_30) / var_61_40

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_30 + var_61_40 and arg_58_1.time_ < var_61_30 + var_61_40 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play421091014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 421091014
		arg_62_1.duration_ = 4.3

		local var_62_0 = {
			zh = 3,
			ja = 4.3
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
				arg_62_0:Play421091015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10143ui_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos10143ui_story = var_65_0.localPosition
			end

			local var_65_2 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2
				local var_65_4 = Vector3.New(0.78, -1.06, -6)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10143ui_story, var_65_4, var_65_3)

				local var_65_5 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_5.x, var_65_5.y, var_65_5.z)

				local var_65_6 = var_65_0.localEulerAngles

				var_65_6.z = 0
				var_65_6.x = 0
				var_65_0.localEulerAngles = var_65_6
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_65_7 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_7.x, var_65_7.y, var_65_7.z)

				local var_65_8 = var_65_0.localEulerAngles

				var_65_8.z = 0
				var_65_8.x = 0
				var_65_0.localEulerAngles = var_65_8
			end

			local var_65_9 = arg_62_1.actors_["10143ui_story"]
			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect10143ui_story == nil then
				arg_62_1.var_.characterEffect10143ui_story = var_65_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_11 = 0.200000002980232

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_11 and not isNil(var_65_9) then
				local var_65_12 = (arg_62_1.time_ - var_65_10) / var_65_11

				if arg_62_1.var_.characterEffect10143ui_story and not isNil(var_65_9) then
					arg_62_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_10 + var_65_11 and arg_62_1.time_ < var_65_10 + var_65_11 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect10143ui_story then
				arg_62_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_65_13 = arg_62_1.actors_["1047ui_story"]
			local var_65_14 = 0

			if var_65_14 < arg_62_1.time_ and arg_62_1.time_ <= var_65_14 + arg_65_0 and not isNil(var_65_13) and arg_62_1.var_.characterEffect1047ui_story == nil then
				arg_62_1.var_.characterEffect1047ui_story = var_65_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_15 = 0.200000002980232

			if var_65_14 <= arg_62_1.time_ and arg_62_1.time_ < var_65_14 + var_65_15 and not isNil(var_65_13) then
				local var_65_16 = (arg_62_1.time_ - var_65_14) / var_65_15

				if arg_62_1.var_.characterEffect1047ui_story and not isNil(var_65_13) then
					local var_65_17 = Mathf.Lerp(0, 0.5, var_65_16)

					arg_62_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1047ui_story.fillRatio = var_65_17
				end
			end

			if arg_62_1.time_ >= var_65_14 + var_65_15 and arg_62_1.time_ < var_65_14 + var_65_15 + arg_65_0 and not isNil(var_65_13) and arg_62_1.var_.characterEffect1047ui_story then
				local var_65_18 = 0.5

				arg_62_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1047ui_story.fillRatio = var_65_18
			end

			local var_65_19 = 0

			if var_65_19 < arg_62_1.time_ and arg_62_1.time_ <= var_65_19 + arg_65_0 then
				arg_62_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			local var_65_20 = 0

			if var_65_20 < arg_62_1.time_ and arg_62_1.time_ <= var_65_20 + arg_65_0 then
				arg_62_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_65_21 = 0
			local var_65_22 = 0.425

			if var_65_21 < arg_62_1.time_ and arg_62_1.time_ <= var_65_21 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_23 = arg_62_1:FormatText(StoryNameCfg[1307].name)

				arg_62_1.leftNameTxt_.text = var_65_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_24 = arg_62_1:GetWordFromCfg(421091014)
				local var_65_25 = arg_62_1:FormatText(var_65_24.content)

				arg_62_1.text_.text = var_65_25

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_26 = 17
				local var_65_27 = utf8.len(var_65_25)
				local var_65_28 = var_65_26 <= 0 and var_65_22 or var_65_22 * (var_65_27 / var_65_26)

				if var_65_28 > 0 and var_65_22 < var_65_28 then
					arg_62_1.talkMaxDuration = var_65_28

					if var_65_28 + var_65_21 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_28 + var_65_21
					end
				end

				arg_62_1.text_.text = var_65_25
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091014", "story_v_out_421091.awb") ~= 0 then
					local var_65_29 = manager.audio:GetVoiceLength("story_v_out_421091", "421091014", "story_v_out_421091.awb") / 1000

					if var_65_29 + var_65_21 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_29 + var_65_21
					end

					if var_65_24.prefab_name ~= "" and arg_62_1.actors_[var_65_24.prefab_name] ~= nil then
						local var_65_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_24.prefab_name].transform, "story_v_out_421091", "421091014", "story_v_out_421091.awb")

						arg_62_1:RecordAudio("421091014", var_65_30)
						arg_62_1:RecordAudio("421091014", var_65_30)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_421091", "421091014", "story_v_out_421091.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_421091", "421091014", "story_v_out_421091.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_31 = math.max(var_65_22, arg_62_1.talkMaxDuration)

			if var_65_21 <= arg_62_1.time_ and arg_62_1.time_ < var_65_21 + var_65_31 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_21) / var_65_31

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_21 + var_65_31 and arg_62_1.time_ < var_65_21 + var_65_31 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play421091015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 421091015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play421091016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10143ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos10143ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, 100, 0)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10143ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, 100, 0)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1047ui_story"].transform
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.var_.moveOldPos1047ui_story = var_69_9.localPosition
			end

			local var_69_11 = 0.001

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_11 then
				local var_69_12 = (arg_66_1.time_ - var_69_10) / var_69_11
				local var_69_13 = Vector3.New(0, 100, 0)

				var_69_9.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1047ui_story, var_69_13, var_69_12)

				local var_69_14 = manager.ui.mainCamera.transform.position - var_69_9.position

				var_69_9.forward = Vector3.New(var_69_14.x, var_69_14.y, var_69_14.z)

				local var_69_15 = var_69_9.localEulerAngles

				var_69_15.z = 0
				var_69_15.x = 0
				var_69_9.localEulerAngles = var_69_15
			end

			if arg_66_1.time_ >= var_69_10 + var_69_11 and arg_66_1.time_ < var_69_10 + var_69_11 + arg_69_0 then
				var_69_9.localPosition = Vector3.New(0, 100, 0)

				local var_69_16 = manager.ui.mainCamera.transform.position - var_69_9.position

				var_69_9.forward = Vector3.New(var_69_16.x, var_69_16.y, var_69_16.z)

				local var_69_17 = var_69_9.localEulerAngles

				var_69_17.z = 0
				var_69_17.x = 0
				var_69_9.localEulerAngles = var_69_17
			end

			local var_69_18 = 0
			local var_69_19 = 0.85

			if var_69_18 < arg_66_1.time_ and arg_66_1.time_ <= var_69_18 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_20 = arg_66_1:GetWordFromCfg(421091015)
				local var_69_21 = arg_66_1:FormatText(var_69_20.content)

				arg_66_1.text_.text = var_69_21

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_22 = 34
				local var_69_23 = utf8.len(var_69_21)
				local var_69_24 = var_69_22 <= 0 and var_69_19 or var_69_19 * (var_69_23 / var_69_22)

				if var_69_24 > 0 and var_69_19 < var_69_24 then
					arg_66_1.talkMaxDuration = var_69_24

					if var_69_24 + var_69_18 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_18
					end
				end

				arg_66_1.text_.text = var_69_21
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = math.max(var_69_19, arg_66_1.talkMaxDuration)

			if var_69_18 <= arg_66_1.time_ and arg_66_1.time_ < var_69_18 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_18) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_18 + var_69_25 and arg_66_1.time_ < var_69_18 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play421091016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 421091016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play421091017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.85

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(421091016)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 34
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_8 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_8 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_8

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_8 and arg_70_1.time_ < var_73_0 + var_73_8 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play421091017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 421091017
		arg_74_1.duration_ = 2

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play421091018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10102ui_story"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos10102ui_story = var_77_0.localPosition
			end

			local var_77_2 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2
				local var_77_4 = Vector3.New(0, -0.985, -6.275)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10102ui_story, var_77_4, var_77_3)

				local var_77_5 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_5.x, var_77_5.y, var_77_5.z)

				local var_77_6 = var_77_0.localEulerAngles

				var_77_6.z = 0
				var_77_6.x = 0
				var_77_0.localEulerAngles = var_77_6
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_77_7 = manager.ui.mainCamera.transform.position - var_77_0.position

				var_77_0.forward = Vector3.New(var_77_7.x, var_77_7.y, var_77_7.z)

				local var_77_8 = var_77_0.localEulerAngles

				var_77_8.z = 0
				var_77_8.x = 0
				var_77_0.localEulerAngles = var_77_8
			end

			local var_77_9 = arg_74_1.actors_["10102ui_story"]
			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect10102ui_story == nil then
				arg_74_1.var_.characterEffect10102ui_story = var_77_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_11 = 0.200000002980232

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_11 and not isNil(var_77_9) then
				local var_77_12 = (arg_74_1.time_ - var_77_10) / var_77_11

				if arg_74_1.var_.characterEffect10102ui_story and not isNil(var_77_9) then
					arg_74_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_10 + var_77_11 and arg_74_1.time_ < var_77_10 + var_77_11 + arg_77_0 and not isNil(var_77_9) and arg_74_1.var_.characterEffect10102ui_story then
				arg_74_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_77_13 = 0

			if var_77_13 < arg_74_1.time_ and arg_74_1.time_ <= var_77_13 + arg_77_0 then
				arg_74_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			local var_77_14 = 0

			if var_77_14 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 then
				arg_74_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_77_15 = 0
			local var_77_16 = 0.175

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_17 = arg_74_1:FormatText(StoryNameCfg[6].name)

				arg_74_1.leftNameTxt_.text = var_77_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_18 = arg_74_1:GetWordFromCfg(421091017)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 7
				local var_77_21 = utf8.len(var_77_19)
				local var_77_22 = var_77_20 <= 0 and var_77_16 or var_77_16 * (var_77_21 / var_77_20)

				if var_77_22 > 0 and var_77_16 < var_77_22 then
					arg_74_1.talkMaxDuration = var_77_22

					if var_77_22 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_22 + var_77_15
					end
				end

				arg_74_1.text_.text = var_77_19
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091017", "story_v_out_421091.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091017", "story_v_out_421091.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_421091", "421091017", "story_v_out_421091.awb")

						arg_74_1:RecordAudio("421091017", var_77_24)
						arg_74_1:RecordAudio("421091017", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_421091", "421091017", "story_v_out_421091.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_421091", "421091017", "story_v_out_421091.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_25 = math.max(var_77_16, arg_74_1.talkMaxDuration)

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_25 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_15) / var_77_25

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_15 + var_77_25 and arg_74_1.time_ < var_77_15 + var_77_25 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play421091018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 421091018
		arg_78_1.duration_ = 7.1

		local var_78_0 = {
			zh = 3.266,
			ja = 7.1
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
				arg_78_0:Play421091019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10102ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos10102ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10102ui_story, var_81_4, var_81_3)

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

			local var_81_9 = arg_78_1.actors_["1047ui_story"].transform
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.var_.moveOldPos1047ui_story = var_81_9.localPosition
			end

			local var_81_11 = 0.001

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11
				local var_81_13 = Vector3.New(-0.6, -1.13, -6.2)

				var_81_9.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1047ui_story, var_81_13, var_81_12)

				local var_81_14 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_14.x, var_81_14.y, var_81_14.z)

				local var_81_15 = var_81_9.localEulerAngles

				var_81_15.z = 0
				var_81_15.x = 0
				var_81_9.localEulerAngles = var_81_15
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				var_81_9.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_81_16 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_16.x, var_81_16.y, var_81_16.z)

				local var_81_17 = var_81_9.localEulerAngles

				var_81_17.z = 0
				var_81_17.x = 0
				var_81_9.localEulerAngles = var_81_17
			end

			local var_81_18 = arg_78_1.actors_["1047ui_story"]
			local var_81_19 = 0

			if var_81_19 < arg_78_1.time_ and arg_78_1.time_ <= var_81_19 + arg_81_0 and not isNil(var_81_18) and arg_78_1.var_.characterEffect1047ui_story == nil then
				arg_78_1.var_.characterEffect1047ui_story = var_81_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_20 = 0.200000002980232

			if var_81_19 <= arg_78_1.time_ and arg_78_1.time_ < var_81_19 + var_81_20 and not isNil(var_81_18) then
				local var_81_21 = (arg_78_1.time_ - var_81_19) / var_81_20

				if arg_78_1.var_.characterEffect1047ui_story and not isNil(var_81_18) then
					arg_78_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_19 + var_81_20 and arg_78_1.time_ < var_81_19 + var_81_20 + arg_81_0 and not isNil(var_81_18) and arg_78_1.var_.characterEffect1047ui_story then
				arg_78_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_81_22 = arg_78_1.actors_["10102ui_story"]
			local var_81_23 = 0

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 and not isNil(var_81_22) and arg_78_1.var_.characterEffect10102ui_story == nil then
				arg_78_1.var_.characterEffect10102ui_story = var_81_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_24 = 0.200000002980232

			if var_81_23 <= arg_78_1.time_ and arg_78_1.time_ < var_81_23 + var_81_24 and not isNil(var_81_22) then
				local var_81_25 = (arg_78_1.time_ - var_81_23) / var_81_24

				if arg_78_1.var_.characterEffect10102ui_story and not isNil(var_81_22) then
					local var_81_26 = Mathf.Lerp(0, 0.5, var_81_25)

					arg_78_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10102ui_story.fillRatio = var_81_26
				end
			end

			if arg_78_1.time_ >= var_81_23 + var_81_24 and arg_78_1.time_ < var_81_23 + var_81_24 + arg_81_0 and not isNil(var_81_22) and arg_78_1.var_.characterEffect10102ui_story then
				local var_81_27 = 0.5

				arg_78_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10102ui_story.fillRatio = var_81_27
			end

			local var_81_28 = 0

			if var_81_28 < arg_78_1.time_ and arg_78_1.time_ <= var_81_28 + arg_81_0 then
				arg_78_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_81_29 = 0

			if var_81_29 < arg_78_1.time_ and arg_78_1.time_ <= var_81_29 + arg_81_0 then
				arg_78_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_81_30 = 0
			local var_81_31 = 0.375

			if var_81_30 < arg_78_1.time_ and arg_78_1.time_ <= var_81_30 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_32 = arg_78_1:FormatText(StoryNameCfg[1296].name)

				arg_78_1.leftNameTxt_.text = var_81_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_33 = arg_78_1:GetWordFromCfg(421091018)
				local var_81_34 = arg_78_1:FormatText(var_81_33.content)

				arg_78_1.text_.text = var_81_34

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_35 = 15
				local var_81_36 = utf8.len(var_81_34)
				local var_81_37 = var_81_35 <= 0 and var_81_31 or var_81_31 * (var_81_36 / var_81_35)

				if var_81_37 > 0 and var_81_31 < var_81_37 then
					arg_78_1.talkMaxDuration = var_81_37

					if var_81_37 + var_81_30 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_37 + var_81_30
					end
				end

				arg_78_1.text_.text = var_81_34
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091018", "story_v_out_421091.awb") ~= 0 then
					local var_81_38 = manager.audio:GetVoiceLength("story_v_out_421091", "421091018", "story_v_out_421091.awb") / 1000

					if var_81_38 + var_81_30 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_38 + var_81_30
					end

					if var_81_33.prefab_name ~= "" and arg_78_1.actors_[var_81_33.prefab_name] ~= nil then
						local var_81_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_33.prefab_name].transform, "story_v_out_421091", "421091018", "story_v_out_421091.awb")

						arg_78_1:RecordAudio("421091018", var_81_39)
						arg_78_1:RecordAudio("421091018", var_81_39)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_421091", "421091018", "story_v_out_421091.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_421091", "421091018", "story_v_out_421091.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_40 = math.max(var_81_31, arg_78_1.talkMaxDuration)

			if var_81_30 <= arg_78_1.time_ and arg_78_1.time_ < var_81_30 + var_81_40 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_30) / var_81_40

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_30 + var_81_40 and arg_78_1.time_ < var_81_30 + var_81_40 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 421091019
		arg_82_1.duration_ = 6.43

		local var_82_0 = {
			zh = 5.566,
			ja = 6.433
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play421091020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10143ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos10143ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0.78, -1.06, -6)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10143ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["10143ui_story"]
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect10143ui_story == nil then
				arg_82_1.var_.characterEffect10143ui_story = var_85_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.200000002980232

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 and not isNil(var_85_9) then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11

				if arg_82_1.var_.characterEffect10143ui_story and not isNil(var_85_9) then
					arg_82_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect10143ui_story then
				arg_82_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_85_13 = arg_82_1.actors_["1047ui_story"]
			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 and not isNil(var_85_13) and arg_82_1.var_.characterEffect1047ui_story == nil then
				arg_82_1.var_.characterEffect1047ui_story = var_85_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_15 = 0.200000002980232

			if var_85_14 <= arg_82_1.time_ and arg_82_1.time_ < var_85_14 + var_85_15 and not isNil(var_85_13) then
				local var_85_16 = (arg_82_1.time_ - var_85_14) / var_85_15

				if arg_82_1.var_.characterEffect1047ui_story and not isNil(var_85_13) then
					local var_85_17 = Mathf.Lerp(0, 0.5, var_85_16)

					arg_82_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1047ui_story.fillRatio = var_85_17
				end
			end

			if arg_82_1.time_ >= var_85_14 + var_85_15 and arg_82_1.time_ < var_85_14 + var_85_15 + arg_85_0 and not isNil(var_85_13) and arg_82_1.var_.characterEffect1047ui_story then
				local var_85_18 = 0.5

				arg_82_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1047ui_story.fillRatio = var_85_18
			end

			local var_85_19 = 0

			if var_85_19 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 then
				arg_82_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_85_20 = 0

			if var_85_20 < arg_82_1.time_ and arg_82_1.time_ <= var_85_20 + arg_85_0 then
				arg_82_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_85_21 = 0
			local var_85_22 = 0.65

			if var_85_21 < arg_82_1.time_ and arg_82_1.time_ <= var_85_21 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_23 = arg_82_1:FormatText(StoryNameCfg[1307].name)

				arg_82_1.leftNameTxt_.text = var_85_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_24 = arg_82_1:GetWordFromCfg(421091019)
				local var_85_25 = arg_82_1:FormatText(var_85_24.content)

				arg_82_1.text_.text = var_85_25

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_26 = 26
				local var_85_27 = utf8.len(var_85_25)
				local var_85_28 = var_85_26 <= 0 and var_85_22 or var_85_22 * (var_85_27 / var_85_26)

				if var_85_28 > 0 and var_85_22 < var_85_28 then
					arg_82_1.talkMaxDuration = var_85_28

					if var_85_28 + var_85_21 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_28 + var_85_21
					end
				end

				arg_82_1.text_.text = var_85_25
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091019", "story_v_out_421091.awb") ~= 0 then
					local var_85_29 = manager.audio:GetVoiceLength("story_v_out_421091", "421091019", "story_v_out_421091.awb") / 1000

					if var_85_29 + var_85_21 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_29 + var_85_21
					end

					if var_85_24.prefab_name ~= "" and arg_82_1.actors_[var_85_24.prefab_name] ~= nil then
						local var_85_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_24.prefab_name].transform, "story_v_out_421091", "421091019", "story_v_out_421091.awb")

						arg_82_1:RecordAudio("421091019", var_85_30)
						arg_82_1:RecordAudio("421091019", var_85_30)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_421091", "421091019", "story_v_out_421091.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_421091", "421091019", "story_v_out_421091.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_31 = math.max(var_85_22, arg_82_1.talkMaxDuration)

			if var_85_21 <= arg_82_1.time_ and arg_82_1.time_ < var_85_21 + var_85_31 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_21) / var_85_31

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_21 + var_85_31 and arg_82_1.time_ < var_85_21 + var_85_31 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play421091020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 421091020
		arg_86_1.duration_ = 4.77

		local var_86_0 = {
			zh = 4.766,
			ja = 1.833
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play421091021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10143ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10143ui_story == nil then
				arg_86_1.var_.characterEffect10143ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10143ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10143ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10143ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10143ui_story.fillRatio = var_89_5
			end

			local var_89_6 = arg_86_1.actors_["1047ui_story"]
			local var_89_7 = 0

			if var_89_7 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect1047ui_story == nil then
				arg_86_1.var_.characterEffect1047ui_story = var_89_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_8 = 0.200000002980232

			if var_89_7 <= arg_86_1.time_ and arg_86_1.time_ < var_89_7 + var_89_8 and not isNil(var_89_6) then
				local var_89_9 = (arg_86_1.time_ - var_89_7) / var_89_8

				if arg_86_1.var_.characterEffect1047ui_story and not isNil(var_89_6) then
					arg_86_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_7 + var_89_8 and arg_86_1.time_ < var_89_7 + var_89_8 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect1047ui_story then
				arg_86_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_89_10 = 0
			local var_89_11 = 0.75

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_12 = arg_86_1:FormatText(StoryNameCfg[1296].name)

				arg_86_1.leftNameTxt_.text = var_89_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_13 = arg_86_1:GetWordFromCfg(421091020)
				local var_89_14 = arg_86_1:FormatText(var_89_13.content)

				arg_86_1.text_.text = var_89_14

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 30
				local var_89_16 = utf8.len(var_89_14)
				local var_89_17 = var_89_15 <= 0 and var_89_11 or var_89_11 * (var_89_16 / var_89_15)

				if var_89_17 > 0 and var_89_11 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17

					if var_89_17 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_14
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091020", "story_v_out_421091.awb") ~= 0 then
					local var_89_18 = manager.audio:GetVoiceLength("story_v_out_421091", "421091020", "story_v_out_421091.awb") / 1000

					if var_89_18 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_10
					end

					if var_89_13.prefab_name ~= "" and arg_86_1.actors_[var_89_13.prefab_name] ~= nil then
						local var_89_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_13.prefab_name].transform, "story_v_out_421091", "421091020", "story_v_out_421091.awb")

						arg_86_1:RecordAudio("421091020", var_89_19)
						arg_86_1:RecordAudio("421091020", var_89_19)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_421091", "421091020", "story_v_out_421091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_421091", "421091020", "story_v_out_421091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_20 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_20 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_20

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_20 and arg_86_1.time_ < var_89_10 + var_89_20 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play421091021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 421091021
		arg_90_1.duration_ = 10.47

		local var_90_0 = {
			zh = 8.433,
			ja = 10.466
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
				arg_90_0:Play421091022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_93_2 = 0
			local var_93_3 = 0.975

			if var_93_2 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_4 = arg_90_1:FormatText(StoryNameCfg[1296].name)

				arg_90_1.leftNameTxt_.text = var_93_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_5 = arg_90_1:GetWordFromCfg(421091021)
				local var_93_6 = arg_90_1:FormatText(var_93_5.content)

				arg_90_1.text_.text = var_93_6

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 39
				local var_93_8 = utf8.len(var_93_6)
				local var_93_9 = var_93_7 <= 0 and var_93_3 or var_93_3 * (var_93_8 / var_93_7)

				if var_93_9 > 0 and var_93_3 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_6
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091021", "story_v_out_421091.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_421091", "421091021", "story_v_out_421091.awb") / 1000

					if var_93_10 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_2
					end

					if var_93_5.prefab_name ~= "" and arg_90_1.actors_[var_93_5.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_5.prefab_name].transform, "story_v_out_421091", "421091021", "story_v_out_421091.awb")

						arg_90_1:RecordAudio("421091021", var_93_11)
						arg_90_1:RecordAudio("421091021", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_421091", "421091021", "story_v_out_421091.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_421091", "421091021", "story_v_out_421091.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_12 and arg_90_1.time_ < var_93_2 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play421091022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 421091022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play421091023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1047ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1047ui_story == nil then
				arg_94_1.var_.characterEffect1047ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1047ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1047ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1047ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1047ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.5

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(421091022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 20
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
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play421091023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 421091023
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play421091024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10143ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos10143ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0.78, -1.06, -6)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10143ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = arg_98_1.actors_["10143ui_story"]
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect10143ui_story == nil then
				arg_98_1.var_.characterEffect10143ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_11 = 0.200000002980232

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 and not isNil(var_101_9) then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11

				if arg_98_1.var_.characterEffect10143ui_story and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect10143ui_story then
				arg_98_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_101_13 = 0

			if var_101_13 < arg_98_1.time_ and arg_98_1.time_ <= var_101_13 + arg_101_0 then
				arg_98_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_101_15 = 0
			local var_101_16 = 0.075

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_17 = arg_98_1:FormatText(StoryNameCfg[1307].name)

				arg_98_1.leftNameTxt_.text = var_101_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_18 = arg_98_1:GetWordFromCfg(421091023)
				local var_101_19 = arg_98_1:FormatText(var_101_18.content)

				arg_98_1.text_.text = var_101_19

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_20 = 3
				local var_101_21 = utf8.len(var_101_19)
				local var_101_22 = var_101_20 <= 0 and var_101_16 or var_101_16 * (var_101_21 / var_101_20)

				if var_101_22 > 0 and var_101_16 < var_101_22 then
					arg_98_1.talkMaxDuration = var_101_22

					if var_101_22 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_22 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_19
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091023", "story_v_out_421091.awb") ~= 0 then
					local var_101_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091023", "story_v_out_421091.awb") / 1000

					if var_101_23 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_15
					end

					if var_101_18.prefab_name ~= "" and arg_98_1.actors_[var_101_18.prefab_name] ~= nil then
						local var_101_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_18.prefab_name].transform, "story_v_out_421091", "421091023", "story_v_out_421091.awb")

						arg_98_1:RecordAudio("421091023", var_101_24)
						arg_98_1:RecordAudio("421091023", var_101_24)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_421091", "421091023", "story_v_out_421091.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_421091", "421091023", "story_v_out_421091.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_25 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_25 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_15) / var_101_25

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_15 + var_101_25 and arg_98_1.time_ < var_101_15 + var_101_25 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421091024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 421091024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play421091025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10143ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10143ui_story == nil then
				arg_102_1.var_.characterEffect10143ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect10143ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10143ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect10143ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10143ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 0.85

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_8 = arg_102_1:GetWordFromCfg(421091024)
				local var_105_9 = arg_102_1:FormatText(var_105_8.content)

				arg_102_1.text_.text = var_105_9

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_10 = 34
				local var_105_11 = utf8.len(var_105_9)
				local var_105_12 = var_105_10 <= 0 and var_105_7 or var_105_7 * (var_105_11 / var_105_10)

				if var_105_12 > 0 and var_105_7 < var_105_12 then
					arg_102_1.talkMaxDuration = var_105_12

					if var_105_12 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_12 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_9
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_13 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_13 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_13

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_13 and arg_102_1.time_ < var_105_6 + var_105_13 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play421091025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 421091025
		arg_106_1.duration_ = 4.3

		local var_106_0 = {
			zh = 4.3,
			ja = 3.8
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
				arg_106_0:Play421091026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1047ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1047ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1047ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1047ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1047ui_story == nil then
				arg_106_1.var_.characterEffect1047ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1047ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1047ui_story then
				arg_106_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_109_14 = 0

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_109_15 = 0
			local var_109_16 = 0.475

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_17 = arg_106_1:FormatText(StoryNameCfg[1296].name)

				arg_106_1.leftNameTxt_.text = var_109_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(421091025)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 19
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_16 or var_109_16 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_16 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091025", "story_v_out_421091.awb") ~= 0 then
					local var_109_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091025", "story_v_out_421091.awb") / 1000

					if var_109_23 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_15
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_421091", "421091025", "story_v_out_421091.awb")

						arg_106_1:RecordAudio("421091025", var_109_24)
						arg_106_1:RecordAudio("421091025", var_109_24)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_421091", "421091025", "story_v_out_421091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_421091", "421091025", "story_v_out_421091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_25 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_25 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_25

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_25 and arg_106_1.time_ < var_109_15 + var_109_25 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 421091026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play421091027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1047ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1047ui_story == nil then
				arg_110_1.var_.characterEffect1047ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1047ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1047ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1047ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1047ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.475

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_9 = arg_110_1:GetWordFromCfg(421091026)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 19
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
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play421091027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 421091027
		arg_114_1.duration_ = 11.43

		local var_114_0 = {
			zh = 8.3,
			ja = 11.433
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
				arg_114_0:Play421091028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10143ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos10143ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(0.78, -1.06, -6)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10143ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["10143ui_story"]
			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect10143ui_story == nil then
				arg_114_1.var_.characterEffect10143ui_story = var_117_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_11 = 0.200000002980232

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 and not isNil(var_117_9) then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11

				if arg_114_1.var_.characterEffect10143ui_story and not isNil(var_117_9) then
					arg_114_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect10143ui_story then
				arg_114_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_117_13 = 0

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 then
				arg_114_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			local var_117_14 = 0
			local var_117_15 = 0.95

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_16 = arg_114_1:FormatText(StoryNameCfg[1307].name)

				arg_114_1.leftNameTxt_.text = var_117_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_17 = arg_114_1:GetWordFromCfg(421091027)
				local var_117_18 = arg_114_1:FormatText(var_117_17.content)

				arg_114_1.text_.text = var_117_18

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_19 = 38
				local var_117_20 = utf8.len(var_117_18)
				local var_117_21 = var_117_19 <= 0 and var_117_15 or var_117_15 * (var_117_20 / var_117_19)

				if var_117_21 > 0 and var_117_15 < var_117_21 then
					arg_114_1.talkMaxDuration = var_117_21

					if var_117_21 + var_117_14 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_21 + var_117_14
					end
				end

				arg_114_1.text_.text = var_117_18
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091027", "story_v_out_421091.awb") ~= 0 then
					local var_117_22 = manager.audio:GetVoiceLength("story_v_out_421091", "421091027", "story_v_out_421091.awb") / 1000

					if var_117_22 + var_117_14 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_14
					end

					if var_117_17.prefab_name ~= "" and arg_114_1.actors_[var_117_17.prefab_name] ~= nil then
						local var_117_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_17.prefab_name].transform, "story_v_out_421091", "421091027", "story_v_out_421091.awb")

						arg_114_1:RecordAudio("421091027", var_117_23)
						arg_114_1:RecordAudio("421091027", var_117_23)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_421091", "421091027", "story_v_out_421091.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_421091", "421091027", "story_v_out_421091.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_24 = math.max(var_117_15, arg_114_1.talkMaxDuration)

			if var_117_14 <= arg_114_1.time_ and arg_114_1.time_ < var_117_14 + var_117_24 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_14) / var_117_24

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_14 + var_117_24 and arg_114_1.time_ < var_117_14 + var_117_24 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421091028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 421091028
		arg_118_1.duration_ = 15.1

		local var_118_0 = {
			zh = 7.333,
			ja = 15.1
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
				arg_118_0:Play421091029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1047ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1047ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1047ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["1047ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1047ui_story == nil then
				arg_118_1.var_.characterEffect1047ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.200000002980232

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect1047ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1047ui_story then
				arg_118_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_121_13 = arg_118_1.actors_["10143ui_story"]
			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 and not isNil(var_121_13) and arg_118_1.var_.characterEffect10143ui_story == nil then
				arg_118_1.var_.characterEffect10143ui_story = var_121_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_15 = 0.200000002980232

			if var_121_14 <= arg_118_1.time_ and arg_118_1.time_ < var_121_14 + var_121_15 and not isNil(var_121_13) then
				local var_121_16 = (arg_118_1.time_ - var_121_14) / var_121_15

				if arg_118_1.var_.characterEffect10143ui_story and not isNil(var_121_13) then
					local var_121_17 = Mathf.Lerp(0, 0.5, var_121_16)

					arg_118_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10143ui_story.fillRatio = var_121_17
				end
			end

			if arg_118_1.time_ >= var_121_14 + var_121_15 and arg_118_1.time_ < var_121_14 + var_121_15 + arg_121_0 and not isNil(var_121_13) and arg_118_1.var_.characterEffect10143ui_story then
				local var_121_18 = 0.5

				arg_118_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10143ui_story.fillRatio = var_121_18
			end

			local var_121_19 = 0

			if var_121_19 < arg_118_1.time_ and arg_118_1.time_ <= var_121_19 + arg_121_0 then
				arg_118_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_121_20 = 0

			if var_121_20 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_121_21 = 0
			local var_121_22 = 0.9

			if var_121_21 < arg_118_1.time_ and arg_118_1.time_ <= var_121_21 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_23 = arg_118_1:FormatText(StoryNameCfg[1296].name)

				arg_118_1.leftNameTxt_.text = var_121_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_24 = arg_118_1:GetWordFromCfg(421091028)
				local var_121_25 = arg_118_1:FormatText(var_121_24.content)

				arg_118_1.text_.text = var_121_25

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_26 = 36
				local var_121_27 = utf8.len(var_121_25)
				local var_121_28 = var_121_26 <= 0 and var_121_22 or var_121_22 * (var_121_27 / var_121_26)

				if var_121_28 > 0 and var_121_22 < var_121_28 then
					arg_118_1.talkMaxDuration = var_121_28

					if var_121_28 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_28 + var_121_21
					end
				end

				arg_118_1.text_.text = var_121_25
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091028", "story_v_out_421091.awb") ~= 0 then
					local var_121_29 = manager.audio:GetVoiceLength("story_v_out_421091", "421091028", "story_v_out_421091.awb") / 1000

					if var_121_29 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_29 + var_121_21
					end

					if var_121_24.prefab_name ~= "" and arg_118_1.actors_[var_121_24.prefab_name] ~= nil then
						local var_121_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_24.prefab_name].transform, "story_v_out_421091", "421091028", "story_v_out_421091.awb")

						arg_118_1:RecordAudio("421091028", var_121_30)
						arg_118_1:RecordAudio("421091028", var_121_30)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_421091", "421091028", "story_v_out_421091.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_421091", "421091028", "story_v_out_421091.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_31 = math.max(var_121_22, arg_118_1.talkMaxDuration)

			if var_121_21 <= arg_118_1.time_ and arg_118_1.time_ < var_121_21 + var_121_31 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_21) / var_121_31

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_21 + var_121_31 and arg_118_1.time_ < var_121_21 + var_121_31 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 421091029
		arg_122_1.duration_ = 7.83

		local var_122_0 = {
			zh = 6.5,
			ja = 7.833
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
				arg_122_0:Play421091030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1047ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1047ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1047ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			local var_125_10 = 0

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_125_11 = 0
			local var_125_12 = 0.75

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_13 = arg_122_1:FormatText(StoryNameCfg[1296].name)

				arg_122_1.leftNameTxt_.text = var_125_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_14 = arg_122_1:GetWordFromCfg(421091029)
				local var_125_15 = arg_122_1:FormatText(var_125_14.content)

				arg_122_1.text_.text = var_125_15

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_16 = 30
				local var_125_17 = utf8.len(var_125_15)
				local var_125_18 = var_125_16 <= 0 and var_125_12 or var_125_12 * (var_125_17 / var_125_16)

				if var_125_18 > 0 and var_125_12 < var_125_18 then
					arg_122_1.talkMaxDuration = var_125_18

					if var_125_18 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_18 + var_125_11
					end
				end

				arg_122_1.text_.text = var_125_15
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091029", "story_v_out_421091.awb") ~= 0 then
					local var_125_19 = manager.audio:GetVoiceLength("story_v_out_421091", "421091029", "story_v_out_421091.awb") / 1000

					if var_125_19 + var_125_11 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_11
					end

					if var_125_14.prefab_name ~= "" and arg_122_1.actors_[var_125_14.prefab_name] ~= nil then
						local var_125_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_14.prefab_name].transform, "story_v_out_421091", "421091029", "story_v_out_421091.awb")

						arg_122_1:RecordAudio("421091029", var_125_20)
						arg_122_1:RecordAudio("421091029", var_125_20)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_421091", "421091029", "story_v_out_421091.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_421091", "421091029", "story_v_out_421091.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_21 = math.max(var_125_12, arg_122_1.talkMaxDuration)

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_21 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_11) / var_125_21

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_11 + var_125_21 and arg_122_1.time_ < var_125_11 + var_125_21 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 421091030
		arg_126_1.duration_ = 7.63

		local var_126_0 = {
			zh = 7.633,
			ja = 7.366
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
				arg_126_0:Play421091031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["10143ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos10143ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0.78, -1.06, -6)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10143ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["10143ui_story"]
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect10143ui_story == nil then
				arg_126_1.var_.characterEffect10143ui_story = var_129_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_11 = 0.200000002980232

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 and not isNil(var_129_9) then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11

				if arg_126_1.var_.characterEffect10143ui_story and not isNil(var_129_9) then
					arg_126_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect10143ui_story then
				arg_126_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_129_13 = arg_126_1.actors_["1047ui_story"]
			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 and not isNil(var_129_13) and arg_126_1.var_.characterEffect1047ui_story == nil then
				arg_126_1.var_.characterEffect1047ui_story = var_129_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_15 = 0.200000002980232

			if var_129_14 <= arg_126_1.time_ and arg_126_1.time_ < var_129_14 + var_129_15 and not isNil(var_129_13) then
				local var_129_16 = (arg_126_1.time_ - var_129_14) / var_129_15

				if arg_126_1.var_.characterEffect1047ui_story and not isNil(var_129_13) then
					local var_129_17 = Mathf.Lerp(0, 0.5, var_129_16)

					arg_126_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1047ui_story.fillRatio = var_129_17
				end
			end

			if arg_126_1.time_ >= var_129_14 + var_129_15 and arg_126_1.time_ < var_129_14 + var_129_15 + arg_129_0 and not isNil(var_129_13) and arg_126_1.var_.characterEffect1047ui_story then
				local var_129_18 = 0.5

				arg_126_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1047ui_story.fillRatio = var_129_18
			end

			local var_129_19 = 0

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				arg_126_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_129_20 = 0

			if var_129_20 < arg_126_1.time_ and arg_126_1.time_ <= var_129_20 + arg_129_0 then
				arg_126_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_129_21 = 0
			local var_129_22 = 0.875

			if var_129_21 < arg_126_1.time_ and arg_126_1.time_ <= var_129_21 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_23 = arg_126_1:FormatText(StoryNameCfg[1307].name)

				arg_126_1.leftNameTxt_.text = var_129_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_24 = arg_126_1:GetWordFromCfg(421091030)
				local var_129_25 = arg_126_1:FormatText(var_129_24.content)

				arg_126_1.text_.text = var_129_25

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_26 = 35
				local var_129_27 = utf8.len(var_129_25)
				local var_129_28 = var_129_26 <= 0 and var_129_22 or var_129_22 * (var_129_27 / var_129_26)

				if var_129_28 > 0 and var_129_22 < var_129_28 then
					arg_126_1.talkMaxDuration = var_129_28

					if var_129_28 + var_129_21 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_28 + var_129_21
					end
				end

				arg_126_1.text_.text = var_129_25
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091030", "story_v_out_421091.awb") ~= 0 then
					local var_129_29 = manager.audio:GetVoiceLength("story_v_out_421091", "421091030", "story_v_out_421091.awb") / 1000

					if var_129_29 + var_129_21 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_29 + var_129_21
					end

					if var_129_24.prefab_name ~= "" and arg_126_1.actors_[var_129_24.prefab_name] ~= nil then
						local var_129_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_24.prefab_name].transform, "story_v_out_421091", "421091030", "story_v_out_421091.awb")

						arg_126_1:RecordAudio("421091030", var_129_30)
						arg_126_1:RecordAudio("421091030", var_129_30)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_421091", "421091030", "story_v_out_421091.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_421091", "421091030", "story_v_out_421091.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_31 = math.max(var_129_22, arg_126_1.talkMaxDuration)

			if var_129_21 <= arg_126_1.time_ and arg_126_1.time_ < var_129_21 + var_129_31 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_21) / var_129_31

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_21 + var_129_31 and arg_126_1.time_ < var_129_21 + var_129_31 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421091031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 421091031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play421091032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10143ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos10143ui_story = var_133_0.localPosition
			end

			local var_133_2 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2
				local var_133_4 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10143ui_story, var_133_4, var_133_3)

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

			local var_133_9 = arg_130_1.actors_["1047ui_story"].transform
			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1.var_.moveOldPos1047ui_story = var_133_9.localPosition
			end

			local var_133_11 = 0.001

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_11 then
				local var_133_12 = (arg_130_1.time_ - var_133_10) / var_133_11
				local var_133_13 = Vector3.New(0, 100, 0)

				var_133_9.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1047ui_story, var_133_13, var_133_12)

				local var_133_14 = manager.ui.mainCamera.transform.position - var_133_9.position

				var_133_9.forward = Vector3.New(var_133_14.x, var_133_14.y, var_133_14.z)

				local var_133_15 = var_133_9.localEulerAngles

				var_133_15.z = 0
				var_133_15.x = 0
				var_133_9.localEulerAngles = var_133_15
			end

			if arg_130_1.time_ >= var_133_10 + var_133_11 and arg_130_1.time_ < var_133_10 + var_133_11 + arg_133_0 then
				var_133_9.localPosition = Vector3.New(0, 100, 0)

				local var_133_16 = manager.ui.mainCamera.transform.position - var_133_9.position

				var_133_9.forward = Vector3.New(var_133_16.x, var_133_16.y, var_133_16.z)

				local var_133_17 = var_133_9.localEulerAngles

				var_133_17.z = 0
				var_133_17.x = 0
				var_133_9.localEulerAngles = var_133_17
			end

			local var_133_18 = 0
			local var_133_19 = 0.85

			if var_133_18 < arg_130_1.time_ and arg_130_1.time_ <= var_133_18 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_20 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_21 = arg_130_1:GetWordFromCfg(421091031)
				local var_133_22 = arg_130_1:FormatText(var_133_21.content)

				arg_130_1.text_.text = var_133_22

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_23 = 34
				local var_133_24 = utf8.len(var_133_22)
				local var_133_25 = var_133_23 <= 0 and var_133_19 or var_133_19 * (var_133_24 / var_133_23)

				if var_133_25 > 0 and var_133_19 < var_133_25 then
					arg_130_1.talkMaxDuration = var_133_25

					if var_133_25 + var_133_18 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_25 + var_133_18
					end
				end

				arg_130_1.text_.text = var_133_22
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_26 = math.max(var_133_19, arg_130_1.talkMaxDuration)

			if var_133_18 <= arg_130_1.time_ and arg_130_1.time_ < var_133_18 + var_133_26 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_18) / var_133_26

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_18 + var_133_26 and arg_130_1.time_ < var_133_18 + var_133_26 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 421091032
		arg_134_1.duration_ = 3.07

		local var_134_0 = {
			zh = 2.9,
			ja = 3.066
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
				arg_134_0:Play421091033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10102ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos10102ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0, -0.985, -6.275)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10102ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = arg_134_1.actors_["10102ui_story"]
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect10102ui_story == nil then
				arg_134_1.var_.characterEffect10102ui_story = var_137_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_11 = 0.200000002980232

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 and not isNil(var_137_9) then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / var_137_11

				if arg_134_1.var_.characterEffect10102ui_story and not isNil(var_137_9) then
					arg_134_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 and not isNil(var_137_9) and arg_134_1.var_.characterEffect10102ui_story then
				arg_134_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_137_13 = 0

			if var_137_13 < arg_134_1.time_ and arg_134_1.time_ <= var_137_13 + arg_137_0 then
				arg_134_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_137_14 = 0

			if var_137_14 < arg_134_1.time_ and arg_134_1.time_ <= var_137_14 + arg_137_0 then
				arg_134_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_15 = 0
			local var_137_16 = 0.35

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_17 = arg_134_1:FormatText(StoryNameCfg[6].name)

				arg_134_1.leftNameTxt_.text = var_137_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_18 = arg_134_1:GetWordFromCfg(421091032)
				local var_137_19 = arg_134_1:FormatText(var_137_18.content)

				arg_134_1.text_.text = var_137_19

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091032", "story_v_out_421091.awb") ~= 0 then
					local var_137_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091032", "story_v_out_421091.awb") / 1000

					if var_137_23 + var_137_15 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_23 + var_137_15
					end

					if var_137_18.prefab_name ~= "" and arg_134_1.actors_[var_137_18.prefab_name] ~= nil then
						local var_137_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_18.prefab_name].transform, "story_v_out_421091", "421091032", "story_v_out_421091.awb")

						arg_134_1:RecordAudio("421091032", var_137_24)
						arg_134_1:RecordAudio("421091032", var_137_24)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_421091", "421091032", "story_v_out_421091.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_421091", "421091032", "story_v_out_421091.awb")
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
				actorName = "10102ui_story",
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
	Play421091033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 421091033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play421091034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10102ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos10102ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10102ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = 0
			local var_141_10 = 0.875

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_11 = arg_138_1:GetWordFromCfg(421091033)
				local var_141_12 = arg_138_1:FormatText(var_141_11.content)

				arg_138_1.text_.text = var_141_12

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 31
				local var_141_14 = utf8.len(var_141_12)
				local var_141_15 = var_141_13 <= 0 and var_141_10 or var_141_10 * (var_141_14 / var_141_13)

				if var_141_15 > 0 and var_141_10 < var_141_15 then
					arg_138_1.talkMaxDuration = var_141_15

					if var_141_15 + var_141_9 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_15 + var_141_9
					end
				end

				arg_138_1.text_.text = var_141_12
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_10, arg_138_1.talkMaxDuration)

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_9) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_9 + var_141_16 and arg_138_1.time_ < var_141_9 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play421091034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 421091034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play421091035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.3

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				local var_145_2 = "play"
				local var_145_3 = "music"

				arg_142_1:AudioAction(var_145_2, var_145_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_145_4 = ""
				local var_145_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_145_5 ~= "" then
					if arg_142_1.bgmTxt_.text ~= var_145_5 and arg_142_1.bgmTxt_.text ~= "" then
						if arg_142_1.bgmTxt2_.text ~= "" then
							arg_142_1.bgmTxt_.text = arg_142_1.bgmTxt2_.text
						end

						arg_142_1.bgmTxt2_.text = var_145_5

						arg_142_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_142_1.bgmTxt_.text = var_145_5
						arg_142_1.bgmTxt2_.text = var_145_5
					end

					if arg_142_1.bgmTimer then
						arg_142_1.bgmTimer:Stop()

						arg_142_1.bgmTimer = nil
					end

					if arg_142_1.settingData.show_music_name == 1 then
						arg_142_1.musicController:SetSelectedState("show")
						arg_142_1.musicAnimator_:Play("open", 0, 0)

						if arg_142_1.settingData.music_time ~= 0 then
							arg_142_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_142_1.settingData.music_time), function()
								if arg_142_1 == nil or isNil(arg_142_1.bgmTxt_) then
									return
								end

								arg_142_1.musicController:SetSelectedState("hide")
								arg_142_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_145_6 = 0
			local var_145_7 = 0.3

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_8 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_9 = arg_142_1:GetWordFromCfg(421091034)
				local var_145_10 = arg_142_1:FormatText(var_145_9.content)

				arg_142_1.text_.text = var_145_10

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_11 = 12
				local var_145_12 = utf8.len(var_145_10)
				local var_145_13 = var_145_11 <= 0 and var_145_7 or var_145_7 * (var_145_12 / var_145_11)

				if var_145_13 > 0 and var_145_7 < var_145_13 then
					arg_142_1.talkMaxDuration = var_145_13

					if var_145_13 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_13 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_10
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_14 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_14 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_14

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_14 and arg_142_1.time_ < var_145_6 + var_145_14 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play421091035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 421091035
		arg_147_1.duration_ = 3.4

		local var_147_0 = {
			zh = 1.999999999999,
			ja = 3.4
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
				arg_147_0:Play421091036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1047ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1047ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -1.13, -6.2)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1047ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1047ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1047ui_story == nil then
				arg_147_1.var_.characterEffect1047ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1047ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1047ui_story then
				arg_147_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_150_15 = 0
			local var_150_16 = 0.175

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[1296].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(421091035)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091035", "story_v_out_421091.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091035", "story_v_out_421091.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_421091", "421091035", "story_v_out_421091.awb")

						arg_147_1:RecordAudio("421091035", var_150_24)
						arg_147_1:RecordAudio("421091035", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_421091", "421091035", "story_v_out_421091.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_421091", "421091035", "story_v_out_421091.awb")
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
				actorName = "1047ui_story",
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
	Play421091036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 421091036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play421091037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1047ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1047ui_story == nil then
				arg_151_1.var_.characterEffect1047ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1047ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1047ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1047ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1047ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.15

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

				local var_154_9 = arg_151_1:GetWordFromCfg(421091036)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 6
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
	Play421091037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 421091037
		arg_155_1.duration_ = 1

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"

			SetActive(arg_155_1.choicesGo_, true)

			for iter_156_0, iter_156_1 in ipairs(arg_155_1.choices_) do
				local var_156_0 = iter_156_0 <= 2

				SetActive(iter_156_1.go, var_156_0)
			end

			arg_155_1.choices_[1].txt.text = arg_155_1:FormatText(StoryChoiceCfg[1353].name)
			arg_155_1.choices_[2].txt.text = arg_155_1:FormatText(StoryChoiceCfg[1354].name)
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play421091038(arg_155_1)
			end

			if arg_157_0 == 2 then
				arg_155_0:Play421091038(arg_155_1)
			end

			arg_155_1:RecordChoiceLog(421091037, 1353, 1354)
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			return
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play421091038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 421091038
		arg_159_1.duration_ = 2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play421091039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1047ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1047ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -1.13, -6.2)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1047ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1047ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1047ui_story == nil then
				arg_159_1.var_.characterEffect1047ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1047ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1047ui_story then
				arg_159_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_162_13 = "1047ui_story"

			if arg_159_1.actors_[var_162_13] == nil then
				local var_162_14 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_162_14) then
					local var_162_15 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_159_1.stage_.transform)

					var_162_15.name = var_162_13
					var_162_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_159_1.actors_[var_162_13] = var_162_15

					local var_162_16 = var_162_15:GetComponentInChildren(typeof(CharacterEffect))

					var_162_16.enabled = true

					local var_162_17 = GameObjectTools.GetOrAddComponent(var_162_15, typeof(DynamicBoneHelper))

					if var_162_17 then
						var_162_17:EnableDynamicBone(false)
					end

					arg_159_1:ShowWeapon(var_162_16.transform, false)

					arg_159_1.var_[var_162_13 .. "Animator"] = var_162_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_159_1.var_[var_162_13 .. "Animator"].applyRootMotion = true
					arg_159_1.var_[var_162_13 .. "LipSync"] = var_162_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_162_18 = 0

			if var_162_18 < arg_159_1.time_ and arg_159_1.time_ <= var_162_18 + arg_162_0 then
				arg_159_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_162_19 = 0
			local var_162_20 = 0.3

			if var_162_19 < arg_159_1.time_ and arg_159_1.time_ <= var_162_19 + arg_162_0 then
				local var_162_21 = "play"
				local var_162_22 = "music"

				arg_159_1:AudioAction(var_162_21, var_162_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_162_23 = ""
				local var_162_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_162_24 ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_24 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_24

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_24
						arg_159_1.bgmTxt2_.text = var_162_24
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_25 = 0.433333333333333
			local var_162_26 = 1

			if var_162_25 < arg_159_1.time_ and arg_159_1.time_ <= var_162_25 + arg_162_0 then
				local var_162_27 = "play"
				local var_162_28 = "music"

				arg_159_1:AudioAction(var_162_27, var_162_28, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_162_29 = ""
				local var_162_30 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_162_30 ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_30 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_30

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_30
						arg_159_1.bgmTxt2_.text = var_162_30
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_31 = 0
			local var_162_32 = 0.05

			if var_162_31 < arg_159_1.time_ and arg_159_1.time_ <= var_162_31 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_33 = arg_159_1:FormatText(StoryNameCfg[1296].name)

				arg_159_1.leftNameTxt_.text = var_162_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_34 = arg_159_1:GetWordFromCfg(421091038)
				local var_162_35 = arg_159_1:FormatText(var_162_34.content)

				arg_159_1.text_.text = var_162_35

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_36 = 2
				local var_162_37 = utf8.len(var_162_35)
				local var_162_38 = var_162_36 <= 0 and var_162_32 or var_162_32 * (var_162_37 / var_162_36)

				if var_162_38 > 0 and var_162_32 < var_162_38 then
					arg_159_1.talkMaxDuration = var_162_38

					if var_162_38 + var_162_31 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_38 + var_162_31
					end
				end

				arg_159_1.text_.text = var_162_35
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091038", "story_v_out_421091.awb") ~= 0 then
					local var_162_39 = manager.audio:GetVoiceLength("story_v_out_421091", "421091038", "story_v_out_421091.awb") / 1000

					if var_162_39 + var_162_31 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_39 + var_162_31
					end

					if var_162_34.prefab_name ~= "" and arg_159_1.actors_[var_162_34.prefab_name] ~= nil then
						local var_162_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_34.prefab_name].transform, "story_v_out_421091", "421091038", "story_v_out_421091.awb")

						arg_159_1:RecordAudio("421091038", var_162_40)
						arg_159_1:RecordAudio("421091038", var_162_40)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_421091", "421091038", "story_v_out_421091.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_421091", "421091038", "story_v_out_421091.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_41 = math.max(var_162_32, arg_159_1.talkMaxDuration)

			if var_162_31 <= arg_159_1.time_ and arg_159_1.time_ < var_162_31 + var_162_41 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_31) / var_162_41

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_31 + var_162_41 and arg_159_1.time_ < var_162_31 + var_162_41 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421091039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play421091040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1047ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1047ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, 100, 0)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1047ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, 100, 0)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = 0
			local var_168_10 = 1.275

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_11 = arg_165_1:GetWordFromCfg(421091039)
				local var_168_12 = arg_165_1:FormatText(var_168_11.content)

				arg_165_1.text_.text = var_168_12

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 51
				local var_168_14 = utf8.len(var_168_12)
				local var_168_15 = var_168_13 <= 0 and var_168_10 or var_168_10 * (var_168_14 / var_168_13)

				if var_168_15 > 0 and var_168_10 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_9 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_9
					end
				end

				arg_165_1.text_.text = var_168_12
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_10, arg_165_1.talkMaxDuration)

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_9) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_9 + var_168_16 and arg_165_1.time_ < var_168_9 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421091040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play421091041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.375

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(421091040)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 15
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play421091041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421091041
		arg_173_1.duration_ = 16.4

		local var_173_0 = {
			zh = 13.166,
			ja = 16.4
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
				arg_173_0:Play421091042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1047ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -1.13, -6.2)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1047ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1047ui_story == nil then
				arg_173_1.var_.characterEffect1047ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1047ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1047ui_story then
				arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_176_14 = 0
			local var_176_15 = 1.25

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_16 = arg_173_1:FormatText(StoryNameCfg[1296].name)

				arg_173_1.leftNameTxt_.text = var_176_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_17 = arg_173_1:GetWordFromCfg(421091041)
				local var_176_18 = arg_173_1:FormatText(var_176_17.content)

				arg_173_1.text_.text = var_176_18

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_19 = 50
				local var_176_20 = utf8.len(var_176_18)
				local var_176_21 = var_176_19 <= 0 and var_176_15 or var_176_15 * (var_176_20 / var_176_19)

				if var_176_21 > 0 and var_176_15 < var_176_21 then
					arg_173_1.talkMaxDuration = var_176_21

					if var_176_21 + var_176_14 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_21 + var_176_14
					end
				end

				arg_173_1.text_.text = var_176_18
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091041", "story_v_out_421091.awb") ~= 0 then
					local var_176_22 = manager.audio:GetVoiceLength("story_v_out_421091", "421091041", "story_v_out_421091.awb") / 1000

					if var_176_22 + var_176_14 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_14
					end

					if var_176_17.prefab_name ~= "" and arg_173_1.actors_[var_176_17.prefab_name] ~= nil then
						local var_176_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_17.prefab_name].transform, "story_v_out_421091", "421091041", "story_v_out_421091.awb")

						arg_173_1:RecordAudio("421091041", var_176_23)
						arg_173_1:RecordAudio("421091041", var_176_23)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421091", "421091041", "story_v_out_421091.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421091", "421091041", "story_v_out_421091.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_24 = math.max(var_176_15, arg_173_1.talkMaxDuration)

			if var_176_14 <= arg_173_1.time_ and arg_173_1.time_ < var_176_14 + var_176_24 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_14) / var_176_24

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_14 + var_176_24 and arg_173_1.time_ < var_176_14 + var_176_24 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421091042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play421091043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1047ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, 100, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, 100, 0)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = 0
			local var_180_10 = 1.275

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_11 = arg_177_1:GetWordFromCfg(421091042)
				local var_180_12 = arg_177_1:FormatText(var_180_11.content)

				arg_177_1.text_.text = var_180_12

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 21
				local var_180_14 = utf8.len(var_180_12)
				local var_180_15 = var_180_13 <= 0 and var_180_10 or var_180_10 * (var_180_14 / var_180_13)

				if var_180_15 > 0 and var_180_10 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_9 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_9
					end
				end

				arg_177_1.text_.text = var_180_12
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_10, arg_177_1.talkMaxDuration)

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_9) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_9 + var_180_16 and arg_177_1.time_ < var_180_9 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421091043
		arg_181_1.duration_ = 23.73

		local var_181_0 = {
			zh = 18.166,
			ja = 23.733
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
				arg_181_0:Play421091044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1047ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1047ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, -1.13, -6.2)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1047ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1047ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1047ui_story == nil then
				arg_181_1.var_.characterEffect1047ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1047ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1047ui_story then
				arg_181_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_184_13 = 0

			if var_184_13 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_184_14 = 0
			local var_184_15 = 1.525

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_16 = arg_181_1:FormatText(StoryNameCfg[1296].name)

				arg_181_1.leftNameTxt_.text = var_184_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_17 = arg_181_1:GetWordFromCfg(421091043)
				local var_184_18 = arg_181_1:FormatText(var_184_17.content)

				arg_181_1.text_.text = var_184_18

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_19 = 61
				local var_184_20 = utf8.len(var_184_18)
				local var_184_21 = var_184_19 <= 0 and var_184_15 or var_184_15 * (var_184_20 / var_184_19)

				if var_184_21 > 0 and var_184_15 < var_184_21 then
					arg_181_1.talkMaxDuration = var_184_21

					if var_184_21 + var_184_14 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_21 + var_184_14
					end
				end

				arg_181_1.text_.text = var_184_18
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091043", "story_v_out_421091.awb") ~= 0 then
					local var_184_22 = manager.audio:GetVoiceLength("story_v_out_421091", "421091043", "story_v_out_421091.awb") / 1000

					if var_184_22 + var_184_14 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_22 + var_184_14
					end

					if var_184_17.prefab_name ~= "" and arg_181_1.actors_[var_184_17.prefab_name] ~= nil then
						local var_184_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_17.prefab_name].transform, "story_v_out_421091", "421091043", "story_v_out_421091.awb")

						arg_181_1:RecordAudio("421091043", var_184_23)
						arg_181_1:RecordAudio("421091043", var_184_23)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_421091", "421091043", "story_v_out_421091.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_421091", "421091043", "story_v_out_421091.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_24 = math.max(var_184_15, arg_181_1.talkMaxDuration)

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_24 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_14) / var_184_24

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_14 + var_184_24 and arg_181_1.time_ < var_184_14 + var_184_24 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421091044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play421091045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1047ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1047ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, -1.13, -6.2)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1047ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1047ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1047ui_story == nil then
				arg_185_1.var_.characterEffect1047ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect1047ui_story and not isNil(var_188_9) then
					local var_188_13 = Mathf.Lerp(0, 0.5, var_188_12)

					arg_185_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1047ui_story.fillRatio = var_188_13
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1047ui_story then
				local var_188_14 = 0.5

				arg_185_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1047ui_story.fillRatio = var_188_14
			end

			local var_188_15 = 0
			local var_188_16 = 0.35

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_17 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_18 = arg_185_1:GetWordFromCfg(421091044)
				local var_188_19 = arg_185_1:FormatText(var_188_18.content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_20 = 14
				local var_188_21 = utf8.len(var_188_19)
				local var_188_22 = var_188_20 <= 0 and var_188_16 or var_188_16 * (var_188_21 / var_188_20)

				if var_188_22 > 0 and var_188_16 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22

					if var_188_22 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_15
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_23 = math.max(var_188_16, arg_185_1.talkMaxDuration)

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_23 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_23

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_23 and arg_185_1.time_ < var_188_15 + var_188_23 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421091045
		arg_189_1.duration_ = 18.03

		local var_189_0 = {
			zh = 14.2,
			ja = 18.033
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
				arg_189_0:Play421091046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1047ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1047ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, -1.13, -6.2)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1047ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1047ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1047ui_story == nil then
				arg_189_1.var_.characterEffect1047ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1047ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1047ui_story then
				arg_189_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_192_15 = 0
			local var_192_16 = 1.35

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[1296].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(421091045)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091045", "story_v_out_421091.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091045", "story_v_out_421091.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_421091", "421091045", "story_v_out_421091.awb")

						arg_189_1:RecordAudio("421091045", var_192_24)
						arg_189_1:RecordAudio("421091045", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_421091", "421091045", "story_v_out_421091.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_421091", "421091045", "story_v_out_421091.awb")
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
				actorName = "1047ui_story",
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
	Play421091046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421091046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play421091047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1047ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1047ui_story == nil then
				arg_193_1.var_.characterEffect1047ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1047ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1047ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1047ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1047ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 0.225

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_9 = arg_193_1:GetWordFromCfg(421091046)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 9
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play421091047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421091047
		arg_197_1.duration_ = 8.6

		local var_197_0 = {
			zh = 6.6,
			ja = 8.6
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
				arg_197_0:Play421091048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1047ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1047ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -1.13, -6.2)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1047ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1047ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1047ui_story == nil then
				arg_197_1.var_.characterEffect1047ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1047ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1047ui_story then
				arg_197_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			local var_200_14 = 0
			local var_200_15 = 0.675

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_16 = arg_197_1:FormatText(StoryNameCfg[1296].name)

				arg_197_1.leftNameTxt_.text = var_200_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_17 = arg_197_1:GetWordFromCfg(421091047)
				local var_200_18 = arg_197_1:FormatText(var_200_17.content)

				arg_197_1.text_.text = var_200_18

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_19 = 27
				local var_200_20 = utf8.len(var_200_18)
				local var_200_21 = var_200_19 <= 0 and var_200_15 or var_200_15 * (var_200_20 / var_200_19)

				if var_200_21 > 0 and var_200_15 < var_200_21 then
					arg_197_1.talkMaxDuration = var_200_21

					if var_200_21 + var_200_14 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_21 + var_200_14
					end
				end

				arg_197_1.text_.text = var_200_18
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091047", "story_v_out_421091.awb") ~= 0 then
					local var_200_22 = manager.audio:GetVoiceLength("story_v_out_421091", "421091047", "story_v_out_421091.awb") / 1000

					if var_200_22 + var_200_14 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_22 + var_200_14
					end

					if var_200_17.prefab_name ~= "" and arg_197_1.actors_[var_200_17.prefab_name] ~= nil then
						local var_200_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_17.prefab_name].transform, "story_v_out_421091", "421091047", "story_v_out_421091.awb")

						arg_197_1:RecordAudio("421091047", var_200_23)
						arg_197_1:RecordAudio("421091047", var_200_23)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_421091", "421091047", "story_v_out_421091.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_421091", "421091047", "story_v_out_421091.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_24 = math.max(var_200_15, arg_197_1.talkMaxDuration)

			if var_200_14 <= arg_197_1.time_ and arg_197_1.time_ < var_200_14 + var_200_24 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_14) / var_200_24

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_14 + var_200_24 and arg_197_1.time_ < var_200_14 + var_200_24 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421091048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play421091049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1047ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1047ui_story == nil then
				arg_201_1.var_.characterEffect1047ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1047ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1047ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1047ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1047ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.425

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_9 = arg_201_1:GetWordFromCfg(421091048)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 17
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play421091049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421091049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play421091050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.325

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

				local var_208_3 = arg_205_1:GetWordFromCfg(421091049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 53
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
	Play421091050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421091050
		arg_209_1.duration_ = 7.6

		local var_209_0 = {
			zh = 5.066,
			ja = 7.6
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
				arg_209_0:Play421091051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1047ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, -1.13, -6.2)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1047ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1047ui_story == nil then
				arg_209_1.var_.characterEffect1047ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1047ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1047ui_story then
				arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_212_14 = 0
			local var_212_15 = 0.475

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_16 = arg_209_1:FormatText(StoryNameCfg[1296].name)

				arg_209_1.leftNameTxt_.text = var_212_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_17 = arg_209_1:GetWordFromCfg(421091050)
				local var_212_18 = arg_209_1:FormatText(var_212_17.content)

				arg_209_1.text_.text = var_212_18

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_19 = 19
				local var_212_20 = utf8.len(var_212_18)
				local var_212_21 = var_212_19 <= 0 and var_212_15 or var_212_15 * (var_212_20 / var_212_19)

				if var_212_21 > 0 and var_212_15 < var_212_21 then
					arg_209_1.talkMaxDuration = var_212_21

					if var_212_21 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_21 + var_212_14
					end
				end

				arg_209_1.text_.text = var_212_18
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091050", "story_v_out_421091.awb") ~= 0 then
					local var_212_22 = manager.audio:GetVoiceLength("story_v_out_421091", "421091050", "story_v_out_421091.awb") / 1000

					if var_212_22 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_14
					end

					if var_212_17.prefab_name ~= "" and arg_209_1.actors_[var_212_17.prefab_name] ~= nil then
						local var_212_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_17.prefab_name].transform, "story_v_out_421091", "421091050", "story_v_out_421091.awb")

						arg_209_1:RecordAudio("421091050", var_212_23)
						arg_209_1:RecordAudio("421091050", var_212_23)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421091", "421091050", "story_v_out_421091.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421091", "421091050", "story_v_out_421091.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_24 = math.max(var_212_15, arg_209_1.talkMaxDuration)

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_24 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_14) / var_212_24

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_14 + var_212_24 and arg_209_1.time_ < var_212_14 + var_212_24 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421091051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play421091052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1047ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1047ui_story == nil then
				arg_213_1.var_.characterEffect1047ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1047ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1047ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1047ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1047ui_story.fillRatio = var_216_5
			end

			local var_216_6 = 0
			local var_216_7 = 1.025

			if var_216_6 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_8 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_9 = arg_213_1:GetWordFromCfg(421091051)
				local var_216_10 = arg_213_1:FormatText(var_216_9.content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 42
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
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play421091052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 421091052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play421091053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.325

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(421091052)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 53
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
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play421091053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 421091053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play421091054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1047ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1047ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1047ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = 0
			local var_224_10 = 0.85

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_11 = arg_221_1:GetWordFromCfg(421091053)
				local var_224_12 = arg_221_1:FormatText(var_224_11.content)

				arg_221_1.text_.text = var_224_12

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 34
				local var_224_14 = utf8.len(var_224_12)
				local var_224_15 = var_224_13 <= 0 and var_224_10 or var_224_10 * (var_224_14 / var_224_13)

				if var_224_15 > 0 and var_224_10 < var_224_15 then
					arg_221_1.talkMaxDuration = var_224_15

					if var_224_15 + var_224_9 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_15 + var_224_9
					end
				end

				arg_221_1.text_.text = var_224_12
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_10, arg_221_1.talkMaxDuration)

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_9) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_9 + var_224_16 and arg_221_1.time_ < var_224_9 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 421091054
		arg_225_1.duration_ = 4.87

		local var_225_0 = {
			zh = 3.533,
			ja = 4.866
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
				arg_225_0:Play421091055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1047ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1047ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, -1.13, -6.2)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1047ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1047ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1047ui_story == nil then
				arg_225_1.var_.characterEffect1047ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1047ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1047ui_story then
				arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_228_15 = 0
			local var_228_16 = 0.4

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[1296].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(421091054)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 16
				local var_228_21 = utf8.len(var_228_19)
				local var_228_22 = var_228_20 <= 0 and var_228_16 or var_228_16 * (var_228_21 / var_228_20)

				if var_228_22 > 0 and var_228_16 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_19
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091054", "story_v_out_421091.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091054", "story_v_out_421091.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_out_421091", "421091054", "story_v_out_421091.awb")

						arg_225_1:RecordAudio("421091054", var_228_24)
						arg_225_1:RecordAudio("421091054", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_421091", "421091054", "story_v_out_421091.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_421091", "421091054", "story_v_out_421091.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_25 and arg_225_1.time_ < var_228_15 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play421091055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 421091055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play421091056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1047ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1047ui_story == nil then
				arg_229_1.var_.characterEffect1047ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1047ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1047ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1047ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1047ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 0.6

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_9 = arg_229_1:GetWordFromCfg(421091055)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 24
				local var_232_12 = utf8.len(var_232_10)
				local var_232_13 = var_232_11 <= 0 and var_232_7 or var_232_7 * (var_232_12 / var_232_11)

				if var_232_13 > 0 and var_232_7 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play421091056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 421091056
		arg_233_1.duration_ = 4.63

		local var_233_0 = {
			zh = 3.166,
			ja = 4.633
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
				arg_233_0:Play421091057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1047ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1047ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, -1.13, -6.2)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1047ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["1047ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1047ui_story == nil then
				arg_233_1.var_.characterEffect1047ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect1047ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1047ui_story then
				arg_233_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_236_13 = 0

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_236_15 = 0
			local var_236_16 = 0.325

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_17 = arg_233_1:FormatText(StoryNameCfg[1296].name)

				arg_233_1.leftNameTxt_.text = var_236_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_18 = arg_233_1:GetWordFromCfg(421091056)
				local var_236_19 = arg_233_1:FormatText(var_236_18.content)

				arg_233_1.text_.text = var_236_19

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_20 = 13
				local var_236_21 = utf8.len(var_236_19)
				local var_236_22 = var_236_20 <= 0 and var_236_16 or var_236_16 * (var_236_21 / var_236_20)

				if var_236_22 > 0 and var_236_16 < var_236_22 then
					arg_233_1.talkMaxDuration = var_236_22

					if var_236_22 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_15
					end
				end

				arg_233_1.text_.text = var_236_19
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091056", "story_v_out_421091.awb") ~= 0 then
					local var_236_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091056", "story_v_out_421091.awb") / 1000

					if var_236_23 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_15
					end

					if var_236_18.prefab_name ~= "" and arg_233_1.actors_[var_236_18.prefab_name] ~= nil then
						local var_236_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_18.prefab_name].transform, "story_v_out_421091", "421091056", "story_v_out_421091.awb")

						arg_233_1:RecordAudio("421091056", var_236_24)
						arg_233_1:RecordAudio("421091056", var_236_24)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_421091", "421091056", "story_v_out_421091.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_421091", "421091056", "story_v_out_421091.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_25 = math.max(var_236_16, arg_233_1.talkMaxDuration)

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_25 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_15) / var_236_25

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_15 + var_236_25 and arg_233_1.time_ < var_236_15 + var_236_25 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 421091057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play421091058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1047ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1047ui_story == nil then
				arg_237_1.var_.characterEffect1047ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1047ui_story and not isNil(var_240_0) then
					local var_240_4 = Mathf.Lerp(0, 0.5, var_240_3)

					arg_237_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1047ui_story.fillRatio = var_240_4
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1047ui_story then
				local var_240_5 = 0.5

				arg_237_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1047ui_story.fillRatio = var_240_5
			end

			local var_240_6 = 0
			local var_240_7 = 0.125

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_9 = arg_237_1:GetWordFromCfg(421091057)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 5
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play421091058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 421091058
		arg_241_1.duration_ = 2.97

		local var_241_0 = {
			zh = 2.4,
			ja = 2.966
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
				arg_241_0:Play421091059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1047ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1047ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1047ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = 0
			local var_244_10 = 0.325

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_11 = arg_241_1:FormatText(StoryNameCfg[6].name)

				arg_241_1.leftNameTxt_.text = var_244_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_12 = arg_241_1:GetWordFromCfg(421091058)
				local var_244_13 = arg_241_1:FormatText(var_244_12.content)

				arg_241_1.text_.text = var_244_13

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_14 = 13
				local var_244_15 = utf8.len(var_244_13)
				local var_244_16 = var_244_14 <= 0 and var_244_10 or var_244_10 * (var_244_15 / var_244_14)

				if var_244_16 > 0 and var_244_10 < var_244_16 then
					arg_241_1.talkMaxDuration = var_244_16

					if var_244_16 + var_244_9 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_9
					end
				end

				arg_241_1.text_.text = var_244_13
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091058", "story_v_out_421091.awb") ~= 0 then
					local var_244_17 = manager.audio:GetVoiceLength("story_v_out_421091", "421091058", "story_v_out_421091.awb") / 1000

					if var_244_17 + var_244_9 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_17 + var_244_9
					end

					if var_244_12.prefab_name ~= "" and arg_241_1.actors_[var_244_12.prefab_name] ~= nil then
						local var_244_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_12.prefab_name].transform, "story_v_out_421091", "421091058", "story_v_out_421091.awb")

						arg_241_1:RecordAudio("421091058", var_244_18)
						arg_241_1:RecordAudio("421091058", var_244_18)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_421091", "421091058", "story_v_out_421091.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_421091", "421091058", "story_v_out_421091.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_19 = math.max(var_244_10, arg_241_1.talkMaxDuration)

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_19 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_9) / var_244_19

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_9 + var_244_19 and arg_241_1.time_ < var_244_9 + var_244_19 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play421091059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 421091059
		arg_245_1.duration_ = 3.87

		local var_245_0 = {
			zh = 2.7,
			ja = 3.866
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
				arg_245_0:Play421091060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1047ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1047ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0, -1.13, -6.2)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1047ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["1047ui_story"]
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1047ui_story == nil then
				arg_245_1.var_.characterEffect1047ui_story = var_248_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.200000002980232

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 and not isNil(var_248_9) then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11

				if arg_245_1.var_.characterEffect1047ui_story and not isNil(var_248_9) then
					arg_245_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1047ui_story then
				arg_245_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_248_13 = arg_245_1.actors_["10102ui_story"]
			local var_248_14 = 0

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 and not isNil(var_248_13) and arg_245_1.var_.characterEffect10102ui_story == nil then
				arg_245_1.var_.characterEffect10102ui_story = var_248_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_15 = 0.200000002980232

			if var_248_14 <= arg_245_1.time_ and arg_245_1.time_ < var_248_14 + var_248_15 and not isNil(var_248_13) then
				local var_248_16 = (arg_245_1.time_ - var_248_14) / var_248_15

				if arg_245_1.var_.characterEffect10102ui_story and not isNil(var_248_13) then
					local var_248_17 = Mathf.Lerp(0, 0.5, var_248_16)

					arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10102ui_story.fillRatio = var_248_17
				end
			end

			if arg_245_1.time_ >= var_248_14 + var_248_15 and arg_245_1.time_ < var_248_14 + var_248_15 + arg_248_0 and not isNil(var_248_13) and arg_245_1.var_.characterEffect10102ui_story then
				local var_248_18 = 0.5

				arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10102ui_story.fillRatio = var_248_18
			end

			local var_248_19 = 0

			if var_248_19 < arg_245_1.time_ and arg_245_1.time_ <= var_248_19 + arg_248_0 then
				arg_245_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_248_20 = 0

			if var_248_20 < arg_245_1.time_ and arg_245_1.time_ <= var_248_20 + arg_248_0 then
				arg_245_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_248_21 = 0
			local var_248_22 = 0.225

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_23 = arg_245_1:FormatText(StoryNameCfg[1296].name)

				arg_245_1.leftNameTxt_.text = var_248_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_24 = arg_245_1:GetWordFromCfg(421091059)
				local var_248_25 = arg_245_1:FormatText(var_248_24.content)

				arg_245_1.text_.text = var_248_25

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_26 = 9
				local var_248_27 = utf8.len(var_248_25)
				local var_248_28 = var_248_26 <= 0 and var_248_22 or var_248_22 * (var_248_27 / var_248_26)

				if var_248_28 > 0 and var_248_22 < var_248_28 then
					arg_245_1.talkMaxDuration = var_248_28

					if var_248_28 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_28 + var_248_21
					end
				end

				arg_245_1.text_.text = var_248_25
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091059", "story_v_out_421091.awb") ~= 0 then
					local var_248_29 = manager.audio:GetVoiceLength("story_v_out_421091", "421091059", "story_v_out_421091.awb") / 1000

					if var_248_29 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_29 + var_248_21
					end

					if var_248_24.prefab_name ~= "" and arg_245_1.actors_[var_248_24.prefab_name] ~= nil then
						local var_248_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_24.prefab_name].transform, "story_v_out_421091", "421091059", "story_v_out_421091.awb")

						arg_245_1:RecordAudio("421091059", var_248_30)
						arg_245_1:RecordAudio("421091059", var_248_30)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_421091", "421091059", "story_v_out_421091.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_421091", "421091059", "story_v_out_421091.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_31 = math.max(var_248_22, arg_245_1.talkMaxDuration)

			if var_248_21 <= arg_245_1.time_ and arg_245_1.time_ < var_248_21 + var_248_31 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_21) / var_248_31

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_21 + var_248_31 and arg_245_1.time_ < var_248_21 + var_248_31 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play421091060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 421091060
		arg_249_1.duration_ = 9.47

		local var_249_0 = {
			zh = 5.633,
			ja = 9.466
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
				arg_249_0:Play421091061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10143ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10143ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0.78, -1.06, -6)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10143ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["1047ui_story"].transform
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1.var_.moveOldPos1047ui_story = var_252_9.localPosition
			end

			local var_252_11 = 0.001

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11
				local var_252_13 = Vector3.New(-0.6, -1.13, -6.2)

				var_252_9.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1047ui_story, var_252_13, var_252_12)

				local var_252_14 = manager.ui.mainCamera.transform.position - var_252_9.position

				var_252_9.forward = Vector3.New(var_252_14.x, var_252_14.y, var_252_14.z)

				local var_252_15 = var_252_9.localEulerAngles

				var_252_15.z = 0
				var_252_15.x = 0
				var_252_9.localEulerAngles = var_252_15
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 then
				var_252_9.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_252_16 = manager.ui.mainCamera.transform.position - var_252_9.position

				var_252_9.forward = Vector3.New(var_252_16.x, var_252_16.y, var_252_16.z)

				local var_252_17 = var_252_9.localEulerAngles

				var_252_17.z = 0
				var_252_17.x = 0
				var_252_9.localEulerAngles = var_252_17
			end

			local var_252_18 = arg_249_1.actors_["10143ui_story"]
			local var_252_19 = 0

			if var_252_19 < arg_249_1.time_ and arg_249_1.time_ <= var_252_19 + arg_252_0 and not isNil(var_252_18) and arg_249_1.var_.characterEffect10143ui_story == nil then
				arg_249_1.var_.characterEffect10143ui_story = var_252_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_20 = 0.200000002980232

			if var_252_19 <= arg_249_1.time_ and arg_249_1.time_ < var_252_19 + var_252_20 and not isNil(var_252_18) then
				local var_252_21 = (arg_249_1.time_ - var_252_19) / var_252_20

				if arg_249_1.var_.characterEffect10143ui_story and not isNil(var_252_18) then
					arg_249_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_19 + var_252_20 and arg_249_1.time_ < var_252_19 + var_252_20 + arg_252_0 and not isNil(var_252_18) and arg_249_1.var_.characterEffect10143ui_story then
				arg_249_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_252_22 = arg_249_1.actors_["1047ui_story"]
			local var_252_23 = 0

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.characterEffect1047ui_story == nil then
				arg_249_1.var_.characterEffect1047ui_story = var_252_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_24 = 0.200000002980232

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_24 and not isNil(var_252_22) then
				local var_252_25 = (arg_249_1.time_ - var_252_23) / var_252_24

				if arg_249_1.var_.characterEffect1047ui_story and not isNil(var_252_22) then
					local var_252_26 = Mathf.Lerp(0, 0.5, var_252_25)

					arg_249_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1047ui_story.fillRatio = var_252_26
				end
			end

			if arg_249_1.time_ >= var_252_23 + var_252_24 and arg_249_1.time_ < var_252_23 + var_252_24 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.characterEffect1047ui_story then
				local var_252_27 = 0.5

				arg_249_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1047ui_story.fillRatio = var_252_27
			end

			local var_252_28 = 0

			if var_252_28 < arg_249_1.time_ and arg_249_1.time_ <= var_252_28 + arg_252_0 then
				arg_249_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_252_29 = 0

			if var_252_29 < arg_249_1.time_ and arg_249_1.time_ <= var_252_29 + arg_252_0 then
				arg_249_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_252_30 = 0
			local var_252_31 = 0.75

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_32 = arg_249_1:FormatText(StoryNameCfg[1307].name)

				arg_249_1.leftNameTxt_.text = var_252_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_33 = arg_249_1:GetWordFromCfg(421091060)
				local var_252_34 = arg_249_1:FormatText(var_252_33.content)

				arg_249_1.text_.text = var_252_34

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_35 = 30
				local var_252_36 = utf8.len(var_252_34)
				local var_252_37 = var_252_35 <= 0 and var_252_31 or var_252_31 * (var_252_36 / var_252_35)

				if var_252_37 > 0 and var_252_31 < var_252_37 then
					arg_249_1.talkMaxDuration = var_252_37

					if var_252_37 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_37 + var_252_30
					end
				end

				arg_249_1.text_.text = var_252_34
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091060", "story_v_out_421091.awb") ~= 0 then
					local var_252_38 = manager.audio:GetVoiceLength("story_v_out_421091", "421091060", "story_v_out_421091.awb") / 1000

					if var_252_38 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_38 + var_252_30
					end

					if var_252_33.prefab_name ~= "" and arg_249_1.actors_[var_252_33.prefab_name] ~= nil then
						local var_252_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_33.prefab_name].transform, "story_v_out_421091", "421091060", "story_v_out_421091.awb")

						arg_249_1:RecordAudio("421091060", var_252_39)
						arg_249_1:RecordAudio("421091060", var_252_39)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_421091", "421091060", "story_v_out_421091.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_421091", "421091060", "story_v_out_421091.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_40 = math.max(var_252_31, arg_249_1.talkMaxDuration)

			if var_252_30 <= arg_249_1.time_ and arg_249_1.time_ < var_252_30 + var_252_40 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_30) / var_252_40

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_30 + var_252_40 and arg_249_1.time_ < var_252_30 + var_252_40 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play421091061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 421091061
		arg_253_1.duration_ = 12.3

		local var_253_0 = {
			zh = 9.633,
			ja = 12.3
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play421091062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1047ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1047ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1047ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1047ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1047ui_story == nil then
				arg_253_1.var_.characterEffect1047ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1047ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1047ui_story then
				arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_256_13 = arg_253_1.actors_["10143ui_story"]
			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 and not isNil(var_256_13) and arg_253_1.var_.characterEffect10143ui_story == nil then
				arg_253_1.var_.characterEffect10143ui_story = var_256_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_15 = 0.200000002980232

			if var_256_14 <= arg_253_1.time_ and arg_253_1.time_ < var_256_14 + var_256_15 and not isNil(var_256_13) then
				local var_256_16 = (arg_253_1.time_ - var_256_14) / var_256_15

				if arg_253_1.var_.characterEffect10143ui_story and not isNil(var_256_13) then
					local var_256_17 = Mathf.Lerp(0, 0.5, var_256_16)

					arg_253_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10143ui_story.fillRatio = var_256_17
				end
			end

			if arg_253_1.time_ >= var_256_14 + var_256_15 and arg_253_1.time_ < var_256_14 + var_256_15 + arg_256_0 and not isNil(var_256_13) and arg_253_1.var_.characterEffect10143ui_story then
				local var_256_18 = 0.5

				arg_253_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10143ui_story.fillRatio = var_256_18
			end

			local var_256_19 = 0

			if var_256_19 < arg_253_1.time_ and arg_253_1.time_ <= var_256_19 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_256_20 = 0

			if var_256_20 < arg_253_1.time_ and arg_253_1.time_ <= var_256_20 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_256_21 = 0
			local var_256_22 = 0.95

			if var_256_21 < arg_253_1.time_ and arg_253_1.time_ <= var_256_21 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_23 = arg_253_1:FormatText(StoryNameCfg[1296].name)

				arg_253_1.leftNameTxt_.text = var_256_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_24 = arg_253_1:GetWordFromCfg(421091061)
				local var_256_25 = arg_253_1:FormatText(var_256_24.content)

				arg_253_1.text_.text = var_256_25

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_26 = 38
				local var_256_27 = utf8.len(var_256_25)
				local var_256_28 = var_256_26 <= 0 and var_256_22 or var_256_22 * (var_256_27 / var_256_26)

				if var_256_28 > 0 and var_256_22 < var_256_28 then
					arg_253_1.talkMaxDuration = var_256_28

					if var_256_28 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_28 + var_256_21
					end
				end

				arg_253_1.text_.text = var_256_25
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091061", "story_v_out_421091.awb") ~= 0 then
					local var_256_29 = manager.audio:GetVoiceLength("story_v_out_421091", "421091061", "story_v_out_421091.awb") / 1000

					if var_256_29 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_29 + var_256_21
					end

					if var_256_24.prefab_name ~= "" and arg_253_1.actors_[var_256_24.prefab_name] ~= nil then
						local var_256_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_24.prefab_name].transform, "story_v_out_421091", "421091061", "story_v_out_421091.awb")

						arg_253_1:RecordAudio("421091061", var_256_30)
						arg_253_1:RecordAudio("421091061", var_256_30)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_421091", "421091061", "story_v_out_421091.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_421091", "421091061", "story_v_out_421091.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_31 = math.max(var_256_22, arg_253_1.talkMaxDuration)

			if var_256_21 <= arg_253_1.time_ and arg_253_1.time_ < var_256_21 + var_256_31 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_21) / var_256_31

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_21 + var_256_31 and arg_253_1.time_ < var_256_21 + var_256_31 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play421091062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 421091062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play421091063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1047ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1047ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(0, 100, 0)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1047ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, 100, 0)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["10143ui_story"].transform
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1.var_.moveOldPos10143ui_story = var_260_9.localPosition
			end

			local var_260_11 = 0.001

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11
				local var_260_13 = Vector3.New(0, 100, 0)

				var_260_9.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10143ui_story, var_260_13, var_260_12)

				local var_260_14 = manager.ui.mainCamera.transform.position - var_260_9.position

				var_260_9.forward = Vector3.New(var_260_14.x, var_260_14.y, var_260_14.z)

				local var_260_15 = var_260_9.localEulerAngles

				var_260_15.z = 0
				var_260_15.x = 0
				var_260_9.localEulerAngles = var_260_15
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 then
				var_260_9.localPosition = Vector3.New(0, 100, 0)

				local var_260_16 = manager.ui.mainCamera.transform.position - var_260_9.position

				var_260_9.forward = Vector3.New(var_260_16.x, var_260_16.y, var_260_16.z)

				local var_260_17 = var_260_9.localEulerAngles

				var_260_17.z = 0
				var_260_17.x = 0
				var_260_9.localEulerAngles = var_260_17
			end

			local var_260_18 = 0.1
			local var_260_19 = 1

			if var_260_18 < arg_257_1.time_ and arg_257_1.time_ <= var_260_18 + arg_260_0 then
				local var_260_20 = "play"
				local var_260_21 = "effect"

				arg_257_1:AudioAction(var_260_20, var_260_21, "se_story_140", "se_story_140_foley_bag01", "")
			end

			local var_260_22 = 0
			local var_260_23 = 0.925

			if var_260_22 < arg_257_1.time_ and arg_257_1.time_ <= var_260_22 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_24 = arg_257_1:GetWordFromCfg(421091062)
				local var_260_25 = arg_257_1:FormatText(var_260_24.content)

				arg_257_1.text_.text = var_260_25

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_26 = 37
				local var_260_27 = utf8.len(var_260_25)
				local var_260_28 = var_260_26 <= 0 and var_260_23 or var_260_23 * (var_260_27 / var_260_26)

				if var_260_28 > 0 and var_260_23 < var_260_28 then
					arg_257_1.talkMaxDuration = var_260_28

					if var_260_28 + var_260_22 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_28 + var_260_22
					end
				end

				arg_257_1.text_.text = var_260_25
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_29 = math.max(var_260_23, arg_257_1.talkMaxDuration)

			if var_260_22 <= arg_257_1.time_ and arg_257_1.time_ < var_260_22 + var_260_29 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_22) / var_260_29

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_22 + var_260_29 and arg_257_1.time_ < var_260_22 + var_260_29 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play421091063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 421091063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play421091064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.325

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(421091063)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 13
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play421091064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 421091064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play421091065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 1.05

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_2 = arg_265_1:GetWordFromCfg(421091064)
				local var_268_3 = arg_265_1:FormatText(var_268_2.content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 42
				local var_268_5 = utf8.len(var_268_3)
				local var_268_6 = var_268_4 <= 0 and var_268_1 or var_268_1 * (var_268_5 / var_268_4)

				if var_268_6 > 0 and var_268_1 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_7 and arg_265_1.time_ < var_268_0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play421091065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 421091065
		arg_269_1.duration_ = 5.2

		local var_269_0 = {
			zh = 4.433,
			ja = 5.2
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play421091066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10143ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos10143ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0, -1.06, -6)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10143ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -1.06, -6)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["10143ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect10143ui_story == nil then
				arg_269_1.var_.characterEffect10143ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect10143ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect10143ui_story then
				arg_269_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_272_15 = 0
			local var_272_16 = 0.575

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[1307].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(421091065)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 23
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091065", "story_v_out_421091.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091065", "story_v_out_421091.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_out_421091", "421091065", "story_v_out_421091.awb")

						arg_269_1:RecordAudio("421091065", var_272_24)
						arg_269_1:RecordAudio("421091065", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_421091", "421091065", "story_v_out_421091.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_421091", "421091065", "story_v_out_421091.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play421091066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 421091066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play421091067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10143ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10143ui_story == nil then
				arg_273_1.var_.characterEffect10143ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect10143ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10143ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10143ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10143ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.825

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(421091066)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 33
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play421091067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 421091067
		arg_277_1.duration_ = 9.7

		local var_277_0 = {
			zh = 7.866,
			ja = 9.7
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
				arg_277_0:Play421091068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1047ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1047ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(0.74, -1.13, -6.2)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1047ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["10143ui_story"].transform
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1.var_.moveOldPos10143ui_story = var_280_9.localPosition
			end

			local var_280_11 = 0.001

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11
				local var_280_13 = Vector3.New(-0.72, -1.06, -6)

				var_280_9.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10143ui_story, var_280_13, var_280_12)

				local var_280_14 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_14.x, var_280_14.y, var_280_14.z)

				local var_280_15 = var_280_9.localEulerAngles

				var_280_15.z = 0
				var_280_15.x = 0
				var_280_9.localEulerAngles = var_280_15
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 then
				var_280_9.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_280_16 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_16.x, var_280_16.y, var_280_16.z)

				local var_280_17 = var_280_9.localEulerAngles

				var_280_17.z = 0
				var_280_17.x = 0
				var_280_9.localEulerAngles = var_280_17
			end

			local var_280_18 = arg_277_1.actors_["1047ui_story"]
			local var_280_19 = 0

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 and not isNil(var_280_18) and arg_277_1.var_.characterEffect1047ui_story == nil then
				arg_277_1.var_.characterEffect1047ui_story = var_280_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_20 = 0.200000002980232

			if var_280_19 <= arg_277_1.time_ and arg_277_1.time_ < var_280_19 + var_280_20 and not isNil(var_280_18) then
				local var_280_21 = (arg_277_1.time_ - var_280_19) / var_280_20

				if arg_277_1.var_.characterEffect1047ui_story and not isNil(var_280_18) then
					arg_277_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_19 + var_280_20 and arg_277_1.time_ < var_280_19 + var_280_20 + arg_280_0 and not isNil(var_280_18) and arg_277_1.var_.characterEffect1047ui_story then
				arg_277_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_280_22 = 0

			if var_280_22 < arg_277_1.time_ and arg_277_1.time_ <= var_280_22 + arg_280_0 then
				arg_277_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_280_23 = 0

			if var_280_23 < arg_277_1.time_ and arg_277_1.time_ <= var_280_23 + arg_280_0 then
				arg_277_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_280_24 = 0
			local var_280_25 = 1.05

			if var_280_24 < arg_277_1.time_ and arg_277_1.time_ <= var_280_24 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_26 = arg_277_1:FormatText(StoryNameCfg[1296].name)

				arg_277_1.leftNameTxt_.text = var_280_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_27 = arg_277_1:GetWordFromCfg(421091067)
				local var_280_28 = arg_277_1:FormatText(var_280_27.content)

				arg_277_1.text_.text = var_280_28

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_29 = 42
				local var_280_30 = utf8.len(var_280_28)
				local var_280_31 = var_280_29 <= 0 and var_280_25 or var_280_25 * (var_280_30 / var_280_29)

				if var_280_31 > 0 and var_280_25 < var_280_31 then
					arg_277_1.talkMaxDuration = var_280_31

					if var_280_31 + var_280_24 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_31 + var_280_24
					end
				end

				arg_277_1.text_.text = var_280_28
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091067", "story_v_out_421091.awb") ~= 0 then
					local var_280_32 = manager.audio:GetVoiceLength("story_v_out_421091", "421091067", "story_v_out_421091.awb") / 1000

					if var_280_32 + var_280_24 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_32 + var_280_24
					end

					if var_280_27.prefab_name ~= "" and arg_277_1.actors_[var_280_27.prefab_name] ~= nil then
						local var_280_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_27.prefab_name].transform, "story_v_out_421091", "421091067", "story_v_out_421091.awb")

						arg_277_1:RecordAudio("421091067", var_280_33)
						arg_277_1:RecordAudio("421091067", var_280_33)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_421091", "421091067", "story_v_out_421091.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_421091", "421091067", "story_v_out_421091.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_34 = math.max(var_280_25, arg_277_1.talkMaxDuration)

			if var_280_24 <= arg_277_1.time_ and arg_277_1.time_ < var_280_24 + var_280_34 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_24) / var_280_34

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_24 + var_280_34 and arg_277_1.time_ < var_280_24 + var_280_34 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421091068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 421091068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play421091069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1047ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1047ui_story == nil then
				arg_281_1.var_.characterEffect1047ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1047ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1047ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1047ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1047ui_story.fillRatio = var_284_5
			end

			local var_284_6 = 0
			local var_284_7 = 1.025

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_8 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_9 = arg_281_1:GetWordFromCfg(421091068)
				local var_284_10 = arg_281_1:FormatText(var_284_9.content)

				arg_281_1.text_.text = var_284_10

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 41
				local var_284_12 = utf8.len(var_284_10)
				local var_284_13 = var_284_11 <= 0 and var_284_7 or var_284_7 * (var_284_12 / var_284_11)

				if var_284_13 > 0 and var_284_7 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_10
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_14 and arg_281_1.time_ < var_284_6 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play421091069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 421091069
		arg_285_1.duration_ = 2.1

		local var_285_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_285_0:Play421091070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10143ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10143ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(-0.72, -1.06, -6)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10143ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["10143ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect10143ui_story == nil then
				arg_285_1.var_.characterEffect10143ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect10143ui_story and not isNil(var_288_9) then
					arg_285_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect10143ui_story then
				arg_285_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_288_13 = 0

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_288_15 = 0
			local var_288_16 = 0.075

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[1307].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(421091069)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 3
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091069", "story_v_out_421091.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_out_421091", "421091069", "story_v_out_421091.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_out_421091", "421091069", "story_v_out_421091.awb")

						arg_285_1:RecordAudio("421091069", var_288_24)
						arg_285_1:RecordAudio("421091069", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_421091", "421091069", "story_v_out_421091.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_421091", "421091069", "story_v_out_421091.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421091070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 421091070
		arg_289_1.duration_ = 2

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play421091071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10102ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10102ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0.7, -0.985, -6.275)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10102ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["1047ui_story"].transform
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.var_.moveOldPos1047ui_story = var_292_9.localPosition
			end

			local var_292_11 = 0.001

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11
				local var_292_13 = Vector3.New(0, 100, 0)

				var_292_9.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1047ui_story, var_292_13, var_292_12)

				local var_292_14 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_14.x, var_292_14.y, var_292_14.z)

				local var_292_15 = var_292_9.localEulerAngles

				var_292_15.z = 0
				var_292_15.x = 0
				var_292_9.localEulerAngles = var_292_15
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 then
				var_292_9.localPosition = Vector3.New(0, 100, 0)

				local var_292_16 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_16.x, var_292_16.y, var_292_16.z)

				local var_292_17 = var_292_9.localEulerAngles

				var_292_17.z = 0
				var_292_17.x = 0
				var_292_9.localEulerAngles = var_292_17
			end

			local var_292_18 = arg_289_1.actors_["10102ui_story"]
			local var_292_19 = 0

			if var_292_19 < arg_289_1.time_ and arg_289_1.time_ <= var_292_19 + arg_292_0 and not isNil(var_292_18) and arg_289_1.var_.characterEffect10102ui_story == nil then
				arg_289_1.var_.characterEffect10102ui_story = var_292_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_20 = 0.200000002980232

			if var_292_19 <= arg_289_1.time_ and arg_289_1.time_ < var_292_19 + var_292_20 and not isNil(var_292_18) then
				local var_292_21 = (arg_289_1.time_ - var_292_19) / var_292_20

				if arg_289_1.var_.characterEffect10102ui_story and not isNil(var_292_18) then
					arg_289_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_19 + var_292_20 and arg_289_1.time_ < var_292_19 + var_292_20 + arg_292_0 and not isNil(var_292_18) and arg_289_1.var_.characterEffect10102ui_story then
				arg_289_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_292_22 = arg_289_1.actors_["10143ui_story"]
			local var_292_23 = 0

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 and not isNil(var_292_22) and arg_289_1.var_.characterEffect10143ui_story == nil then
				arg_289_1.var_.characterEffect10143ui_story = var_292_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_24 = 0.200000002980232

			if var_292_23 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_24 and not isNil(var_292_22) then
				local var_292_25 = (arg_289_1.time_ - var_292_23) / var_292_24

				if arg_289_1.var_.characterEffect10143ui_story and not isNil(var_292_22) then
					local var_292_26 = Mathf.Lerp(0, 0.5, var_292_25)

					arg_289_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10143ui_story.fillRatio = var_292_26
				end
			end

			if arg_289_1.time_ >= var_292_23 + var_292_24 and arg_289_1.time_ < var_292_23 + var_292_24 + arg_292_0 and not isNil(var_292_22) and arg_289_1.var_.characterEffect10143ui_story then
				local var_292_27 = 0.5

				arg_289_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10143ui_story.fillRatio = var_292_27
			end

			local var_292_28 = 0

			if var_292_28 < arg_289_1.time_ and arg_289_1.time_ <= var_292_28 + arg_292_0 then
				arg_289_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_292_29 = 0

			if var_292_29 < arg_289_1.time_ and arg_289_1.time_ <= var_292_29 + arg_292_0 then
				arg_289_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_30 = 0
			local var_292_31 = 0.2

			if var_292_30 < arg_289_1.time_ and arg_289_1.time_ <= var_292_30 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_32 = arg_289_1:FormatText(StoryNameCfg[6].name)

				arg_289_1.leftNameTxt_.text = var_292_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_33 = arg_289_1:GetWordFromCfg(421091070)
				local var_292_34 = arg_289_1:FormatText(var_292_33.content)

				arg_289_1.text_.text = var_292_34

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_35 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091070", "story_v_out_421091.awb") ~= 0 then
					local var_292_38 = manager.audio:GetVoiceLength("story_v_out_421091", "421091070", "story_v_out_421091.awb") / 1000

					if var_292_38 + var_292_30 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_38 + var_292_30
					end

					if var_292_33.prefab_name ~= "" and arg_289_1.actors_[var_292_33.prefab_name] ~= nil then
						local var_292_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_33.prefab_name].transform, "story_v_out_421091", "421091070", "story_v_out_421091.awb")

						arg_289_1:RecordAudio("421091070", var_292_39)
						arg_289_1:RecordAudio("421091070", var_292_39)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_421091", "421091070", "story_v_out_421091.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_421091", "421091070", "story_v_out_421091.awb")
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421091071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 421091071
		arg_293_1.duration_ = 9.9

		local var_293_0 = {
			zh = 5.7,
			ja = 9.9
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
				arg_293_0:Play421091072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10143ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10143ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(-0.72, -1.06, -6)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10143ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["10143ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect10143ui_story == nil then
				arg_293_1.var_.characterEffect10143ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect10143ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect10143ui_story then
				arg_293_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_296_13 = arg_293_1.actors_["10102ui_story"]
			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 and not isNil(var_296_13) and arg_293_1.var_.characterEffect10102ui_story == nil then
				arg_293_1.var_.characterEffect10102ui_story = var_296_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_15 = 0.200000002980232

			if var_296_14 <= arg_293_1.time_ and arg_293_1.time_ < var_296_14 + var_296_15 and not isNil(var_296_13) then
				local var_296_16 = (arg_293_1.time_ - var_296_14) / var_296_15

				if arg_293_1.var_.characterEffect10102ui_story and not isNil(var_296_13) then
					local var_296_17 = Mathf.Lerp(0, 0.5, var_296_16)

					arg_293_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10102ui_story.fillRatio = var_296_17
				end
			end

			if arg_293_1.time_ >= var_296_14 + var_296_15 and arg_293_1.time_ < var_296_14 + var_296_15 + arg_296_0 and not isNil(var_296_13) and arg_293_1.var_.characterEffect10102ui_story then
				local var_296_18 = 0.5

				arg_293_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10102ui_story.fillRatio = var_296_18
			end

			local var_296_19 = 0

			if var_296_19 < arg_293_1.time_ and arg_293_1.time_ <= var_296_19 + arg_296_0 then
				arg_293_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			local var_296_20 = 0

			if var_296_20 < arg_293_1.time_ and arg_293_1.time_ <= var_296_20 + arg_296_0 then
				arg_293_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_296_21 = 0
			local var_296_22 = 0.7

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_23 = arg_293_1:FormatText(StoryNameCfg[1307].name)

				arg_293_1.leftNameTxt_.text = var_296_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_24 = arg_293_1:GetWordFromCfg(421091071)
				local var_296_25 = arg_293_1:FormatText(var_296_24.content)

				arg_293_1.text_.text = var_296_25

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_26 = 28
				local var_296_27 = utf8.len(var_296_25)
				local var_296_28 = var_296_26 <= 0 and var_296_22 or var_296_22 * (var_296_27 / var_296_26)

				if var_296_28 > 0 and var_296_22 < var_296_28 then
					arg_293_1.talkMaxDuration = var_296_28

					if var_296_28 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_28 + var_296_21
					end
				end

				arg_293_1.text_.text = var_296_25
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421091", "421091071", "story_v_out_421091.awb") ~= 0 then
					local var_296_29 = manager.audio:GetVoiceLength("story_v_out_421091", "421091071", "story_v_out_421091.awb") / 1000

					if var_296_29 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_29 + var_296_21
					end

					if var_296_24.prefab_name ~= "" and arg_293_1.actors_[var_296_24.prefab_name] ~= nil then
						local var_296_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_24.prefab_name].transform, "story_v_out_421091", "421091071", "story_v_out_421091.awb")

						arg_293_1:RecordAudio("421091071", var_296_30)
						arg_293_1:RecordAudio("421091071", var_296_30)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_421091", "421091071", "story_v_out_421091.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_421091", "421091071", "story_v_out_421091.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_31 = math.max(var_296_22, arg_293_1.talkMaxDuration)

			if var_296_21 <= arg_293_1.time_ and arg_293_1.time_ < var_296_21 + var_296_31 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_21) / var_296_31

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_21 + var_296_31 and arg_293_1.time_ < var_296_21 + var_296_31 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play421091072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 421091072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play421091073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10143ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos10143ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, 100, 0)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10143ui_story, var_300_4, var_300_3)

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

			local var_300_9 = arg_297_1.actors_["10102ui_story"].transform
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.var_.moveOldPos10102ui_story = var_300_9.localPosition
			end

			local var_300_11 = 0.001

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11
				local var_300_13 = Vector3.New(0, 100, 0)

				var_300_9.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10102ui_story, var_300_13, var_300_12)

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
			local var_300_19 = 0.775

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

				local var_300_20 = arg_297_1:GetWordFromCfg(421091072)
				local var_300_21 = arg_297_1:FormatText(var_300_20.content)

				arg_297_1.text_.text = var_300_21

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_22 = 31
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
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421091073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 421091073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
			arg_301_1.auto_ = false
		end

		function arg_301_1.playNext_(arg_303_0)
			arg_301_1.onStoryFinished_()
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.65

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(421091073)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 26
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D12a"
	},
	voices = {
		"story_v_out_421091.awb"
	}
}
