return {
	Play322161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322161001
		arg_1_1.duration_ = 5.93

		local var_1_0 = {
			zh = 5.333,
			ja = 5.933
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
				arg_1_0:Play322161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0510"

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
				local var_4_5 = arg_1_1.bgs_.ST0510

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
					if iter_4_0 ~= "ST0510" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.25

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

			local var_4_24 = "1085ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1085ui_story"].transform
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1085ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.01, -5.83)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1085ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1085ui_story"]
			local var_4_39 = 2

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1085ui_story == nil then
				arg_1_1.var_.characterEffect1085ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1085ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1085ui_story then
				arg_1_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_4_42 = 2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_4_43 = 2

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.3
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_145", "se_story_145_amb_data", "")
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

			local var_4_54 = 0.466666666666667
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

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

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[328].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(322161001)
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161001", "story_v_out_322161.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_322161", "322161001", "story_v_out_322161.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_322161", "322161001", "story_v_out_322161.awb")

						arg_1_1:RecordAudio("322161001", var_4_70)
						arg_1_1:RecordAudio("322161001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322161", "322161001", "story_v_out_322161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322161", "322161001", "story_v_out_322161.awb")
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
				actorName = "1085ui_story",
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
	Play322161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322161002
		arg_9_1.duration_ = 4.67

		local var_9_0 = {
			zh = 4.666,
			ja = 3.5
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
				arg_9_0:Play322161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1085ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1085ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1085ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = arg_9_1.actors_["1085ui_story"]
			local var_12_10 = 0

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1085ui_story == nil then
				arg_9_1.var_.characterEffect1085ui_story = var_12_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_11 and not isNil(var_12_9) then
				local var_12_12 = (arg_9_1.time_ - var_12_10) / var_12_11

				if arg_9_1.var_.characterEffect1085ui_story and not isNil(var_12_9) then
					local var_12_13 = Mathf.Lerp(0, 0.5, var_12_12)

					arg_9_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1085ui_story.fillRatio = var_12_13
				end
			end

			if arg_9_1.time_ >= var_12_10 + var_12_11 and arg_9_1.time_ < var_12_10 + var_12_11 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1085ui_story then
				local var_12_14 = 0.5

				arg_9_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1085ui_story.fillRatio = var_12_14
			end

			local var_12_15 = "404001ui_story"

			if arg_9_1.actors_[var_12_15] == nil then
				local var_12_16 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_12_16) then
					local var_12_17 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_9_1.stage_.transform)

					var_12_17.name = var_12_15
					var_12_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_15] = var_12_17

					local var_12_18 = var_12_17:GetComponentInChildren(typeof(CharacterEffect))

					var_12_18.enabled = true

					local var_12_19 = GameObjectTools.GetOrAddComponent(var_12_17, typeof(DynamicBoneHelper))

					if var_12_19 then
						var_12_19:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_18.transform, false)

					arg_9_1.var_[var_12_15 .. "Animator"] = var_12_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_15 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_15 .. "LipSync"] = var_12_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_20 = arg_9_1.actors_["404001ui_story"].transform
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.var_.moveOldPos404001ui_story = var_12_20.localPosition
			end

			local var_12_22 = 0.001

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_21) / var_12_22
				local var_12_24 = Vector3.New(0.8, -1.55, -5.5)

				var_12_20.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos404001ui_story, var_12_24, var_12_23)

				local var_12_25 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_25.x, var_12_25.y, var_12_25.z)

				local var_12_26 = var_12_20.localEulerAngles

				var_12_26.z = 0
				var_12_26.x = 0
				var_12_20.localEulerAngles = var_12_26
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 then
				var_12_20.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_12_27 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_27.x, var_12_27.y, var_12_27.z)

				local var_12_28 = var_12_20.localEulerAngles

				var_12_28.z = 0
				var_12_28.x = 0
				var_12_20.localEulerAngles = var_12_28
			end

			local var_12_29 = arg_9_1.actors_["404001ui_story"]
			local var_12_30 = 0

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect404001ui_story == nil then
				arg_9_1.var_.characterEffect404001ui_story = var_12_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_31 = 0.200000002980232

			if var_12_30 <= arg_9_1.time_ and arg_9_1.time_ < var_12_30 + var_12_31 and not isNil(var_12_29) then
				local var_12_32 = (arg_9_1.time_ - var_12_30) / var_12_31

				if arg_9_1.var_.characterEffect404001ui_story and not isNil(var_12_29) then
					arg_9_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_30 + var_12_31 and arg_9_1.time_ < var_12_30 + var_12_31 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect404001ui_story then
				arg_9_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_12_33 = 0

			if var_12_33 < arg_9_1.time_ and arg_9_1.time_ <= var_12_33 + arg_12_0 then
				arg_9_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_12_34 = 0

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_12_35 = 0
			local var_12_36 = 0.5

			if var_12_35 < arg_9_1.time_ and arg_9_1.time_ <= var_12_35 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_37 = arg_9_1:FormatText(StoryNameCfg[668].name)

				arg_9_1.leftNameTxt_.text = var_12_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_38 = arg_9_1:GetWordFromCfg(322161002)
				local var_12_39 = arg_9_1:FormatText(var_12_38.content)

				arg_9_1.text_.text = var_12_39

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_40 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161002", "story_v_out_322161.awb") ~= 0 then
					local var_12_43 = manager.audio:GetVoiceLength("story_v_out_322161", "322161002", "story_v_out_322161.awb") / 1000

					if var_12_43 + var_12_35 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_43 + var_12_35
					end

					if var_12_38.prefab_name ~= "" and arg_9_1.actors_[var_12_38.prefab_name] ~= nil then
						local var_12_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_38.prefab_name].transform, "story_v_out_322161", "322161002", "story_v_out_322161.awb")

						arg_9_1:RecordAudio("322161002", var_12_44)
						arg_9_1:RecordAudio("322161002", var_12_44)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322161", "322161002", "story_v_out_322161.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322161", "322161002", "story_v_out_322161.awb")
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

		arg_9_1:InitPlayNodeList()
	end,
	Play322161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322161003
		arg_13_1.duration_ = 2.67

		local var_13_0 = {
			zh = 2.666,
			ja = 2.566
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
				arg_13_0:Play322161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1085ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1085ui_story == nil then
				arg_13_1.var_.characterEffect1085ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1085ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1085ui_story then
				arg_13_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_16_4 = arg_13_1.actors_["404001ui_story"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect404001ui_story == nil then
				arg_13_1.var_.characterEffect404001ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.characterEffect404001ui_story and not isNil(var_16_4) then
					local var_16_8 = Mathf.Lerp(0, 0.5, var_16_7)

					arg_13_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_13_1.var_.characterEffect404001ui_story.fillRatio = var_16_8
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect404001ui_story then
				local var_16_9 = 0.5

				arg_13_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_13_1.var_.characterEffect404001ui_story.fillRatio = var_16_9
			end

			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_16_11 = 0

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_16_12 = 0
			local var_16_13 = 0.2

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[328].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(322161003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161003", "story_v_out_322161.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_322161", "322161003", "story_v_out_322161.awb") / 1000

					if var_16_20 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_322161", "322161003", "story_v_out_322161.awb")

						arg_13_1:RecordAudio("322161003", var_16_21)
						arg_13_1:RecordAudio("322161003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322161", "322161003", "story_v_out_322161.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322161", "322161003", "story_v_out_322161.awb")
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
	Play322161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322161004
		arg_17_1.duration_ = 7.9

		local var_17_0 = {
			zh = 6.966,
			ja = 7.9
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
				arg_17_0:Play322161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["404001ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect404001ui_story == nil then
				arg_17_1.var_.characterEffect404001ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect404001ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect404001ui_story then
				arg_17_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_20_4 = arg_17_1.actors_["1085ui_story"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1085ui_story == nil then
				arg_17_1.var_.characterEffect1085ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.characterEffect1085ui_story and not isNil(var_20_4) then
					local var_20_8 = Mathf.Lerp(0, 0.5, var_20_7)

					arg_17_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1085ui_story.fillRatio = var_20_8
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1085ui_story then
				local var_20_9 = 0.5

				arg_17_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1085ui_story.fillRatio = var_20_9
			end

			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_20_11 = 0
			local var_20_12 = 0.85

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_13 = arg_17_1:FormatText(StoryNameCfg[668].name)

				arg_17_1.leftNameTxt_.text = var_20_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(322161004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 34
				local var_20_17 = utf8.len(var_20_15)
				local var_20_18 = var_20_16 <= 0 and var_20_12 or var_20_12 * (var_20_17 / var_20_16)

				if var_20_18 > 0 and var_20_12 < var_20_18 then
					arg_17_1.talkMaxDuration = var_20_18

					if var_20_18 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161004", "story_v_out_322161.awb") ~= 0 then
					local var_20_19 = manager.audio:GetVoiceLength("story_v_out_322161", "322161004", "story_v_out_322161.awb") / 1000

					if var_20_19 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_11
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_322161", "322161004", "story_v_out_322161.awb")

						arg_17_1:RecordAudio("322161004", var_20_20)
						arg_17_1:RecordAudio("322161004", var_20_20)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322161", "322161004", "story_v_out_322161.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322161", "322161004", "story_v_out_322161.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_21 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_21 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_21

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_21 and arg_17_1.time_ < var_20_11 + var_20_21 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322161005
		arg_21_1.duration_ = 13.27

		local var_21_0 = {
			zh = 8.266,
			ja = 13.266
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
				arg_21_0:Play322161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1085ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1085ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1085ui_story, var_24_4, var_24_3)

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

			local var_24_9 = arg_21_1.actors_["404001ui_story"].transform
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.var_.moveOldPos404001ui_story = var_24_9.localPosition
			end

			local var_24_11 = 0.001

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11
				local var_24_13 = Vector3.New(0, 100, 0)

				var_24_9.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos404001ui_story, var_24_13, var_24_12)

				local var_24_14 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_14.x, var_24_14.y, var_24_14.z)

				local var_24_15 = var_24_9.localEulerAngles

				var_24_15.z = 0
				var_24_15.x = 0
				var_24_9.localEulerAngles = var_24_15
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 then
				var_24_9.localPosition = Vector3.New(0, 100, 0)

				local var_24_16 = manager.ui.mainCamera.transform.position - var_24_9.position

				var_24_9.forward = Vector3.New(var_24_16.x, var_24_16.y, var_24_16.z)

				local var_24_17 = var_24_9.localEulerAngles

				var_24_17.z = 0
				var_24_17.x = 0
				var_24_9.localEulerAngles = var_24_17
			end

			local var_24_18 = "10104ui_story"

			if arg_21_1.actors_[var_24_18] == nil then
				local var_24_19 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_24_19) then
					local var_24_20 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_21_1.stage_.transform)

					var_24_20.name = var_24_18
					var_24_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_18] = var_24_20

					local var_24_21 = var_24_20:GetComponentInChildren(typeof(CharacterEffect))

					var_24_21.enabled = true

					local var_24_22 = GameObjectTools.GetOrAddComponent(var_24_20, typeof(DynamicBoneHelper))

					if var_24_22 then
						var_24_22:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_21.transform, false)

					arg_21_1.var_[var_24_18 .. "Animator"] = var_24_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_18 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_18 .. "LipSync"] = var_24_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_23 = arg_21_1.actors_["10104ui_story"].transform
			local var_24_24 = 0

			if var_24_24 < arg_21_1.time_ and arg_21_1.time_ <= var_24_24 + arg_24_0 then
				arg_21_1.var_.moveOldPos10104ui_story = var_24_23.localPosition
			end

			local var_24_25 = 0.001

			if var_24_24 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 then
				local var_24_26 = (arg_21_1.time_ - var_24_24) / var_24_25
				local var_24_27 = Vector3.New(0.02, -1.12, -5.99)

				var_24_23.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10104ui_story, var_24_27, var_24_26)

				local var_24_28 = manager.ui.mainCamera.transform.position - var_24_23.position

				var_24_23.forward = Vector3.New(var_24_28.x, var_24_28.y, var_24_28.z)

				local var_24_29 = var_24_23.localEulerAngles

				var_24_29.z = 0
				var_24_29.x = 0
				var_24_23.localEulerAngles = var_24_29
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 then
				var_24_23.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_24_30 = manager.ui.mainCamera.transform.position - var_24_23.position

				var_24_23.forward = Vector3.New(var_24_30.x, var_24_30.y, var_24_30.z)

				local var_24_31 = var_24_23.localEulerAngles

				var_24_31.z = 0
				var_24_31.x = 0
				var_24_23.localEulerAngles = var_24_31
			end

			local var_24_32 = arg_21_1.actors_["10104ui_story"]
			local var_24_33 = 0

			if var_24_33 < arg_21_1.time_ and arg_21_1.time_ <= var_24_33 + arg_24_0 and not isNil(var_24_32) and arg_21_1.var_.characterEffect10104ui_story == nil then
				arg_21_1.var_.characterEffect10104ui_story = var_24_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_34 = 0.200000002980232

			if var_24_33 <= arg_21_1.time_ and arg_21_1.time_ < var_24_33 + var_24_34 and not isNil(var_24_32) then
				local var_24_35 = (arg_21_1.time_ - var_24_33) / var_24_34

				if arg_21_1.var_.characterEffect10104ui_story and not isNil(var_24_32) then
					arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_33 + var_24_34 and arg_21_1.time_ < var_24_33 + var_24_34 + arg_24_0 and not isNil(var_24_32) and arg_21_1.var_.characterEffect10104ui_story then
				arg_21_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_24_36 = 0

			if var_24_36 < arg_21_1.time_ and arg_21_1.time_ <= var_24_36 + arg_24_0 then
				arg_21_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_24_37 = 0

			if var_24_37 < arg_21_1.time_ and arg_21_1.time_ <= var_24_37 + arg_24_0 then
				arg_21_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_24_38 = 0
			local var_24_39 = 0.925

			if var_24_38 < arg_21_1.time_ and arg_21_1.time_ <= var_24_38 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_40 = arg_21_1:FormatText(StoryNameCfg[1030].name)

				arg_21_1.leftNameTxt_.text = var_24_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_41 = arg_21_1:GetWordFromCfg(322161005)
				local var_24_42 = arg_21_1:FormatText(var_24_41.content)

				arg_21_1.text_.text = var_24_42

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_43 = 37
				local var_24_44 = utf8.len(var_24_42)
				local var_24_45 = var_24_43 <= 0 and var_24_39 or var_24_39 * (var_24_44 / var_24_43)

				if var_24_45 > 0 and var_24_39 < var_24_45 then
					arg_21_1.talkMaxDuration = var_24_45

					if var_24_45 + var_24_38 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_45 + var_24_38
					end
				end

				arg_21_1.text_.text = var_24_42
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161005", "story_v_out_322161.awb") ~= 0 then
					local var_24_46 = manager.audio:GetVoiceLength("story_v_out_322161", "322161005", "story_v_out_322161.awb") / 1000

					if var_24_46 + var_24_38 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_46 + var_24_38
					end

					if var_24_41.prefab_name ~= "" and arg_21_1.actors_[var_24_41.prefab_name] ~= nil then
						local var_24_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_41.prefab_name].transform, "story_v_out_322161", "322161005", "story_v_out_322161.awb")

						arg_21_1:RecordAudio("322161005", var_24_47)
						arg_21_1:RecordAudio("322161005", var_24_47)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322161", "322161005", "story_v_out_322161.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322161", "322161005", "story_v_out_322161.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_48 = math.max(var_24_39, arg_21_1.talkMaxDuration)

			if var_24_38 <= arg_21_1.time_ and arg_21_1.time_ < var_24_38 + var_24_48 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_38) / var_24_48

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_38 + var_24_48 and arg_21_1.time_ < var_24_38 + var_24_48 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play322161006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322161006
		arg_25_1.duration_ = 7

		local var_25_0 = {
			zh = 4.533,
			ja = 7
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
				arg_25_0:Play322161007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["404001ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos404001ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0.8, -1.55, -5.5)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos404001ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["404001ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect404001ui_story == nil then
				arg_25_1.var_.characterEffect404001ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect404001ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect404001ui_story then
				arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_28_13 = arg_25_1.actors_["10104ui_story"].transform
			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.var_.moveOldPos10104ui_story = var_28_13.localPosition
			end

			local var_28_15 = 0.001

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_15 then
				local var_28_16 = (arg_25_1.time_ - var_28_14) / var_28_15
				local var_28_17 = Vector3.New(-0.88, -1.12, -5.99)

				var_28_13.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10104ui_story, var_28_17, var_28_16)

				local var_28_18 = manager.ui.mainCamera.transform.position - var_28_13.position

				var_28_13.forward = Vector3.New(var_28_18.x, var_28_18.y, var_28_18.z)

				local var_28_19 = var_28_13.localEulerAngles

				var_28_19.z = 0
				var_28_19.x = 0
				var_28_13.localEulerAngles = var_28_19
			end

			if arg_25_1.time_ >= var_28_14 + var_28_15 and arg_25_1.time_ < var_28_14 + var_28_15 + arg_28_0 then
				var_28_13.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_28_20 = manager.ui.mainCamera.transform.position - var_28_13.position

				var_28_13.forward = Vector3.New(var_28_20.x, var_28_20.y, var_28_20.z)

				local var_28_21 = var_28_13.localEulerAngles

				var_28_21.z = 0
				var_28_21.x = 0
				var_28_13.localEulerAngles = var_28_21
			end

			local var_28_22 = arg_25_1.actors_["10104ui_story"]
			local var_28_23 = 0

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.characterEffect10104ui_story == nil then
				arg_25_1.var_.characterEffect10104ui_story = var_28_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_24 = 0.200000002980232

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_24 and not isNil(var_28_22) then
				local var_28_25 = (arg_25_1.time_ - var_28_23) / var_28_24

				if arg_25_1.var_.characterEffect10104ui_story and not isNil(var_28_22) then
					local var_28_26 = Mathf.Lerp(0, 0.5, var_28_25)

					arg_25_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10104ui_story.fillRatio = var_28_26
				end
			end

			if arg_25_1.time_ >= var_28_23 + var_28_24 and arg_25_1.time_ < var_28_23 + var_28_24 + arg_28_0 and not isNil(var_28_22) and arg_25_1.var_.characterEffect10104ui_story then
				local var_28_27 = 0.5

				arg_25_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10104ui_story.fillRatio = var_28_27
			end

			local var_28_28 = 0

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_28_29 = 0
			local var_28_30 = 0.5

			if var_28_29 < arg_25_1.time_ and arg_25_1.time_ <= var_28_29 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_31 = arg_25_1:FormatText(StoryNameCfg[668].name)

				arg_25_1.leftNameTxt_.text = var_28_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_32 = arg_25_1:GetWordFromCfg(322161006)
				local var_28_33 = arg_25_1:FormatText(var_28_32.content)

				arg_25_1.text_.text = var_28_33

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_34 = 20
				local var_28_35 = utf8.len(var_28_33)
				local var_28_36 = var_28_34 <= 0 and var_28_30 or var_28_30 * (var_28_35 / var_28_34)

				if var_28_36 > 0 and var_28_30 < var_28_36 then
					arg_25_1.talkMaxDuration = var_28_36

					if var_28_36 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_36 + var_28_29
					end
				end

				arg_25_1.text_.text = var_28_33
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161006", "story_v_out_322161.awb") ~= 0 then
					local var_28_37 = manager.audio:GetVoiceLength("story_v_out_322161", "322161006", "story_v_out_322161.awb") / 1000

					if var_28_37 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_29
					end

					if var_28_32.prefab_name ~= "" and arg_25_1.actors_[var_28_32.prefab_name] ~= nil then
						local var_28_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_32.prefab_name].transform, "story_v_out_322161", "322161006", "story_v_out_322161.awb")

						arg_25_1:RecordAudio("322161006", var_28_38)
						arg_25_1:RecordAudio("322161006", var_28_38)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322161", "322161006", "story_v_out_322161.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322161", "322161006", "story_v_out_322161.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_39 = math.max(var_28_30, arg_25_1.talkMaxDuration)

			if var_28_29 <= arg_25_1.time_ and arg_25_1.time_ < var_28_29 + var_28_39 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_29) / var_28_39

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_29 + var_28_39 and arg_25_1.time_ < var_28_29 + var_28_39 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play322161007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322161007
		arg_29_1.duration_ = 6.1

		local var_29_0 = {
			zh = 2.6,
			ja = 6.1
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
				arg_29_0:Play322161008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10104ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10104ui_story == nil then
				arg_29_1.var_.characterEffect10104ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10104ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10104ui_story then
				arg_29_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["404001ui_story"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect404001ui_story == nil then
				arg_29_1.var_.characterEffect404001ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.characterEffect404001ui_story and not isNil(var_32_4) then
					local var_32_8 = Mathf.Lerp(0, 0.5, var_32_7)

					arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_29_1.var_.characterEffect404001ui_story.fillRatio = var_32_8
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect404001ui_story then
				local var_32_9 = 0.5

				arg_29_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_29_1.var_.characterEffect404001ui_story.fillRatio = var_32_9
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_32_11 = 0
			local var_32_12 = 0.275

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_13 = arg_29_1:FormatText(StoryNameCfg[1030].name)

				arg_29_1.leftNameTxt_.text = var_32_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(322161007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 11
				local var_32_17 = utf8.len(var_32_15)
				local var_32_18 = var_32_16 <= 0 and var_32_12 or var_32_12 * (var_32_17 / var_32_16)

				if var_32_18 > 0 and var_32_12 < var_32_18 then
					arg_29_1.talkMaxDuration = var_32_18

					if var_32_18 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161007", "story_v_out_322161.awb") ~= 0 then
					local var_32_19 = manager.audio:GetVoiceLength("story_v_out_322161", "322161007", "story_v_out_322161.awb") / 1000

					if var_32_19 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_11
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_out_322161", "322161007", "story_v_out_322161.awb")

						arg_29_1:RecordAudio("322161007", var_32_20)
						arg_29_1:RecordAudio("322161007", var_32_20)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322161", "322161007", "story_v_out_322161.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322161", "322161007", "story_v_out_322161.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_21 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_21 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_21

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_21 and arg_29_1.time_ < var_32_11 + var_32_21 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322161008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322161008
		arg_33_1.duration_ = 5.83

		local var_33_0 = {
			zh = 3.433,
			ja = 5.833
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
				arg_33_0:Play322161009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10104ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10104ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10104ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["404001ui_story"].transform
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.var_.moveOldPos404001ui_story = var_36_9.localPosition
			end

			local var_36_11 = 0.001

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11
				local var_36_13 = Vector3.New(0, 100, 0)

				var_36_9.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos404001ui_story, var_36_13, var_36_12)

				local var_36_14 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_14.x, var_36_14.y, var_36_14.z)

				local var_36_15 = var_36_9.localEulerAngles

				var_36_15.z = 0
				var_36_15.x = 0
				var_36_9.localEulerAngles = var_36_15
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 then
				var_36_9.localPosition = Vector3.New(0, 100, 0)

				local var_36_16 = manager.ui.mainCamera.transform.position - var_36_9.position

				var_36_9.forward = Vector3.New(var_36_16.x, var_36_16.y, var_36_16.z)

				local var_36_17 = var_36_9.localEulerAngles

				var_36_17.z = 0
				var_36_17.x = 0
				var_36_9.localEulerAngles = var_36_17
			end

			local var_36_18 = 0
			local var_36_19 = 0.475

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_20 = arg_33_1:FormatText(StoryNameCfg[1137].name)

				arg_33_1.leftNameTxt_.text = var_36_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_21 = arg_33_1:GetWordFromCfg(322161008)
				local var_36_22 = arg_33_1:FormatText(var_36_21.content)

				arg_33_1.text_.text = var_36_22

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_23 = 19
				local var_36_24 = utf8.len(var_36_22)
				local var_36_25 = var_36_23 <= 0 and var_36_19 or var_36_19 * (var_36_24 / var_36_23)

				if var_36_25 > 0 and var_36_19 < var_36_25 then
					arg_33_1.talkMaxDuration = var_36_25

					if var_36_25 + var_36_18 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_25 + var_36_18
					end
				end

				arg_33_1.text_.text = var_36_22
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161008", "story_v_out_322161.awb") ~= 0 then
					local var_36_26 = manager.audio:GetVoiceLength("story_v_out_322161", "322161008", "story_v_out_322161.awb") / 1000

					if var_36_26 + var_36_18 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_26 + var_36_18
					end

					if var_36_21.prefab_name ~= "" and arg_33_1.actors_[var_36_21.prefab_name] ~= nil then
						local var_36_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_21.prefab_name].transform, "story_v_out_322161", "322161008", "story_v_out_322161.awb")

						arg_33_1:RecordAudio("322161008", var_36_27)
						arg_33_1:RecordAudio("322161008", var_36_27)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322161", "322161008", "story_v_out_322161.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322161", "322161008", "story_v_out_322161.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_28 = math.max(var_36_19, arg_33_1.talkMaxDuration)

			if var_36_18 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_28 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_18) / var_36_28

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_18 + var_36_28 and arg_33_1.time_ < var_36_18 + var_36_28 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
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
	Play322161009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322161009
		arg_37_1.duration_ = 6.27

		local var_37_0 = {
			zh = 4.966,
			ja = 6.266
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
				arg_37_0:Play322161010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "10102ui_story"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_37_1.stage_.transform)

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

			local var_40_5 = arg_37_1.actors_["10102ui_story"].transform
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.var_.moveOldPos10102ui_story = var_40_5.localPosition
			end

			local var_40_7 = 0.001

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7
				local var_40_9 = Vector3.New(0, -0.985, -6.275)

				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10102ui_story, var_40_9, var_40_8)

				local var_40_10 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_10.x, var_40_10.y, var_40_10.z)

				local var_40_11 = var_40_5.localEulerAngles

				var_40_11.z = 0
				var_40_11.x = 0
				var_40_5.localEulerAngles = var_40_11
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_40_12 = manager.ui.mainCamera.transform.position - var_40_5.position

				var_40_5.forward = Vector3.New(var_40_12.x, var_40_12.y, var_40_12.z)

				local var_40_13 = var_40_5.localEulerAngles

				var_40_13.z = 0
				var_40_13.x = 0
				var_40_5.localEulerAngles = var_40_13
			end

			local var_40_14 = arg_37_1.actors_["10102ui_story"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect10102ui_story == nil then
				arg_37_1.var_.characterEffect10102ui_story = var_40_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_16 = 0.200000002980232

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.characterEffect10102ui_story and not isNil(var_40_14) then
					arg_37_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.characterEffect10102ui_story then
				arg_37_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_40_18 = 0

			if var_40_18 < arg_37_1.time_ and arg_37_1.time_ <= var_40_18 + arg_40_0 then
				arg_37_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_40_20 = 0
			local var_40_21 = 0.575

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_22 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_23 = arg_37_1:GetWordFromCfg(322161009)
				local var_40_24 = arg_37_1:FormatText(var_40_23.content)

				arg_37_1.text_.text = var_40_24

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_25 = 23
				local var_40_26 = utf8.len(var_40_24)
				local var_40_27 = var_40_25 <= 0 and var_40_21 or var_40_21 * (var_40_26 / var_40_25)

				if var_40_27 > 0 and var_40_21 < var_40_27 then
					arg_37_1.talkMaxDuration = var_40_27

					if var_40_27 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_20
					end
				end

				arg_37_1.text_.text = var_40_24
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161009", "story_v_out_322161.awb") ~= 0 then
					local var_40_28 = manager.audio:GetVoiceLength("story_v_out_322161", "322161009", "story_v_out_322161.awb") / 1000

					if var_40_28 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_20
					end

					if var_40_23.prefab_name ~= "" and arg_37_1.actors_[var_40_23.prefab_name] ~= nil then
						local var_40_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_23.prefab_name].transform, "story_v_out_322161", "322161009", "story_v_out_322161.awb")

						arg_37_1:RecordAudio("322161009", var_40_29)
						arg_37_1:RecordAudio("322161009", var_40_29)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322161", "322161009", "story_v_out_322161.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322161", "322161009", "story_v_out_322161.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_30 = math.max(var_40_21, arg_37_1.talkMaxDuration)

			if var_40_20 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_30 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_20) / var_40_30

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_20 + var_40_30 and arg_37_1.time_ < var_40_20 + var_40_30 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play322161010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322161010
		arg_41_1.duration_ = 6.37

		local var_41_0 = {
			zh = 3.533,
			ja = 6.366
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
				arg_41_0:Play322161011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10102ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10102ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10102ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["10102ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10102ui_story == nil then
				arg_41_1.var_.characterEffect10102ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect10102ui_story and not isNil(var_44_9) then
					local var_44_13 = Mathf.Lerp(0, 0.5, var_44_12)

					arg_41_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10102ui_story.fillRatio = var_44_13
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10102ui_story then
				local var_44_14 = 0.5

				arg_41_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10102ui_story.fillRatio = var_44_14
			end

			local var_44_15 = arg_41_1.actors_["10104ui_story"].transform
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.var_.moveOldPos10104ui_story = var_44_15.localPosition
			end

			local var_44_17 = 0.001

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17
				local var_44_19 = Vector3.New(0.99, -1.12, -5.99)

				var_44_15.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10104ui_story, var_44_19, var_44_18)

				local var_44_20 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_20.x, var_44_20.y, var_44_20.z)

				local var_44_21 = var_44_15.localEulerAngles

				var_44_21.z = 0
				var_44_21.x = 0
				var_44_15.localEulerAngles = var_44_21
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				var_44_15.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_44_22 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_22.x, var_44_22.y, var_44_22.z)

				local var_44_23 = var_44_15.localEulerAngles

				var_44_23.z = 0
				var_44_23.x = 0
				var_44_15.localEulerAngles = var_44_23
			end

			local var_44_24 = arg_41_1.actors_["10104ui_story"]
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10104ui_story == nil then
				arg_41_1.var_.characterEffect10104ui_story = var_44_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_26 = 0.200000002980232

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 and not isNil(var_44_24) then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26

				if arg_41_1.var_.characterEffect10104ui_story and not isNil(var_44_24) then
					arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 and not isNil(var_44_24) and arg_41_1.var_.characterEffect10104ui_story then
				arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_44_28 = 0

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_44_29 = 0
			local var_44_30 = 0.4

			if var_44_29 < arg_41_1.time_ and arg_41_1.time_ <= var_44_29 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_31 = arg_41_1:FormatText(StoryNameCfg[1030].name)

				arg_41_1.leftNameTxt_.text = var_44_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_32 = arg_41_1:GetWordFromCfg(322161010)
				local var_44_33 = arg_41_1:FormatText(var_44_32.content)

				arg_41_1.text_.text = var_44_33

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_34 = 16
				local var_44_35 = utf8.len(var_44_33)
				local var_44_36 = var_44_34 <= 0 and var_44_30 or var_44_30 * (var_44_35 / var_44_34)

				if var_44_36 > 0 and var_44_30 < var_44_36 then
					arg_41_1.talkMaxDuration = var_44_36

					if var_44_36 + var_44_29 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_36 + var_44_29
					end
				end

				arg_41_1.text_.text = var_44_33
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161010", "story_v_out_322161.awb") ~= 0 then
					local var_44_37 = manager.audio:GetVoiceLength("story_v_out_322161", "322161010", "story_v_out_322161.awb") / 1000

					if var_44_37 + var_44_29 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_29
					end

					if var_44_32.prefab_name ~= "" and arg_41_1.actors_[var_44_32.prefab_name] ~= nil then
						local var_44_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_32.prefab_name].transform, "story_v_out_322161", "322161010", "story_v_out_322161.awb")

						arg_41_1:RecordAudio("322161010", var_44_38)
						arg_41_1:RecordAudio("322161010", var_44_38)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322161", "322161010", "story_v_out_322161.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322161", "322161010", "story_v_out_322161.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_39 = math.max(var_44_30, arg_41_1.talkMaxDuration)

			if var_44_29 <= arg_41_1.time_ and arg_41_1.time_ < var_44_29 + var_44_39 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_29) / var_44_39

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_29 + var_44_39 and arg_41_1.time_ < var_44_29 + var_44_39 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play322161011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322161011
		arg_45_1.duration_ = 16.73

		local var_45_0 = {
			zh = 11.2,
			ja = 16.733
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
				arg_45_0:Play322161012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.125

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

				local var_48_3 = arg_45_1:GetWordFromCfg(322161011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161011", "story_v_out_322161.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161011", "story_v_out_322161.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_322161", "322161011", "story_v_out_322161.awb")

						arg_45_1:RecordAudio("322161011", var_48_9)
						arg_45_1:RecordAudio("322161011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322161", "322161011", "story_v_out_322161.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322161", "322161011", "story_v_out_322161.awb")
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
	Play322161012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322161012
		arg_49_1.duration_ = 9.5

		local var_49_0 = {
			zh = 4.866,
			ja = 9.5
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
				arg_49_0:Play322161013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10104ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10104ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10104ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, 100, 0)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10102ui_story"].transform
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.var_.moveOldPos10102ui_story = var_52_9.localPosition
			end

			local var_52_11 = 0.001

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11
				local var_52_13 = Vector3.New(0, 100, 0)

				var_52_9.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10102ui_story, var_52_13, var_52_12)

				local var_52_14 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_14.x, var_52_14.y, var_52_14.z)

				local var_52_15 = var_52_9.localEulerAngles

				var_52_15.z = 0
				var_52_15.x = 0
				var_52_9.localEulerAngles = var_52_15
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 then
				var_52_9.localPosition = Vector3.New(0, 100, 0)

				local var_52_16 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_16.x, var_52_16.y, var_52_16.z)

				local var_52_17 = var_52_9.localEulerAngles

				var_52_17.z = 0
				var_52_17.x = 0
				var_52_9.localEulerAngles = var_52_17
			end

			local var_52_18 = "1089ui_story"

			if arg_49_1.actors_[var_52_18] == nil then
				local var_52_19 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_52_19) then
					local var_52_20 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_49_1.stage_.transform)

					var_52_20.name = var_52_18
					var_52_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_18] = var_52_20

					local var_52_21 = var_52_20:GetComponentInChildren(typeof(CharacterEffect))

					var_52_21.enabled = true

					local var_52_22 = GameObjectTools.GetOrAddComponent(var_52_20, typeof(DynamicBoneHelper))

					if var_52_22 then
						var_52_22:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_21.transform, false)

					arg_49_1.var_[var_52_18 .. "Animator"] = var_52_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_18 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_18 .. "LipSync"] = var_52_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_23 = arg_49_1.actors_["1089ui_story"].transform
			local var_52_24 = 0

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 then
				arg_49_1.var_.moveOldPos1089ui_story = var_52_23.localPosition

				local var_52_25 = "1089ui_story"

				arg_49_1:ShowWeapon(arg_49_1.var_[var_52_25 .. "Animator"].transform, false)
			end

			local var_52_26 = 0.001

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_26 then
				local var_52_27 = (arg_49_1.time_ - var_52_24) / var_52_26
				local var_52_28 = Vector3.New(0, -1.1, -6.17)

				var_52_23.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1089ui_story, var_52_28, var_52_27)

				local var_52_29 = manager.ui.mainCamera.transform.position - var_52_23.position

				var_52_23.forward = Vector3.New(var_52_29.x, var_52_29.y, var_52_29.z)

				local var_52_30 = var_52_23.localEulerAngles

				var_52_30.z = 0
				var_52_30.x = 0
				var_52_23.localEulerAngles = var_52_30
			end

			if arg_49_1.time_ >= var_52_24 + var_52_26 and arg_49_1.time_ < var_52_24 + var_52_26 + arg_52_0 then
				var_52_23.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_52_31 = manager.ui.mainCamera.transform.position - var_52_23.position

				var_52_23.forward = Vector3.New(var_52_31.x, var_52_31.y, var_52_31.z)

				local var_52_32 = var_52_23.localEulerAngles

				var_52_32.z = 0
				var_52_32.x = 0
				var_52_23.localEulerAngles = var_52_32
			end

			local var_52_33 = arg_49_1.actors_["1089ui_story"]
			local var_52_34 = 0

			if var_52_34 < arg_49_1.time_ and arg_49_1.time_ <= var_52_34 + arg_52_0 and not isNil(var_52_33) and arg_49_1.var_.characterEffect1089ui_story == nil then
				arg_49_1.var_.characterEffect1089ui_story = var_52_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_35 = 0.200000002980232

			if var_52_34 <= arg_49_1.time_ and arg_49_1.time_ < var_52_34 + var_52_35 and not isNil(var_52_33) then
				local var_52_36 = (arg_49_1.time_ - var_52_34) / var_52_35

				if arg_49_1.var_.characterEffect1089ui_story and not isNil(var_52_33) then
					arg_49_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_34 + var_52_35 and arg_49_1.time_ < var_52_34 + var_52_35 + arg_52_0 and not isNil(var_52_33) and arg_49_1.var_.characterEffect1089ui_story then
				arg_49_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_52_37 = arg_49_1.actors_["10104ui_story"]
			local var_52_38 = 0

			if var_52_38 < arg_49_1.time_ and arg_49_1.time_ <= var_52_38 + arg_52_0 and not isNil(var_52_37) and arg_49_1.var_.characterEffect10104ui_story == nil then
				arg_49_1.var_.characterEffect10104ui_story = var_52_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_39 = 0.200000002980232

			if var_52_38 <= arg_49_1.time_ and arg_49_1.time_ < var_52_38 + var_52_39 and not isNil(var_52_37) then
				local var_52_40 = (arg_49_1.time_ - var_52_38) / var_52_39

				if arg_49_1.var_.characterEffect10104ui_story and not isNil(var_52_37) then
					local var_52_41 = Mathf.Lerp(0, 0.5, var_52_40)

					arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10104ui_story.fillRatio = var_52_41
				end
			end

			if arg_49_1.time_ >= var_52_38 + var_52_39 and arg_49_1.time_ < var_52_38 + var_52_39 + arg_52_0 and not isNil(var_52_37) and arg_49_1.var_.characterEffect10104ui_story then
				local var_52_42 = 0.5

				arg_49_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10104ui_story.fillRatio = var_52_42
			end

			local var_52_43 = 0

			if var_52_43 < arg_49_1.time_ and arg_49_1.time_ <= var_52_43 + arg_52_0 then
				arg_49_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_1")
			end

			local var_52_44 = 0

			if var_52_44 < arg_49_1.time_ and arg_49_1.time_ <= var_52_44 + arg_52_0 then
				arg_49_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_52_45 = 0
			local var_52_46 = 0.55

			if var_52_45 < arg_49_1.time_ and arg_49_1.time_ <= var_52_45 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_47 = arg_49_1:FormatText(StoryNameCfg[1031].name)

				arg_49_1.leftNameTxt_.text = var_52_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_48 = arg_49_1:GetWordFromCfg(322161012)
				local var_52_49 = arg_49_1:FormatText(var_52_48.content)

				arg_49_1.text_.text = var_52_49

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_50 = 22
				local var_52_51 = utf8.len(var_52_49)
				local var_52_52 = var_52_50 <= 0 and var_52_46 or var_52_46 * (var_52_51 / var_52_50)

				if var_52_52 > 0 and var_52_46 < var_52_52 then
					arg_49_1.talkMaxDuration = var_52_52

					if var_52_52 + var_52_45 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_52 + var_52_45
					end
				end

				arg_49_1.text_.text = var_52_49
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161012", "story_v_out_322161.awb") ~= 0 then
					local var_52_53 = manager.audio:GetVoiceLength("story_v_out_322161", "322161012", "story_v_out_322161.awb") / 1000

					if var_52_53 + var_52_45 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_53 + var_52_45
					end

					if var_52_48.prefab_name ~= "" and arg_49_1.actors_[var_52_48.prefab_name] ~= nil then
						local var_52_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_48.prefab_name].transform, "story_v_out_322161", "322161012", "story_v_out_322161.awb")

						arg_49_1:RecordAudio("322161012", var_52_54)
						arg_49_1:RecordAudio("322161012", var_52_54)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322161", "322161012", "story_v_out_322161.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322161", "322161012", "story_v_out_322161.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_55 = math.max(var_52_46, arg_49_1.talkMaxDuration)

			if var_52_45 <= arg_49_1.time_ and arg_49_1.time_ < var_52_45 + var_52_55 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_45) / var_52_55

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_45 + var_52_55 and arg_49_1.time_ < var_52_45 + var_52_55 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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
				actorName = "1089ui_story",
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
	Play322161013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322161013
		arg_53_1.duration_ = 4.5

		local var_53_0 = {
			zh = 3.1,
			ja = 4.5
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
				arg_53_0:Play322161014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_2")
			end

			local var_56_1 = 0
			local var_56_2 = 0.275

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[1031].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(322161013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 11
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161013", "story_v_out_322161.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_322161", "322161013", "story_v_out_322161.awb") / 1000

					if var_56_9 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_1
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_322161", "322161013", "story_v_out_322161.awb")

						arg_53_1:RecordAudio("322161013", var_56_10)
						arg_53_1:RecordAudio("322161013", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322161", "322161013", "story_v_out_322161.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322161", "322161013", "story_v_out_322161.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_11 and arg_53_1.time_ < var_56_1 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322161014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322161014
		arg_57_1.duration_ = 2.23

		local var_57_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_57_0:Play322161015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1089ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1089ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1089ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = "1061ui_story"

			if arg_57_1.actors_[var_60_9] == nil then
				local var_60_10 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_60_10) then
					local var_60_11 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_57_1.stage_.transform)

					var_60_11.name = var_60_9
					var_60_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_57_1.actors_[var_60_9] = var_60_11

					local var_60_12 = var_60_11:GetComponentInChildren(typeof(CharacterEffect))

					var_60_12.enabled = true

					local var_60_13 = GameObjectTools.GetOrAddComponent(var_60_11, typeof(DynamicBoneHelper))

					if var_60_13 then
						var_60_13:EnableDynamicBone(false)
					end

					arg_57_1:ShowWeapon(var_60_12.transform, false)

					arg_57_1.var_[var_60_9 .. "Animator"] = var_60_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_57_1.var_[var_60_9 .. "Animator"].applyRootMotion = true
					arg_57_1.var_[var_60_9 .. "LipSync"] = var_60_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_60_14 = arg_57_1.actors_["1061ui_story"].transform
			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.var_.moveOldPos1061ui_story = var_60_14.localPosition

				local var_60_16 = "1061ui_story"

				arg_57_1:ShowWeapon(arg_57_1.var_[var_60_16 .. "Animator"].transform, false)
			end

			local var_60_17 = 0.001

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_17 then
				local var_60_18 = (arg_57_1.time_ - var_60_15) / var_60_17
				local var_60_19 = Vector3.New(0.7, -1.18, -6.15)

				var_60_14.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1061ui_story, var_60_19, var_60_18)

				local var_60_20 = manager.ui.mainCamera.transform.position - var_60_14.position

				var_60_14.forward = Vector3.New(var_60_20.x, var_60_20.y, var_60_20.z)

				local var_60_21 = var_60_14.localEulerAngles

				var_60_21.z = 0
				var_60_21.x = 0
				var_60_14.localEulerAngles = var_60_21
			end

			if arg_57_1.time_ >= var_60_15 + var_60_17 and arg_57_1.time_ < var_60_15 + var_60_17 + arg_60_0 then
				var_60_14.localPosition = Vector3.New(0.7, -1.18, -6.15)

				local var_60_22 = manager.ui.mainCamera.transform.position - var_60_14.position

				var_60_14.forward = Vector3.New(var_60_22.x, var_60_22.y, var_60_22.z)

				local var_60_23 = var_60_14.localEulerAngles

				var_60_23.z = 0
				var_60_23.x = 0
				var_60_14.localEulerAngles = var_60_23
			end

			local var_60_24 = arg_57_1.actors_["1061ui_story"]
			local var_60_25 = 0

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 and not isNil(var_60_24) and arg_57_1.var_.characterEffect1061ui_story == nil then
				arg_57_1.var_.characterEffect1061ui_story = var_60_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_26 = 0.200000002980232

			if var_60_25 <= arg_57_1.time_ and arg_57_1.time_ < var_60_25 + var_60_26 and not isNil(var_60_24) then
				local var_60_27 = (arg_57_1.time_ - var_60_25) / var_60_26

				if arg_57_1.var_.characterEffect1061ui_story and not isNil(var_60_24) then
					arg_57_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_25 + var_60_26 and arg_57_1.time_ < var_60_25 + var_60_26 + arg_60_0 and not isNil(var_60_24) and arg_57_1.var_.characterEffect1061ui_story then
				arg_57_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_60_28 = arg_57_1.actors_["1089ui_story"]
			local var_60_29 = 0

			if var_60_29 < arg_57_1.time_ and arg_57_1.time_ <= var_60_29 + arg_60_0 and not isNil(var_60_28) and arg_57_1.var_.characterEffect1089ui_story == nil then
				arg_57_1.var_.characterEffect1089ui_story = var_60_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_30 = 0.200000002980232

			if var_60_29 <= arg_57_1.time_ and arg_57_1.time_ < var_60_29 + var_60_30 and not isNil(var_60_28) then
				local var_60_31 = (arg_57_1.time_ - var_60_29) / var_60_30

				if arg_57_1.var_.characterEffect1089ui_story and not isNil(var_60_28) then
					local var_60_32 = Mathf.Lerp(0, 0.5, var_60_31)

					arg_57_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1089ui_story.fillRatio = var_60_32
				end
			end

			if arg_57_1.time_ >= var_60_29 + var_60_30 and arg_57_1.time_ < var_60_29 + var_60_30 + arg_60_0 and not isNil(var_60_28) and arg_57_1.var_.characterEffect1089ui_story then
				local var_60_33 = 0.5

				arg_57_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1089ui_story.fillRatio = var_60_33
			end

			local var_60_34 = 0

			if var_60_34 < arg_57_1.time_ and arg_57_1.time_ <= var_60_34 + arg_60_0 then
				arg_57_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_60_35 = 0

			if var_60_35 < arg_57_1.time_ and arg_57_1.time_ <= var_60_35 + arg_60_0 then
				arg_57_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_36 = 0
			local var_60_37 = 0.1

			if var_60_36 < arg_57_1.time_ and arg_57_1.time_ <= var_60_36 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_38 = arg_57_1:FormatText(StoryNameCfg[612].name)

				arg_57_1.leftNameTxt_.text = var_60_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_39 = arg_57_1:GetWordFromCfg(322161014)
				local var_60_40 = arg_57_1:FormatText(var_60_39.content)

				arg_57_1.text_.text = var_60_40

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_41 = 4
				local var_60_42 = utf8.len(var_60_40)
				local var_60_43 = var_60_41 <= 0 and var_60_37 or var_60_37 * (var_60_42 / var_60_41)

				if var_60_43 > 0 and var_60_37 < var_60_43 then
					arg_57_1.talkMaxDuration = var_60_43

					if var_60_43 + var_60_36 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_43 + var_60_36
					end
				end

				arg_57_1.text_.text = var_60_40
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161014", "story_v_out_322161.awb") ~= 0 then
					local var_60_44 = manager.audio:GetVoiceLength("story_v_out_322161", "322161014", "story_v_out_322161.awb") / 1000

					if var_60_44 + var_60_36 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_44 + var_60_36
					end

					if var_60_39.prefab_name ~= "" and arg_57_1.actors_[var_60_39.prefab_name] ~= nil then
						local var_60_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_39.prefab_name].transform, "story_v_out_322161", "322161014", "story_v_out_322161.awb")

						arg_57_1:RecordAudio("322161014", var_60_45)
						arg_57_1:RecordAudio("322161014", var_60_45)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322161", "322161014", "story_v_out_322161.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322161", "322161014", "story_v_out_322161.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_46 = math.max(var_60_37, arg_57_1.talkMaxDuration)

			if var_60_36 <= arg_57_1.time_ and arg_57_1.time_ < var_60_36 + var_60_46 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_36) / var_60_46

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_36 + var_60_46 and arg_57_1.time_ < var_60_36 + var_60_46 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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

		arg_57_1:InitPlayNodeList()
	end,
	Play322161015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322161015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322161016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1089ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1089ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1089ui_story, var_64_4, var_64_3)

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

			local var_64_9 = arg_61_1.actors_["1061ui_story"].transform
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061ui_story = var_64_9.localPosition

				local var_64_11 = "1061ui_story"

				arg_61_1:ShowWeapon(arg_61_1.var_[var_64_11 .. "Animator"].transform, false)
			end

			local var_64_12 = 0.001

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_12 then
				local var_64_13 = (arg_61_1.time_ - var_64_10) / var_64_12
				local var_64_14 = Vector3.New(0, 100, 0)

				var_64_9.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061ui_story, var_64_14, var_64_13)

				local var_64_15 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_15.x, var_64_15.y, var_64_15.z)

				local var_64_16 = var_64_9.localEulerAngles

				var_64_16.z = 0
				var_64_16.x = 0
				var_64_9.localEulerAngles = var_64_16
			end

			if arg_61_1.time_ >= var_64_10 + var_64_12 and arg_61_1.time_ < var_64_10 + var_64_12 + arg_64_0 then
				var_64_9.localPosition = Vector3.New(0, 100, 0)

				local var_64_17 = manager.ui.mainCamera.transform.position - var_64_9.position

				var_64_9.forward = Vector3.New(var_64_17.x, var_64_17.y, var_64_17.z)

				local var_64_18 = var_64_9.localEulerAngles

				var_64_18.z = 0
				var_64_18.x = 0
				var_64_9.localEulerAngles = var_64_18
			end

			local var_64_19 = 0
			local var_64_20 = 1.325

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_21 = arg_61_1:GetWordFromCfg(322161015)
				local var_64_22 = arg_61_1:FormatText(var_64_21.content)

				arg_61_1.text_.text = var_64_22

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_23 = 53
				local var_64_24 = utf8.len(var_64_22)
				local var_64_25 = var_64_23 <= 0 and var_64_20 or var_64_20 * (var_64_24 / var_64_23)

				if var_64_25 > 0 and var_64_20 < var_64_25 then
					arg_61_1.talkMaxDuration = var_64_25

					if var_64_25 + var_64_19 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_25 + var_64_19
					end
				end

				arg_61_1.text_.text = var_64_22
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_20, arg_61_1.talkMaxDuration)

			if var_64_19 <= arg_61_1.time_ and arg_61_1.time_ < var_64_19 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_19) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_19 + var_64_26 and arg_61_1.time_ < var_64_19 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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

		arg_61_1:InitPlayNodeList()
	end,
	Play322161016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322161016
		arg_65_1.duration_ = 9

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322161017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 4

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_1 = 0.3

			if arg_65_1.time_ >= var_68_0 + var_68_1 and arg_65_1.time_ < var_68_0 + var_68_1 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_2 = "L01f"

			if arg_65_1.bgs_[var_68_2] == nil then
				local var_68_3 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_2)
				var_68_3.name = var_68_2
				var_68_3.transform.parent = arg_65_1.stage_.transform
				var_68_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_2] = var_68_3
			end

			local var_68_4 = 2

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				local var_68_5 = manager.ui.mainCamera.transform.localPosition
				local var_68_6 = Vector3.New(0, 0, 10) + Vector3.New(var_68_5.x, var_68_5.y, 0)
				local var_68_7 = arg_65_1.bgs_.L01f

				var_68_7.transform.localPosition = var_68_6
				var_68_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_8 = var_68_7:GetComponent("SpriteRenderer")

				if var_68_8 and var_68_8.sprite then
					local var_68_9 = (var_68_7.transform.localPosition - var_68_5).z
					local var_68_10 = manager.ui.mainCameraCom_
					local var_68_11 = 2 * var_68_9 * Mathf.Tan(var_68_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_12 = var_68_11 * var_68_10.aspect
					local var_68_13 = var_68_8.sprite.bounds.size.x
					local var_68_14 = var_68_8.sprite.bounds.size.y
					local var_68_15 = var_68_12 / var_68_13
					local var_68_16 = var_68_11 / var_68_14
					local var_68_17 = var_68_16 < var_68_15 and var_68_15 or var_68_16

					var_68_7.transform.localScale = Vector3.New(var_68_17, var_68_17, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "L01f" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_18 = 0

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_19 = 2

			if var_68_18 <= arg_65_1.time_ and arg_65_1.time_ < var_68_18 + var_68_19 then
				local var_68_20 = (arg_65_1.time_ - var_68_18) / var_68_19
				local var_68_21 = Color.New(0, 0, 0)

				var_68_21.a = Mathf.Lerp(0, 1, var_68_20)
				arg_65_1.mask_.color = var_68_21
			end

			if arg_65_1.time_ >= var_68_18 + var_68_19 and arg_65_1.time_ < var_68_18 + var_68_19 + arg_68_0 then
				local var_68_22 = Color.New(0, 0, 0)

				var_68_22.a = 1
				arg_65_1.mask_.color = var_68_22
			end

			local var_68_23 = 2

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_24 = 2

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 then
				local var_68_25 = (arg_65_1.time_ - var_68_23) / var_68_24
				local var_68_26 = Color.New(0, 0, 0)

				var_68_26.a = Mathf.Lerp(1, 0, var_68_25)
				arg_65_1.mask_.color = var_68_26
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 then
				local var_68_27 = Color.New(0, 0, 0)
				local var_68_28 = 0

				arg_65_1.mask_.enabled = false
				var_68_27.a = var_68_28
				arg_65_1.mask_.color = var_68_27
			end

			local var_68_29 = 0.2
			local var_68_30 = 1

			if var_68_29 < arg_65_1.time_ and arg_65_1.time_ <= var_68_29 + arg_68_0 then
				local var_68_31 = "stop"
				local var_68_32 = "effect"

				arg_65_1:AudioAction(var_68_31, var_68_32, "se_story_145", "se_story_145_amb_data", "")
			end

			local var_68_33 = 1.53333333333333
			local var_68_34 = 1

			if var_68_33 < arg_65_1.time_ and arg_65_1.time_ <= var_68_33 + arg_68_0 then
				local var_68_35 = "play"
				local var_68_36 = "effect"

				arg_65_1:AudioAction(var_68_35, var_68_36, "se_story_140", "se_story_140_amb_street01", "")
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_37 = 4
			local var_68_38 = 1.1

			if var_68_37 < arg_65_1.time_ and arg_65_1.time_ <= var_68_37 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_39 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_39:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_40 = arg_65_1:GetWordFromCfg(322161016)
				local var_68_41 = arg_65_1:FormatText(var_68_40.content)

				arg_65_1.text_.text = var_68_41

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_42 = 44
				local var_68_43 = utf8.len(var_68_41)
				local var_68_44 = var_68_42 <= 0 and var_68_38 or var_68_38 * (var_68_43 / var_68_42)

				if var_68_44 > 0 and var_68_38 < var_68_44 then
					arg_65_1.talkMaxDuration = var_68_44
					var_68_37 = var_68_37 + 0.3

					if var_68_44 + var_68_37 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_44 + var_68_37
					end
				end

				arg_65_1.text_.text = var_68_41
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_45 = var_68_37 + 0.3
			local var_68_46 = math.max(var_68_38, arg_65_1.talkMaxDuration)

			if var_68_45 <= arg_65_1.time_ and arg_65_1.time_ < var_68_45 + var_68_46 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_45) / var_68_46

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_45 + var_68_46 and arg_65_1.time_ < var_68_45 + var_68_46 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322161017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322161017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322161018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1.575

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_2 = arg_71_1:GetWordFromCfg(322161017)
				local var_74_3 = arg_71_1:FormatText(var_74_2.content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 63
				local var_74_5 = utf8.len(var_74_3)
				local var_74_6 = var_74_4 <= 0 and var_74_1 or var_74_1 * (var_74_5 / var_74_4)

				if var_74_6 > 0 and var_74_1 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_7 and arg_71_1.time_ < var_74_0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322161018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322161018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322161019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1.8

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(322161018)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 71
				local var_78_5 = utf8.len(var_78_3)
				local var_78_6 = var_78_4 <= 0 and var_78_1 or var_78_1 * (var_78_5 / var_78_4)

				if var_78_6 > 0 and var_78_1 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_7 and arg_75_1.time_ < var_78_0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play322161019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322161019
		arg_79_1.duration_ = 9

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322161020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 4

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_1 = 1.26666666666667

			if arg_79_1.time_ >= var_82_0 + var_82_1 and arg_79_1.time_ < var_82_0 + var_82_1 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_2 = "ST0505"

			if arg_79_1.bgs_[var_82_2] == nil then
				local var_82_3 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_82_2)
				var_82_3.name = var_82_2
				var_82_3.transform.parent = arg_79_1.stage_.transform
				var_82_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_[var_82_2] = var_82_3
			end

			local var_82_4 = 2

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				local var_82_5 = manager.ui.mainCamera.transform.localPosition
				local var_82_6 = Vector3.New(0, 0, 10) + Vector3.New(var_82_5.x, var_82_5.y, 0)
				local var_82_7 = arg_79_1.bgs_.ST0505

				var_82_7.transform.localPosition = var_82_6
				var_82_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_8 = var_82_7:GetComponent("SpriteRenderer")

				if var_82_8 and var_82_8.sprite then
					local var_82_9 = (var_82_7.transform.localPosition - var_82_5).z
					local var_82_10 = manager.ui.mainCameraCom_
					local var_82_11 = 2 * var_82_9 * Mathf.Tan(var_82_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_12 = var_82_11 * var_82_10.aspect
					local var_82_13 = var_82_8.sprite.bounds.size.x
					local var_82_14 = var_82_8.sprite.bounds.size.y
					local var_82_15 = var_82_12 / var_82_13
					local var_82_16 = var_82_11 / var_82_14
					local var_82_17 = var_82_16 < var_82_15 and var_82_15 or var_82_16

					var_82_7.transform.localScale = Vector3.New(var_82_17, var_82_17, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "ST0505" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_18 = 0

			if var_82_18 < arg_79_1.time_ and arg_79_1.time_ <= var_82_18 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_19 = 2

			if var_82_18 <= arg_79_1.time_ and arg_79_1.time_ < var_82_18 + var_82_19 then
				local var_82_20 = (arg_79_1.time_ - var_82_18) / var_82_19
				local var_82_21 = Color.New(0, 0, 0)

				var_82_21.a = Mathf.Lerp(0, 1, var_82_20)
				arg_79_1.mask_.color = var_82_21
			end

			if arg_79_1.time_ >= var_82_18 + var_82_19 and arg_79_1.time_ < var_82_18 + var_82_19 + arg_82_0 then
				local var_82_22 = Color.New(0, 0, 0)

				var_82_22.a = 1
				arg_79_1.mask_.color = var_82_22
			end

			local var_82_23 = 2

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_24 = 2

			if var_82_23 <= arg_79_1.time_ and arg_79_1.time_ < var_82_23 + var_82_24 then
				local var_82_25 = (arg_79_1.time_ - var_82_23) / var_82_24
				local var_82_26 = Color.New(0, 0, 0)

				var_82_26.a = Mathf.Lerp(1, 0, var_82_25)
				arg_79_1.mask_.color = var_82_26
			end

			if arg_79_1.time_ >= var_82_23 + var_82_24 and arg_79_1.time_ < var_82_23 + var_82_24 + arg_82_0 then
				local var_82_27 = Color.New(0, 0, 0)
				local var_82_28 = 0

				arg_79_1.mask_.enabled = false
				var_82_27.a = var_82_28
				arg_79_1.mask_.color = var_82_27
			end

			local var_82_29 = 0.233333333333333
			local var_82_30 = 1

			if var_82_29 < arg_79_1.time_ and arg_79_1.time_ <= var_82_29 + arg_82_0 then
				local var_82_31 = "stop"
				local var_82_32 = "effect"

				arg_79_1:AudioAction(var_82_31, var_82_32, "se_story_140", "se_story_140_amb_street01", "")
			end

			local var_82_33 = 1.53333333333333
			local var_82_34 = 1

			if var_82_33 < arg_79_1.time_ and arg_79_1.time_ <= var_82_33 + arg_82_0 then
				local var_82_35 = "play"
				local var_82_36 = "effect"

				arg_79_1:AudioAction(var_82_35, var_82_36, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_82_37 = 4.16666666666667
			local var_82_38 = 1

			if var_82_37 < arg_79_1.time_ and arg_79_1.time_ <= var_82_37 + arg_82_0 then
				local var_82_39 = "play"
				local var_82_40 = "effect"

				arg_79_1:AudioAction(var_82_39, var_82_40, "se_story_141", "se_story_141_message", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_41 = 4
			local var_82_42 = 1.5

			if var_82_41 < arg_79_1.time_ and arg_79_1.time_ <= var_82_41 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_43 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_43:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_44 = arg_79_1:GetWordFromCfg(322161019)
				local var_82_45 = arg_79_1:FormatText(var_82_44.content)

				arg_79_1.text_.text = var_82_45

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_46 = 60
				local var_82_47 = utf8.len(var_82_45)
				local var_82_48 = var_82_46 <= 0 and var_82_42 or var_82_42 * (var_82_47 / var_82_46)

				if var_82_48 > 0 and var_82_42 < var_82_48 then
					arg_79_1.talkMaxDuration = var_82_48
					var_82_41 = var_82_41 + 0.3

					if var_82_48 + var_82_41 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_48 + var_82_41
					end
				end

				arg_79_1.text_.text = var_82_45
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_49 = var_82_41 + 0.3
			local var_82_50 = math.max(var_82_42, arg_79_1.talkMaxDuration)

			if var_82_49 <= arg_79_1.time_ and arg_79_1.time_ < var_82_49 + var_82_50 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_49) / var_82_50

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_49 + var_82_50 and arg_79_1.time_ < var_82_49 + var_82_50 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play322161020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322161020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322161021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.675

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(322161020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 27
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
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play322161021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322161021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322161022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.6

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

				local var_92_2 = arg_89_1:GetWordFromCfg(322161021)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 64
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
	Play322161022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322161022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322161023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.725

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(322161022)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 69
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play322161023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322161023
		arg_97_1.duration_ = 8

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322161024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 3

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			local var_100_1 = 0.9

			if arg_97_1.time_ >= var_100_0 + var_100_1 and arg_97_1.time_ < var_100_0 + var_100_1 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_2 = 1

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				local var_100_3 = manager.ui.mainCamera.transform.localPosition
				local var_100_4 = Vector3.New(0, 0, 10) + Vector3.New(var_100_3.x, var_100_3.y, 0)
				local var_100_5 = arg_97_1.bgs_.ST0510

				var_100_5.transform.localPosition = var_100_4
				var_100_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_6 = var_100_5:GetComponent("SpriteRenderer")

				if var_100_6 and var_100_6.sprite then
					local var_100_7 = (var_100_5.transform.localPosition - var_100_3).z
					local var_100_8 = manager.ui.mainCameraCom_
					local var_100_9 = 2 * var_100_7 * Mathf.Tan(var_100_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_100_10 = var_100_9 * var_100_8.aspect
					local var_100_11 = var_100_6.sprite.bounds.size.x
					local var_100_12 = var_100_6.sprite.bounds.size.y
					local var_100_13 = var_100_10 / var_100_11
					local var_100_14 = var_100_9 / var_100_12
					local var_100_15 = var_100_14 < var_100_13 and var_100_13 or var_100_14

					var_100_5.transform.localScale = Vector3.New(var_100_15, var_100_15, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "ST0510" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_17 = 1

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17
				local var_100_19 = Color.New(0, 0, 0)

				var_100_19.a = Mathf.Lerp(0, 1, var_100_18)
				arg_97_1.mask_.color = var_100_19
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				local var_100_20 = Color.New(0, 0, 0)

				var_100_20.a = 1
				arg_97_1.mask_.color = var_100_20
			end

			local var_100_21 = 1

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_22 = 2

			if var_100_21 <= arg_97_1.time_ and arg_97_1.time_ < var_100_21 + var_100_22 then
				local var_100_23 = (arg_97_1.time_ - var_100_21) / var_100_22
				local var_100_24 = Color.New(0, 0, 0)

				var_100_24.a = Mathf.Lerp(1, 0, var_100_23)
				arg_97_1.mask_.color = var_100_24
			end

			if arg_97_1.time_ >= var_100_21 + var_100_22 and arg_97_1.time_ < var_100_21 + var_100_22 + arg_100_0 then
				local var_100_25 = Color.New(0, 0, 0)
				local var_100_26 = 0

				arg_97_1.mask_.enabled = false
				var_100_25.a = var_100_26
				arg_97_1.mask_.color = var_100_25
			end

			local var_100_27 = 3.60822483003176e-16
			local var_100_28 = 1

			if var_100_27 < arg_97_1.time_ and arg_97_1.time_ <= var_100_27 + arg_100_0 then
				local var_100_29 = "stop"
				local var_100_30 = "effect"

				arg_97_1:AudioAction(var_100_29, var_100_30, "se_story_140", "se_story_140_amb_room02", "")
			end

			local var_100_31 = 0.6
			local var_100_32 = 1

			if var_100_31 < arg_97_1.time_ and arg_97_1.time_ <= var_100_31 + arg_100_0 then
				local var_100_33 = "play"
				local var_100_34 = "effect"

				arg_97_1:AudioAction(var_100_33, var_100_34, "se_story_145", "se_story_145_amb_data", "")
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_35 = 3
			local var_100_36 = 1.2

			if var_100_35 < arg_97_1.time_ and arg_97_1.time_ <= var_100_35 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_37 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_37:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_38 = arg_97_1:GetWordFromCfg(322161023)
				local var_100_39 = arg_97_1:FormatText(var_100_38.content)

				arg_97_1.text_.text = var_100_39

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_40 = 48
				local var_100_41 = utf8.len(var_100_39)
				local var_100_42 = var_100_40 <= 0 and var_100_36 or var_100_36 * (var_100_41 / var_100_40)

				if var_100_42 > 0 and var_100_36 < var_100_42 then
					arg_97_1.talkMaxDuration = var_100_42
					var_100_35 = var_100_35 + 0.3

					if var_100_42 + var_100_35 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_42 + var_100_35
					end
				end

				arg_97_1.text_.text = var_100_39
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_43 = var_100_35 + 0.3
			local var_100_44 = math.max(var_100_36, arg_97_1.talkMaxDuration)

			if var_100_43 <= arg_97_1.time_ and arg_97_1.time_ < var_100_43 + var_100_44 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_43) / var_100_44

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_43 + var_100_44 and arg_97_1.time_ < var_100_43 + var_100_44 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322161024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322161024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play322161025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.425

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(322161024)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 57
				local var_106_5 = utf8.len(var_106_3)
				local var_106_6 = var_106_4 <= 0 and var_106_1 or var_106_1 * (var_106_5 / var_106_4)

				if var_106_6 > 0 and var_106_1 < var_106_6 then
					arg_103_1.talkMaxDuration = var_106_6

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_7 and arg_103_1.time_ < var_106_0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play322161025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 322161025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play322161026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.55

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(322161025)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 62
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play322161026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322161026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play322161027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1.05

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

				local var_114_2 = arg_111_1:GetWordFromCfg(322161026)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 42
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
	Play322161027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322161027
		arg_115_1.duration_ = 4.43

		local var_115_0 = {
			zh = 2.933,
			ja = 4.433
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
				arg_115_0:Play322161028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "1211ui_story"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_118_1) then
					local var_118_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_115_1.stage_.transform)

					var_118_2.name = var_118_0
					var_118_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_0] = var_118_2

					local var_118_3 = var_118_2:GetComponentInChildren(typeof(CharacterEffect))

					var_118_3.enabled = true

					local var_118_4 = GameObjectTools.GetOrAddComponent(var_118_2, typeof(DynamicBoneHelper))

					if var_118_4 then
						var_118_4:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_3.transform, false)

					arg_115_1.var_[var_118_0 .. "Animator"] = var_118_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_0 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_0 .. "LipSync"] = var_118_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_5 = arg_115_1.actors_["1211ui_story"].transform
			local var_118_6 = 0

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.var_.moveOldPos1211ui_story = var_118_5.localPosition

				local var_118_7 = "1211ui_story"

				arg_115_1:ShowWeapon(arg_115_1.var_[var_118_7 .. "Animator"].transform, false)
			end

			local var_118_8 = 0.001

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_8 then
				local var_118_9 = (arg_115_1.time_ - var_118_6) / var_118_8
				local var_118_10 = Vector3.New(0, -0.67, -6.07)

				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1211ui_story, var_118_10, var_118_9)

				local var_118_11 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_11.x, var_118_11.y, var_118_11.z)

				local var_118_12 = var_118_5.localEulerAngles

				var_118_12.z = 0
				var_118_12.x = 0
				var_118_5.localEulerAngles = var_118_12
			end

			if arg_115_1.time_ >= var_118_6 + var_118_8 and arg_115_1.time_ < var_118_6 + var_118_8 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_118_13 = manager.ui.mainCamera.transform.position - var_118_5.position

				var_118_5.forward = Vector3.New(var_118_13.x, var_118_13.y, var_118_13.z)

				local var_118_14 = var_118_5.localEulerAngles

				var_118_14.z = 0
				var_118_14.x = 0
				var_118_5.localEulerAngles = var_118_14
			end

			local var_118_15 = arg_115_1.actors_["1211ui_story"]
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.characterEffect1211ui_story == nil then
				arg_115_1.var_.characterEffect1211ui_story = var_118_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_17 = 0.200000002980232

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_17 and not isNil(var_118_15) then
				local var_118_18 = (arg_115_1.time_ - var_118_16) / var_118_17

				if arg_115_1.var_.characterEffect1211ui_story and not isNil(var_118_15) then
					arg_115_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.characterEffect1211ui_story then
				arg_115_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_118_19 = 0

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_118_20 = 0

			if var_118_20 < arg_115_1.time_ and arg_115_1.time_ <= var_118_20 + arg_118_0 then
				arg_115_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_118_21 = 0
			local var_118_22 = 0.3

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_23 = arg_115_1:FormatText(StoryNameCfg[37].name)

				arg_115_1.leftNameTxt_.text = var_118_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_24 = arg_115_1:GetWordFromCfg(322161027)
				local var_118_25 = arg_115_1:FormatText(var_118_24.content)

				arg_115_1.text_.text = var_118_25

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_26 = 12
				local var_118_27 = utf8.len(var_118_25)
				local var_118_28 = var_118_26 <= 0 and var_118_22 or var_118_22 * (var_118_27 / var_118_26)

				if var_118_28 > 0 and var_118_22 < var_118_28 then
					arg_115_1.talkMaxDuration = var_118_28

					if var_118_28 + var_118_21 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_28 + var_118_21
					end
				end

				arg_115_1.text_.text = var_118_25
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161027", "story_v_out_322161.awb") ~= 0 then
					local var_118_29 = manager.audio:GetVoiceLength("story_v_out_322161", "322161027", "story_v_out_322161.awb") / 1000

					if var_118_29 + var_118_21 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_29 + var_118_21
					end

					if var_118_24.prefab_name ~= "" and arg_115_1.actors_[var_118_24.prefab_name] ~= nil then
						local var_118_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_24.prefab_name].transform, "story_v_out_322161", "322161027", "story_v_out_322161.awb")

						arg_115_1:RecordAudio("322161027", var_118_30)
						arg_115_1:RecordAudio("322161027", var_118_30)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322161", "322161027", "story_v_out_322161.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322161", "322161027", "story_v_out_322161.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_31 = math.max(var_118_22, arg_115_1.talkMaxDuration)

			if var_118_21 <= arg_115_1.time_ and arg_115_1.time_ < var_118_21 + var_118_31 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_21) / var_118_31

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_21 + var_118_31 and arg_115_1.time_ < var_118_21 + var_118_31 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play322161028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322161028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play322161029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1211ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1211ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0, 100, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1211ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, 100, 0)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = 0
			local var_122_10 = 0.875

			if var_122_9 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_11 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_12 = arg_119_1:GetWordFromCfg(322161028)
				local var_122_13 = arg_119_1:FormatText(var_122_12.content)

				arg_119_1.text_.text = var_122_13

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_14 = 35
				local var_122_15 = utf8.len(var_122_13)
				local var_122_16 = var_122_14 <= 0 and var_122_10 or var_122_10 * (var_122_15 / var_122_14)

				if var_122_16 > 0 and var_122_10 < var_122_16 then
					arg_119_1.talkMaxDuration = var_122_16

					if var_122_16 + var_122_9 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_9
					end
				end

				arg_119_1.text_.text = var_122_13
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = math.max(var_122_10, arg_119_1.talkMaxDuration)

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_17 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_9) / var_122_17

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_9 + var_122_17 and arg_119_1.time_ < var_122_9 + var_122_17 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play322161029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322161029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play322161030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.575

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(322161029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 23
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_8 and arg_123_1.time_ < var_126_0 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322161030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322161030
		arg_127_1.duration_ = 2.53

		local var_127_0 = {
			zh = 2.433,
			ja = 2.533
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
				arg_127_0:Play322161031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1085ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1085ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0, -1.01, -5.83)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1085ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["1085ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1085ui_story == nil then
				arg_127_1.var_.characterEffect1085ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 and not isNil(var_130_9) then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect1085ui_story and not isNil(var_130_9) then
					arg_127_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and not isNil(var_130_9) and arg_127_1.var_.characterEffect1085ui_story then
				arg_127_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_130_13 = 0

			if var_130_13 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_130_15 = 0
			local var_130_16 = 0.225

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[328].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(322161030)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 9
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161030", "story_v_out_322161.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161030", "story_v_out_322161.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_322161", "322161030", "story_v_out_322161.awb")

						arg_127_1:RecordAudio("322161030", var_130_24)
						arg_127_1:RecordAudio("322161030", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322161", "322161030", "story_v_out_322161.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322161", "322161030", "story_v_out_322161.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_25 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_25 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_25

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_25 and arg_127_1.time_ < var_130_15 + var_130_25 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play322161031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322161031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322161032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1085ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1085ui_story == nil then
				arg_131_1.var_.characterEffect1085ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1085ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1085ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1085ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1085ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 0.55

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_9 = arg_131_1:GetWordFromCfg(322161031)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 22
				local var_134_12 = utf8.len(var_134_10)
				local var_134_13 = var_134_11 <= 0 and var_134_7 or var_134_7 * (var_134_12 / var_134_11)

				if var_134_13 > 0 and var_134_7 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play322161032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322161032
		arg_135_1.duration_ = 4.57

		local var_135_0 = {
			zh = 3.033,
			ja = 4.566
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322161033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1085ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1085ui_story == nil then
				arg_135_1.var_.characterEffect1085ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1085ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1085ui_story then
				arg_135_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_138_6 = 0
			local var_138_7 = 0.275

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[328].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_9 = arg_135_1:GetWordFromCfg(322161032)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 11
				local var_138_12 = utf8.len(var_138_10)
				local var_138_13 = var_138_11 <= 0 and var_138_7 or var_138_7 * (var_138_12 / var_138_11)

				if var_138_13 > 0 and var_138_7 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161032", "story_v_out_322161.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_322161", "322161032", "story_v_out_322161.awb") / 1000

					if var_138_14 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_6
					end

					if var_138_9.prefab_name ~= "" and arg_135_1.actors_[var_138_9.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_9.prefab_name].transform, "story_v_out_322161", "322161032", "story_v_out_322161.awb")

						arg_135_1:RecordAudio("322161032", var_138_15)
						arg_135_1:RecordAudio("322161032", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322161", "322161032", "story_v_out_322161.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322161", "322161032", "story_v_out_322161.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_16 and arg_135_1.time_ < var_138_6 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play322161033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322161033
		arg_139_1.duration_ = 2

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322161034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_142_2 = 0
			local var_142_3 = 0.1

			if var_142_2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_4 = arg_139_1:FormatText(StoryNameCfg[328].name)

				arg_139_1.leftNameTxt_.text = var_142_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_5 = arg_139_1:GetWordFromCfg(322161033)
				local var_142_6 = arg_139_1:FormatText(var_142_5.content)

				arg_139_1.text_.text = var_142_6

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 4
				local var_142_8 = utf8.len(var_142_6)
				local var_142_9 = var_142_7 <= 0 and var_142_3 or var_142_3 * (var_142_8 / var_142_7)

				if var_142_9 > 0 and var_142_3 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_6
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161033", "story_v_out_322161.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_322161", "322161033", "story_v_out_322161.awb") / 1000

					if var_142_10 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_2
					end

					if var_142_5.prefab_name ~= "" and arg_139_1.actors_[var_142_5.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_5.prefab_name].transform, "story_v_out_322161", "322161033", "story_v_out_322161.awb")

						arg_139_1:RecordAudio("322161033", var_142_11)
						arg_139_1:RecordAudio("322161033", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_322161", "322161033", "story_v_out_322161.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_322161", "322161033", "story_v_out_322161.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_12 and arg_139_1.time_ < var_142_2 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play322161034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322161034
		arg_143_1.duration_ = 4.97

		local var_143_0 = {
			zh = 3.466,
			ja = 4.966
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
				arg_143_0:Play322161035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1085ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1085ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1085ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["404001ui_story"].transform
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1.var_.moveOldPos404001ui_story = var_146_9.localPosition
			end

			local var_146_11 = 0.001

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11
				local var_146_13 = Vector3.New(0.8, -1.55, -5.5)

				var_146_9.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos404001ui_story, var_146_13, var_146_12)

				local var_146_14 = manager.ui.mainCamera.transform.position - var_146_9.position

				var_146_9.forward = Vector3.New(var_146_14.x, var_146_14.y, var_146_14.z)

				local var_146_15 = var_146_9.localEulerAngles

				var_146_15.z = 0
				var_146_15.x = 0
				var_146_9.localEulerAngles = var_146_15
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 then
				var_146_9.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_146_16 = manager.ui.mainCamera.transform.position - var_146_9.position

				var_146_9.forward = Vector3.New(var_146_16.x, var_146_16.y, var_146_16.z)

				local var_146_17 = var_146_9.localEulerAngles

				var_146_17.z = 0
				var_146_17.x = 0
				var_146_9.localEulerAngles = var_146_17
			end

			local var_146_18 = arg_143_1.actors_["404001ui_story"]
			local var_146_19 = 0

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 and not isNil(var_146_18) and arg_143_1.var_.characterEffect404001ui_story == nil then
				arg_143_1.var_.characterEffect404001ui_story = var_146_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_20 = 0.200000002980232

			if var_146_19 <= arg_143_1.time_ and arg_143_1.time_ < var_146_19 + var_146_20 and not isNil(var_146_18) then
				local var_146_21 = (arg_143_1.time_ - var_146_19) / var_146_20

				if arg_143_1.var_.characterEffect404001ui_story and not isNil(var_146_18) then
					arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_19 + var_146_20 and arg_143_1.time_ < var_146_19 + var_146_20 + arg_146_0 and not isNil(var_146_18) and arg_143_1.var_.characterEffect404001ui_story then
				arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_146_22 = arg_143_1.actors_["1085ui_story"]
			local var_146_23 = 0

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.characterEffect1085ui_story == nil then
				arg_143_1.var_.characterEffect1085ui_story = var_146_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_24 = 0.200000002980232

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 and not isNil(var_146_22) then
				local var_146_25 = (arg_143_1.time_ - var_146_23) / var_146_24

				if arg_143_1.var_.characterEffect1085ui_story and not isNil(var_146_22) then
					local var_146_26 = Mathf.Lerp(0, 0.5, var_146_25)

					arg_143_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1085ui_story.fillRatio = var_146_26
				end
			end

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.characterEffect1085ui_story then
				local var_146_27 = 0.5

				arg_143_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1085ui_story.fillRatio = var_146_27
			end

			local var_146_28 = 0

			if var_146_28 < arg_143_1.time_ and arg_143_1.time_ <= var_146_28 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_146_29 = 0

			if var_146_29 < arg_143_1.time_ and arg_143_1.time_ <= var_146_29 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_30 = 0
			local var_146_31 = 0.425

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_32 = arg_143_1:FormatText(StoryNameCfg[668].name)

				arg_143_1.leftNameTxt_.text = var_146_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_33 = arg_143_1:GetWordFromCfg(322161034)
				local var_146_34 = arg_143_1:FormatText(var_146_33.content)

				arg_143_1.text_.text = var_146_34

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_35 = 17
				local var_146_36 = utf8.len(var_146_34)
				local var_146_37 = var_146_35 <= 0 and var_146_31 or var_146_31 * (var_146_36 / var_146_35)

				if var_146_37 > 0 and var_146_31 < var_146_37 then
					arg_143_1.talkMaxDuration = var_146_37

					if var_146_37 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_37 + var_146_30
					end
				end

				arg_143_1.text_.text = var_146_34
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161034", "story_v_out_322161.awb") ~= 0 then
					local var_146_38 = manager.audio:GetVoiceLength("story_v_out_322161", "322161034", "story_v_out_322161.awb") / 1000

					if var_146_38 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_38 + var_146_30
					end

					if var_146_33.prefab_name ~= "" and arg_143_1.actors_[var_146_33.prefab_name] ~= nil then
						local var_146_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_33.prefab_name].transform, "story_v_out_322161", "322161034", "story_v_out_322161.awb")

						arg_143_1:RecordAudio("322161034", var_146_39)
						arg_143_1:RecordAudio("322161034", var_146_39)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322161", "322161034", "story_v_out_322161.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322161", "322161034", "story_v_out_322161.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_40 = math.max(var_146_31, arg_143_1.talkMaxDuration)

			if var_146_30 <= arg_143_1.time_ and arg_143_1.time_ < var_146_30 + var_146_40 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_30) / var_146_40

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_30 + var_146_40 and arg_143_1.time_ < var_146_30 + var_146_40 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play322161035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322161035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play322161036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1085ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1085ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, 100, 0)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1085ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, 100, 0)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["404001ui_story"].transform
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.var_.moveOldPos404001ui_story = var_150_9.localPosition
			end

			local var_150_11 = 0.001

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11
				local var_150_13 = Vector3.New(0, 100, 0)

				var_150_9.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos404001ui_story, var_150_13, var_150_12)

				local var_150_14 = manager.ui.mainCamera.transform.position - var_150_9.position

				var_150_9.forward = Vector3.New(var_150_14.x, var_150_14.y, var_150_14.z)

				local var_150_15 = var_150_9.localEulerAngles

				var_150_15.z = 0
				var_150_15.x = 0
				var_150_9.localEulerAngles = var_150_15
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 then
				var_150_9.localPosition = Vector3.New(0, 100, 0)

				local var_150_16 = manager.ui.mainCamera.transform.position - var_150_9.position

				var_150_9.forward = Vector3.New(var_150_16.x, var_150_16.y, var_150_16.z)

				local var_150_17 = var_150_9.localEulerAngles

				var_150_17.z = 0
				var_150_17.x = 0
				var_150_9.localEulerAngles = var_150_17
			end

			local var_150_18 = 0
			local var_150_19 = 0.95

			if var_150_18 < arg_147_1.time_ and arg_147_1.time_ <= var_150_18 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_20 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_21 = arg_147_1:GetWordFromCfg(322161035)
				local var_150_22 = arg_147_1:FormatText(var_150_21.content)

				arg_147_1.text_.text = var_150_22

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_23 = 38
				local var_150_24 = utf8.len(var_150_22)
				local var_150_25 = var_150_23 <= 0 and var_150_19 or var_150_19 * (var_150_24 / var_150_23)

				if var_150_25 > 0 and var_150_19 < var_150_25 then
					arg_147_1.talkMaxDuration = var_150_25

					if var_150_25 + var_150_18 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_25 + var_150_18
					end
				end

				arg_147_1.text_.text = var_150_22
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_26 = math.max(var_150_19, arg_147_1.talkMaxDuration)

			if var_150_18 <= arg_147_1.time_ and arg_147_1.time_ < var_150_18 + var_150_26 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_18) / var_150_26

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_18 + var_150_26 and arg_147_1.time_ < var_150_18 + var_150_26 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play322161036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322161036
		arg_151_1.duration_ = 9.7

		local var_151_0 = {
			zh = 6.966,
			ja = 9.7
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
				arg_151_0:Play322161037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["404001ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos404001ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -1.55, -5.5)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos404001ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["404001ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect404001ui_story == nil then
				arg_151_1.var_.characterEffect404001ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect404001ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect404001ui_story then
				arg_151_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_154_15 = 0
			local var_154_16 = 0.775

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[668].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_18 = arg_151_1:GetWordFromCfg(322161036)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 31
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161036", "story_v_out_322161.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161036", "story_v_out_322161.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_out_322161", "322161036", "story_v_out_322161.awb")

						arg_151_1:RecordAudio("322161036", var_154_24)
						arg_151_1:RecordAudio("322161036", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_322161", "322161036", "story_v_out_322161.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_322161", "322161036", "story_v_out_322161.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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
	Play322161037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322161037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play322161038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["404001ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect404001ui_story == nil then
				arg_155_1.var_.characterEffect404001ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect404001ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_155_1.var_.characterEffect404001ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect404001ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_155_1.var_.characterEffect404001ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0
			local var_158_7 = 0.25

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_9 = arg_155_1:GetWordFromCfg(322161037)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 10
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play322161038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322161038
		arg_159_1.duration_ = 4.9

		local var_159_0 = {
			zh = 4.1,
			ja = 4.9
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322161039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["404001ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect404001ui_story == nil then
				arg_159_1.var_.characterEffect404001ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect404001ui_story and not isNil(var_162_0) then
					arg_159_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect404001ui_story then
				arg_159_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_162_4 = 0

			if var_162_4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_162_5 = 0
			local var_162_6 = 0.35

			if var_162_5 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_7 = arg_159_1:FormatText(StoryNameCfg[668].name)

				arg_159_1.leftNameTxt_.text = var_162_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(322161038)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 14
				local var_162_11 = utf8.len(var_162_9)
				local var_162_12 = var_162_10 <= 0 and var_162_6 or var_162_6 * (var_162_11 / var_162_10)

				if var_162_12 > 0 and var_162_6 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12

					if var_162_12 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161038", "story_v_out_322161.awb") ~= 0 then
					local var_162_13 = manager.audio:GetVoiceLength("story_v_out_322161", "322161038", "story_v_out_322161.awb") / 1000

					if var_162_13 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_5
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_322161", "322161038", "story_v_out_322161.awb")

						arg_159_1:RecordAudio("322161038", var_162_14)
						arg_159_1:RecordAudio("322161038", var_162_14)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_322161", "322161038", "story_v_out_322161.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_322161", "322161038", "story_v_out_322161.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_15 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_15 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_15

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_15 and arg_159_1.time_ < var_162_5 + var_162_15 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322161039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322161039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play322161040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["404001ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos404001ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos404001ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = 0.1
			local var_166_10 = 1

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				local var_166_11 = "play"
				local var_166_12 = "effect"

				arg_163_1:AudioAction(var_166_11, var_166_12, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_166_13 = manager.ui.mainCamera.transform
			local var_166_14 = 0.1

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1.var_.shakeOldPos = var_166_13.localPosition
			end

			local var_166_15 = 0.366666666666667

			if var_166_14 <= arg_163_1.time_ and arg_163_1.time_ < var_166_14 + var_166_15 then
				local var_166_16 = (arg_163_1.time_ - var_166_14) / 0.132
				local var_166_17, var_166_18 = math.modf(var_166_16)

				var_166_13.localPosition = Vector3.New(var_166_18 * 0.13, var_166_18 * 0.13, var_166_18 * 0.13) + arg_163_1.var_.shakeOldPos
			end

			if arg_163_1.time_ >= var_166_14 + var_166_15 and arg_163_1.time_ < var_166_14 + var_166_15 + arg_166_0 then
				var_166_13.localPosition = arg_163_1.var_.shakeOldPos
			end

			local var_166_19 = 0
			local var_166_20 = 1.15

			if var_166_19 < arg_163_1.time_ and arg_163_1.time_ <= var_166_19 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_21 = arg_163_1:GetWordFromCfg(322161039)
				local var_166_22 = arg_163_1:FormatText(var_166_21.content)

				arg_163_1.text_.text = var_166_22

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_23 = 46
				local var_166_24 = utf8.len(var_166_22)
				local var_166_25 = var_166_23 <= 0 and var_166_20 or var_166_20 * (var_166_24 / var_166_23)

				if var_166_25 > 0 and var_166_20 < var_166_25 then
					arg_163_1.talkMaxDuration = var_166_25

					if var_166_25 + var_166_19 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_25 + var_166_19
					end
				end

				arg_163_1.text_.text = var_166_22
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_26 = math.max(var_166_20, arg_163_1.talkMaxDuration)

			if var_166_19 <= arg_163_1.time_ and arg_163_1.time_ < var_166_19 + var_166_26 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_19) / var_166_26

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_19 + var_166_26 and arg_163_1.time_ < var_166_19 + var_166_26 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play322161040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322161040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322161041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.1
			local var_170_1 = 1

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				local var_170_2 = "play"
				local var_170_3 = "effect"

				arg_167_1:AudioAction(var_170_2, var_170_3, "se_story_144", "se_story_144_door_close", "")
			end

			local var_170_4 = 0
			local var_170_5 = 1.2

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(322161040)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 48
				local var_170_9 = utf8.len(var_170_7)
				local var_170_10 = var_170_8 <= 0 and var_170_5 or var_170_5 * (var_170_9 / var_170_8)

				if var_170_10 > 0 and var_170_5 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_11 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_11 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_11

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_11 and arg_167_1.time_ < var_170_4 + var_170_11 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play322161041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322161041
		arg_171_1.duration_ = 4.3

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322161042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 3

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_1 = 0.3

			if arg_171_1.time_ >= var_174_0 + var_174_1 and arg_171_1.time_ < var_174_0 + var_174_1 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_2 = "STblack"

			if arg_171_1.bgs_[var_174_2] == nil then
				local var_174_3 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_2)
				var_174_3.name = var_174_2
				var_174_3.transform.parent = arg_171_1.stage_.transform
				var_174_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_2] = var_174_3
			end

			local var_174_4 = 1

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				local var_174_5 = manager.ui.mainCamera.transform.localPosition
				local var_174_6 = Vector3.New(0, 0, 10) + Vector3.New(var_174_5.x, var_174_5.y, 0)
				local var_174_7 = arg_171_1.bgs_.STblack

				var_174_7.transform.localPosition = var_174_6
				var_174_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_8 = var_174_7:GetComponent("SpriteRenderer")

				if var_174_8 and var_174_8.sprite then
					local var_174_9 = (var_174_7.transform.localPosition - var_174_5).z
					local var_174_10 = manager.ui.mainCameraCom_
					local var_174_11 = 2 * var_174_9 * Mathf.Tan(var_174_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_174_12 = var_174_11 * var_174_10.aspect
					local var_174_13 = var_174_8.sprite.bounds.size.x
					local var_174_14 = var_174_8.sprite.bounds.size.y
					local var_174_15 = var_174_12 / var_174_13
					local var_174_16 = var_174_11 / var_174_14
					local var_174_17 = var_174_16 < var_174_15 and var_174_15 or var_174_16

					var_174_7.transform.localScale = Vector3.New(var_174_17, var_174_17, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "STblack" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_18 = 0

			if var_174_18 < arg_171_1.time_ and arg_171_1.time_ <= var_174_18 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_19 = 1

			if var_174_18 <= arg_171_1.time_ and arg_171_1.time_ < var_174_18 + var_174_19 then
				local var_174_20 = (arg_171_1.time_ - var_174_18) / var_174_19
				local var_174_21 = Color.New(0, 0, 0)

				var_174_21.a = Mathf.Lerp(0, 1, var_174_20)
				arg_171_1.mask_.color = var_174_21
			end

			if arg_171_1.time_ >= var_174_18 + var_174_19 and arg_171_1.time_ < var_174_18 + var_174_19 + arg_174_0 then
				local var_174_22 = Color.New(0, 0, 0)

				var_174_22.a = 1
				arg_171_1.mask_.color = var_174_22
			end

			local var_174_23 = 1

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_24 = 2

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24
				local var_174_26 = Color.New(0, 0, 0)

				var_174_26.a = Mathf.Lerp(1, 0, var_174_25)
				arg_171_1.mask_.color = var_174_26
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 then
				local var_174_27 = Color.New(0, 0, 0)
				local var_174_28 = 0

				arg_171_1.mask_.enabled = false
				var_174_27.a = var_174_28
				arg_171_1.mask_.color = var_174_27
			end

			local var_174_29 = 2
			local var_174_30 = 1

			if var_174_29 < arg_171_1.time_ and arg_171_1.time_ <= var_174_29 + arg_174_0 then
				local var_174_31 = "play"
				local var_174_32 = "effect"

				arg_171_1:AudioAction(var_174_31, var_174_32, "se_story_140", "se_story_140_ui", "")
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 102,
				charCount = 0,
				enableLayoutChange = true,
				duration = 1,
				groupID = "10412",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 102,
				charCount = 0,
				enableLayoutChange = true,
				duration = 0,
				groupID = "1234",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161041,
				charCount = 15,
				enableLayoutChange = true,
				duration = 1,
				groupID = "1041",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play322161042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322161042
		arg_175_1.duration_ = 1.83

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322161043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			return
		end

		arg_175_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161042,
				charCount = 24,
				enableLayoutChange = true,
				duration = 1.6,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play322161043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322161043
		arg_179_1.duration_ = 1.83

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322161044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			return
		end

		arg_179_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161043,
				charCount = 21,
				enableLayoutChange = true,
				duration = 1.4,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play322161044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322161044
		arg_183_1.duration_ = 1.27

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322161045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			return
		end

		arg_183_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161044,
				charCount = 19,
				enableLayoutChange = true,
				duration = 1.26666666666667,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play322161045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322161045
		arg_187_1.duration_ = 3.03

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322161046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			return
		end

		arg_187_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161045,
				charCount = 40,
				enableLayoutChange = true,
				duration = 2.66666666666667,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play322161046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322161046
		arg_191_1.duration_ = 3.03

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322161047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			return
		end

		arg_191_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161046,
				charCount = 41,
				enableLayoutChange = true,
				duration = 2.73333333333333,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play322161047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322161047
		arg_195_1.duration_ = 1.67

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322161048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			return
		end

		arg_195_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161047,
				charCount = 16,
				enableLayoutChange = true,
				duration = 1.06666666666667,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play322161048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322161048
		arg_199_1.duration_ = 1

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322161049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			return
		end

		arg_199_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161048,
				charCount = 11,
				enableLayoutChange = true,
				duration = 0.733333333333333,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play322161049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322161049
		arg_203_1.duration_ = 1

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322161050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			return
		end

		arg_203_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161049,
				charCount = 13,
				enableLayoutChange = true,
				duration = 0.866666666666667,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play322161050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322161050
		arg_207_1.duration_ = 2.1

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play322161051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			return
		end

		arg_207_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161050,
				charCount = 22,
				enableLayoutChange = true,
				duration = 1.46666666666667,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play322161051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322161051
		arg_211_1.duration_ = 2.47

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play322161052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			return
		end

		arg_211_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322161051,
				charCount = 24,
				enableLayoutChange = true,
				duration = 1.6,
				groupID = "1041",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.ADD_TEXT,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play322161052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322161052
		arg_215_1.duration_ = 9

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play322161053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 4

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			local var_218_1 = 0.0750000000000002

			if arg_215_1.time_ >= var_218_0 + var_218_1 and arg_215_1.time_ < var_218_0 + var_218_1 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_2 = 2

			if var_218_2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				local var_218_3 = manager.ui.mainCamera.transform.localPosition
				local var_218_4 = Vector3.New(0, 0, 10) + Vector3.New(var_218_3.x, var_218_3.y, 0)
				local var_218_5 = arg_215_1.bgs_.ST0510

				var_218_5.transform.localPosition = var_218_4
				var_218_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_6 = var_218_5:GetComponent("SpriteRenderer")

				if var_218_6 and var_218_6.sprite then
					local var_218_7 = (var_218_5.transform.localPosition - var_218_3).z
					local var_218_8 = manager.ui.mainCameraCom_
					local var_218_9 = 2 * var_218_7 * Mathf.Tan(var_218_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_10 = var_218_9 * var_218_8.aspect
					local var_218_11 = var_218_6.sprite.bounds.size.x
					local var_218_12 = var_218_6.sprite.bounds.size.y
					local var_218_13 = var_218_10 / var_218_11
					local var_218_14 = var_218_9 / var_218_12
					local var_218_15 = var_218_14 < var_218_13 and var_218_13 or var_218_14

					var_218_5.transform.localScale = Vector3.New(var_218_15, var_218_15, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "ST0510" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_16 = 0

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_17 = 2

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_17 then
				local var_218_18 = (arg_215_1.time_ - var_218_16) / var_218_17
				local var_218_19 = Color.New(0, 0, 0)

				var_218_19.a = Mathf.Lerp(0, 1, var_218_18)
				arg_215_1.mask_.color = var_218_19
			end

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 then
				local var_218_20 = Color.New(0, 0, 0)

				var_218_20.a = 1
				arg_215_1.mask_.color = var_218_20
			end

			local var_218_21 = 2

			if var_218_21 < arg_215_1.time_ and arg_215_1.time_ <= var_218_21 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_22 = 2

			if var_218_21 <= arg_215_1.time_ and arg_215_1.time_ < var_218_21 + var_218_22 then
				local var_218_23 = (arg_215_1.time_ - var_218_21) / var_218_22
				local var_218_24 = Color.New(0, 0, 0)

				var_218_24.a = Mathf.Lerp(1, 0, var_218_23)
				arg_215_1.mask_.color = var_218_24
			end

			if arg_215_1.time_ >= var_218_21 + var_218_22 and arg_215_1.time_ < var_218_21 + var_218_22 + arg_218_0 then
				local var_218_25 = Color.New(0, 0, 0)
				local var_218_26 = 0

				arg_215_1.mask_.enabled = false
				var_218_25.a = var_218_26
				arg_215_1.mask_.color = var_218_25
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_27 = 4
			local var_218_28 = 0.075

			if var_218_27 < arg_215_1.time_ and arg_215_1.time_ <= var_218_27 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_29 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_29:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_30 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_31 = arg_215_1:GetWordFromCfg(322161052)
				local var_218_32 = arg_215_1:FormatText(var_218_31.content)

				arg_215_1.text_.text = var_218_32

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_33 = 3
				local var_218_34 = utf8.len(var_218_32)
				local var_218_35 = var_218_33 <= 0 and var_218_28 or var_218_28 * (var_218_34 / var_218_33)

				if var_218_35 > 0 and var_218_28 < var_218_35 then
					arg_215_1.talkMaxDuration = var_218_35
					var_218_27 = var_218_27 + 0.3

					if var_218_35 + var_218_27 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_35 + var_218_27
					end
				end

				arg_215_1.text_.text = var_218_32
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_36 = var_218_27 + 0.3
			local var_218_37 = math.max(var_218_28, arg_215_1.talkMaxDuration)

			if var_218_36 <= arg_215_1.time_ and arg_215_1.time_ < var_218_36 + var_218_37 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_36) / var_218_37

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_36 + var_218_37 and arg_215_1.time_ < var_218_36 + var_218_37 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				groupID = "1041",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1.98333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play322161053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322161053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322161054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1.125

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_2 = arg_221_1:GetWordFromCfg(322161053)
				local var_224_3 = arg_221_1:FormatText(var_224_2.content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 45
				local var_224_5 = utf8.len(var_224_3)
				local var_224_6 = var_224_4 <= 0 and var_224_1 or var_224_1 * (var_224_5 / var_224_4)

				if var_224_6 > 0 and var_224_1 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_7 and arg_221_1.time_ < var_224_0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play322161054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322161054
		arg_225_1.duration_ = 3.23

		local var_225_0 = {
			zh = 2.666,
			ja = 3.233
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
				arg_225_0:Play322161055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1211ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1211ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, -0.67, -6.07)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1211ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1211ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1211ui_story == nil then
				arg_225_1.var_.characterEffect1211ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1211ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1211ui_story then
				arg_225_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_228_15 = 0
			local var_228_16 = 0.275

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[37].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(322161054)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161054", "story_v_out_322161.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161054", "story_v_out_322161.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_out_322161", "322161054", "story_v_out_322161.awb")

						arg_225_1:RecordAudio("322161054", var_228_24)
						arg_225_1:RecordAudio("322161054", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_322161", "322161054", "story_v_out_322161.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_322161", "322161054", "story_v_out_322161.awb")
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
				actorName = "1211ui_story",
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
	Play322161055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322161055
		arg_229_1.duration_ = 4.33

		local var_229_0 = {
			zh = 3.333,
			ja = 4.333
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
				arg_229_0:Play322161056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1211ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1211ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(-0.7, -0.67, -6.07)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1211ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["1085ui_story"].transform
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.var_.moveOldPos1085ui_story = var_232_9.localPosition
			end

			local var_232_11 = 0.001

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11
				local var_232_13 = Vector3.New(0.75, -1.01, -5.83)

				var_232_9.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1085ui_story, var_232_13, var_232_12)

				local var_232_14 = manager.ui.mainCamera.transform.position - var_232_9.position

				var_232_9.forward = Vector3.New(var_232_14.x, var_232_14.y, var_232_14.z)

				local var_232_15 = var_232_9.localEulerAngles

				var_232_15.z = 0
				var_232_15.x = 0
				var_232_9.localEulerAngles = var_232_15
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 then
				var_232_9.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_232_16 = manager.ui.mainCamera.transform.position - var_232_9.position

				var_232_9.forward = Vector3.New(var_232_16.x, var_232_16.y, var_232_16.z)

				local var_232_17 = var_232_9.localEulerAngles

				var_232_17.z = 0
				var_232_17.x = 0
				var_232_9.localEulerAngles = var_232_17
			end

			local var_232_18 = arg_229_1.actors_["1085ui_story"]
			local var_232_19 = 0

			if var_232_19 < arg_229_1.time_ and arg_229_1.time_ <= var_232_19 + arg_232_0 and not isNil(var_232_18) and arg_229_1.var_.characterEffect1085ui_story == nil then
				arg_229_1.var_.characterEffect1085ui_story = var_232_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_20 = 0.200000002980232

			if var_232_19 <= arg_229_1.time_ and arg_229_1.time_ < var_232_19 + var_232_20 and not isNil(var_232_18) then
				local var_232_21 = (arg_229_1.time_ - var_232_19) / var_232_20

				if arg_229_1.var_.characterEffect1085ui_story and not isNil(var_232_18) then
					arg_229_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_19 + var_232_20 and arg_229_1.time_ < var_232_19 + var_232_20 + arg_232_0 and not isNil(var_232_18) and arg_229_1.var_.characterEffect1085ui_story then
				arg_229_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_232_22 = arg_229_1.actors_["1211ui_story"]
			local var_232_23 = 0

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 and not isNil(var_232_22) and arg_229_1.var_.characterEffect1211ui_story == nil then
				arg_229_1.var_.characterEffect1211ui_story = var_232_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_24 = 0.200000002980232

			if var_232_23 <= arg_229_1.time_ and arg_229_1.time_ < var_232_23 + var_232_24 and not isNil(var_232_22) then
				local var_232_25 = (arg_229_1.time_ - var_232_23) / var_232_24

				if arg_229_1.var_.characterEffect1211ui_story and not isNil(var_232_22) then
					local var_232_26 = Mathf.Lerp(0, 0.5, var_232_25)

					arg_229_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1211ui_story.fillRatio = var_232_26
				end
			end

			if arg_229_1.time_ >= var_232_23 + var_232_24 and arg_229_1.time_ < var_232_23 + var_232_24 + arg_232_0 and not isNil(var_232_22) and arg_229_1.var_.characterEffect1211ui_story then
				local var_232_27 = 0.5

				arg_229_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1211ui_story.fillRatio = var_232_27
			end

			local var_232_28 = 0

			if var_232_28 < arg_229_1.time_ and arg_229_1.time_ <= var_232_28 + arg_232_0 then
				arg_229_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_232_29 = 0

			if var_232_29 < arg_229_1.time_ and arg_229_1.time_ <= var_232_29 + arg_232_0 then
				arg_229_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_232_30 = 0
			local var_232_31 = 0.25

			if var_232_30 < arg_229_1.time_ and arg_229_1.time_ <= var_232_30 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_32 = arg_229_1:FormatText(StoryNameCfg[328].name)

				arg_229_1.leftNameTxt_.text = var_232_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_33 = arg_229_1:GetWordFromCfg(322161055)
				local var_232_34 = arg_229_1:FormatText(var_232_33.content)

				arg_229_1.text_.text = var_232_34

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_35 = 10
				local var_232_36 = utf8.len(var_232_34)
				local var_232_37 = var_232_35 <= 0 and var_232_31 or var_232_31 * (var_232_36 / var_232_35)

				if var_232_37 > 0 and var_232_31 < var_232_37 then
					arg_229_1.talkMaxDuration = var_232_37

					if var_232_37 + var_232_30 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_37 + var_232_30
					end
				end

				arg_229_1.text_.text = var_232_34
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161055", "story_v_out_322161.awb") ~= 0 then
					local var_232_38 = manager.audio:GetVoiceLength("story_v_out_322161", "322161055", "story_v_out_322161.awb") / 1000

					if var_232_38 + var_232_30 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_38 + var_232_30
					end

					if var_232_33.prefab_name ~= "" and arg_229_1.actors_[var_232_33.prefab_name] ~= nil then
						local var_232_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_33.prefab_name].transform, "story_v_out_322161", "322161055", "story_v_out_322161.awb")

						arg_229_1:RecordAudio("322161055", var_232_39)
						arg_229_1:RecordAudio("322161055", var_232_39)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322161", "322161055", "story_v_out_322161.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322161", "322161055", "story_v_out_322161.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_40 = math.max(var_232_31, arg_229_1.talkMaxDuration)

			if var_232_30 <= arg_229_1.time_ and arg_229_1.time_ < var_232_30 + var_232_40 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_30) / var_232_40

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_30 + var_232_40 and arg_229_1.time_ < var_232_30 + var_232_40 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
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
	Play322161056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322161056
		arg_233_1.duration_ = 4.13

		local var_233_0 = {
			zh = 3.7,
			ja = 4.133
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
				arg_233_0:Play322161057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1211ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1211ui_story == nil then
				arg_233_1.var_.characterEffect1211ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1211ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1211ui_story then
				arg_233_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_236_4 = arg_233_1.actors_["1085ui_story"]
			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1085ui_story == nil then
				arg_233_1.var_.characterEffect1085ui_story = var_236_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.200000002980232

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 and not isNil(var_236_4) then
				local var_236_7 = (arg_233_1.time_ - var_236_5) / var_236_6

				if arg_233_1.var_.characterEffect1085ui_story and not isNil(var_236_4) then
					local var_236_8 = Mathf.Lerp(0, 0.5, var_236_7)

					arg_233_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1085ui_story.fillRatio = var_236_8
				end
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1085ui_story then
				local var_236_9 = 0.5

				arg_233_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1085ui_story.fillRatio = var_236_9
			end

			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 then
				arg_233_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_2")
			end

			local var_236_11 = 0
			local var_236_12 = 0.4

			if var_236_11 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_13 = arg_233_1:FormatText(StoryNameCfg[37].name)

				arg_233_1.leftNameTxt_.text = var_236_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_14 = arg_233_1:GetWordFromCfg(322161056)
				local var_236_15 = arg_233_1:FormatText(var_236_14.content)

				arg_233_1.text_.text = var_236_15

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_16 = 16
				local var_236_17 = utf8.len(var_236_15)
				local var_236_18 = var_236_16 <= 0 and var_236_12 or var_236_12 * (var_236_17 / var_236_16)

				if var_236_18 > 0 and var_236_12 < var_236_18 then
					arg_233_1.talkMaxDuration = var_236_18

					if var_236_18 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_18 + var_236_11
					end
				end

				arg_233_1.text_.text = var_236_15
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161056", "story_v_out_322161.awb") ~= 0 then
					local var_236_19 = manager.audio:GetVoiceLength("story_v_out_322161", "322161056", "story_v_out_322161.awb") / 1000

					if var_236_19 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_19 + var_236_11
					end

					if var_236_14.prefab_name ~= "" and arg_233_1.actors_[var_236_14.prefab_name] ~= nil then
						local var_236_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_14.prefab_name].transform, "story_v_out_322161", "322161056", "story_v_out_322161.awb")

						arg_233_1:RecordAudio("322161056", var_236_20)
						arg_233_1:RecordAudio("322161056", var_236_20)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_322161", "322161056", "story_v_out_322161.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_322161", "322161056", "story_v_out_322161.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_21 = math.max(var_236_12, arg_233_1.talkMaxDuration)

			if var_236_11 <= arg_233_1.time_ and arg_233_1.time_ < var_236_11 + var_236_21 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_11) / var_236_21

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_11 + var_236_21 and arg_233_1.time_ < var_236_11 + var_236_21 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play322161057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322161057
		arg_237_1.duration_ = 12.93

		local var_237_0 = {
			zh = 8.333,
			ja = 12.933
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
				arg_237_0:Play322161058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1085ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1085ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0, 100, 0)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1085ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, 100, 0)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["10104ui_story"].transform
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1.var_.moveOldPos10104ui_story = var_240_9.localPosition
			end

			local var_240_11 = 0.001

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11
				local var_240_13 = Vector3.New(0.99, -1.12, -5.99)

				var_240_9.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10104ui_story, var_240_13, var_240_12)

				local var_240_14 = manager.ui.mainCamera.transform.position - var_240_9.position

				var_240_9.forward = Vector3.New(var_240_14.x, var_240_14.y, var_240_14.z)

				local var_240_15 = var_240_9.localEulerAngles

				var_240_15.z = 0
				var_240_15.x = 0
				var_240_9.localEulerAngles = var_240_15
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 then
				var_240_9.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_240_16 = manager.ui.mainCamera.transform.position - var_240_9.position

				var_240_9.forward = Vector3.New(var_240_16.x, var_240_16.y, var_240_16.z)

				local var_240_17 = var_240_9.localEulerAngles

				var_240_17.z = 0
				var_240_17.x = 0
				var_240_9.localEulerAngles = var_240_17
			end

			local var_240_18 = arg_237_1.actors_["10104ui_story"]
			local var_240_19 = 0

			if var_240_19 < arg_237_1.time_ and arg_237_1.time_ <= var_240_19 + arg_240_0 and not isNil(var_240_18) and arg_237_1.var_.characterEffect10104ui_story == nil then
				arg_237_1.var_.characterEffect10104ui_story = var_240_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_20 = 0.200000002980232

			if var_240_19 <= arg_237_1.time_ and arg_237_1.time_ < var_240_19 + var_240_20 and not isNil(var_240_18) then
				local var_240_21 = (arg_237_1.time_ - var_240_19) / var_240_20

				if arg_237_1.var_.characterEffect10104ui_story and not isNil(var_240_18) then
					arg_237_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_19 + var_240_20 and arg_237_1.time_ < var_240_19 + var_240_20 + arg_240_0 and not isNil(var_240_18) and arg_237_1.var_.characterEffect10104ui_story then
				arg_237_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_240_22 = arg_237_1.actors_["1211ui_story"]
			local var_240_23 = 0

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.characterEffect1211ui_story == nil then
				arg_237_1.var_.characterEffect1211ui_story = var_240_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_24 = 0.200000002980232

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 and not isNil(var_240_22) then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24

				if arg_237_1.var_.characterEffect1211ui_story and not isNil(var_240_22) then
					local var_240_26 = Mathf.Lerp(0, 0.5, var_240_25)

					arg_237_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1211ui_story.fillRatio = var_240_26
				end
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.characterEffect1211ui_story then
				local var_240_27 = 0.5

				arg_237_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1211ui_story.fillRatio = var_240_27
			end

			local var_240_28 = 0

			if var_240_28 < arg_237_1.time_ and arg_237_1.time_ <= var_240_28 + arg_240_0 then
				arg_237_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_240_29 = 0

			if var_240_29 < arg_237_1.time_ and arg_237_1.time_ <= var_240_29 + arg_240_0 then
				arg_237_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_240_30 = 0
			local var_240_31 = 1.05

			if var_240_30 < arg_237_1.time_ and arg_237_1.time_ <= var_240_30 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_32 = arg_237_1:FormatText(StoryNameCfg[1030].name)

				arg_237_1.leftNameTxt_.text = var_240_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_33 = arg_237_1:GetWordFromCfg(322161057)
				local var_240_34 = arg_237_1:FormatText(var_240_33.content)

				arg_237_1.text_.text = var_240_34

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_35 = 42
				local var_240_36 = utf8.len(var_240_34)
				local var_240_37 = var_240_35 <= 0 and var_240_31 or var_240_31 * (var_240_36 / var_240_35)

				if var_240_37 > 0 and var_240_31 < var_240_37 then
					arg_237_1.talkMaxDuration = var_240_37

					if var_240_37 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_37 + var_240_30
					end
				end

				arg_237_1.text_.text = var_240_34
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161057", "story_v_out_322161.awb") ~= 0 then
					local var_240_38 = manager.audio:GetVoiceLength("story_v_out_322161", "322161057", "story_v_out_322161.awb") / 1000

					if var_240_38 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_38 + var_240_30
					end

					if var_240_33.prefab_name ~= "" and arg_237_1.actors_[var_240_33.prefab_name] ~= nil then
						local var_240_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_33.prefab_name].transform, "story_v_out_322161", "322161057", "story_v_out_322161.awb")

						arg_237_1:RecordAudio("322161057", var_240_39)
						arg_237_1:RecordAudio("322161057", var_240_39)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_322161", "322161057", "story_v_out_322161.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_322161", "322161057", "story_v_out_322161.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_40 = math.max(var_240_31, arg_237_1.talkMaxDuration)

			if var_240_30 <= arg_237_1.time_ and arg_237_1.time_ < var_240_30 + var_240_40 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_30) / var_240_40

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_30 + var_240_40 and arg_237_1.time_ < var_240_30 + var_240_40 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play322161058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322161058
		arg_241_1.duration_ = 3.93

		local var_241_0 = {
			zh = 2.9,
			ja = 3.933
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
				arg_241_0:Play322161059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10102ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos10102ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10102ui_story, var_244_4, var_244_3)

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

			local var_244_9 = arg_241_1.actors_["10102ui_story"].transform
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.var_.moveOldPos10102ui_story = var_244_9.localPosition
			end

			local var_244_11 = 0.001

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11
				local var_244_13 = Vector3.New(-0.7, -0.985, -6.275)

				var_244_9.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10102ui_story, var_244_13, var_244_12)

				local var_244_14 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_14.x, var_244_14.y, var_244_14.z)

				local var_244_15 = var_244_9.localEulerAngles

				var_244_15.z = 0
				var_244_15.x = 0
				var_244_9.localEulerAngles = var_244_15
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 then
				var_244_9.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_244_16 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_16.x, var_244_16.y, var_244_16.z)

				local var_244_17 = var_244_9.localEulerAngles

				var_244_17.z = 0
				var_244_17.x = 0
				var_244_9.localEulerAngles = var_244_17
			end

			local var_244_18 = arg_241_1.actors_["1211ui_story"].transform
			local var_244_19 = 0

			if var_244_19 < arg_241_1.time_ and arg_241_1.time_ <= var_244_19 + arg_244_0 then
				arg_241_1.var_.moveOldPos1211ui_story = var_244_18.localPosition
			end

			local var_244_20 = 0.001

			if var_244_19 <= arg_241_1.time_ and arg_241_1.time_ < var_244_19 + var_244_20 then
				local var_244_21 = (arg_241_1.time_ - var_244_19) / var_244_20
				local var_244_22 = Vector3.New(0, 100, 0)

				var_244_18.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1211ui_story, var_244_22, var_244_21)

				local var_244_23 = manager.ui.mainCamera.transform.position - var_244_18.position

				var_244_18.forward = Vector3.New(var_244_23.x, var_244_23.y, var_244_23.z)

				local var_244_24 = var_244_18.localEulerAngles

				var_244_24.z = 0
				var_244_24.x = 0
				var_244_18.localEulerAngles = var_244_24
			end

			if arg_241_1.time_ >= var_244_19 + var_244_20 and arg_241_1.time_ < var_244_19 + var_244_20 + arg_244_0 then
				var_244_18.localPosition = Vector3.New(0, 100, 0)

				local var_244_25 = manager.ui.mainCamera.transform.position - var_244_18.position

				var_244_18.forward = Vector3.New(var_244_25.x, var_244_25.y, var_244_25.z)

				local var_244_26 = var_244_18.localEulerAngles

				var_244_26.z = 0
				var_244_26.x = 0
				var_244_18.localEulerAngles = var_244_26
			end

			local var_244_27 = 0

			if var_244_27 < arg_241_1.time_ and arg_241_1.time_ <= var_244_27 + arg_244_0 then
				arg_241_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_244_28 = arg_241_1.actors_["10104ui_story"]
			local var_244_29 = 0

			if var_244_29 < arg_241_1.time_ and arg_241_1.time_ <= var_244_29 + arg_244_0 and not isNil(var_244_28) and arg_241_1.var_.characterEffect10104ui_story == nil then
				arg_241_1.var_.characterEffect10104ui_story = var_244_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_30 = 0.2

			if var_244_29 <= arg_241_1.time_ and arg_241_1.time_ < var_244_29 + var_244_30 and not isNil(var_244_28) then
				local var_244_31 = (arg_241_1.time_ - var_244_29) / var_244_30

				if arg_241_1.var_.characterEffect10104ui_story and not isNil(var_244_28) then
					local var_244_32 = Mathf.Lerp(0, 0.5, var_244_31)

					arg_241_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10104ui_story.fillRatio = var_244_32
				end
			end

			if arg_241_1.time_ >= var_244_29 + var_244_30 and arg_241_1.time_ < var_244_29 + var_244_30 + arg_244_0 and not isNil(var_244_28) and arg_241_1.var_.characterEffect10104ui_story then
				local var_244_33 = 0.5

				arg_241_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10104ui_story.fillRatio = var_244_33
			end

			local var_244_34 = arg_241_1.actors_["10102ui_story"]
			local var_244_35 = 0

			if var_244_35 < arg_241_1.time_ and arg_241_1.time_ <= var_244_35 + arg_244_0 and not isNil(var_244_34) and arg_241_1.var_.characterEffect10102ui_story == nil then
				arg_241_1.var_.characterEffect10102ui_story = var_244_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_36 = 0.2

			if var_244_35 <= arg_241_1.time_ and arg_241_1.time_ < var_244_35 + var_244_36 and not isNil(var_244_34) then
				local var_244_37 = (arg_241_1.time_ - var_244_35) / var_244_36

				if arg_241_1.var_.characterEffect10102ui_story and not isNil(var_244_34) then
					arg_241_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_35 + var_244_36 and arg_241_1.time_ < var_244_35 + var_244_36 + arg_244_0 and not isNil(var_244_34) and arg_241_1.var_.characterEffect10102ui_story then
				arg_241_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_244_38 = 0
			local var_244_39 = 0.275

			if var_244_38 < arg_241_1.time_ and arg_241_1.time_ <= var_244_38 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_40 = arg_241_1:FormatText(StoryNameCfg[6].name)

				arg_241_1.leftNameTxt_.text = var_244_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_41 = arg_241_1:GetWordFromCfg(322161058)
				local var_244_42 = arg_241_1:FormatText(var_244_41.content)

				arg_241_1.text_.text = var_244_42

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_43 = 11
				local var_244_44 = utf8.len(var_244_42)
				local var_244_45 = var_244_43 <= 0 and var_244_39 or var_244_39 * (var_244_44 / var_244_43)

				if var_244_45 > 0 and var_244_39 < var_244_45 then
					arg_241_1.talkMaxDuration = var_244_45

					if var_244_45 + var_244_38 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_45 + var_244_38
					end
				end

				arg_241_1.text_.text = var_244_42
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161058", "story_v_out_322161.awb") ~= 0 then
					local var_244_46 = manager.audio:GetVoiceLength("story_v_out_322161", "322161058", "story_v_out_322161.awb") / 1000

					if var_244_46 + var_244_38 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_46 + var_244_38
					end

					if var_244_41.prefab_name ~= "" and arg_241_1.actors_[var_244_41.prefab_name] ~= nil then
						local var_244_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_41.prefab_name].transform, "story_v_out_322161", "322161058", "story_v_out_322161.awb")

						arg_241_1:RecordAudio("322161058", var_244_47)
						arg_241_1:RecordAudio("322161058", var_244_47)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_322161", "322161058", "story_v_out_322161.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_322161", "322161058", "story_v_out_322161.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_48 = math.max(var_244_39, arg_241_1.talkMaxDuration)

			if var_244_38 <= arg_241_1.time_ and arg_241_1.time_ < var_244_38 + var_244_48 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_38) / var_244_48

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_38 + var_244_48 and arg_241_1.time_ < var_244_38 + var_244_48 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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
				actorName = "1211ui_story",
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
	Play322161059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322161059
		arg_245_1.duration_ = 1.97

		local var_245_0 = {
			zh = 1.6,
			ja = 1.966
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
				arg_245_0:Play322161060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10102ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos10102ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0, 100, 0)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10102ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0, 100, 0)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["10104ui_story"].transform
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1.var_.moveOldPos10104ui_story = var_248_9.localPosition
			end

			local var_248_11 = 0.001

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11
				local var_248_13 = Vector3.New(0, 100, 0)

				var_248_9.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10104ui_story, var_248_13, var_248_12)

				local var_248_14 = manager.ui.mainCamera.transform.position - var_248_9.position

				var_248_9.forward = Vector3.New(var_248_14.x, var_248_14.y, var_248_14.z)

				local var_248_15 = var_248_9.localEulerAngles

				var_248_15.z = 0
				var_248_15.x = 0
				var_248_9.localEulerAngles = var_248_15
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 then
				var_248_9.localPosition = Vector3.New(0, 100, 0)

				local var_248_16 = manager.ui.mainCamera.transform.position - var_248_9.position

				var_248_9.forward = Vector3.New(var_248_16.x, var_248_16.y, var_248_16.z)

				local var_248_17 = var_248_9.localEulerAngles

				var_248_17.z = 0
				var_248_17.x = 0
				var_248_9.localEulerAngles = var_248_17
			end

			local var_248_18 = 0
			local var_248_19 = 0.225

			if var_248_18 < arg_245_1.time_ and arg_245_1.time_ <= var_248_18 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_20 = arg_245_1:FormatText(StoryNameCfg[1137].name)

				arg_245_1.leftNameTxt_.text = var_248_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_21 = arg_245_1:GetWordFromCfg(322161059)
				local var_248_22 = arg_245_1:FormatText(var_248_21.content)

				arg_245_1.text_.text = var_248_22

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_23 = 9
				local var_248_24 = utf8.len(var_248_22)
				local var_248_25 = var_248_23 <= 0 and var_248_19 or var_248_19 * (var_248_24 / var_248_23)

				if var_248_25 > 0 and var_248_19 < var_248_25 then
					arg_245_1.talkMaxDuration = var_248_25

					if var_248_25 + var_248_18 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_25 + var_248_18
					end
				end

				arg_245_1.text_.text = var_248_22
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161059", "story_v_out_322161.awb") ~= 0 then
					local var_248_26 = manager.audio:GetVoiceLength("story_v_out_322161", "322161059", "story_v_out_322161.awb") / 1000

					if var_248_26 + var_248_18 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_26 + var_248_18
					end

					if var_248_21.prefab_name ~= "" and arg_245_1.actors_[var_248_21.prefab_name] ~= nil then
						local var_248_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_21.prefab_name].transform, "story_v_out_322161", "322161059", "story_v_out_322161.awb")

						arg_245_1:RecordAudio("322161059", var_248_27)
						arg_245_1:RecordAudio("322161059", var_248_27)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_322161", "322161059", "story_v_out_322161.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_322161", "322161059", "story_v_out_322161.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_28 = math.max(var_248_19, arg_245_1.talkMaxDuration)

			if var_248_18 <= arg_245_1.time_ and arg_245_1.time_ < var_248_18 + var_248_28 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_18) / var_248_28

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_18 + var_248_28 and arg_245_1.time_ < var_248_18 + var_248_28 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
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
	Play322161060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322161060
		arg_249_1.duration_ = 3.9

		local var_249_0 = {
			zh = 3.766,
			ja = 3.9
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
				arg_249_0:Play322161061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["404001ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos404001ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0, -1.55, -5.5)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos404001ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["404001ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect404001ui_story == nil then
				arg_249_1.var_.characterEffect404001ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect404001ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect404001ui_story then
				arg_249_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_252_13 = 0

			if var_252_13 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 then
				arg_249_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_252_15 = 0
			local var_252_16 = 0.425

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_17 = arg_249_1:FormatText(StoryNameCfg[668].name)

				arg_249_1.leftNameTxt_.text = var_252_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:GetWordFromCfg(322161060)
				local var_252_19 = arg_249_1:FormatText(var_252_18.content)

				arg_249_1.text_.text = var_252_19

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 17
				local var_252_21 = utf8.len(var_252_19)
				local var_252_22 = var_252_20 <= 0 and var_252_16 or var_252_16 * (var_252_21 / var_252_20)

				if var_252_22 > 0 and var_252_16 < var_252_22 then
					arg_249_1.talkMaxDuration = var_252_22

					if var_252_22 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_22 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_19
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161060", "story_v_out_322161.awb") ~= 0 then
					local var_252_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161060", "story_v_out_322161.awb") / 1000

					if var_252_23 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_15
					end

					if var_252_18.prefab_name ~= "" and arg_249_1.actors_[var_252_18.prefab_name] ~= nil then
						local var_252_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_18.prefab_name].transform, "story_v_out_322161", "322161060", "story_v_out_322161.awb")

						arg_249_1:RecordAudio("322161060", var_252_24)
						arg_249_1:RecordAudio("322161060", var_252_24)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322161", "322161060", "story_v_out_322161.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322161", "322161060", "story_v_out_322161.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_25 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_25 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_15) / var_252_25

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_15 + var_252_25 and arg_249_1.time_ < var_252_15 + var_252_25 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play322161061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322161061
		arg_253_1.duration_ = 4.83

		local var_253_0 = {
			zh = 4.7,
			ja = 4.833
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
				arg_253_0:Play322161062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["404001ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos404001ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0, 100, 0)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos404001ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, 100, 0)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = 0
			local var_256_10 = 0.475

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_11 = arg_253_1:FormatText(StoryNameCfg[1137].name)

				arg_253_1.leftNameTxt_.text = var_256_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_12 = arg_253_1:GetWordFromCfg(322161061)
				local var_256_13 = arg_253_1:FormatText(var_256_12.content)

				arg_253_1.text_.text = var_256_13

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_14 = 19
				local var_256_15 = utf8.len(var_256_13)
				local var_256_16 = var_256_14 <= 0 and var_256_10 or var_256_10 * (var_256_15 / var_256_14)

				if var_256_16 > 0 and var_256_10 < var_256_16 then
					arg_253_1.talkMaxDuration = var_256_16

					if var_256_16 + var_256_9 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_9
					end
				end

				arg_253_1.text_.text = var_256_13
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161061", "story_v_out_322161.awb") ~= 0 then
					local var_256_17 = manager.audio:GetVoiceLength("story_v_out_322161", "322161061", "story_v_out_322161.awb") / 1000

					if var_256_17 + var_256_9 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_17 + var_256_9
					end

					if var_256_12.prefab_name ~= "" and arg_253_1.actors_[var_256_12.prefab_name] ~= nil then
						local var_256_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_12.prefab_name].transform, "story_v_out_322161", "322161061", "story_v_out_322161.awb")

						arg_253_1:RecordAudio("322161061", var_256_18)
						arg_253_1:RecordAudio("322161061", var_256_18)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322161", "322161061", "story_v_out_322161.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322161", "322161061", "story_v_out_322161.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_19 = math.max(var_256_10, arg_253_1.talkMaxDuration)

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_19 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_9) / var_256_19

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_9 + var_256_19 and arg_253_1.time_ < var_256_9 + var_256_19 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play322161062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322161062
		arg_257_1.duration_ = 11.9

		local var_257_0 = {
			zh = 7.2,
			ja = 11.9
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322161063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.975

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[1137].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(322161062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 39
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161062", "story_v_out_322161.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161062", "story_v_out_322161.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_322161", "322161062", "story_v_out_322161.awb")

						arg_257_1:RecordAudio("322161062", var_260_9)
						arg_257_1:RecordAudio("322161062", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322161", "322161062", "story_v_out_322161.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322161", "322161062", "story_v_out_322161.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play322161063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322161063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322161064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.1
			local var_264_1 = 1

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				local var_264_2 = "play"
				local var_264_3 = "effect"

				arg_261_1:AudioAction(var_264_2, var_264_3, "se_story_145", "se_story_145_footstep02", "")
			end

			local var_264_4 = 0
			local var_264_5 = 0.55

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(322161063)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_8 = 22
				local var_264_9 = utf8.len(var_264_7)
				local var_264_10 = var_264_8 <= 0 and var_264_5 or var_264_5 * (var_264_9 / var_264_8)

				if var_264_10 > 0 and var_264_5 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_11 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_11 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_11

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_11 and arg_261_1.time_ < var_264_4 + var_264_11 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322161064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322161064
		arg_265_1.duration_ = 8.07

		local var_265_0 = {
			zh = 6.433,
			ja = 8.066
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322161065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 1.05

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[1137].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(322161064)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 42
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161064", "story_v_out_322161.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161064", "story_v_out_322161.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_322161", "322161064", "story_v_out_322161.awb")

						arg_265_1:RecordAudio("322161064", var_268_9)
						arg_265_1:RecordAudio("322161064", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322161", "322161064", "story_v_out_322161.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322161", "322161064", "story_v_out_322161.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_10 and arg_265_1.time_ < var_268_0 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322161065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322161065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322161066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.275

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(322161065)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 11
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_8 and arg_269_1.time_ < var_272_0 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322161066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322161066
		arg_273_1.duration_ = 9.93

		local var_273_0 = {
			zh = 5.8,
			ja = 9.933
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
				arg_273_0:Play322161067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.775

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[1137].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(322161066)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 31
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161066", "story_v_out_322161.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161066", "story_v_out_322161.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_322161", "322161066", "story_v_out_322161.awb")

						arg_273_1:RecordAudio("322161066", var_276_9)
						arg_273_1:RecordAudio("322161066", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322161", "322161066", "story_v_out_322161.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322161", "322161066", "story_v_out_322161.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322161067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322161067
		arg_277_1.duration_ = 5.23

		local var_277_0 = {
			zh = 3.566,
			ja = 5.233
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
				arg_277_0:Play322161068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.425

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[1137].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(322161067)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 17
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161067", "story_v_out_322161.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161067", "story_v_out_322161.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_322161", "322161067", "story_v_out_322161.awb")

						arg_277_1:RecordAudio("322161067", var_280_9)
						arg_277_1:RecordAudio("322161067", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322161", "322161067", "story_v_out_322161.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322161", "322161067", "story_v_out_322161.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322161068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322161068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322161069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.7

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(322161068)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 28
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322161069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322161069
		arg_285_1.duration_ = 2.1

		local var_285_0 = {
			zh = 1.666,
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
				arg_285_0:Play322161070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.3

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				local var_288_2 = "play"
				local var_288_3 = "music"

				arg_285_1:AudioAction(var_288_2, var_288_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_288_4 = ""
				local var_288_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_288_5 ~= "" then
					if arg_285_1.bgmTxt_.text ~= var_288_5 and arg_285_1.bgmTxt_.text ~= "" then
						if arg_285_1.bgmTxt2_.text ~= "" then
							arg_285_1.bgmTxt_.text = arg_285_1.bgmTxt2_.text
						end

						arg_285_1.bgmTxt2_.text = var_288_5

						arg_285_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_285_1.bgmTxt_.text = var_288_5
						arg_285_1.bgmTxt2_.text = var_288_5
					end

					if arg_285_1.bgmTimer then
						arg_285_1.bgmTimer:Stop()

						arg_285_1.bgmTimer = nil
					end

					if arg_285_1.settingData.show_music_name == 1 then
						arg_285_1.musicController:SetSelectedState("show")
						arg_285_1.musicAnimator_:Play("open", 0, 0)

						if arg_285_1.settingData.music_time ~= 0 then
							arg_285_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_285_1.settingData.music_time), function()
								if arg_285_1 == nil or isNil(arg_285_1.bgmTxt_) then
									return
								end

								arg_285_1.musicController:SetSelectedState("hide")
								arg_285_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_288_6 = 0
			local var_288_7 = 0.125

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[36].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1044")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_9 = arg_285_1:GetWordFromCfg(322161069)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 5
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161069", "story_v_out_322161.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_322161", "322161069", "story_v_out_322161.awb") / 1000

					if var_288_14 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_6
					end

					if var_288_9.prefab_name ~= "" and arg_285_1.actors_[var_288_9.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_9.prefab_name].transform, "story_v_out_322161", "322161069", "story_v_out_322161.awb")

						arg_285_1:RecordAudio("322161069", var_288_15)
						arg_285_1:RecordAudio("322161069", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322161", "322161069", "story_v_out_322161.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322161", "322161069", "story_v_out_322161.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_16 and arg_285_1.time_ < var_288_6 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322161070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 322161070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play322161071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 1.725

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(322161070)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 67
				local var_293_5 = utf8.len(var_293_3)
				local var_293_6 = var_293_4 <= 0 and var_293_1 or var_293_1 * (var_293_5 / var_293_4)

				if var_293_6 > 0 and var_293_1 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_7 and arg_290_1.time_ < var_293_0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play322161071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 322161071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play322161072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 1.05

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

				local var_297_2 = arg_294_1:GetWordFromCfg(322161071)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 42
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
	Play322161072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 322161072
		arg_298_1.duration_ = 8.67

		local var_298_0 = {
			zh = 6.033,
			ja = 8.666
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play322161073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.725

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[36].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1044")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:GetWordFromCfg(322161072)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 29
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161072", "story_v_out_322161.awb") ~= 0 then
					local var_301_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161072", "story_v_out_322161.awb") / 1000

					if var_301_8 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_0
					end

					if var_301_3.prefab_name ~= "" and arg_298_1.actors_[var_301_3.prefab_name] ~= nil then
						local var_301_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_3.prefab_name].transform, "story_v_out_322161", "322161072", "story_v_out_322161.awb")

						arg_298_1:RecordAudio("322161072", var_301_9)
						arg_298_1:RecordAudio("322161072", var_301_9)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_322161", "322161072", "story_v_out_322161.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_322161", "322161072", "story_v_out_322161.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_10 and arg_298_1.time_ < var_301_0 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play322161073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 322161073
		arg_302_1.duration_ = 2.57

		local var_302_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_302_0:Play322161074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1211ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1211ui_story = var_305_0.localPosition

				local var_305_2 = "1211ui_story"

				arg_302_1:ShowWeapon(arg_302_1.var_[var_305_2 .. "Animator"].transform, false)
			end

			local var_305_3 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_3 then
				local var_305_4 = (arg_302_1.time_ - var_305_1) / var_305_3
				local var_305_5 = Vector3.New(0, -0.67, -6.07)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1211ui_story, var_305_5, var_305_4)

				local var_305_6 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_6.x, var_305_6.y, var_305_6.z)

				local var_305_7 = var_305_0.localEulerAngles

				var_305_7.z = 0
				var_305_7.x = 0
				var_305_0.localEulerAngles = var_305_7
			end

			if arg_302_1.time_ >= var_305_1 + var_305_3 and arg_302_1.time_ < var_305_1 + var_305_3 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_305_8 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_8.x, var_305_8.y, var_305_8.z)

				local var_305_9 = var_305_0.localEulerAngles

				var_305_9.z = 0
				var_305_9.x = 0
				var_305_0.localEulerAngles = var_305_9
			end

			local var_305_10 = arg_302_1.actors_["1211ui_story"]
			local var_305_11 = 0

			if var_305_11 < arg_302_1.time_ and arg_302_1.time_ <= var_305_11 + arg_305_0 and not isNil(var_305_10) and arg_302_1.var_.characterEffect1211ui_story == nil then
				arg_302_1.var_.characterEffect1211ui_story = var_305_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_12 = 0.200000002980232

			if var_305_11 <= arg_302_1.time_ and arg_302_1.time_ < var_305_11 + var_305_12 and not isNil(var_305_10) then
				local var_305_13 = (arg_302_1.time_ - var_305_11) / var_305_12

				if arg_302_1.var_.characterEffect1211ui_story and not isNil(var_305_10) then
					arg_302_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_11 + var_305_12 and arg_302_1.time_ < var_305_11 + var_305_12 + arg_305_0 and not isNil(var_305_10) and arg_302_1.var_.characterEffect1211ui_story then
				arg_302_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_1")
			end

			local var_305_15 = 0

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_305_16 = 0
			local var_305_17 = 0.15

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_18 = arg_302_1:FormatText(StoryNameCfg[37].name)

				arg_302_1.leftNameTxt_.text = var_305_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_19 = arg_302_1:GetWordFromCfg(322161073)
				local var_305_20 = arg_302_1:FormatText(var_305_19.content)

				arg_302_1.text_.text = var_305_20

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_21 = 6
				local var_305_22 = utf8.len(var_305_20)
				local var_305_23 = var_305_21 <= 0 and var_305_17 or var_305_17 * (var_305_22 / var_305_21)

				if var_305_23 > 0 and var_305_17 < var_305_23 then
					arg_302_1.talkMaxDuration = var_305_23

					if var_305_23 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_16
					end
				end

				arg_302_1.text_.text = var_305_20
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161073", "story_v_out_322161.awb") ~= 0 then
					local var_305_24 = manager.audio:GetVoiceLength("story_v_out_322161", "322161073", "story_v_out_322161.awb") / 1000

					if var_305_24 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_24 + var_305_16
					end

					if var_305_19.prefab_name ~= "" and arg_302_1.actors_[var_305_19.prefab_name] ~= nil then
						local var_305_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_19.prefab_name].transform, "story_v_out_322161", "322161073", "story_v_out_322161.awb")

						arg_302_1:RecordAudio("322161073", var_305_25)
						arg_302_1:RecordAudio("322161073", var_305_25)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_322161", "322161073", "story_v_out_322161.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_322161", "322161073", "story_v_out_322161.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_26 = math.max(var_305_17, arg_302_1.talkMaxDuration)

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_26 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_16) / var_305_26

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_16 + var_305_26 and arg_302_1.time_ < var_305_16 + var_305_26 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	Play322161074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 322161074
		arg_306_1.duration_ = 4.83

		local var_306_0 = {
			zh = 4.466,
			ja = 4.833
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
				arg_306_0:Play322161075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1211ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1211ui_story = var_309_0.localPosition

				local var_309_2 = "1211ui_story"

				arg_306_1:ShowWeapon(arg_306_1.var_[var_309_2 .. "Animator"].transform, false)
			end

			local var_309_3 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_3 then
				local var_309_4 = (arg_306_1.time_ - var_309_1) / var_309_3
				local var_309_5 = Vector3.New(0, 100, 0)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1211ui_story, var_309_5, var_309_4)

				local var_309_6 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_6.x, var_309_6.y, var_309_6.z)

				local var_309_7 = var_309_0.localEulerAngles

				var_309_7.z = 0
				var_309_7.x = 0
				var_309_0.localEulerAngles = var_309_7
			end

			if arg_306_1.time_ >= var_309_1 + var_309_3 and arg_306_1.time_ < var_309_1 + var_309_3 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, 100, 0)

				local var_309_8 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_8.x, var_309_8.y, var_309_8.z)

				local var_309_9 = var_309_0.localEulerAngles

				var_309_9.z = 0
				var_309_9.x = 0
				var_309_0.localEulerAngles = var_309_9
			end

			local var_309_10 = 0
			local var_309_11 = 0.45

			if var_309_10 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_12 = arg_306_1:FormatText(StoryNameCfg[36].name)

				arg_306_1.leftNameTxt_.text = var_309_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1044")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_13 = arg_306_1:GetWordFromCfg(322161074)
				local var_309_14 = arg_306_1:FormatText(var_309_13.content)

				arg_306_1.text_.text = var_309_14

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_15 = 18
				local var_309_16 = utf8.len(var_309_14)
				local var_309_17 = var_309_15 <= 0 and var_309_11 or var_309_11 * (var_309_16 / var_309_15)

				if var_309_17 > 0 and var_309_11 < var_309_17 then
					arg_306_1.talkMaxDuration = var_309_17

					if var_309_17 + var_309_10 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_17 + var_309_10
					end
				end

				arg_306_1.text_.text = var_309_14
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161074", "story_v_out_322161.awb") ~= 0 then
					local var_309_18 = manager.audio:GetVoiceLength("story_v_out_322161", "322161074", "story_v_out_322161.awb") / 1000

					if var_309_18 + var_309_10 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_18 + var_309_10
					end

					if var_309_13.prefab_name ~= "" and arg_306_1.actors_[var_309_13.prefab_name] ~= nil then
						local var_309_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_13.prefab_name].transform, "story_v_out_322161", "322161074", "story_v_out_322161.awb")

						arg_306_1:RecordAudio("322161074", var_309_19)
						arg_306_1:RecordAudio("322161074", var_309_19)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_322161", "322161074", "story_v_out_322161.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_322161", "322161074", "story_v_out_322161.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_20 = math.max(var_309_11, arg_306_1.talkMaxDuration)

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_20 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_10) / var_309_20

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_10 + var_309_20 and arg_306_1.time_ < var_309_10 + var_309_20 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
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

		arg_306_1:InitPlayNodeList()
	end,
	Play322161075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 322161075
		arg_310_1.duration_ = 9

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play322161076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 4

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			local var_313_1 = 0.3

			if arg_310_1.time_ >= var_313_0 + var_313_1 and arg_310_1.time_ < var_313_0 + var_313_1 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end

			local var_313_2 = "MS2210"

			if arg_310_1.bgs_[var_313_2] == nil then
				local var_313_3 = Object.Instantiate(arg_310_1.paintGo_)

				var_313_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_313_2)
				var_313_3.name = var_313_2
				var_313_3.transform.parent = arg_310_1.stage_.transform
				var_313_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.bgs_[var_313_2] = var_313_3
			end

			local var_313_4 = 2

			if var_313_4 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				local var_313_5 = manager.ui.mainCamera.transform.localPosition
				local var_313_6 = Vector3.New(0, 0, 10) + Vector3.New(var_313_5.x, var_313_5.y, 0)
				local var_313_7 = arg_310_1.bgs_.MS2210

				var_313_7.transform.localPosition = var_313_6
				var_313_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_8 = var_313_7:GetComponent("SpriteRenderer")

				if var_313_8 and var_313_8.sprite then
					local var_313_9 = (var_313_7.transform.localPosition - var_313_5).z
					local var_313_10 = manager.ui.mainCameraCom_
					local var_313_11 = 2 * var_313_9 * Mathf.Tan(var_313_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_313_12 = var_313_11 * var_313_10.aspect
					local var_313_13 = var_313_8.sprite.bounds.size.x
					local var_313_14 = var_313_8.sprite.bounds.size.y
					local var_313_15 = var_313_12 / var_313_13
					local var_313_16 = var_313_11 / var_313_14
					local var_313_17 = var_313_16 < var_313_15 and var_313_15 or var_313_16

					var_313_7.transform.localScale = Vector3.New(var_313_17, var_313_17, 0)
				end

				for iter_313_0, iter_313_1 in pairs(arg_310_1.bgs_) do
					if iter_313_0 ~= "MS2210" then
						iter_313_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_313_18 = 0

			if var_313_18 < arg_310_1.time_ and arg_310_1.time_ <= var_313_18 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_19 = 2

			if var_313_18 <= arg_310_1.time_ and arg_310_1.time_ < var_313_18 + var_313_19 then
				local var_313_20 = (arg_310_1.time_ - var_313_18) / var_313_19
				local var_313_21 = Color.New(0, 0, 0)

				var_313_21.a = Mathf.Lerp(0, 1, var_313_20)
				arg_310_1.mask_.color = var_313_21
			end

			if arg_310_1.time_ >= var_313_18 + var_313_19 and arg_310_1.time_ < var_313_18 + var_313_19 + arg_313_0 then
				local var_313_22 = Color.New(0, 0, 0)

				var_313_22.a = 1
				arg_310_1.mask_.color = var_313_22
			end

			local var_313_23 = 2

			if var_313_23 < arg_310_1.time_ and arg_310_1.time_ <= var_313_23 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_24 = 2

			if var_313_23 <= arg_310_1.time_ and arg_310_1.time_ < var_313_23 + var_313_24 then
				local var_313_25 = (arg_310_1.time_ - var_313_23) / var_313_24
				local var_313_26 = Color.New(0, 0, 0)

				var_313_26.a = Mathf.Lerp(1, 0, var_313_25)
				arg_310_1.mask_.color = var_313_26
			end

			if arg_310_1.time_ >= var_313_23 + var_313_24 and arg_310_1.time_ < var_313_23 + var_313_24 + arg_313_0 then
				local var_313_27 = Color.New(0, 0, 0)
				local var_313_28 = 0

				arg_310_1.mask_.enabled = false
				var_313_27.a = var_313_28
				arg_310_1.mask_.color = var_313_27
			end

			local var_313_29 = arg_310_1.bgs_.MS2210.transform
			local var_313_30 = 2

			if var_313_30 < arg_310_1.time_ and arg_310_1.time_ <= var_313_30 + arg_313_0 then
				arg_310_1.var_.moveOldPosMS2210 = var_313_29.localPosition
			end

			local var_313_31 = 2

			if var_313_30 <= arg_310_1.time_ and arg_310_1.time_ < var_313_30 + var_313_31 then
				local var_313_32 = (arg_310_1.time_ - var_313_30) / var_313_31
				local var_313_33 = Vector3.New(0, 0, 4)

				var_313_29.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPosMS2210, var_313_33, var_313_32)
			end

			if arg_310_1.time_ >= var_313_30 + var_313_31 and arg_310_1.time_ < var_313_30 + var_313_31 + arg_313_0 then
				var_313_29.localPosition = Vector3.New(0, 0, 4)
			end

			local var_313_34 = 0
			local var_313_35 = 0.3

			if var_313_34 < arg_310_1.time_ and arg_310_1.time_ <= var_313_34 + arg_313_0 then
				local var_313_36 = "play"
				local var_313_37 = "music"

				arg_310_1:AudioAction(var_313_36, var_313_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_313_38 = ""
				local var_313_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_313_39 ~= "" then
					if arg_310_1.bgmTxt_.text ~= var_313_39 and arg_310_1.bgmTxt_.text ~= "" then
						if arg_310_1.bgmTxt2_.text ~= "" then
							arg_310_1.bgmTxt_.text = arg_310_1.bgmTxt2_.text
						end

						arg_310_1.bgmTxt2_.text = var_313_39

						arg_310_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_310_1.bgmTxt_.text = var_313_39
						arg_310_1.bgmTxt2_.text = var_313_39
					end

					if arg_310_1.bgmTimer then
						arg_310_1.bgmTimer:Stop()

						arg_310_1.bgmTimer = nil
					end

					if arg_310_1.settingData.show_music_name == 1 then
						arg_310_1.musicController:SetSelectedState("show")
						arg_310_1.musicAnimator_:Play("open", 0, 0)

						if arg_310_1.settingData.music_time ~= 0 then
							arg_310_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_310_1.settingData.music_time), function()
								if arg_310_1 == nil or isNil(arg_310_1.bgmTxt_) then
									return
								end

								arg_310_1.musicController:SetSelectedState("hide")
								arg_310_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_313_40 = 0.466666666666667
			local var_313_41 = 1

			if var_313_40 < arg_310_1.time_ and arg_310_1.time_ <= var_313_40 + arg_313_0 then
				local var_313_42 = "play"
				local var_313_43 = "music"

				arg_310_1:AudioAction(var_313_42, var_313_43, "bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano.awb")

				local var_313_44 = ""
				local var_313_45 = manager.audio:GetAudioName("bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano")

				if var_313_45 ~= "" then
					if arg_310_1.bgmTxt_.text ~= var_313_45 and arg_310_1.bgmTxt_.text ~= "" then
						if arg_310_1.bgmTxt2_.text ~= "" then
							arg_310_1.bgmTxt_.text = arg_310_1.bgmTxt2_.text
						end

						arg_310_1.bgmTxt2_.text = var_313_45

						arg_310_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_310_1.bgmTxt_.text = var_313_45
						arg_310_1.bgmTxt2_.text = var_313_45
					end

					if arg_310_1.bgmTimer then
						arg_310_1.bgmTimer:Stop()

						arg_310_1.bgmTimer = nil
					end

					if arg_310_1.settingData.show_music_name == 1 then
						arg_310_1.musicController:SetSelectedState("show")
						arg_310_1.musicAnimator_:Play("open", 0, 0)

						if arg_310_1.settingData.music_time ~= 0 then
							arg_310_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_310_1.settingData.music_time), function()
								if arg_310_1 == nil or isNil(arg_310_1.bgmTxt_) then
									return
								end

								arg_310_1.musicController:SetSelectedState("hide")
								arg_310_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_313_46 = 2
			local var_313_47 = 1

			if var_313_46 < arg_310_1.time_ and arg_310_1.time_ <= var_313_46 + arg_313_0 then
				local var_313_48 = "play"
				local var_313_49 = "effect"

				arg_310_1:AudioAction(var_313_48, var_313_49, "se_story_140", "se_story_140_foley_hug", "")
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_50 = 4
			local var_313_51 = 1.3

			if var_313_50 < arg_310_1.time_ and arg_310_1.time_ <= var_313_50 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_52 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_52:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_310_1.dialogCg_.alpha = arg_316_0
				end))
				var_313_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_53 = arg_310_1:GetWordFromCfg(322161075)
				local var_313_54 = arg_310_1:FormatText(var_313_53.content)

				arg_310_1.text_.text = var_313_54

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_55 = 52
				local var_313_56 = utf8.len(var_313_54)
				local var_313_57 = var_313_55 <= 0 and var_313_51 or var_313_51 * (var_313_56 / var_313_55)

				if var_313_57 > 0 and var_313_51 < var_313_57 then
					arg_310_1.talkMaxDuration = var_313_57
					var_313_50 = var_313_50 + 0.3

					if var_313_57 + var_313_50 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_57 + var_313_50
					end
				end

				arg_310_1.text_.text = var_313_54
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_58 = var_313_50 + 0.3
			local var_313_59 = math.max(var_313_51, arg_310_1.talkMaxDuration)

			if var_313_58 <= arg_310_1.time_ and arg_310_1.time_ < var_313_58 + var_313_59 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_58) / var_313_59

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_58 + var_313_59 and arg_310_1.time_ < var_313_58 + var_313_59 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2210",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 3),
					endPos = Vector3.New(0, 0, 4),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play322161076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 322161076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play322161077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 1.15

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_2 = arg_318_1:GetWordFromCfg(322161076)
				local var_321_3 = arg_318_1:FormatText(var_321_2.content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 46
				local var_321_5 = utf8.len(var_321_3)
				local var_321_6 = var_321_4 <= 0 and var_321_1 or var_321_1 * (var_321_5 / var_321_4)

				if var_321_6 > 0 and var_321_1 < var_321_6 then
					arg_318_1.talkMaxDuration = var_321_6

					if var_321_6 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_6 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_7 and arg_318_1.time_ < var_321_0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play322161077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322161077
		arg_322_1.duration_ = 6.53

		local var_322_0 = {
			zh = 5.966,
			ja = 6.533
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
				arg_322_0:Play322161078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.7

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[1367].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:GetWordFromCfg(322161077)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 28
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161077", "story_v_out_322161.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161077", "story_v_out_322161.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_322161", "322161077", "story_v_out_322161.awb")

						arg_322_1:RecordAudio("322161077", var_325_9)
						arg_322_1:RecordAudio("322161077", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_322161", "322161077", "story_v_out_322161.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_322161", "322161077", "story_v_out_322161.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_10 and arg_322_1.time_ < var_325_0 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play322161078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 322161078
		arg_326_1.duration_ = 9.17

		local var_326_0 = {
			zh = 7.2,
			ja = 9.166
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play322161079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.85

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[1367].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_3 = arg_326_1:GetWordFromCfg(322161078)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 34
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161078", "story_v_out_322161.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161078", "story_v_out_322161.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_322161", "322161078", "story_v_out_322161.awb")

						arg_326_1:RecordAudio("322161078", var_329_9)
						arg_326_1:RecordAudio("322161078", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_322161", "322161078", "story_v_out_322161.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_322161", "322161078", "story_v_out_322161.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play322161079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 322161079
		arg_330_1.duration_ = 5.33

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play322161080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.bgs_.MS2210.transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPosMS2210 = var_333_0.localPosition
			end

			local var_333_2 = 0.333333333333333

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2
				local var_333_4 = Vector3.New(0.5, 0, 4)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPosMS2210, var_333_4, var_333_3)
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(0.5, 0, 4)
			end

			local var_333_5 = 0

			if var_333_5 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
				arg_330_1.allBtn_.enabled = false
			end

			local var_333_6 = 0.333333333333333

			if arg_330_1.time_ >= var_333_5 + var_333_6 and arg_330_1.time_ < var_333_5 + var_333_6 + arg_333_0 then
				arg_330_1.allBtn_.enabled = true
			end

			local var_333_7 = 0

			if var_333_7 < arg_330_1.time_ and arg_330_1.time_ <= var_333_7 + arg_333_0 then
				arg_330_1.allBtn_.enabled = false
			end

			local var_333_8 = 0.866666666666667

			if arg_330_1.time_ >= var_333_7 + var_333_8 and arg_330_1.time_ < var_333_7 + var_333_8 + arg_333_0 then
				arg_330_1.allBtn_.enabled = true
			end

			if arg_330_1.frameCnt_ <= 1 then
				arg_330_1.dialog_:SetActive(false)
			end

			local var_333_9 = 0.333333333333333
			local var_333_10 = 0.775

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0

				arg_330_1.dialog_:SetActive(true)

				arg_330_1.dialogCg_.alpha = 0

				local var_333_11 = LeanTween.value(arg_330_1.dialog_, 0, 1, 0.3)

				var_333_11:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_330_1.dialogCg_.alpha = arg_334_0
				end))
				var_333_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_330_1.dialog_)
					var_333_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_330_1.duration_ = arg_330_1.duration_ + 0.3

				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_12 = arg_330_1:FormatText(StoryNameCfg[7].name)

				arg_330_1.leftNameTxt_.text = var_333_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_13 = arg_330_1:GetWordFromCfg(322161079)
				local var_333_14 = arg_330_1:FormatText(var_333_13.content)

				arg_330_1.text_.text = var_333_14

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_15 = 31
				local var_333_16 = utf8.len(var_333_14)
				local var_333_17 = var_333_15 <= 0 and var_333_10 or var_333_10 * (var_333_16 / var_333_15)

				if var_333_17 > 0 and var_333_10 < var_333_17 then
					arg_330_1.talkMaxDuration = var_333_17
					var_333_9 = var_333_9 + 0.3

					if var_333_17 + var_333_9 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_17 + var_333_9
					end
				end

				arg_330_1.text_.text = var_333_14
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_18 = var_333_9 + 0.3
			local var_333_19 = math.max(var_333_10, arg_330_1.talkMaxDuration)

			if var_333_18 <= arg_330_1.time_ and arg_330_1.time_ < var_333_18 + var_333_19 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_18) / var_333_19

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_18 + var_333_19 and arg_330_1.time_ < var_333_18 + var_333_19 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2210",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 4),
					endPos = Vector3.New(0.5, 0, 4),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play322161080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 322161080
		arg_336_1.duration_ = 9.07

		local var_336_0 = {
			zh = 6.6,
			ja = 9.066
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
				arg_336_0:Play322161081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.7

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[1367].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_3 = arg_336_1:GetWordFromCfg(322161080)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 28
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161080", "story_v_out_322161.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161080", "story_v_out_322161.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_322161", "322161080", "story_v_out_322161.awb")

						arg_336_1:RecordAudio("322161080", var_339_9)
						arg_336_1:RecordAudio("322161080", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_322161", "322161080", "story_v_out_322161.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_322161", "322161080", "story_v_out_322161.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play322161081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 322161081
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play322161082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 1.475

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

				local var_343_2 = arg_340_1:GetWordFromCfg(322161081)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 59
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
	Play322161082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 322161082
		arg_344_1.duration_ = 5.1

		local var_344_0 = {
			zh = 4.43266666666667,
			ja = 5.09966666666667
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
				arg_344_0:Play322161083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.bgs_.MS2210.transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPosMS2210 = var_347_0.localPosition
			end

			local var_347_2 = 0.333333333333333

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(0.5, 0, 4.5)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPosMS2210, var_347_4, var_347_3)
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(0.5, 0, 4.5)
			end

			local var_347_5 = 0

			if var_347_5 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1.allBtn_.enabled = false
			end

			local var_347_6 = 0.566666666666667

			if arg_344_1.time_ >= var_347_5 + var_347_6 and arg_344_1.time_ < var_347_5 + var_347_6 + arg_347_0 then
				arg_344_1.allBtn_.enabled = true
			end

			if arg_344_1.frameCnt_ <= 1 then
				arg_344_1.dialog_:SetActive(false)
			end

			local var_347_7 = 0.166666666666667
			local var_347_8 = 0.4

			if var_347_7 < arg_344_1.time_ and arg_344_1.time_ <= var_347_7 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0

				arg_344_1.dialog_:SetActive(true)

				arg_344_1.dialogCg_.alpha = 0

				local var_347_9 = LeanTween.value(arg_344_1.dialog_, 0, 1, 0.3)

				var_347_9:setOnUpdate(LuaHelper.FloatAction(function(arg_348_0)
					arg_344_1.dialogCg_.alpha = arg_348_0
				end))
				var_347_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_344_1.dialog_)
					var_347_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_344_1.duration_ = arg_344_1.duration_ + 0.3

				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_10 = arg_344_1:FormatText(StoryNameCfg[1367].name)

				arg_344_1.leftNameTxt_.text = var_347_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_11 = arg_344_1:GetWordFromCfg(322161082)
				local var_347_12 = arg_344_1:FormatText(var_347_11.content)

				arg_344_1.text_.text = var_347_12

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_13 = 16
				local var_347_14 = utf8.len(var_347_12)
				local var_347_15 = var_347_13 <= 0 and var_347_8 or var_347_8 * (var_347_14 / var_347_13)

				if var_347_15 > 0 and var_347_8 < var_347_15 then
					arg_344_1.talkMaxDuration = var_347_15
					var_347_7 = var_347_7 + 0.3

					if var_347_15 + var_347_7 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_15 + var_347_7
					end
				end

				arg_344_1.text_.text = var_347_12
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161082", "story_v_out_322161.awb") ~= 0 then
					local var_347_16 = manager.audio:GetVoiceLength("story_v_out_322161", "322161082", "story_v_out_322161.awb") / 1000

					if var_347_16 + var_347_7 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_16 + var_347_7
					end

					if var_347_11.prefab_name ~= "" and arg_344_1.actors_[var_347_11.prefab_name] ~= nil then
						local var_347_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_11.prefab_name].transform, "story_v_out_322161", "322161082", "story_v_out_322161.awb")

						arg_344_1:RecordAudio("322161082", var_347_17)
						arg_344_1:RecordAudio("322161082", var_347_17)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_322161", "322161082", "story_v_out_322161.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_322161", "322161082", "story_v_out_322161.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_18 = var_347_7 + 0.3
			local var_347_19 = math.max(var_347_8, arg_344_1.talkMaxDuration)

			if var_347_18 <= arg_344_1.time_ and arg_344_1.time_ < var_347_18 + var_347_19 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_18) / var_347_19

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_18 + var_347_19 and arg_344_1.time_ < var_347_18 + var_347_19 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2210",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.5, 0, 4),
					endPos = Vector3.New(0.5, 0, 4.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play322161083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 322161083
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play322161084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.3

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[7].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_3 = arg_350_1:GetWordFromCfg(322161083)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 12
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
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_8 and arg_350_1.time_ < var_353_0 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play322161084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 322161084
		arg_354_1.duration_ = 4.27

		local var_354_0 = {
			zh = 2.833,
			ja = 4.266
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
				arg_354_0:Play322161085(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 0.35

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_2 = arg_354_1:FormatText(StoryNameCfg[1367].name)

				arg_354_1.leftNameTxt_.text = var_357_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_3 = arg_354_1:GetWordFromCfg(322161084)
				local var_357_4 = arg_354_1:FormatText(var_357_3.content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 14
				local var_357_6 = utf8.len(var_357_4)
				local var_357_7 = var_357_5 <= 0 and var_357_1 or var_357_1 * (var_357_6 / var_357_5)

				if var_357_7 > 0 and var_357_1 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161084", "story_v_out_322161.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161084", "story_v_out_322161.awb") / 1000

					if var_357_8 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_0
					end

					if var_357_3.prefab_name ~= "" and arg_354_1.actors_[var_357_3.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_3.prefab_name].transform, "story_v_out_322161", "322161084", "story_v_out_322161.awb")

						arg_354_1:RecordAudio("322161084", var_357_9)
						arg_354_1:RecordAudio("322161084", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_322161", "322161084", "story_v_out_322161.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_322161", "322161084", "story_v_out_322161.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_10 and arg_354_1.time_ < var_357_0 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play322161085 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 322161085
		arg_358_1.duration_ = 18.43

		local var_358_0 = {
			zh = 10.066,
			ja = 18.433
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
				arg_358_0:Play322161086(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 1.15

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[1030].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(322161085)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 46
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161085", "story_v_out_322161.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161085", "story_v_out_322161.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_out_322161", "322161085", "story_v_out_322161.awb")

						arg_358_1:RecordAudio("322161085", var_361_9)
						arg_358_1:RecordAudio("322161085", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_322161", "322161085", "story_v_out_322161.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_322161", "322161085", "story_v_out_322161.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play322161086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 322161086
		arg_362_1.duration_ = 7.43

		local var_362_0 = {
			zh = 6.43266666666667,
			ja = 7.43266666666667
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
				arg_362_0:Play322161087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = manager.ui.mainCamera.transform
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.var_.shakeOldPos = var_365_0.localPosition
			end

			local var_365_2 = 0.166666666666667

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / 0.066
				local var_365_4, var_365_5 = math.modf(var_365_3)

				var_365_0.localPosition = Vector3.New(var_365_5 * 0.13, var_365_5 * 0.13, var_365_5 * 0.13) + arg_362_1.var_.shakeOldPos
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 then
				var_365_0.localPosition = arg_362_1.var_.shakeOldPos
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_6 = 0.166666666666667
			local var_365_7 = 0.675

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_8 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_8:setOnUpdate(LuaHelper.FloatAction(function(arg_366_0)
					arg_362_1.dialogCg_.alpha = arg_366_0
				end))
				var_365_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_9 = arg_362_1:FormatText(StoryNameCfg[1367].name)

				arg_362_1.leftNameTxt_.text = var_365_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_10 = arg_362_1:GetWordFromCfg(322161086)
				local var_365_11 = arg_362_1:FormatText(var_365_10.content)

				arg_362_1.text_.text = var_365_11

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_12 = 27
				local var_365_13 = utf8.len(var_365_11)
				local var_365_14 = var_365_12 <= 0 and var_365_7 or var_365_7 * (var_365_13 / var_365_12)

				if var_365_14 > 0 and var_365_7 < var_365_14 then
					arg_362_1.talkMaxDuration = var_365_14
					var_365_6 = var_365_6 + 0.3

					if var_365_14 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_11
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161086", "story_v_out_322161.awb") ~= 0 then
					local var_365_15 = manager.audio:GetVoiceLength("story_v_out_322161", "322161086", "story_v_out_322161.awb") / 1000

					if var_365_15 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_15 + var_365_6
					end

					if var_365_10.prefab_name ~= "" and arg_362_1.actors_[var_365_10.prefab_name] ~= nil then
						local var_365_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_10.prefab_name].transform, "story_v_out_322161", "322161086", "story_v_out_322161.awb")

						arg_362_1:RecordAudio("322161086", var_365_16)
						arg_362_1:RecordAudio("322161086", var_365_16)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_322161", "322161086", "story_v_out_322161.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_322161", "322161086", "story_v_out_322161.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_17 = var_365_6 + 0.3
			local var_365_18 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_17 <= arg_362_1.time_ and arg_362_1.time_ < var_365_17 + var_365_18 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_17) / var_365_18

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_17 + var_365_18 and arg_362_1.time_ < var_365_17 + var_365_18 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play322161087 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322161087
		arg_368_1.duration_ = 10.57

		local var_368_0 = {
			zh = 7.6,
			ja = 10.566
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
				arg_368_0:Play322161088(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.825

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[1030].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(322161087)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 33
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161087", "story_v_out_322161.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161087", "story_v_out_322161.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_322161", "322161087", "story_v_out_322161.awb")

						arg_368_1:RecordAudio("322161087", var_371_9)
						arg_368_1:RecordAudio("322161087", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_322161", "322161087", "story_v_out_322161.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_322161", "322161087", "story_v_out_322161.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play322161088 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 322161088
		arg_372_1.duration_ = 6.97

		local var_372_0 = {
			zh = 4.666,
			ja = 6.966
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
				arg_372_0:Play322161089(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.45

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[1367].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:GetWordFromCfg(322161088)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 18
				local var_375_6 = utf8.len(var_375_4)
				local var_375_7 = var_375_5 <= 0 and var_375_1 or var_375_1 * (var_375_6 / var_375_5)

				if var_375_7 > 0 and var_375_1 < var_375_7 then
					arg_372_1.talkMaxDuration = var_375_7

					if var_375_7 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161088", "story_v_out_322161.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161088", "story_v_out_322161.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_322161", "322161088", "story_v_out_322161.awb")

						arg_372_1:RecordAudio("322161088", var_375_9)
						arg_372_1:RecordAudio("322161088", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_322161", "322161088", "story_v_out_322161.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_322161", "322161088", "story_v_out_322161.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_10 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_10 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_10

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_10 and arg_372_1.time_ < var_375_0 + var_375_10 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play322161089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 322161089
		arg_376_1.duration_ = 3.2

		local var_376_0 = {
			zh = 1.8,
			ja = 3.2
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play322161090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.15

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[37].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_3 = arg_376_1:GetWordFromCfg(322161089)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 6
				local var_379_6 = utf8.len(var_379_4)
				local var_379_7 = var_379_5 <= 0 and var_379_1 or var_379_1 * (var_379_6 / var_379_5)

				if var_379_7 > 0 and var_379_1 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161089", "story_v_out_322161.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161089", "story_v_out_322161.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_322161", "322161089", "story_v_out_322161.awb")

						arg_376_1:RecordAudio("322161089", var_379_9)
						arg_376_1:RecordAudio("322161089", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_322161", "322161089", "story_v_out_322161.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_322161", "322161089", "story_v_out_322161.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_10 and arg_376_1.time_ < var_379_0 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play322161090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 322161090
		arg_380_1.duration_ = 5.97

		local var_380_0 = {
			zh = 5.966,
			ja = 5.333
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
				arg_380_0:Play322161091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.4

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[1367].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:GetWordFromCfg(322161090)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 16
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161090", "story_v_out_322161.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161090", "story_v_out_322161.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_322161", "322161090", "story_v_out_322161.awb")

						arg_380_1:RecordAudio("322161090", var_383_9)
						arg_380_1:RecordAudio("322161090", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_322161", "322161090", "story_v_out_322161.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_322161", "322161090", "story_v_out_322161.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play322161091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 322161091
		arg_384_1.duration_ = 4.3

		local var_384_0 = {
			zh = 3.2,
			ja = 4.3
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
				arg_384_0:Play322161092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.375

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[6].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102_split_4")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(322161091)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 15
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161091", "story_v_out_322161.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161091", "story_v_out_322161.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_322161", "322161091", "story_v_out_322161.awb")

						arg_384_1:RecordAudio("322161091", var_387_9)
						arg_384_1:RecordAudio("322161091", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_322161", "322161091", "story_v_out_322161.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_322161", "322161091", "story_v_out_322161.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play322161092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 322161092
		arg_388_1.duration_ = 2.6

		local var_388_0 = {
			zh = 2.6,
			ja = 2.1
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
				arg_388_0:Play322161093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 0.225

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_2 = arg_388_1:FormatText(StoryNameCfg[37].name)

				arg_388_1.leftNameTxt_.text = var_391_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_3 = arg_388_1:GetWordFromCfg(322161092)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 9
				local var_391_6 = utf8.len(var_391_4)
				local var_391_7 = var_391_5 <= 0 and var_391_1 or var_391_1 * (var_391_6 / var_391_5)

				if var_391_7 > 0 and var_391_1 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161092", "story_v_out_322161.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161092", "story_v_out_322161.awb") / 1000

					if var_391_8 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_0
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_out_322161", "322161092", "story_v_out_322161.awb")

						arg_388_1:RecordAudio("322161092", var_391_9)
						arg_388_1:RecordAudio("322161092", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_322161", "322161092", "story_v_out_322161.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_322161", "322161092", "story_v_out_322161.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_10 and arg_388_1.time_ < var_391_0 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play322161093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 322161093
		arg_392_1.duration_ = 3.73

		local var_392_0 = {
			zh = 3.733,
			ja = 1.433
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
				arg_392_0:Play322161094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 0.325

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[1367].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_3 = arg_392_1:GetWordFromCfg(322161093)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 13
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161093", "story_v_out_322161.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161093", "story_v_out_322161.awb") / 1000

					if var_395_8 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_0
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_322161", "322161093", "story_v_out_322161.awb")

						arg_392_1:RecordAudio("322161093", var_395_9)
						arg_392_1:RecordAudio("322161093", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_322161", "322161093", "story_v_out_322161.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_322161", "322161093", "story_v_out_322161.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_10 and arg_392_1.time_ < var_395_0 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play322161094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322161094
		arg_396_1.duration_ = 7.17

		local var_396_0 = {
			zh = 5.4,
			ja = 7.166
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
				arg_396_0:Play322161095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 0.675

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[1367].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_3 = arg_396_1:GetWordFromCfg(322161094)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 27
				local var_399_6 = utf8.len(var_399_4)
				local var_399_7 = var_399_5 <= 0 and var_399_1 or var_399_1 * (var_399_6 / var_399_5)

				if var_399_7 > 0 and var_399_1 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161094", "story_v_out_322161.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161094", "story_v_out_322161.awb") / 1000

					if var_399_8 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_0
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_322161", "322161094", "story_v_out_322161.awb")

						arg_396_1:RecordAudio("322161094", var_399_9)
						arg_396_1:RecordAudio("322161094", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_322161", "322161094", "story_v_out_322161.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_322161", "322161094", "story_v_out_322161.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_10 and arg_396_1.time_ < var_399_0 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play322161095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 322161095
		arg_400_1.duration_ = 4.07

		local var_400_0 = {
			zh = 4.066,
			ja = 3.666
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
				arg_400_0:Play322161096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.3

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[37].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:GetWordFromCfg(322161095)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 12
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161095", "story_v_out_322161.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161095", "story_v_out_322161.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_out_322161", "322161095", "story_v_out_322161.awb")

						arg_400_1:RecordAudio("322161095", var_403_9)
						arg_400_1:RecordAudio("322161095", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_322161", "322161095", "story_v_out_322161.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_322161", "322161095", "story_v_out_322161.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play322161096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 322161096
		arg_404_1.duration_ = 8.87

		local var_404_0 = {
			zh = 7.133,
			ja = 8.866
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
				arg_404_0:Play322161097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1211ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1211ui_story == nil then
				arg_404_1.var_.characterEffect1211ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect1211ui_story and not isNil(var_407_0) then
					local var_407_4 = Mathf.Lerp(0, 0.5, var_407_3)

					arg_404_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1211ui_story.fillRatio = var_407_4
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect1211ui_story then
				local var_407_5 = 0.5

				arg_404_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1211ui_story.fillRatio = var_407_5
			end

			local var_407_6 = 0
			local var_407_7 = 0.875

			if var_407_6 < arg_404_1.time_ and arg_404_1.time_ <= var_407_6 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_8 = arg_404_1:FormatText(StoryNameCfg[1367].name)

				arg_404_1.leftNameTxt_.text = var_407_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_9 = arg_404_1:GetWordFromCfg(322161096)
				local var_407_10 = arg_404_1:FormatText(var_407_9.content)

				arg_404_1.text_.text = var_407_10

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_11 = 35
				local var_407_12 = utf8.len(var_407_10)
				local var_407_13 = var_407_11 <= 0 and var_407_7 or var_407_7 * (var_407_12 / var_407_11)

				if var_407_13 > 0 and var_407_7 < var_407_13 then
					arg_404_1.talkMaxDuration = var_407_13

					if var_407_13 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_13 + var_407_6
					end
				end

				arg_404_1.text_.text = var_407_10
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161096", "story_v_out_322161.awb") ~= 0 then
					local var_407_14 = manager.audio:GetVoiceLength("story_v_out_322161", "322161096", "story_v_out_322161.awb") / 1000

					if var_407_14 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_14 + var_407_6
					end

					if var_407_9.prefab_name ~= "" and arg_404_1.actors_[var_407_9.prefab_name] ~= nil then
						local var_407_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_9.prefab_name].transform, "story_v_out_322161", "322161096", "story_v_out_322161.awb")

						arg_404_1:RecordAudio("322161096", var_407_15)
						arg_404_1:RecordAudio("322161096", var_407_15)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_322161", "322161096", "story_v_out_322161.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_322161", "322161096", "story_v_out_322161.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_16 = math.max(var_407_7, arg_404_1.talkMaxDuration)

			if var_407_6 <= arg_404_1.time_ and arg_404_1.time_ < var_407_6 + var_407_16 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_6) / var_407_16

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_6 + var_407_16 and arg_404_1.time_ < var_407_6 + var_407_16 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play322161097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 322161097
		arg_408_1.duration_ = 11.3

		local var_408_0 = {
			zh = 7.433,
			ja = 11.3
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
				arg_408_0:Play322161098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.85

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[1367].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:GetWordFromCfg(322161097)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161097", "story_v_out_322161.awb") ~= 0 then
					local var_411_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161097", "story_v_out_322161.awb") / 1000

					if var_411_8 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_8 + var_411_0
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_322161", "322161097", "story_v_out_322161.awb")

						arg_408_1:RecordAudio("322161097", var_411_9)
						arg_408_1:RecordAudio("322161097", var_411_9)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_322161", "322161097", "story_v_out_322161.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_322161", "322161097", "story_v_out_322161.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_10 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_10 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_10

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_10 and arg_408_1.time_ < var_411_0 + var_411_10 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play322161098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 322161098
		arg_412_1.duration_ = 1.5

		local var_412_0 = {
			zh = 1.5,
			ja = 1.3
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
				arg_412_0:Play322161099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.1

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[37].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(322161098)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161098", "story_v_out_322161.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161098", "story_v_out_322161.awb") / 1000

					if var_415_8 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_0
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_322161", "322161098", "story_v_out_322161.awb")

						arg_412_1:RecordAudio("322161098", var_415_9)
						arg_412_1:RecordAudio("322161098", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_322161", "322161098", "story_v_out_322161.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_322161", "322161098", "story_v_out_322161.awb")
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
	Play322161099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 322161099
		arg_416_1.duration_ = 10.93

		local var_416_0 = {
			zh = 4.6,
			ja = 10.933
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
				arg_416_0:Play322161100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.4

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[37].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(322161099)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161099", "story_v_out_322161.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161099", "story_v_out_322161.awb") / 1000

					if var_419_8 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_0
					end

					if var_419_3.prefab_name ~= "" and arg_416_1.actors_[var_419_3.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_3.prefab_name].transform, "story_v_out_322161", "322161099", "story_v_out_322161.awb")

						arg_416_1:RecordAudio("322161099", var_419_9)
						arg_416_1:RecordAudio("322161099", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_322161", "322161099", "story_v_out_322161.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_322161", "322161099", "story_v_out_322161.awb")
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
	Play322161100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 322161100
		arg_420_1.duration_ = 15.17

		local var_420_0 = {
			zh = 10.866,
			ja = 15.166
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
				arg_420_0:Play322161101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1211ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1211ui_story == nil then
				arg_420_1.var_.characterEffect1211ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect1211ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1211ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect1211ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1211ui_story.fillRatio = var_423_5
			end

			local var_423_6 = arg_420_1.bgs_.MS2210.transform
			local var_423_7 = 0

			if var_423_7 < arg_420_1.time_ and arg_420_1.time_ <= var_423_7 + arg_423_0 then
				arg_420_1.var_.moveOldPosMS2210 = var_423_6.localPosition
			end

			local var_423_8 = 1

			if var_423_7 <= arg_420_1.time_ and arg_420_1.time_ < var_423_7 + var_423_8 then
				local var_423_9 = (arg_420_1.time_ - var_423_7) / var_423_8
				local var_423_10 = Vector3.New(0.5, 0.5, 6)

				var_423_6.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosMS2210, var_423_10, var_423_9)
			end

			if arg_420_1.time_ >= var_423_7 + var_423_8 and arg_420_1.time_ < var_423_7 + var_423_8 + arg_423_0 then
				var_423_6.localPosition = Vector3.New(0.5, 0.5, 6)
			end

			local var_423_11 = 0

			if var_423_11 < arg_420_1.time_ and arg_420_1.time_ <= var_423_11 + arg_423_0 then
				arg_420_1.allBtn_.enabled = false
			end

			local var_423_12 = 1.63333333333333

			if arg_420_1.time_ >= var_423_11 + var_423_12 and arg_420_1.time_ < var_423_11 + var_423_12 + arg_423_0 then
				arg_420_1.allBtn_.enabled = true
			end

			if arg_420_1.frameCnt_ <= 1 then
				arg_420_1.dialog_:SetActive(false)
			end

			local var_423_13 = 1
			local var_423_14 = 1.175

			if var_423_13 < arg_420_1.time_ and arg_420_1.time_ <= var_423_13 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0

				arg_420_1.dialog_:SetActive(true)

				arg_420_1.dialogCg_.alpha = 0

				local var_423_15 = LeanTween.value(arg_420_1.dialog_, 0, 1, 0.3)

				var_423_15:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_420_1.dialogCg_.alpha = arg_424_0
				end))
				var_423_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_420_1.dialog_)
					var_423_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_420_1.duration_ = arg_420_1.duration_ + 0.3

				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_16 = arg_420_1:FormatText(StoryNameCfg[1367].name)

				arg_420_1.leftNameTxt_.text = var_423_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_17 = arg_420_1:GetWordFromCfg(322161100)
				local var_423_18 = arg_420_1:FormatText(var_423_17.content)

				arg_420_1.text_.text = var_423_18

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_19 = 47
				local var_423_20 = utf8.len(var_423_18)
				local var_423_21 = var_423_19 <= 0 and var_423_14 or var_423_14 * (var_423_20 / var_423_19)

				if var_423_21 > 0 and var_423_14 < var_423_21 then
					arg_420_1.talkMaxDuration = var_423_21
					var_423_13 = var_423_13 + 0.3

					if var_423_21 + var_423_13 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_21 + var_423_13
					end
				end

				arg_420_1.text_.text = var_423_18
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161100", "story_v_out_322161.awb") ~= 0 then
					local var_423_22 = manager.audio:GetVoiceLength("story_v_out_322161", "322161100", "story_v_out_322161.awb") / 1000

					if var_423_22 + var_423_13 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_22 + var_423_13
					end

					if var_423_17.prefab_name ~= "" and arg_420_1.actors_[var_423_17.prefab_name] ~= nil then
						local var_423_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_17.prefab_name].transform, "story_v_out_322161", "322161100", "story_v_out_322161.awb")

						arg_420_1:RecordAudio("322161100", var_423_23)
						arg_420_1:RecordAudio("322161100", var_423_23)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_322161", "322161100", "story_v_out_322161.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_322161", "322161100", "story_v_out_322161.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_24 = var_423_13 + 0.3
			local var_423_25 = math.max(var_423_14, arg_420_1.talkMaxDuration)

			if var_423_24 <= arg_420_1.time_ and arg_420_1.time_ < var_423_24 + var_423_25 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_24) / var_423_25

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_24 + var_423_25 and arg_420_1.time_ < var_423_24 + var_423_25 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2210",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.5, 0, 4.5),
					endPos = Vector3.New(0.5, 0.5, 6),
					easeType = LeanTweenType.easeOutCubic
				}
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play322161101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 322161101
		arg_426_1.duration_ = 5.97

		local var_426_0 = {
			zh = 4.333,
			ja = 5.966
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
				arg_426_0:Play322161102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.4

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[37].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:GetWordFromCfg(322161101)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161101", "story_v_out_322161.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161101", "story_v_out_322161.awb") / 1000

					if var_429_8 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_0
					end

					if var_429_3.prefab_name ~= "" and arg_426_1.actors_[var_429_3.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_3.prefab_name].transform, "story_v_out_322161", "322161101", "story_v_out_322161.awb")

						arg_426_1:RecordAudio("322161101", var_429_9)
						arg_426_1:RecordAudio("322161101", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_322161", "322161101", "story_v_out_322161.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_322161", "322161101", "story_v_out_322161.awb")
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
	Play322161102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 322161102
		arg_430_1.duration_ = 4.97

		local var_430_0 = {
			zh = 4.533,
			ja = 4.966
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
				arg_430_0:Play322161103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 0.5

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_2 = arg_430_1:FormatText(StoryNameCfg[1367].name)

				arg_430_1.leftNameTxt_.text = var_433_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_3 = arg_430_1:GetWordFromCfg(322161102)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 20
				local var_433_6 = utf8.len(var_433_4)
				local var_433_7 = var_433_5 <= 0 and var_433_1 or var_433_1 * (var_433_6 / var_433_5)

				if var_433_7 > 0 and var_433_1 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161102", "story_v_out_322161.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161102", "story_v_out_322161.awb") / 1000

					if var_433_8 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_0
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_322161", "322161102", "story_v_out_322161.awb")

						arg_430_1:RecordAudio("322161102", var_433_9)
						arg_430_1:RecordAudio("322161102", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_322161", "322161102", "story_v_out_322161.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_322161", "322161102", "story_v_out_322161.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_10 and arg_430_1.time_ < var_433_0 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play322161103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 322161103
		arg_434_1.duration_ = 5.4

		local var_434_0 = {
			zh = 4.866,
			ja = 5.4
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
				arg_434_0:Play322161104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.375

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[37].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(322161103)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161103", "story_v_out_322161.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161103", "story_v_out_322161.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_322161", "322161103", "story_v_out_322161.awb")

						arg_434_1:RecordAudio("322161103", var_437_9)
						arg_434_1:RecordAudio("322161103", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_322161", "322161103", "story_v_out_322161.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_322161", "322161103", "story_v_out_322161.awb")
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
	Play322161104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 322161104
		arg_438_1.duration_ = 11.33

		local var_438_0 = {
			zh = 8,
			ja = 11.333
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
				arg_438_0:Play322161105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.775

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[1367].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_3 = arg_438_1:GetWordFromCfg(322161104)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161104", "story_v_out_322161.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161104", "story_v_out_322161.awb") / 1000

					if var_441_8 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_0
					end

					if var_441_3.prefab_name ~= "" and arg_438_1.actors_[var_441_3.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_3.prefab_name].transform, "story_v_out_322161", "322161104", "story_v_out_322161.awb")

						arg_438_1:RecordAudio("322161104", var_441_9)
						arg_438_1:RecordAudio("322161104", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_322161", "322161104", "story_v_out_322161.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_322161", "322161104", "story_v_out_322161.awb")
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
	Play322161105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 322161105
		arg_442_1.duration_ = 1

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"

			SetActive(arg_442_1.choicesGo_, true)

			for iter_443_0, iter_443_1 in ipairs(arg_442_1.choices_) do
				local var_443_0 = iter_443_0 <= 2

				SetActive(iter_443_1.go, var_443_0)
			end

			arg_442_1.choices_[1].txt.text = arg_442_1:FormatText(StoryChoiceCfg[1419].name)
			arg_442_1.choices_[2].txt.text = arg_442_1:FormatText(StoryChoiceCfg[1420].name)
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play322161106(arg_442_1)
			end

			if arg_444_0 == 2 then
				arg_442_0:Play322161106(arg_442_1)
			end

			arg_442_1:RecordChoiceLog(322161105, 1419, 1420)
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.allBtn_.enabled = false
			end

			local var_445_1 = 0.6

			if arg_442_1.time_ >= var_445_0 + var_445_1 and arg_442_1.time_ < var_445_0 + var_445_1 + arg_445_0 then
				arg_442_1.allBtn_.enabled = true
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play322161106 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 322161106
		arg_446_1.duration_ = 13.7

		local var_446_0 = {
			zh = 11.1,
			ja = 13.7
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
				arg_446_0:Play322161107(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 2

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				local var_449_1 = manager.ui.mainCamera.transform.localPosition
				local var_449_2 = Vector3.New(0, 0, 10) + Vector3.New(var_449_1.x, var_449_1.y, 0)
				local var_449_3 = arg_446_1.bgs_.ST0510

				var_449_3.transform.localPosition = var_449_2
				var_449_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_4 = var_449_3:GetComponent("SpriteRenderer")

				if var_449_4 and var_449_4.sprite then
					local var_449_5 = (var_449_3.transform.localPosition - var_449_1).z
					local var_449_6 = manager.ui.mainCameraCom_
					local var_449_7 = 2 * var_449_5 * Mathf.Tan(var_449_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_449_8 = var_449_7 * var_449_6.aspect
					local var_449_9 = var_449_4.sprite.bounds.size.x
					local var_449_10 = var_449_4.sprite.bounds.size.y
					local var_449_11 = var_449_8 / var_449_9
					local var_449_12 = var_449_7 / var_449_10
					local var_449_13 = var_449_12 < var_449_11 and var_449_11 or var_449_12

					var_449_3.transform.localScale = Vector3.New(var_449_13, var_449_13, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "ST0510" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_14 = 4

			if var_449_14 < arg_446_1.time_ and arg_446_1.time_ <= var_449_14 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			local var_449_15 = 0.3

			if arg_446_1.time_ >= var_449_14 + var_449_15 and arg_446_1.time_ < var_449_14 + var_449_15 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			local var_449_16 = 0

			if var_449_16 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_17 = 2

			if var_449_16 <= arg_446_1.time_ and arg_446_1.time_ < var_449_16 + var_449_17 then
				local var_449_18 = (arg_446_1.time_ - var_449_16) / var_449_17
				local var_449_19 = Color.New(0, 0, 0)

				var_449_19.a = Mathf.Lerp(0, 1, var_449_18)
				arg_446_1.mask_.color = var_449_19
			end

			if arg_446_1.time_ >= var_449_16 + var_449_17 and arg_446_1.time_ < var_449_16 + var_449_17 + arg_449_0 then
				local var_449_20 = Color.New(0, 0, 0)

				var_449_20.a = 1
				arg_446_1.mask_.color = var_449_20
			end

			local var_449_21 = 2

			if var_449_21 < arg_446_1.time_ and arg_446_1.time_ <= var_449_21 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_22 = 2

			if var_449_21 <= arg_446_1.time_ and arg_446_1.time_ < var_449_21 + var_449_22 then
				local var_449_23 = (arg_446_1.time_ - var_449_21) / var_449_22
				local var_449_24 = Color.New(0, 0, 0)

				var_449_24.a = Mathf.Lerp(1, 0, var_449_23)
				arg_446_1.mask_.color = var_449_24
			end

			if arg_446_1.time_ >= var_449_21 + var_449_22 and arg_446_1.time_ < var_449_21 + var_449_22 + arg_449_0 then
				local var_449_25 = Color.New(0, 0, 0)
				local var_449_26 = 0

				arg_446_1.mask_.enabled = false
				var_449_25.a = var_449_26
				arg_446_1.mask_.color = var_449_25
			end

			local var_449_27 = "1044ui_story"

			if arg_446_1.actors_[var_449_27] == nil then
				local var_449_28 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_449_28) then
					local var_449_29 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_446_1.stage_.transform)

					var_449_29.name = var_449_27
					var_449_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_446_1.actors_[var_449_27] = var_449_29

					local var_449_30 = var_449_29:GetComponentInChildren(typeof(CharacterEffect))

					var_449_30.enabled = true

					local var_449_31 = GameObjectTools.GetOrAddComponent(var_449_29, typeof(DynamicBoneHelper))

					if var_449_31 then
						var_449_31:EnableDynamicBone(false)
					end

					arg_446_1:ShowWeapon(var_449_30.transform, false)

					arg_446_1.var_[var_449_27 .. "Animator"] = var_449_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_446_1.var_[var_449_27 .. "Animator"].applyRootMotion = true
					arg_446_1.var_[var_449_27 .. "LipSync"] = var_449_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_449_32 = arg_446_1.actors_["1044ui_story"].transform
			local var_449_33 = 3.96599999815226

			if var_449_33 < arg_446_1.time_ and arg_446_1.time_ <= var_449_33 + arg_449_0 then
				arg_446_1.var_.moveOldPos1044ui_story = var_449_32.localPosition
			end

			local var_449_34 = 0.001

			if var_449_33 <= arg_446_1.time_ and arg_446_1.time_ < var_449_33 + var_449_34 then
				local var_449_35 = (arg_446_1.time_ - var_449_33) / var_449_34
				local var_449_36 = Vector3.New(0, -1, -5.93)

				var_449_32.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1044ui_story, var_449_36, var_449_35)

				local var_449_37 = manager.ui.mainCamera.transform.position - var_449_32.position

				var_449_32.forward = Vector3.New(var_449_37.x, var_449_37.y, var_449_37.z)

				local var_449_38 = var_449_32.localEulerAngles

				var_449_38.z = 0
				var_449_38.x = 0
				var_449_32.localEulerAngles = var_449_38
			end

			if arg_446_1.time_ >= var_449_33 + var_449_34 and arg_446_1.time_ < var_449_33 + var_449_34 + arg_449_0 then
				var_449_32.localPosition = Vector3.New(0, -1, -5.93)

				local var_449_39 = manager.ui.mainCamera.transform.position - var_449_32.position

				var_449_32.forward = Vector3.New(var_449_39.x, var_449_39.y, var_449_39.z)

				local var_449_40 = var_449_32.localEulerAngles

				var_449_40.z = 0
				var_449_40.x = 0
				var_449_32.localEulerAngles = var_449_40
			end

			local var_449_41 = arg_446_1.actors_["1044ui_story"]
			local var_449_42 = 3.96599999815226

			if var_449_42 < arg_446_1.time_ and arg_446_1.time_ <= var_449_42 + arg_449_0 and not isNil(var_449_41) and arg_446_1.var_.characterEffect1044ui_story == nil then
				arg_446_1.var_.characterEffect1044ui_story = var_449_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_43 = 0.200000002980232

			if var_449_42 <= arg_446_1.time_ and arg_446_1.time_ < var_449_42 + var_449_43 and not isNil(var_449_41) then
				local var_449_44 = (arg_446_1.time_ - var_449_42) / var_449_43

				if arg_446_1.var_.characterEffect1044ui_story and not isNil(var_449_41) then
					arg_446_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= var_449_42 + var_449_43 and arg_446_1.time_ < var_449_42 + var_449_43 + arg_449_0 and not isNil(var_449_41) and arg_446_1.var_.characterEffect1044ui_story then
				arg_446_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_449_45 = "1044ui_story"

			if arg_446_1.actors_[var_449_45] == nil then
				local var_449_46 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_449_46) then
					local var_449_47 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_446_1.stage_.transform)

					var_449_47.name = var_449_45
					var_449_47.transform.localPosition = Vector3.New(0, 100, 0)
					arg_446_1.actors_[var_449_45] = var_449_47

					local var_449_48 = var_449_47:GetComponentInChildren(typeof(CharacterEffect))

					var_449_48.enabled = true

					local var_449_49 = GameObjectTools.GetOrAddComponent(var_449_47, typeof(DynamicBoneHelper))

					if var_449_49 then
						var_449_49:EnableDynamicBone(false)
					end

					arg_446_1:ShowWeapon(var_449_48.transform, false)

					arg_446_1.var_[var_449_45 .. "Animator"] = var_449_48.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_446_1.var_[var_449_45 .. "Animator"].applyRootMotion = true
					arg_446_1.var_[var_449_45 .. "LipSync"] = var_449_48.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_449_50 = 3.96599999815226

			if var_449_50 < arg_446_1.time_ and arg_446_1.time_ <= var_449_50 + arg_449_0 then
				arg_446_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_449_51 = "1044ui_story"

			if arg_446_1.actors_[var_449_51] == nil then
				local var_449_52 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_449_52) then
					local var_449_53 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_446_1.stage_.transform)

					var_449_53.name = var_449_51
					var_449_53.transform.localPosition = Vector3.New(0, 100, 0)
					arg_446_1.actors_[var_449_51] = var_449_53

					local var_449_54 = var_449_53:GetComponentInChildren(typeof(CharacterEffect))

					var_449_54.enabled = true

					local var_449_55 = GameObjectTools.GetOrAddComponent(var_449_53, typeof(DynamicBoneHelper))

					if var_449_55 then
						var_449_55:EnableDynamicBone(false)
					end

					arg_446_1:ShowWeapon(var_449_54.transform, false)

					arg_446_1.var_[var_449_51 .. "Animator"] = var_449_54.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_446_1.var_[var_449_51 .. "Animator"].applyRootMotion = true
					arg_446_1.var_[var_449_51 .. "LipSync"] = var_449_54.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_449_56 = 3.96599999815226

			if var_449_56 < arg_446_1.time_ and arg_446_1.time_ <= var_449_56 + arg_449_0 then
				arg_446_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if arg_446_1.frameCnt_ <= 1 then
				arg_446_1.dialog_:SetActive(false)
			end

			local var_449_57 = 4
			local var_449_58 = 0.75

			if var_449_57 < arg_446_1.time_ and arg_446_1.time_ <= var_449_57 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0

				arg_446_1.dialog_:SetActive(true)

				arg_446_1.dialogCg_.alpha = 0

				local var_449_59 = LeanTween.value(arg_446_1.dialog_, 0, 1, 0.3)

				var_449_59:setOnUpdate(LuaHelper.FloatAction(function(arg_450_0)
					arg_446_1.dialogCg_.alpha = arg_450_0
				end))
				var_449_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_446_1.dialog_)
					var_449_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_446_1.duration_ = arg_446_1.duration_ + 0.3

				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_60 = arg_446_1:FormatText(StoryNameCfg[1367].name)

				arg_446_1.leftNameTxt_.text = var_449_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_61 = arg_446_1:GetWordFromCfg(322161106)
				local var_449_62 = arg_446_1:FormatText(var_449_61.content)

				arg_446_1.text_.text = var_449_62

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_63 = 30
				local var_449_64 = utf8.len(var_449_62)
				local var_449_65 = var_449_63 <= 0 and var_449_58 or var_449_58 * (var_449_64 / var_449_63)

				if var_449_65 > 0 and var_449_58 < var_449_65 then
					arg_446_1.talkMaxDuration = var_449_65
					var_449_57 = var_449_57 + 0.3

					if var_449_65 + var_449_57 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_65 + var_449_57
					end
				end

				arg_446_1.text_.text = var_449_62
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161106", "story_v_out_322161.awb") ~= 0 then
					local var_449_66 = manager.audio:GetVoiceLength("story_v_out_322161", "322161106", "story_v_out_322161.awb") / 1000

					if var_449_66 + var_449_57 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_66 + var_449_57
					end

					if var_449_61.prefab_name ~= "" and arg_446_1.actors_[var_449_61.prefab_name] ~= nil then
						local var_449_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_61.prefab_name].transform, "story_v_out_322161", "322161106", "story_v_out_322161.awb")

						arg_446_1:RecordAudio("322161106", var_449_67)
						arg_446_1:RecordAudio("322161106", var_449_67)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_322161", "322161106", "story_v_out_322161.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_322161", "322161106", "story_v_out_322161.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_68 = var_449_57 + 0.3
			local var_449_69 = math.max(var_449_58, arg_446_1.talkMaxDuration)

			if var_449_68 <= arg_446_1.time_ and arg_446_1.time_ < var_449_68 + var_449_69 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_68) / var_449_69

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_68 + var_449_69 and arg_446_1.time_ < var_449_68 + var_449_69 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play322161107 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 322161107
		arg_452_1.duration_ = 13.33

		local var_452_0 = {
			zh = 9.066,
			ja = 13.333
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
				arg_452_0:Play322161108(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1044ui_story"].transform
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.var_.moveOldPos1044ui_story = var_455_0.localPosition
			end

			local var_455_2 = 0.001

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2
				local var_455_4 = Vector3.New(-0.7, -1, -5.93)

				var_455_0.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1044ui_story, var_455_4, var_455_3)

				local var_455_5 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_5.x, var_455_5.y, var_455_5.z)

				local var_455_6 = var_455_0.localEulerAngles

				var_455_6.z = 0
				var_455_6.x = 0
				var_455_0.localEulerAngles = var_455_6
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 then
				var_455_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_455_7 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_7.x, var_455_7.y, var_455_7.z)

				local var_455_8 = var_455_0.localEulerAngles

				var_455_8.z = 0
				var_455_8.x = 0
				var_455_0.localEulerAngles = var_455_8
			end

			local var_455_9 = arg_452_1.actors_["10104ui_story"].transform
			local var_455_10 = 0

			if var_455_10 < arg_452_1.time_ and arg_452_1.time_ <= var_455_10 + arg_455_0 then
				arg_452_1.var_.moveOldPos10104ui_story = var_455_9.localPosition
			end

			local var_455_11 = 0.001

			if var_455_10 <= arg_452_1.time_ and arg_452_1.time_ < var_455_10 + var_455_11 then
				local var_455_12 = (arg_452_1.time_ - var_455_10) / var_455_11
				local var_455_13 = Vector3.New(0.99, -1.12, -5.99)

				var_455_9.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos10104ui_story, var_455_13, var_455_12)

				local var_455_14 = manager.ui.mainCamera.transform.position - var_455_9.position

				var_455_9.forward = Vector3.New(var_455_14.x, var_455_14.y, var_455_14.z)

				local var_455_15 = var_455_9.localEulerAngles

				var_455_15.z = 0
				var_455_15.x = 0
				var_455_9.localEulerAngles = var_455_15
			end

			if arg_452_1.time_ >= var_455_10 + var_455_11 and arg_452_1.time_ < var_455_10 + var_455_11 + arg_455_0 then
				var_455_9.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_455_16 = manager.ui.mainCamera.transform.position - var_455_9.position

				var_455_9.forward = Vector3.New(var_455_16.x, var_455_16.y, var_455_16.z)

				local var_455_17 = var_455_9.localEulerAngles

				var_455_17.z = 0
				var_455_17.x = 0
				var_455_9.localEulerAngles = var_455_17
			end

			local var_455_18 = arg_452_1.actors_["10104ui_story"]
			local var_455_19 = 0

			if var_455_19 < arg_452_1.time_ and arg_452_1.time_ <= var_455_19 + arg_455_0 and not isNil(var_455_18) and arg_452_1.var_.characterEffect10104ui_story == nil then
				arg_452_1.var_.characterEffect10104ui_story = var_455_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_20 = 0.200000002980232

			if var_455_19 <= arg_452_1.time_ and arg_452_1.time_ < var_455_19 + var_455_20 and not isNil(var_455_18) then
				local var_455_21 = (arg_452_1.time_ - var_455_19) / var_455_20

				if arg_452_1.var_.characterEffect10104ui_story and not isNil(var_455_18) then
					arg_452_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= var_455_19 + var_455_20 and arg_452_1.time_ < var_455_19 + var_455_20 + arg_455_0 and not isNil(var_455_18) and arg_452_1.var_.characterEffect10104ui_story then
				arg_452_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_455_22 = 0

			if var_455_22 < arg_452_1.time_ and arg_452_1.time_ <= var_455_22 + arg_455_0 then
				arg_452_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_455_23 = 0

			if var_455_23 < arg_452_1.time_ and arg_452_1.time_ <= var_455_23 + arg_455_0 then
				arg_452_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_455_24 = arg_452_1.actors_["1044ui_story"]
			local var_455_25 = 0

			if var_455_25 < arg_452_1.time_ and arg_452_1.time_ <= var_455_25 + arg_455_0 and not isNil(var_455_24) and arg_452_1.var_.characterEffect1044ui_story == nil then
				arg_452_1.var_.characterEffect1044ui_story = var_455_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_26 = 0.200000002980232

			if var_455_25 <= arg_452_1.time_ and arg_452_1.time_ < var_455_25 + var_455_26 and not isNil(var_455_24) then
				local var_455_27 = (arg_452_1.time_ - var_455_25) / var_455_26

				if arg_452_1.var_.characterEffect1044ui_story and not isNil(var_455_24) then
					local var_455_28 = Mathf.Lerp(0, 0.5, var_455_27)

					arg_452_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1044ui_story.fillRatio = var_455_28
				end
			end

			if arg_452_1.time_ >= var_455_25 + var_455_26 and arg_452_1.time_ < var_455_25 + var_455_26 + arg_455_0 and not isNil(var_455_24) and arg_452_1.var_.characterEffect1044ui_story then
				local var_455_29 = 0.5

				arg_452_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1044ui_story.fillRatio = var_455_29
			end

			local var_455_30 = 0
			local var_455_31 = 1.075

			if var_455_30 < arg_452_1.time_ and arg_452_1.time_ <= var_455_30 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_32 = arg_452_1:FormatText(StoryNameCfg[1030].name)

				arg_452_1.leftNameTxt_.text = var_455_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_33 = arg_452_1:GetWordFromCfg(322161107)
				local var_455_34 = arg_452_1:FormatText(var_455_33.content)

				arg_452_1.text_.text = var_455_34

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_35 = 43
				local var_455_36 = utf8.len(var_455_34)
				local var_455_37 = var_455_35 <= 0 and var_455_31 or var_455_31 * (var_455_36 / var_455_35)

				if var_455_37 > 0 and var_455_31 < var_455_37 then
					arg_452_1.talkMaxDuration = var_455_37

					if var_455_37 + var_455_30 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_37 + var_455_30
					end
				end

				arg_452_1.text_.text = var_455_34
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161107", "story_v_out_322161.awb") ~= 0 then
					local var_455_38 = manager.audio:GetVoiceLength("story_v_out_322161", "322161107", "story_v_out_322161.awb") / 1000

					if var_455_38 + var_455_30 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_38 + var_455_30
					end

					if var_455_33.prefab_name ~= "" and arg_452_1.actors_[var_455_33.prefab_name] ~= nil then
						local var_455_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_33.prefab_name].transform, "story_v_out_322161", "322161107", "story_v_out_322161.awb")

						arg_452_1:RecordAudio("322161107", var_455_39)
						arg_452_1:RecordAudio("322161107", var_455_39)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_322161", "322161107", "story_v_out_322161.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_322161", "322161107", "story_v_out_322161.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_40 = math.max(var_455_31, arg_452_1.talkMaxDuration)

			if var_455_30 <= arg_452_1.time_ and arg_452_1.time_ < var_455_30 + var_455_40 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_30) / var_455_40

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_30 + var_455_40 and arg_452_1.time_ < var_455_30 + var_455_40 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_452_1:InitPlayNodeList()
	end,
	Play322161108 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 322161108
		arg_456_1.duration_ = 6.47

		local var_456_0 = {
			zh = 4.533,
			ja = 6.466
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play322161109(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["10104ui_story"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect10104ui_story == nil then
				arg_456_1.var_.characterEffect10104ui_story = var_459_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.characterEffect10104ui_story and not isNil(var_459_0) then
					local var_459_4 = Mathf.Lerp(0, 0.5, var_459_3)

					arg_456_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_456_1.var_.characterEffect10104ui_story.fillRatio = var_459_4
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.characterEffect10104ui_story then
				local var_459_5 = 0.5

				arg_456_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_456_1.var_.characterEffect10104ui_story.fillRatio = var_459_5
			end

			local var_459_6 = arg_456_1.actors_["1044ui_story"]
			local var_459_7 = 0

			if var_459_7 < arg_456_1.time_ and arg_456_1.time_ <= var_459_7 + arg_459_0 and not isNil(var_459_6) and arg_456_1.var_.characterEffect1044ui_story == nil then
				arg_456_1.var_.characterEffect1044ui_story = var_459_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_8 = 0.200000002980232

			if var_459_7 <= arg_456_1.time_ and arg_456_1.time_ < var_459_7 + var_459_8 and not isNil(var_459_6) then
				local var_459_9 = (arg_456_1.time_ - var_459_7) / var_459_8

				if arg_456_1.var_.characterEffect1044ui_story and not isNil(var_459_6) then
					arg_456_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_7 + var_459_8 and arg_456_1.time_ < var_459_7 + var_459_8 + arg_459_0 and not isNil(var_459_6) and arg_456_1.var_.characterEffect1044ui_story then
				arg_456_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_459_10 = 0

			if var_459_10 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 then
				arg_456_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_1")
			end

			local var_459_11 = 0

			if var_459_11 < arg_456_1.time_ and arg_456_1.time_ <= var_459_11 + arg_459_0 then
				arg_456_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_459_12 = 0
			local var_459_13 = 0.375

			if var_459_12 < arg_456_1.time_ and arg_456_1.time_ <= var_459_12 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_14 = arg_456_1:FormatText(StoryNameCfg[1367].name)

				arg_456_1.leftNameTxt_.text = var_459_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_15 = arg_456_1:GetWordFromCfg(322161108)
				local var_459_16 = arg_456_1:FormatText(var_459_15.content)

				arg_456_1.text_.text = var_459_16

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_17 = 15
				local var_459_18 = utf8.len(var_459_16)
				local var_459_19 = var_459_17 <= 0 and var_459_13 or var_459_13 * (var_459_18 / var_459_17)

				if var_459_19 > 0 and var_459_13 < var_459_19 then
					arg_456_1.talkMaxDuration = var_459_19

					if var_459_19 + var_459_12 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_19 + var_459_12
					end
				end

				arg_456_1.text_.text = var_459_16
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161108", "story_v_out_322161.awb") ~= 0 then
					local var_459_20 = manager.audio:GetVoiceLength("story_v_out_322161", "322161108", "story_v_out_322161.awb") / 1000

					if var_459_20 + var_459_12 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_20 + var_459_12
					end

					if var_459_15.prefab_name ~= "" and arg_456_1.actors_[var_459_15.prefab_name] ~= nil then
						local var_459_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_15.prefab_name].transform, "story_v_out_322161", "322161108", "story_v_out_322161.awb")

						arg_456_1:RecordAudio("322161108", var_459_21)
						arg_456_1:RecordAudio("322161108", var_459_21)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_322161", "322161108", "story_v_out_322161.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_322161", "322161108", "story_v_out_322161.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_22 = math.max(var_459_13, arg_456_1.talkMaxDuration)

			if var_459_12 <= arg_456_1.time_ and arg_456_1.time_ < var_459_12 + var_459_22 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_12) / var_459_22

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_12 + var_459_22 and arg_456_1.time_ < var_459_12 + var_459_22 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play322161109 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 322161109
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play322161110(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1044ui_story"].transform
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.var_.moveOldPos1044ui_story = var_463_0.localPosition
			end

			local var_463_2 = 0.001

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2
				local var_463_4 = Vector3.New(0, 100, 0)

				var_463_0.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1044ui_story, var_463_4, var_463_3)

				local var_463_5 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_5.x, var_463_5.y, var_463_5.z)

				local var_463_6 = var_463_0.localEulerAngles

				var_463_6.z = 0
				var_463_6.x = 0
				var_463_0.localEulerAngles = var_463_6
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 then
				var_463_0.localPosition = Vector3.New(0, 100, 0)

				local var_463_7 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_7.x, var_463_7.y, var_463_7.z)

				local var_463_8 = var_463_0.localEulerAngles

				var_463_8.z = 0
				var_463_8.x = 0
				var_463_0.localEulerAngles = var_463_8
			end

			local var_463_9 = arg_460_1.actors_["10104ui_story"].transform
			local var_463_10 = 0

			if var_463_10 < arg_460_1.time_ and arg_460_1.time_ <= var_463_10 + arg_463_0 then
				arg_460_1.var_.moveOldPos10104ui_story = var_463_9.localPosition
			end

			local var_463_11 = 0.001

			if var_463_10 <= arg_460_1.time_ and arg_460_1.time_ < var_463_10 + var_463_11 then
				local var_463_12 = (arg_460_1.time_ - var_463_10) / var_463_11
				local var_463_13 = Vector3.New(0, 100, 0)

				var_463_9.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos10104ui_story, var_463_13, var_463_12)

				local var_463_14 = manager.ui.mainCamera.transform.position - var_463_9.position

				var_463_9.forward = Vector3.New(var_463_14.x, var_463_14.y, var_463_14.z)

				local var_463_15 = var_463_9.localEulerAngles

				var_463_15.z = 0
				var_463_15.x = 0
				var_463_9.localEulerAngles = var_463_15
			end

			if arg_460_1.time_ >= var_463_10 + var_463_11 and arg_460_1.time_ < var_463_10 + var_463_11 + arg_463_0 then
				var_463_9.localPosition = Vector3.New(0, 100, 0)

				local var_463_16 = manager.ui.mainCamera.transform.position - var_463_9.position

				var_463_9.forward = Vector3.New(var_463_16.x, var_463_16.y, var_463_16.z)

				local var_463_17 = var_463_9.localEulerAngles

				var_463_17.z = 0
				var_463_17.x = 0
				var_463_9.localEulerAngles = var_463_17
			end

			local var_463_18 = 0
			local var_463_19 = 1.025

			if var_463_18 < arg_460_1.time_ and arg_460_1.time_ <= var_463_18 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_20 = arg_460_1:GetWordFromCfg(322161109)
				local var_463_21 = arg_460_1:FormatText(var_463_20.content)

				arg_460_1.text_.text = var_463_21

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_22 = 41
				local var_463_23 = utf8.len(var_463_21)
				local var_463_24 = var_463_22 <= 0 and var_463_19 or var_463_19 * (var_463_23 / var_463_22)

				if var_463_24 > 0 and var_463_19 < var_463_24 then
					arg_460_1.talkMaxDuration = var_463_24

					if var_463_24 + var_463_18 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_24 + var_463_18
					end
				end

				arg_460_1.text_.text = var_463_21
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_25 = math.max(var_463_19, arg_460_1.talkMaxDuration)

			if var_463_18 <= arg_460_1.time_ and arg_460_1.time_ < var_463_18 + var_463_25 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_18) / var_463_25

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_18 + var_463_25 and arg_460_1.time_ < var_463_18 + var_463_25 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_460_1:InitPlayNodeList()
	end,
	Play322161110 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 322161110
		arg_464_1.duration_ = 8.07

		local var_464_0 = {
			zh = 6.466,
			ja = 8.066
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play322161111(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1044ui_story"].transform
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.var_.moveOldPos1044ui_story = var_467_0.localPosition

				local var_467_2 = "1044ui_story"

				arg_464_1:ShowWeapon(arg_464_1.var_[var_467_2 .. "Animator"].transform, false)
			end

			local var_467_3 = 0.001

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_3 then
				local var_467_4 = (arg_464_1.time_ - var_467_1) / var_467_3
				local var_467_5 = Vector3.New(0, -1, -5.93)

				var_467_0.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1044ui_story, var_467_5, var_467_4)

				local var_467_6 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_6.x, var_467_6.y, var_467_6.z)

				local var_467_7 = var_467_0.localEulerAngles

				var_467_7.z = 0
				var_467_7.x = 0
				var_467_0.localEulerAngles = var_467_7
			end

			if arg_464_1.time_ >= var_467_1 + var_467_3 and arg_464_1.time_ < var_467_1 + var_467_3 + arg_467_0 then
				var_467_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_467_8 = manager.ui.mainCamera.transform.position - var_467_0.position

				var_467_0.forward = Vector3.New(var_467_8.x, var_467_8.y, var_467_8.z)

				local var_467_9 = var_467_0.localEulerAngles

				var_467_9.z = 0
				var_467_9.x = 0
				var_467_0.localEulerAngles = var_467_9
			end

			local var_467_10 = arg_464_1.actors_["1044ui_story"]
			local var_467_11 = 0

			if var_467_11 < arg_464_1.time_ and arg_464_1.time_ <= var_467_11 + arg_467_0 and not isNil(var_467_10) and arg_464_1.var_.characterEffect1044ui_story == nil then
				arg_464_1.var_.characterEffect1044ui_story = var_467_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_12 = 0.200000002980232

			if var_467_11 <= arg_464_1.time_ and arg_464_1.time_ < var_467_11 + var_467_12 and not isNil(var_467_10) then
				local var_467_13 = (arg_464_1.time_ - var_467_11) / var_467_12

				if arg_464_1.var_.characterEffect1044ui_story and not isNil(var_467_10) then
					arg_464_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= var_467_11 + var_467_12 and arg_464_1.time_ < var_467_11 + var_467_12 + arg_467_0 and not isNil(var_467_10) and arg_464_1.var_.characterEffect1044ui_story then
				arg_464_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_467_14 = 0

			if var_467_14 < arg_464_1.time_ and arg_464_1.time_ <= var_467_14 + arg_467_0 then
				arg_464_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action7_2")
			end

			local var_467_15 = 0

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 then
				arg_464_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_467_16 = 0
			local var_467_17 = 0.7

			if var_467_16 < arg_464_1.time_ and arg_464_1.time_ <= var_467_16 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_18 = arg_464_1:FormatText(StoryNameCfg[1367].name)

				arg_464_1.leftNameTxt_.text = var_467_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_19 = arg_464_1:GetWordFromCfg(322161110)
				local var_467_20 = arg_464_1:FormatText(var_467_19.content)

				arg_464_1.text_.text = var_467_20

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_21 = 28
				local var_467_22 = utf8.len(var_467_20)
				local var_467_23 = var_467_21 <= 0 and var_467_17 or var_467_17 * (var_467_22 / var_467_21)

				if var_467_23 > 0 and var_467_17 < var_467_23 then
					arg_464_1.talkMaxDuration = var_467_23

					if var_467_23 + var_467_16 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_23 + var_467_16
					end
				end

				arg_464_1.text_.text = var_467_20
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161110", "story_v_out_322161.awb") ~= 0 then
					local var_467_24 = manager.audio:GetVoiceLength("story_v_out_322161", "322161110", "story_v_out_322161.awb") / 1000

					if var_467_24 + var_467_16 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_24 + var_467_16
					end

					if var_467_19.prefab_name ~= "" and arg_464_1.actors_[var_467_19.prefab_name] ~= nil then
						local var_467_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_19.prefab_name].transform, "story_v_out_322161", "322161110", "story_v_out_322161.awb")

						arg_464_1:RecordAudio("322161110", var_467_25)
						arg_464_1:RecordAudio("322161110", var_467_25)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_322161", "322161110", "story_v_out_322161.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_322161", "322161110", "story_v_out_322161.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_26 = math.max(var_467_17, arg_464_1.talkMaxDuration)

			if var_467_16 <= arg_464_1.time_ and arg_464_1.time_ < var_467_16 + var_467_26 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_16) / var_467_26

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_16 + var_467_26 and arg_464_1.time_ < var_467_16 + var_467_26 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play322161111 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 322161111
		arg_468_1.duration_ = 2.47

		local var_468_0 = {
			zh = 2.466,
			ja = 2.3
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play322161112(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1044ui_story"].transform
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 then
				arg_468_1.var_.moveOldPos1044ui_story = var_471_0.localPosition
			end

			local var_471_2 = 0.001

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2
				local var_471_4 = Vector3.New(-0.7, -1, -5.93)

				var_471_0.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1044ui_story, var_471_4, var_471_3)

				local var_471_5 = manager.ui.mainCamera.transform.position - var_471_0.position

				var_471_0.forward = Vector3.New(var_471_5.x, var_471_5.y, var_471_5.z)

				local var_471_6 = var_471_0.localEulerAngles

				var_471_6.z = 0
				var_471_6.x = 0
				var_471_0.localEulerAngles = var_471_6
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 then
				var_471_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_471_7 = manager.ui.mainCamera.transform.position - var_471_0.position

				var_471_0.forward = Vector3.New(var_471_7.x, var_471_7.y, var_471_7.z)

				local var_471_8 = var_471_0.localEulerAngles

				var_471_8.z = 0
				var_471_8.x = 0
				var_471_0.localEulerAngles = var_471_8
			end

			local var_471_9 = arg_468_1.actors_["10102ui_story"].transform
			local var_471_10 = 0

			if var_471_10 < arg_468_1.time_ and arg_468_1.time_ <= var_471_10 + arg_471_0 then
				arg_468_1.var_.moveOldPos10102ui_story = var_471_9.localPosition
			end

			local var_471_11 = 0.001

			if var_471_10 <= arg_468_1.time_ and arg_468_1.time_ < var_471_10 + var_471_11 then
				local var_471_12 = (arg_468_1.time_ - var_471_10) / var_471_11
				local var_471_13 = Vector3.New(0.7, -0.985, -6.275)

				var_471_9.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos10102ui_story, var_471_13, var_471_12)

				local var_471_14 = manager.ui.mainCamera.transform.position - var_471_9.position

				var_471_9.forward = Vector3.New(var_471_14.x, var_471_14.y, var_471_14.z)

				local var_471_15 = var_471_9.localEulerAngles

				var_471_15.z = 0
				var_471_15.x = 0
				var_471_9.localEulerAngles = var_471_15
			end

			if arg_468_1.time_ >= var_471_10 + var_471_11 and arg_468_1.time_ < var_471_10 + var_471_11 + arg_471_0 then
				var_471_9.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_471_16 = manager.ui.mainCamera.transform.position - var_471_9.position

				var_471_9.forward = Vector3.New(var_471_16.x, var_471_16.y, var_471_16.z)

				local var_471_17 = var_471_9.localEulerAngles

				var_471_17.z = 0
				var_471_17.x = 0
				var_471_9.localEulerAngles = var_471_17
			end

			local var_471_18 = arg_468_1.actors_["10102ui_story"]
			local var_471_19 = 0

			if var_471_19 < arg_468_1.time_ and arg_468_1.time_ <= var_471_19 + arg_471_0 and not isNil(var_471_18) and arg_468_1.var_.characterEffect10102ui_story == nil then
				arg_468_1.var_.characterEffect10102ui_story = var_471_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_20 = 0.200000002980232

			if var_471_19 <= arg_468_1.time_ and arg_468_1.time_ < var_471_19 + var_471_20 and not isNil(var_471_18) then
				local var_471_21 = (arg_468_1.time_ - var_471_19) / var_471_20

				if arg_468_1.var_.characterEffect10102ui_story and not isNil(var_471_18) then
					arg_468_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= var_471_19 + var_471_20 and arg_468_1.time_ < var_471_19 + var_471_20 + arg_471_0 and not isNil(var_471_18) and arg_468_1.var_.characterEffect10102ui_story then
				arg_468_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_471_22 = 0

			if var_471_22 < arg_468_1.time_ and arg_468_1.time_ <= var_471_22 + arg_471_0 then
				arg_468_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_471_23 = 0

			if var_471_23 < arg_468_1.time_ and arg_468_1.time_ <= var_471_23 + arg_471_0 then
				arg_468_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_471_24 = arg_468_1.actors_["1044ui_story"]
			local var_471_25 = 0

			if var_471_25 < arg_468_1.time_ and arg_468_1.time_ <= var_471_25 + arg_471_0 and not isNil(var_471_24) and arg_468_1.var_.characterEffect1044ui_story == nil then
				arg_468_1.var_.characterEffect1044ui_story = var_471_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_26 = 0.200000002980232

			if var_471_25 <= arg_468_1.time_ and arg_468_1.time_ < var_471_25 + var_471_26 and not isNil(var_471_24) then
				local var_471_27 = (arg_468_1.time_ - var_471_25) / var_471_26

				if arg_468_1.var_.characterEffect1044ui_story and not isNil(var_471_24) then
					local var_471_28 = Mathf.Lerp(0, 0.5, var_471_27)

					arg_468_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1044ui_story.fillRatio = var_471_28
				end
			end

			if arg_468_1.time_ >= var_471_25 + var_471_26 and arg_468_1.time_ < var_471_25 + var_471_26 + arg_471_0 and not isNil(var_471_24) and arg_468_1.var_.characterEffect1044ui_story then
				local var_471_29 = 0.5

				arg_468_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1044ui_story.fillRatio = var_471_29
			end

			local var_471_30 = 0
			local var_471_31 = 0.275

			if var_471_30 < arg_468_1.time_ and arg_468_1.time_ <= var_471_30 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_32 = arg_468_1:FormatText(StoryNameCfg[6].name)

				arg_468_1.leftNameTxt_.text = var_471_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_33 = arg_468_1:GetWordFromCfg(322161111)
				local var_471_34 = arg_468_1:FormatText(var_471_33.content)

				arg_468_1.text_.text = var_471_34

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_35 = 11
				local var_471_36 = utf8.len(var_471_34)
				local var_471_37 = var_471_35 <= 0 and var_471_31 or var_471_31 * (var_471_36 / var_471_35)

				if var_471_37 > 0 and var_471_31 < var_471_37 then
					arg_468_1.talkMaxDuration = var_471_37

					if var_471_37 + var_471_30 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_37 + var_471_30
					end
				end

				arg_468_1.text_.text = var_471_34
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161111", "story_v_out_322161.awb") ~= 0 then
					local var_471_38 = manager.audio:GetVoiceLength("story_v_out_322161", "322161111", "story_v_out_322161.awb") / 1000

					if var_471_38 + var_471_30 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_38 + var_471_30
					end

					if var_471_33.prefab_name ~= "" and arg_468_1.actors_[var_471_33.prefab_name] ~= nil then
						local var_471_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_33.prefab_name].transform, "story_v_out_322161", "322161111", "story_v_out_322161.awb")

						arg_468_1:RecordAudio("322161111", var_471_39)
						arg_468_1:RecordAudio("322161111", var_471_39)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_322161", "322161111", "story_v_out_322161.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_322161", "322161111", "story_v_out_322161.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_40 = math.max(var_471_31, arg_468_1.talkMaxDuration)

			if var_471_30 <= arg_468_1.time_ and arg_468_1.time_ < var_471_30 + var_471_40 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_30) / var_471_40

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_30 + var_471_40 and arg_468_1.time_ < var_471_30 + var_471_40 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_468_1:InitPlayNodeList()
	end,
	Play322161112 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 322161112
		arg_472_1.duration_ = 4.4

		local var_472_0 = {
			zh = 2.966,
			ja = 4.4
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play322161113(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["10102ui_story"]
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect10102ui_story == nil then
				arg_472_1.var_.characterEffect10102ui_story = var_475_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 and not isNil(var_475_0) then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / var_475_2

				if arg_472_1.var_.characterEffect10102ui_story and not isNil(var_475_0) then
					local var_475_4 = Mathf.Lerp(0, 0.5, var_475_3)

					arg_472_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_472_1.var_.characterEffect10102ui_story.fillRatio = var_475_4
				end
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 and not isNil(var_475_0) and arg_472_1.var_.characterEffect10102ui_story then
				local var_475_5 = 0.5

				arg_472_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_472_1.var_.characterEffect10102ui_story.fillRatio = var_475_5
			end

			local var_475_6 = arg_472_1.actors_["1044ui_story"]
			local var_475_7 = 0

			if var_475_7 < arg_472_1.time_ and arg_472_1.time_ <= var_475_7 + arg_475_0 and not isNil(var_475_6) and arg_472_1.var_.characterEffect1044ui_story == nil then
				arg_472_1.var_.characterEffect1044ui_story = var_475_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_8 = 0.200000002980232

			if var_475_7 <= arg_472_1.time_ and arg_472_1.time_ < var_475_7 + var_475_8 and not isNil(var_475_6) then
				local var_475_9 = (arg_472_1.time_ - var_475_7) / var_475_8

				if arg_472_1.var_.characterEffect1044ui_story and not isNil(var_475_6) then
					arg_472_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= var_475_7 + var_475_8 and arg_472_1.time_ < var_475_7 + var_475_8 + arg_475_0 and not isNil(var_475_6) and arg_472_1.var_.characterEffect1044ui_story then
				arg_472_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_475_10 = 0

			if var_475_10 < arg_472_1.time_ and arg_472_1.time_ <= var_475_10 + arg_475_0 then
				arg_472_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_475_11 = 0
			local var_475_12 = 0.3

			if var_475_11 < arg_472_1.time_ and arg_472_1.time_ <= var_475_11 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_13 = arg_472_1:FormatText(StoryNameCfg[1367].name)

				arg_472_1.leftNameTxt_.text = var_475_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_14 = arg_472_1:GetWordFromCfg(322161112)
				local var_475_15 = arg_472_1:FormatText(var_475_14.content)

				arg_472_1.text_.text = var_475_15

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_16 = 12
				local var_475_17 = utf8.len(var_475_15)
				local var_475_18 = var_475_16 <= 0 and var_475_12 or var_475_12 * (var_475_17 / var_475_16)

				if var_475_18 > 0 and var_475_12 < var_475_18 then
					arg_472_1.talkMaxDuration = var_475_18

					if var_475_18 + var_475_11 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_18 + var_475_11
					end
				end

				arg_472_1.text_.text = var_475_15
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161112", "story_v_out_322161.awb") ~= 0 then
					local var_475_19 = manager.audio:GetVoiceLength("story_v_out_322161", "322161112", "story_v_out_322161.awb") / 1000

					if var_475_19 + var_475_11 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_19 + var_475_11
					end

					if var_475_14.prefab_name ~= "" and arg_472_1.actors_[var_475_14.prefab_name] ~= nil then
						local var_475_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_14.prefab_name].transform, "story_v_out_322161", "322161112", "story_v_out_322161.awb")

						arg_472_1:RecordAudio("322161112", var_475_20)
						arg_472_1:RecordAudio("322161112", var_475_20)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_322161", "322161112", "story_v_out_322161.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_322161", "322161112", "story_v_out_322161.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_21 = math.max(var_475_12, arg_472_1.talkMaxDuration)

			if var_475_11 <= arg_472_1.time_ and arg_472_1.time_ < var_475_11 + var_475_21 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_11) / var_475_21

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_11 + var_475_21 and arg_472_1.time_ < var_475_11 + var_475_21 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play322161113 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 322161113
		arg_476_1.duration_ = 5.9

		local var_476_0 = {
			zh = 4.766,
			ja = 5.9
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play322161114(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["10102ui_story"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect10102ui_story == nil then
				arg_476_1.var_.characterEffect10102ui_story = var_479_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_2 = 0.200000002980232

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.characterEffect10102ui_story and not isNil(var_479_0) then
					arg_476_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.characterEffect10102ui_story then
				arg_476_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_479_4 = arg_476_1.actors_["1044ui_story"]
			local var_479_5 = 0

			if var_479_5 < arg_476_1.time_ and arg_476_1.time_ <= var_479_5 + arg_479_0 and not isNil(var_479_4) and arg_476_1.var_.characterEffect1044ui_story == nil then
				arg_476_1.var_.characterEffect1044ui_story = var_479_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_6 = 0.200000002980232

			if var_479_5 <= arg_476_1.time_ and arg_476_1.time_ < var_479_5 + var_479_6 and not isNil(var_479_4) then
				local var_479_7 = (arg_476_1.time_ - var_479_5) / var_479_6

				if arg_476_1.var_.characterEffect1044ui_story and not isNil(var_479_4) then
					local var_479_8 = Mathf.Lerp(0, 0.5, var_479_7)

					arg_476_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1044ui_story.fillRatio = var_479_8
				end
			end

			if arg_476_1.time_ >= var_479_5 + var_479_6 and arg_476_1.time_ < var_479_5 + var_479_6 + arg_479_0 and not isNil(var_479_4) and arg_476_1.var_.characterEffect1044ui_story then
				local var_479_9 = 0.5

				arg_476_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1044ui_story.fillRatio = var_479_9
			end

			local var_479_10 = 0

			if var_479_10 < arg_476_1.time_ and arg_476_1.time_ <= var_479_10 + arg_479_0 then
				arg_476_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action424")
			end

			local var_479_11 = 0

			if var_479_11 < arg_476_1.time_ and arg_476_1.time_ <= var_479_11 + arg_479_0 then
				arg_476_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_479_12 = 0
			local var_479_13 = 0.475

			if var_479_12 < arg_476_1.time_ and arg_476_1.time_ <= var_479_12 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_14 = arg_476_1:FormatText(StoryNameCfg[6].name)

				arg_476_1.leftNameTxt_.text = var_479_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_15 = arg_476_1:GetWordFromCfg(322161113)
				local var_479_16 = arg_476_1:FormatText(var_479_15.content)

				arg_476_1.text_.text = var_479_16

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_17 = 19
				local var_479_18 = utf8.len(var_479_16)
				local var_479_19 = var_479_17 <= 0 and var_479_13 or var_479_13 * (var_479_18 / var_479_17)

				if var_479_19 > 0 and var_479_13 < var_479_19 then
					arg_476_1.talkMaxDuration = var_479_19

					if var_479_19 + var_479_12 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_19 + var_479_12
					end
				end

				arg_476_1.text_.text = var_479_16
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161113", "story_v_out_322161.awb") ~= 0 then
					local var_479_20 = manager.audio:GetVoiceLength("story_v_out_322161", "322161113", "story_v_out_322161.awb") / 1000

					if var_479_20 + var_479_12 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_20 + var_479_12
					end

					if var_479_15.prefab_name ~= "" and arg_476_1.actors_[var_479_15.prefab_name] ~= nil then
						local var_479_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_15.prefab_name].transform, "story_v_out_322161", "322161113", "story_v_out_322161.awb")

						arg_476_1:RecordAudio("322161113", var_479_21)
						arg_476_1:RecordAudio("322161113", var_479_21)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_322161", "322161113", "story_v_out_322161.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_322161", "322161113", "story_v_out_322161.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_22 = math.max(var_479_13, arg_476_1.talkMaxDuration)

			if var_479_12 <= arg_476_1.time_ and arg_476_1.time_ < var_479_12 + var_479_22 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_12) / var_479_22

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_12 + var_479_22 and arg_476_1.time_ < var_479_12 + var_479_22 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play322161114 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 322161114
		arg_480_1.duration_ = 17.63

		local var_480_0 = {
			zh = 8.6,
			ja = 17.633
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play322161115(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["10102ui_story"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos10102ui_story = var_483_0.localPosition
			end

			local var_483_2 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2
				local var_483_4 = Vector3.New(0, 100, 0)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10102ui_story, var_483_4, var_483_3)

				local var_483_5 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_5.x, var_483_5.y, var_483_5.z)

				local var_483_6 = var_483_0.localEulerAngles

				var_483_6.z = 0
				var_483_6.x = 0
				var_483_0.localEulerAngles = var_483_6
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, 100, 0)

				local var_483_7 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_7.x, var_483_7.y, var_483_7.z)

				local var_483_8 = var_483_0.localEulerAngles

				var_483_8.z = 0
				var_483_8.x = 0
				var_483_0.localEulerAngles = var_483_8
			end

			local var_483_9 = arg_480_1.actors_["10104ui_story"].transform
			local var_483_10 = 0

			if var_483_10 < arg_480_1.time_ and arg_480_1.time_ <= var_483_10 + arg_483_0 then
				arg_480_1.var_.moveOldPos10104ui_story = var_483_9.localPosition
			end

			local var_483_11 = 0.001

			if var_483_10 <= arg_480_1.time_ and arg_480_1.time_ < var_483_10 + var_483_11 then
				local var_483_12 = (arg_480_1.time_ - var_483_10) / var_483_11
				local var_483_13 = Vector3.New(0.99, -1.12, -5.99)

				var_483_9.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10104ui_story, var_483_13, var_483_12)

				local var_483_14 = manager.ui.mainCamera.transform.position - var_483_9.position

				var_483_9.forward = Vector3.New(var_483_14.x, var_483_14.y, var_483_14.z)

				local var_483_15 = var_483_9.localEulerAngles

				var_483_15.z = 0
				var_483_15.x = 0
				var_483_9.localEulerAngles = var_483_15
			end

			if arg_480_1.time_ >= var_483_10 + var_483_11 and arg_480_1.time_ < var_483_10 + var_483_11 + arg_483_0 then
				var_483_9.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_483_16 = manager.ui.mainCamera.transform.position - var_483_9.position

				var_483_9.forward = Vector3.New(var_483_16.x, var_483_16.y, var_483_16.z)

				local var_483_17 = var_483_9.localEulerAngles

				var_483_17.z = 0
				var_483_17.x = 0
				var_483_9.localEulerAngles = var_483_17
			end

			local var_483_18 = arg_480_1.actors_["10104ui_story"]
			local var_483_19 = 0

			if var_483_19 < arg_480_1.time_ and arg_480_1.time_ <= var_483_19 + arg_483_0 and not isNil(var_483_18) and arg_480_1.var_.characterEffect10104ui_story == nil then
				arg_480_1.var_.characterEffect10104ui_story = var_483_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_20 = 0.200000002980232

			if var_483_19 <= arg_480_1.time_ and arg_480_1.time_ < var_483_19 + var_483_20 and not isNil(var_483_18) then
				local var_483_21 = (arg_480_1.time_ - var_483_19) / var_483_20

				if arg_480_1.var_.characterEffect10104ui_story and not isNil(var_483_18) then
					arg_480_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= var_483_19 + var_483_20 and arg_480_1.time_ < var_483_19 + var_483_20 + arg_483_0 and not isNil(var_483_18) and arg_480_1.var_.characterEffect10104ui_story then
				arg_480_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_483_22 = arg_480_1.actors_["10102ui_story"]
			local var_483_23 = 0

			if var_483_23 < arg_480_1.time_ and arg_480_1.time_ <= var_483_23 + arg_483_0 and not isNil(var_483_22) and arg_480_1.var_.characterEffect10102ui_story == nil then
				arg_480_1.var_.characterEffect10102ui_story = var_483_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_24 = 0.200000002980232

			if var_483_23 <= arg_480_1.time_ and arg_480_1.time_ < var_483_23 + var_483_24 and not isNil(var_483_22) then
				local var_483_25 = (arg_480_1.time_ - var_483_23) / var_483_24

				if arg_480_1.var_.characterEffect10102ui_story and not isNil(var_483_22) then
					local var_483_26 = Mathf.Lerp(0, 0.5, var_483_25)

					arg_480_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_480_1.var_.characterEffect10102ui_story.fillRatio = var_483_26
				end
			end

			if arg_480_1.time_ >= var_483_23 + var_483_24 and arg_480_1.time_ < var_483_23 + var_483_24 + arg_483_0 and not isNil(var_483_22) and arg_480_1.var_.characterEffect10102ui_story then
				local var_483_27 = 0.5

				arg_480_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_480_1.var_.characterEffect10102ui_story.fillRatio = var_483_27
			end

			local var_483_28 = 0

			if var_483_28 < arg_480_1.time_ and arg_480_1.time_ <= var_483_28 + arg_483_0 then
				arg_480_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_483_29 = 0

			if var_483_29 < arg_480_1.time_ and arg_480_1.time_ <= var_483_29 + arg_483_0 then
				arg_480_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_483_30 = 0
			local var_483_31 = 1.15

			if var_483_30 < arg_480_1.time_ and arg_480_1.time_ <= var_483_30 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_32 = arg_480_1:FormatText(StoryNameCfg[1030].name)

				arg_480_1.leftNameTxt_.text = var_483_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_33 = arg_480_1:GetWordFromCfg(322161114)
				local var_483_34 = arg_480_1:FormatText(var_483_33.content)

				arg_480_1.text_.text = var_483_34

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_35 = 46
				local var_483_36 = utf8.len(var_483_34)
				local var_483_37 = var_483_35 <= 0 and var_483_31 or var_483_31 * (var_483_36 / var_483_35)

				if var_483_37 > 0 and var_483_31 < var_483_37 then
					arg_480_1.talkMaxDuration = var_483_37

					if var_483_37 + var_483_30 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_37 + var_483_30
					end
				end

				arg_480_1.text_.text = var_483_34
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161114", "story_v_out_322161.awb") ~= 0 then
					local var_483_38 = manager.audio:GetVoiceLength("story_v_out_322161", "322161114", "story_v_out_322161.awb") / 1000

					if var_483_38 + var_483_30 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_38 + var_483_30
					end

					if var_483_33.prefab_name ~= "" and arg_480_1.actors_[var_483_33.prefab_name] ~= nil then
						local var_483_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_33.prefab_name].transform, "story_v_out_322161", "322161114", "story_v_out_322161.awb")

						arg_480_1:RecordAudio("322161114", var_483_39)
						arg_480_1:RecordAudio("322161114", var_483_39)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_322161", "322161114", "story_v_out_322161.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_322161", "322161114", "story_v_out_322161.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_40 = math.max(var_483_31, arg_480_1.talkMaxDuration)

			if var_483_30 <= arg_480_1.time_ and arg_480_1.time_ < var_483_30 + var_483_40 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_30) / var_483_40

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_30 + var_483_40 and arg_480_1.time_ < var_483_30 + var_483_40 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
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
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play322161115 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 322161115
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play322161116(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["10104ui_story"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect10104ui_story == nil then
				arg_484_1.var_.characterEffect10104ui_story = var_487_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.200000002980232

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.characterEffect10104ui_story and not isNil(var_487_0) then
					local var_487_4 = Mathf.Lerp(0, 0.5, var_487_3)

					arg_484_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_484_1.var_.characterEffect10104ui_story.fillRatio = var_487_4
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect10104ui_story then
				local var_487_5 = 0.5

				arg_484_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_484_1.var_.characterEffect10104ui_story.fillRatio = var_487_5
			end

			local var_487_6 = 0
			local var_487_7 = 0.15

			if var_487_6 < arg_484_1.time_ and arg_484_1.time_ <= var_487_6 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_8 = arg_484_1:FormatText(StoryNameCfg[7].name)

				arg_484_1.leftNameTxt_.text = var_487_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_9 = arg_484_1:GetWordFromCfg(322161115)
				local var_487_10 = arg_484_1:FormatText(var_487_9.content)

				arg_484_1.text_.text = var_487_10

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_11 = 6
				local var_487_12 = utf8.len(var_487_10)
				local var_487_13 = var_487_11 <= 0 and var_487_7 or var_487_7 * (var_487_12 / var_487_11)

				if var_487_13 > 0 and var_487_7 < var_487_13 then
					arg_484_1.talkMaxDuration = var_487_13

					if var_487_13 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_13 + var_487_6
					end
				end

				arg_484_1.text_.text = var_487_10
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_14 = math.max(var_487_7, arg_484_1.talkMaxDuration)

			if var_487_6 <= arg_484_1.time_ and arg_484_1.time_ < var_487_6 + var_487_14 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_6) / var_487_14

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_6 + var_487_14 and arg_484_1.time_ < var_487_6 + var_487_14 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play322161116 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 322161116
		arg_488_1.duration_ = 4.43

		local var_488_0 = {
			zh = 4.433,
			ja = 4.3
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play322161117(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1044ui_story"]
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1044ui_story == nil then
				arg_488_1.var_.characterEffect1044ui_story = var_491_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.2

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 and not isNil(var_491_0) then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2

				if arg_488_1.var_.characterEffect1044ui_story and not isNil(var_491_0) then
					arg_488_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1044ui_story then
				arg_488_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_491_4 = 0

			if var_491_4 < arg_488_1.time_ and arg_488_1.time_ <= var_491_4 + arg_491_0 then
				arg_488_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_1")
			end

			local var_491_5 = 0

			if var_491_5 < arg_488_1.time_ and arg_488_1.time_ <= var_491_5 + arg_491_0 then
				arg_488_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_491_6 = 0
			local var_491_7 = 0.4

			if var_491_6 < arg_488_1.time_ and arg_488_1.time_ <= var_491_6 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_8 = arg_488_1:FormatText(StoryNameCfg[1367].name)

				arg_488_1.leftNameTxt_.text = var_491_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_9 = arg_488_1:GetWordFromCfg(322161116)
				local var_491_10 = arg_488_1:FormatText(var_491_9.content)

				arg_488_1.text_.text = var_491_10

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_11 = 16
				local var_491_12 = utf8.len(var_491_10)
				local var_491_13 = var_491_11 <= 0 and var_491_7 or var_491_7 * (var_491_12 / var_491_11)

				if var_491_13 > 0 and var_491_7 < var_491_13 then
					arg_488_1.talkMaxDuration = var_491_13

					if var_491_13 + var_491_6 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_13 + var_491_6
					end
				end

				arg_488_1.text_.text = var_491_10
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161116", "story_v_out_322161.awb") ~= 0 then
					local var_491_14 = manager.audio:GetVoiceLength("story_v_out_322161", "322161116", "story_v_out_322161.awb") / 1000

					if var_491_14 + var_491_6 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_14 + var_491_6
					end

					if var_491_9.prefab_name ~= "" and arg_488_1.actors_[var_491_9.prefab_name] ~= nil then
						local var_491_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_9.prefab_name].transform, "story_v_out_322161", "322161116", "story_v_out_322161.awb")

						arg_488_1:RecordAudio("322161116", var_491_15)
						arg_488_1:RecordAudio("322161116", var_491_15)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_322161", "322161116", "story_v_out_322161.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_322161", "322161116", "story_v_out_322161.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_16 = math.max(var_491_7, arg_488_1.talkMaxDuration)

			if var_491_6 <= arg_488_1.time_ and arg_488_1.time_ < var_491_6 + var_491_16 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_6) / var_491_16

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_6 + var_491_16 and arg_488_1.time_ < var_491_6 + var_491_16 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play322161117 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 322161117
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play322161118(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1044ui_story"].transform
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.var_.moveOldPos1044ui_story = var_495_0.localPosition
			end

			local var_495_2 = 0.001

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2
				local var_495_4 = Vector3.New(0, 100, 0)

				var_495_0.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1044ui_story, var_495_4, var_495_3)

				local var_495_5 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_5.x, var_495_5.y, var_495_5.z)

				local var_495_6 = var_495_0.localEulerAngles

				var_495_6.z = 0
				var_495_6.x = 0
				var_495_0.localEulerAngles = var_495_6
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 then
				var_495_0.localPosition = Vector3.New(0, 100, 0)

				local var_495_7 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_7.x, var_495_7.y, var_495_7.z)

				local var_495_8 = var_495_0.localEulerAngles

				var_495_8.z = 0
				var_495_8.x = 0
				var_495_0.localEulerAngles = var_495_8
			end

			local var_495_9 = arg_492_1.actors_["10104ui_story"].transform
			local var_495_10 = 0

			if var_495_10 < arg_492_1.time_ and arg_492_1.time_ <= var_495_10 + arg_495_0 then
				arg_492_1.var_.moveOldPos10104ui_story = var_495_9.localPosition
			end

			local var_495_11 = 0.001

			if var_495_10 <= arg_492_1.time_ and arg_492_1.time_ < var_495_10 + var_495_11 then
				local var_495_12 = (arg_492_1.time_ - var_495_10) / var_495_11
				local var_495_13 = Vector3.New(0, 100, 0)

				var_495_9.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10104ui_story, var_495_13, var_495_12)

				local var_495_14 = manager.ui.mainCamera.transform.position - var_495_9.position

				var_495_9.forward = Vector3.New(var_495_14.x, var_495_14.y, var_495_14.z)

				local var_495_15 = var_495_9.localEulerAngles

				var_495_15.z = 0
				var_495_15.x = 0
				var_495_9.localEulerAngles = var_495_15
			end

			if arg_492_1.time_ >= var_495_10 + var_495_11 and arg_492_1.time_ < var_495_10 + var_495_11 + arg_495_0 then
				var_495_9.localPosition = Vector3.New(0, 100, 0)

				local var_495_16 = manager.ui.mainCamera.transform.position - var_495_9.position

				var_495_9.forward = Vector3.New(var_495_16.x, var_495_16.y, var_495_16.z)

				local var_495_17 = var_495_9.localEulerAngles

				var_495_17.z = 0
				var_495_17.x = 0
				var_495_9.localEulerAngles = var_495_17
			end

			local var_495_18 = 0
			local var_495_19 = 0.825

			if var_495_18 < arg_492_1.time_ and arg_492_1.time_ <= var_495_18 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_20 = arg_492_1:GetWordFromCfg(322161117)
				local var_495_21 = arg_492_1:FormatText(var_495_20.content)

				arg_492_1.text_.text = var_495_21

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_22 = 33
				local var_495_23 = utf8.len(var_495_21)
				local var_495_24 = var_495_22 <= 0 and var_495_19 or var_495_19 * (var_495_23 / var_495_22)

				if var_495_24 > 0 and var_495_19 < var_495_24 then
					arg_492_1.talkMaxDuration = var_495_24

					if var_495_24 + var_495_18 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_24 + var_495_18
					end
				end

				arg_492_1.text_.text = var_495_21
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_25 = math.max(var_495_19, arg_492_1.talkMaxDuration)

			if var_495_18 <= arg_492_1.time_ and arg_492_1.time_ < var_495_18 + var_495_25 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_18) / var_495_25

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_18 + var_495_25 and arg_492_1.time_ < var_495_18 + var_495_25 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_492_1:InitPlayNodeList()
	end,
	Play322161118 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 322161118
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play322161119(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 1.55

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_2 = arg_496_1:GetWordFromCfg(322161118)
				local var_499_3 = arg_496_1:FormatText(var_499_2.content)

				arg_496_1.text_.text = var_499_3

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_4 = 62
				local var_499_5 = utf8.len(var_499_3)
				local var_499_6 = var_499_4 <= 0 and var_499_1 or var_499_1 * (var_499_5 / var_499_4)

				if var_499_6 > 0 and var_499_1 < var_499_6 then
					arg_496_1.talkMaxDuration = var_499_6

					if var_499_6 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_6 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_3
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_7 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_7 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_7

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_7 and arg_496_1.time_ < var_499_0 + var_499_7 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play322161119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 322161119
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play322161120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.075

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[7].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_3 = arg_500_1:GetWordFromCfg(322161119)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 3
				local var_503_6 = utf8.len(var_503_4)
				local var_503_7 = var_503_5 <= 0 and var_503_1 or var_503_1 * (var_503_6 / var_503_5)

				if var_503_7 > 0 and var_503_1 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_8 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_8 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_8

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_8 and arg_500_1.time_ < var_503_0 + var_503_8 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play322161120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 322161120
		arg_504_1.duration_ = 3.67

		local var_504_0 = {
			zh = 3.066,
			ja = 3.666
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play322161121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["1044ui_story"].transform
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1.var_.moveOldPos1044ui_story = var_507_0.localPosition
			end

			local var_507_2 = 0.001

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2
				local var_507_4 = Vector3.New(0, -1, -5.93)

				var_507_0.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos1044ui_story, var_507_4, var_507_3)

				local var_507_5 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_5.x, var_507_5.y, var_507_5.z)

				local var_507_6 = var_507_0.localEulerAngles

				var_507_6.z = 0
				var_507_6.x = 0
				var_507_0.localEulerAngles = var_507_6
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 then
				var_507_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_507_7 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_7.x, var_507_7.y, var_507_7.z)

				local var_507_8 = var_507_0.localEulerAngles

				var_507_8.z = 0
				var_507_8.x = 0
				var_507_0.localEulerAngles = var_507_8
			end

			local var_507_9 = 0

			if var_507_9 < arg_504_1.time_ and arg_504_1.time_ <= var_507_9 + arg_507_0 then
				arg_504_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_507_10 = 0

			if var_507_10 < arg_504_1.time_ and arg_504_1.time_ <= var_507_10 + arg_507_0 then
				arg_504_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_507_11 = arg_504_1.actors_["1044ui_story"]
			local var_507_12 = 0

			if var_507_12 < arg_504_1.time_ and arg_504_1.time_ <= var_507_12 + arg_507_0 and not isNil(var_507_11) and arg_504_1.var_.characterEffect1044ui_story == nil then
				arg_504_1.var_.characterEffect1044ui_story = var_507_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_13 = 0.2

			if var_507_12 <= arg_504_1.time_ and arg_504_1.time_ < var_507_12 + var_507_13 and not isNil(var_507_11) then
				local var_507_14 = (arg_504_1.time_ - var_507_12) / var_507_13

				if arg_504_1.var_.characterEffect1044ui_story and not isNil(var_507_11) then
					arg_504_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= var_507_12 + var_507_13 and arg_504_1.time_ < var_507_12 + var_507_13 + arg_507_0 and not isNil(var_507_11) and arg_504_1.var_.characterEffect1044ui_story then
				arg_504_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_507_15 = 0
			local var_507_16 = 0.325

			if var_507_15 < arg_504_1.time_ and arg_504_1.time_ <= var_507_15 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_17 = arg_504_1:FormatText(StoryNameCfg[1367].name)

				arg_504_1.leftNameTxt_.text = var_507_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_18 = arg_504_1:GetWordFromCfg(322161120)
				local var_507_19 = arg_504_1:FormatText(var_507_18.content)

				arg_504_1.text_.text = var_507_19

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_20 = 13
				local var_507_21 = utf8.len(var_507_19)
				local var_507_22 = var_507_20 <= 0 and var_507_16 or var_507_16 * (var_507_21 / var_507_20)

				if var_507_22 > 0 and var_507_16 < var_507_22 then
					arg_504_1.talkMaxDuration = var_507_22

					if var_507_22 + var_507_15 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_22 + var_507_15
					end
				end

				arg_504_1.text_.text = var_507_19
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161120", "story_v_out_322161.awb") ~= 0 then
					local var_507_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161120", "story_v_out_322161.awb") / 1000

					if var_507_23 + var_507_15 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_23 + var_507_15
					end

					if var_507_18.prefab_name ~= "" and arg_504_1.actors_[var_507_18.prefab_name] ~= nil then
						local var_507_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_18.prefab_name].transform, "story_v_out_322161", "322161120", "story_v_out_322161.awb")

						arg_504_1:RecordAudio("322161120", var_507_24)
						arg_504_1:RecordAudio("322161120", var_507_24)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_322161", "322161120", "story_v_out_322161.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_322161", "322161120", "story_v_out_322161.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_25 = math.max(var_507_16, arg_504_1.talkMaxDuration)

			if var_507_15 <= arg_504_1.time_ and arg_504_1.time_ < var_507_15 + var_507_25 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_15) / var_507_25

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_15 + var_507_25 and arg_504_1.time_ < var_507_15 + var_507_25 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play322161121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 322161121
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play322161122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["1044ui_story"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect1044ui_story == nil then
				arg_508_1.var_.characterEffect1044ui_story = var_511_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_2 = 0.2

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.characterEffect1044ui_story and not isNil(var_511_0) then
					local var_511_4 = Mathf.Lerp(0, 0.5, var_511_3)

					arg_508_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_508_1.var_.characterEffect1044ui_story.fillRatio = var_511_4
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect1044ui_story then
				local var_511_5 = 0.5

				arg_508_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_508_1.var_.characterEffect1044ui_story.fillRatio = var_511_5
			end

			local var_511_6 = 0
			local var_511_7 = 0.775

			if var_511_6 < arg_508_1.time_ and arg_508_1.time_ <= var_511_6 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_8 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_9 = arg_508_1:GetWordFromCfg(322161121)
				local var_511_10 = arg_508_1:FormatText(var_511_9.content)

				arg_508_1.text_.text = var_511_10

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_11 = 31
				local var_511_12 = utf8.len(var_511_10)
				local var_511_13 = var_511_11 <= 0 and var_511_7 or var_511_7 * (var_511_12 / var_511_11)

				if var_511_13 > 0 and var_511_7 < var_511_13 then
					arg_508_1.talkMaxDuration = var_511_13

					if var_511_13 + var_511_6 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_13 + var_511_6
					end
				end

				arg_508_1.text_.text = var_511_10
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_14 = math.max(var_511_7, arg_508_1.talkMaxDuration)

			if var_511_6 <= arg_508_1.time_ and arg_508_1.time_ < var_511_6 + var_511_14 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_6) / var_511_14

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_6 + var_511_14 and arg_508_1.time_ < var_511_6 + var_511_14 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play322161122 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 322161122
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play322161123(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["1044ui_story"].transform
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.var_.moveOldPos1044ui_story = var_515_0.localPosition
			end

			local var_515_2 = 0.001

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2
				local var_515_4 = Vector3.New(0, 100, 0)

				var_515_0.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos1044ui_story, var_515_4, var_515_3)

				local var_515_5 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_5.x, var_515_5.y, var_515_5.z)

				local var_515_6 = var_515_0.localEulerAngles

				var_515_6.z = 0
				var_515_6.x = 0
				var_515_0.localEulerAngles = var_515_6
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 then
				var_515_0.localPosition = Vector3.New(0, 100, 0)

				local var_515_7 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_7.x, var_515_7.y, var_515_7.z)

				local var_515_8 = var_515_0.localEulerAngles

				var_515_8.z = 0
				var_515_8.x = 0
				var_515_0.localEulerAngles = var_515_8
			end

			local var_515_9 = 0
			local var_515_10 = 0.875

			if var_515_9 < arg_512_1.time_ and arg_512_1.time_ <= var_515_9 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_11 = arg_512_1:GetWordFromCfg(322161122)
				local var_515_12 = arg_512_1:FormatText(var_515_11.content)

				arg_512_1.text_.text = var_515_12

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_13 = 35
				local var_515_14 = utf8.len(var_515_12)
				local var_515_15 = var_515_13 <= 0 and var_515_10 or var_515_10 * (var_515_14 / var_515_13)

				if var_515_15 > 0 and var_515_10 < var_515_15 then
					arg_512_1.talkMaxDuration = var_515_15

					if var_515_15 + var_515_9 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_15 + var_515_9
					end
				end

				arg_512_1.text_.text = var_515_12
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_16 = math.max(var_515_10, arg_512_1.talkMaxDuration)

			if var_515_9 <= arg_512_1.time_ and arg_512_1.time_ < var_515_9 + var_515_16 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_9) / var_515_16

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_9 + var_515_16 and arg_512_1.time_ < var_515_9 + var_515_16 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play322161123 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 322161123
		arg_516_1.duration_ = 3.87

		local var_516_0 = {
			zh = 3.866,
			ja = 2.9
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play322161124(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["1044ui_story"].transform
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.var_.moveOldPos1044ui_story = var_519_0.localPosition
			end

			local var_519_2 = 0.001

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2
				local var_519_4 = Vector3.New(0, -1, -5.93)

				var_519_0.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1044ui_story, var_519_4, var_519_3)

				local var_519_5 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_5.x, var_519_5.y, var_519_5.z)

				local var_519_6 = var_519_0.localEulerAngles

				var_519_6.z = 0
				var_519_6.x = 0
				var_519_0.localEulerAngles = var_519_6
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 then
				var_519_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_519_7 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_7.x, var_519_7.y, var_519_7.z)

				local var_519_8 = var_519_0.localEulerAngles

				var_519_8.z = 0
				var_519_8.x = 0
				var_519_0.localEulerAngles = var_519_8
			end

			local var_519_9 = 0

			if var_519_9 < arg_516_1.time_ and arg_516_1.time_ <= var_519_9 + arg_519_0 then
				arg_516_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			local var_519_10 = 0

			if var_519_10 < arg_516_1.time_ and arg_516_1.time_ <= var_519_10 + arg_519_0 then
				arg_516_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_519_11 = arg_516_1.actors_["1044ui_story"]
			local var_519_12 = 0

			if var_519_12 < arg_516_1.time_ and arg_516_1.time_ <= var_519_12 + arg_519_0 and not isNil(var_519_11) and arg_516_1.var_.characterEffect1044ui_story == nil then
				arg_516_1.var_.characterEffect1044ui_story = var_519_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_13 = 0.2

			if var_519_12 <= arg_516_1.time_ and arg_516_1.time_ < var_519_12 + var_519_13 and not isNil(var_519_11) then
				local var_519_14 = (arg_516_1.time_ - var_519_12) / var_519_13

				if arg_516_1.var_.characterEffect1044ui_story and not isNil(var_519_11) then
					arg_516_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_12 + var_519_13 and arg_516_1.time_ < var_519_12 + var_519_13 + arg_519_0 and not isNil(var_519_11) and arg_516_1.var_.characterEffect1044ui_story then
				arg_516_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_519_15 = 0
			local var_519_16 = 0.2

			if var_519_15 < arg_516_1.time_ and arg_516_1.time_ <= var_519_15 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_17 = arg_516_1:FormatText(StoryNameCfg[1367].name)

				arg_516_1.leftNameTxt_.text = var_519_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_18 = arg_516_1:GetWordFromCfg(322161123)
				local var_519_19 = arg_516_1:FormatText(var_519_18.content)

				arg_516_1.text_.text = var_519_19

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_20 = 8
				local var_519_21 = utf8.len(var_519_19)
				local var_519_22 = var_519_20 <= 0 and var_519_16 or var_519_16 * (var_519_21 / var_519_20)

				if var_519_22 > 0 and var_519_16 < var_519_22 then
					arg_516_1.talkMaxDuration = var_519_22

					if var_519_22 + var_519_15 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_22 + var_519_15
					end
				end

				arg_516_1.text_.text = var_519_19
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161123", "story_v_out_322161.awb") ~= 0 then
					local var_519_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161123", "story_v_out_322161.awb") / 1000

					if var_519_23 + var_519_15 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_23 + var_519_15
					end

					if var_519_18.prefab_name ~= "" and arg_516_1.actors_[var_519_18.prefab_name] ~= nil then
						local var_519_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_18.prefab_name].transform, "story_v_out_322161", "322161123", "story_v_out_322161.awb")

						arg_516_1:RecordAudio("322161123", var_519_24)
						arg_516_1:RecordAudio("322161123", var_519_24)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_322161", "322161123", "story_v_out_322161.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_322161", "322161123", "story_v_out_322161.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_25 = math.max(var_519_16, arg_516_1.talkMaxDuration)

			if var_519_15 <= arg_516_1.time_ and arg_516_1.time_ < var_519_15 + var_519_25 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_15) / var_519_25

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_15 + var_519_25 and arg_516_1.time_ < var_519_15 + var_519_25 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play322161124 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 322161124
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play322161125(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["1044ui_story"].transform
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 then
				arg_520_1.var_.moveOldPos1044ui_story = var_523_0.localPosition
			end

			local var_523_2 = 0.001

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2
				local var_523_4 = Vector3.New(0, 100, 0)

				var_523_0.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1044ui_story, var_523_4, var_523_3)

				local var_523_5 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_5.x, var_523_5.y, var_523_5.z)

				local var_523_6 = var_523_0.localEulerAngles

				var_523_6.z = 0
				var_523_6.x = 0
				var_523_0.localEulerAngles = var_523_6
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 then
				var_523_0.localPosition = Vector3.New(0, 100, 0)

				local var_523_7 = manager.ui.mainCamera.transform.position - var_523_0.position

				var_523_0.forward = Vector3.New(var_523_7.x, var_523_7.y, var_523_7.z)

				local var_523_8 = var_523_0.localEulerAngles

				var_523_8.z = 0
				var_523_8.x = 0
				var_523_0.localEulerAngles = var_523_8
			end

			local var_523_9 = 0
			local var_523_10 = 0.45

			if var_523_9 < arg_520_1.time_ and arg_520_1.time_ <= var_523_9 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_11 = arg_520_1:FormatText(StoryNameCfg[7].name)

				arg_520_1.leftNameTxt_.text = var_523_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_12 = arg_520_1:GetWordFromCfg(322161124)
				local var_523_13 = arg_520_1:FormatText(var_523_12.content)

				arg_520_1.text_.text = var_523_13

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_14 = 18
				local var_523_15 = utf8.len(var_523_13)
				local var_523_16 = var_523_14 <= 0 and var_523_10 or var_523_10 * (var_523_15 / var_523_14)

				if var_523_16 > 0 and var_523_10 < var_523_16 then
					arg_520_1.talkMaxDuration = var_523_16

					if var_523_16 + var_523_9 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_16 + var_523_9
					end
				end

				arg_520_1.text_.text = var_523_13
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_17 = math.max(var_523_10, arg_520_1.talkMaxDuration)

			if var_523_9 <= arg_520_1.time_ and arg_520_1.time_ < var_523_9 + var_523_17 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_9) / var_523_17

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_9 + var_523_17 and arg_520_1.time_ < var_523_9 + var_523_17 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_520_1:InitPlayNodeList()
	end,
	Play322161125 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 322161125
		arg_524_1.duration_ = 1

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"

			SetActive(arg_524_1.choicesGo_, true)

			for iter_525_0, iter_525_1 in ipairs(arg_524_1.choices_) do
				local var_525_0 = iter_525_0 <= 2

				SetActive(iter_525_1.go, var_525_0)
			end

			arg_524_1.choices_[1].txt.text = arg_524_1:FormatText(StoryChoiceCfg[1421].name)
			arg_524_1.choices_[2].txt.text = arg_524_1:FormatText(StoryChoiceCfg[1422].name)
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play322161126(arg_524_1)
			end

			if arg_526_0 == 2 then
				arg_524_0:Play322161127(arg_524_1)
			end

			arg_524_1:RecordChoiceLog(322161125, 1421, 1422)
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.allBtn_.enabled = false
			end

			local var_527_1 = 0.6

			if arg_524_1.time_ >= var_527_0 + var_527_1 and arg_524_1.time_ < var_527_0 + var_527_1 + arg_527_0 then
				arg_524_1.allBtn_.enabled = true
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play322161126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 322161126
		arg_528_1.duration_ = 3.47

		local var_528_0 = {
			zh = 1.999999999999,
			ja = 3.466
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play322161128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["1044ui_story"].transform
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.var_.moveOldPos1044ui_story = var_531_0.localPosition
			end

			local var_531_2 = 0.001

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2
				local var_531_4 = Vector3.New(0, -1, -5.93)

				var_531_0.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos1044ui_story, var_531_4, var_531_3)

				local var_531_5 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_5.x, var_531_5.y, var_531_5.z)

				local var_531_6 = var_531_0.localEulerAngles

				var_531_6.z = 0
				var_531_6.x = 0
				var_531_0.localEulerAngles = var_531_6
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 then
				var_531_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_531_7 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_7.x, var_531_7.y, var_531_7.z)

				local var_531_8 = var_531_0.localEulerAngles

				var_531_8.z = 0
				var_531_8.x = 0
				var_531_0.localEulerAngles = var_531_8
			end

			local var_531_9 = 0

			if var_531_9 < arg_528_1.time_ and arg_528_1.time_ <= var_531_9 + arg_531_0 then
				arg_528_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_2")
			end

			local var_531_10 = 0

			if var_531_10 < arg_528_1.time_ and arg_528_1.time_ <= var_531_10 + arg_531_0 then
				arg_528_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_531_11 = arg_528_1.actors_["1044ui_story"]
			local var_531_12 = 0

			if var_531_12 < arg_528_1.time_ and arg_528_1.time_ <= var_531_12 + arg_531_0 and not isNil(var_531_11) and arg_528_1.var_.characterEffect1044ui_story == nil then
				arg_528_1.var_.characterEffect1044ui_story = var_531_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_13 = 0.2

			if var_531_12 <= arg_528_1.time_ and arg_528_1.time_ < var_531_12 + var_531_13 and not isNil(var_531_11) then
				local var_531_14 = (arg_528_1.time_ - var_531_12) / var_531_13

				if arg_528_1.var_.characterEffect1044ui_story and not isNil(var_531_11) then
					arg_528_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= var_531_12 + var_531_13 and arg_528_1.time_ < var_531_12 + var_531_13 + arg_531_0 and not isNil(var_531_11) and arg_528_1.var_.characterEffect1044ui_story then
				arg_528_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_531_15 = 0
			local var_531_16 = 0.2

			if var_531_15 < arg_528_1.time_ and arg_528_1.time_ <= var_531_15 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_17 = arg_528_1:FormatText(StoryNameCfg[1367].name)

				arg_528_1.leftNameTxt_.text = var_531_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_18 = arg_528_1:GetWordFromCfg(322161126)
				local var_531_19 = arg_528_1:FormatText(var_531_18.content)

				arg_528_1.text_.text = var_531_19

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_20 = 8
				local var_531_21 = utf8.len(var_531_19)
				local var_531_22 = var_531_20 <= 0 and var_531_16 or var_531_16 * (var_531_21 / var_531_20)

				if var_531_22 > 0 and var_531_16 < var_531_22 then
					arg_528_1.talkMaxDuration = var_531_22

					if var_531_22 + var_531_15 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_22 + var_531_15
					end
				end

				arg_528_1.text_.text = var_531_19
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161126", "story_v_out_322161.awb") ~= 0 then
					local var_531_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161126", "story_v_out_322161.awb") / 1000

					if var_531_23 + var_531_15 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_23 + var_531_15
					end

					if var_531_18.prefab_name ~= "" and arg_528_1.actors_[var_531_18.prefab_name] ~= nil then
						local var_531_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_18.prefab_name].transform, "story_v_out_322161", "322161126", "story_v_out_322161.awb")

						arg_528_1:RecordAudio("322161126", var_531_24)
						arg_528_1:RecordAudio("322161126", var_531_24)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_322161", "322161126", "story_v_out_322161.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_322161", "322161126", "story_v_out_322161.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_25 = math.max(var_531_16, arg_528_1.talkMaxDuration)

			if var_531_15 <= arg_528_1.time_ and arg_528_1.time_ < var_531_15 + var_531_25 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_15) / var_531_25

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_15 + var_531_25 and arg_528_1.time_ < var_531_15 + var_531_25 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play322161128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 322161128
		arg_532_1.duration_ = 6.77

		local var_532_0 = {
			zh = 6.666,
			ja = 6.766
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play322161129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_535_1 = 0
			local var_535_2 = 0.625

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_3 = arg_532_1:FormatText(StoryNameCfg[1367].name)

				arg_532_1.leftNameTxt_.text = var_535_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_4 = arg_532_1:GetWordFromCfg(322161128)
				local var_535_5 = arg_532_1:FormatText(var_535_4.content)

				arg_532_1.text_.text = var_535_5

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_6 = 25
				local var_535_7 = utf8.len(var_535_5)
				local var_535_8 = var_535_6 <= 0 and var_535_2 or var_535_2 * (var_535_7 / var_535_6)

				if var_535_8 > 0 and var_535_2 < var_535_8 then
					arg_532_1.talkMaxDuration = var_535_8

					if var_535_8 + var_535_1 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_1
					end
				end

				arg_532_1.text_.text = var_535_5
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161128", "story_v_out_322161.awb") ~= 0 then
					local var_535_9 = manager.audio:GetVoiceLength("story_v_out_322161", "322161128", "story_v_out_322161.awb") / 1000

					if var_535_9 + var_535_1 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_9 + var_535_1
					end

					if var_535_4.prefab_name ~= "" and arg_532_1.actors_[var_535_4.prefab_name] ~= nil then
						local var_535_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_4.prefab_name].transform, "story_v_out_322161", "322161128", "story_v_out_322161.awb")

						arg_532_1:RecordAudio("322161128", var_535_10)
						arg_532_1:RecordAudio("322161128", var_535_10)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_322161", "322161128", "story_v_out_322161.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_322161", "322161128", "story_v_out_322161.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_11 = math.max(var_535_2, arg_532_1.talkMaxDuration)

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_11 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_1) / var_535_11

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_1 + var_535_11 and arg_532_1.time_ < var_535_1 + var_535_11 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play322161129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 322161129
		arg_536_1.duration_ = 10.1

		local var_536_0 = {
			zh = 8.4,
			ja = 10.1
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play322161130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 0.85

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_2 = arg_536_1:FormatText(StoryNameCfg[1367].name)

				arg_536_1.leftNameTxt_.text = var_539_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_3 = arg_536_1:GetWordFromCfg(322161129)
				local var_539_4 = arg_536_1:FormatText(var_539_3.content)

				arg_536_1.text_.text = var_539_4

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_5 = 34
				local var_539_6 = utf8.len(var_539_4)
				local var_539_7 = var_539_5 <= 0 and var_539_1 or var_539_1 * (var_539_6 / var_539_5)

				if var_539_7 > 0 and var_539_1 < var_539_7 then
					arg_536_1.talkMaxDuration = var_539_7

					if var_539_7 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_7 + var_539_0
					end
				end

				arg_536_1.text_.text = var_539_4
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161129", "story_v_out_322161.awb") ~= 0 then
					local var_539_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161129", "story_v_out_322161.awb") / 1000

					if var_539_8 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_8 + var_539_0
					end

					if var_539_3.prefab_name ~= "" and arg_536_1.actors_[var_539_3.prefab_name] ~= nil then
						local var_539_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_3.prefab_name].transform, "story_v_out_322161", "322161129", "story_v_out_322161.awb")

						arg_536_1:RecordAudio("322161129", var_539_9)
						arg_536_1:RecordAudio("322161129", var_539_9)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_322161", "322161129", "story_v_out_322161.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_322161", "322161129", "story_v_out_322161.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_1, arg_536_1.talkMaxDuration)

			if var_539_0 <= arg_536_1.time_ and arg_536_1.time_ < var_539_0 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_0) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_0 + var_539_10 and arg_536_1.time_ < var_539_0 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play322161130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 322161130
		arg_540_1.duration_ = 3.5

		local var_540_0 = {
			zh = 3.5,
			ja = 1.366
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play322161131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.15

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_2 = arg_540_1:FormatText(StoryNameCfg[1367].name)

				arg_540_1.leftNameTxt_.text = var_543_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_3 = arg_540_1:GetWordFromCfg(322161130)
				local var_543_4 = arg_540_1:FormatText(var_543_3.content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 6
				local var_543_6 = utf8.len(var_543_4)
				local var_543_7 = var_543_5 <= 0 and var_543_1 or var_543_1 * (var_543_6 / var_543_5)

				if var_543_7 > 0 and var_543_1 < var_543_7 then
					arg_540_1.talkMaxDuration = var_543_7

					if var_543_7 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_7 + var_543_0
					end
				end

				arg_540_1.text_.text = var_543_4
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161130", "story_v_out_322161.awb") ~= 0 then
					local var_543_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161130", "story_v_out_322161.awb") / 1000

					if var_543_8 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_8 + var_543_0
					end

					if var_543_3.prefab_name ~= "" and arg_540_1.actors_[var_543_3.prefab_name] ~= nil then
						local var_543_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_3.prefab_name].transform, "story_v_out_322161", "322161130", "story_v_out_322161.awb")

						arg_540_1:RecordAudio("322161130", var_543_9)
						arg_540_1:RecordAudio("322161130", var_543_9)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_322161", "322161130", "story_v_out_322161.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_322161", "322161130", "story_v_out_322161.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_10 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_10 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_10

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_10 and arg_540_1.time_ < var_543_0 + var_543_10 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play322161131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 322161131
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play322161132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["1044ui_story"].transform
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 then
				arg_544_1.var_.moveOldPos1044ui_story = var_547_0.localPosition
			end

			local var_547_2 = 0.001

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2
				local var_547_4 = Vector3.New(0, 100, 0)

				var_547_0.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1044ui_story, var_547_4, var_547_3)

				local var_547_5 = manager.ui.mainCamera.transform.position - var_547_0.position

				var_547_0.forward = Vector3.New(var_547_5.x, var_547_5.y, var_547_5.z)

				local var_547_6 = var_547_0.localEulerAngles

				var_547_6.z = 0
				var_547_6.x = 0
				var_547_0.localEulerAngles = var_547_6
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 then
				var_547_0.localPosition = Vector3.New(0, 100, 0)

				local var_547_7 = manager.ui.mainCamera.transform.position - var_547_0.position

				var_547_0.forward = Vector3.New(var_547_7.x, var_547_7.y, var_547_7.z)

				local var_547_8 = var_547_0.localEulerAngles

				var_547_8.z = 0
				var_547_8.x = 0
				var_547_0.localEulerAngles = var_547_8
			end

			local var_547_9 = 0.1
			local var_547_10 = 1

			if var_547_9 < arg_544_1.time_ and arg_544_1.time_ <= var_547_9 + arg_547_0 then
				local var_547_11 = "play"
				local var_547_12 = "effect"

				arg_544_1:AudioAction(var_547_11, var_547_12, "se_story_145", "se_story_145_clap03", "")
			end

			local var_547_13 = manager.ui.mainCamera.transform
			local var_547_14 = 0.1

			if var_547_14 < arg_544_1.time_ and arg_544_1.time_ <= var_547_14 + arg_547_0 then
				arg_544_1.var_.shakeOldPos = var_547_13.localPosition
			end

			local var_547_15 = 0.266666666666667

			if var_547_14 <= arg_544_1.time_ and arg_544_1.time_ < var_547_14 + var_547_15 then
				local var_547_16 = (arg_544_1.time_ - var_547_14) / 0.066
				local var_547_17, var_547_18 = math.modf(var_547_16)

				var_547_13.localPosition = Vector3.New(var_547_18 * 0.13, var_547_18 * 0.13, var_547_18 * 0.13) + arg_544_1.var_.shakeOldPos
			end

			if arg_544_1.time_ >= var_547_14 + var_547_15 and arg_544_1.time_ < var_547_14 + var_547_15 + arg_547_0 then
				var_547_13.localPosition = arg_544_1.var_.shakeOldPos
			end

			local var_547_19 = 0
			local var_547_20 = 1.3

			if var_547_19 < arg_544_1.time_ and arg_544_1.time_ <= var_547_19 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_21 = arg_544_1:GetWordFromCfg(322161131)
				local var_547_22 = arg_544_1:FormatText(var_547_21.content)

				arg_544_1.text_.text = var_547_22

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_23 = 52
				local var_547_24 = utf8.len(var_547_22)
				local var_547_25 = var_547_23 <= 0 and var_547_20 or var_547_20 * (var_547_24 / var_547_23)

				if var_547_25 > 0 and var_547_20 < var_547_25 then
					arg_544_1.talkMaxDuration = var_547_25

					if var_547_25 + var_547_19 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_25 + var_547_19
					end
				end

				arg_544_1.text_.text = var_547_22
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_26 = math.max(var_547_20, arg_544_1.talkMaxDuration)

			if var_547_19 <= arg_544_1.time_ and arg_544_1.time_ < var_547_19 + var_547_26 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_19) / var_547_26

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_19 + var_547_26 and arg_544_1.time_ < var_547_19 + var_547_26 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play322161132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 322161132
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play322161133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0
			local var_551_1 = 0.825

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_2 = arg_548_1:GetWordFromCfg(322161132)
				local var_551_3 = arg_548_1:FormatText(var_551_2.content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 33
				local var_551_5 = utf8.len(var_551_3)
				local var_551_6 = var_551_4 <= 0 and var_551_1 or var_551_1 * (var_551_5 / var_551_4)

				if var_551_6 > 0 and var_551_1 < var_551_6 then
					arg_548_1.talkMaxDuration = var_551_6

					if var_551_6 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_6 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_7 and arg_548_1.time_ < var_551_0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play322161133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 322161133
		arg_552_1.duration_ = 2.37

		local var_552_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play322161134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["1044ui_story"].transform
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 then
				arg_552_1.var_.moveOldPos1044ui_story = var_555_0.localPosition
			end

			local var_555_2 = 0.001

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2
				local var_555_4 = Vector3.New(0, -1, -5.93)

				var_555_0.localPosition = Vector3.Lerp(arg_552_1.var_.moveOldPos1044ui_story, var_555_4, var_555_3)

				local var_555_5 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_5.x, var_555_5.y, var_555_5.z)

				local var_555_6 = var_555_0.localEulerAngles

				var_555_6.z = 0
				var_555_6.x = 0
				var_555_0.localEulerAngles = var_555_6
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 then
				var_555_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_555_7 = manager.ui.mainCamera.transform.position - var_555_0.position

				var_555_0.forward = Vector3.New(var_555_7.x, var_555_7.y, var_555_7.z)

				local var_555_8 = var_555_0.localEulerAngles

				var_555_8.z = 0
				var_555_8.x = 0
				var_555_0.localEulerAngles = var_555_8
			end

			local var_555_9 = 0

			if var_555_9 < arg_552_1.time_ and arg_552_1.time_ <= var_555_9 + arg_555_0 then
				arg_552_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_555_10 = 0

			if var_555_10 < arg_552_1.time_ and arg_552_1.time_ <= var_555_10 + arg_555_0 then
				arg_552_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_555_11 = arg_552_1.actors_["1044ui_story"]
			local var_555_12 = 0

			if var_555_12 < arg_552_1.time_ and arg_552_1.time_ <= var_555_12 + arg_555_0 and not isNil(var_555_11) and arg_552_1.var_.characterEffect1044ui_story == nil then
				arg_552_1.var_.characterEffect1044ui_story = var_555_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_13 = 0.2

			if var_555_12 <= arg_552_1.time_ and arg_552_1.time_ < var_555_12 + var_555_13 and not isNil(var_555_11) then
				local var_555_14 = (arg_552_1.time_ - var_555_12) / var_555_13

				if arg_552_1.var_.characterEffect1044ui_story and not isNil(var_555_11) then
					arg_552_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_552_1.time_ >= var_555_12 + var_555_13 and arg_552_1.time_ < var_555_12 + var_555_13 + arg_555_0 and not isNil(var_555_11) and arg_552_1.var_.characterEffect1044ui_story then
				arg_552_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_555_15 = 0
			local var_555_16 = 0.125

			if var_555_15 < arg_552_1.time_ and arg_552_1.time_ <= var_555_15 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_17 = arg_552_1:FormatText(StoryNameCfg[1367].name)

				arg_552_1.leftNameTxt_.text = var_555_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_18 = arg_552_1:GetWordFromCfg(322161133)
				local var_555_19 = arg_552_1:FormatText(var_555_18.content)

				arg_552_1.text_.text = var_555_19

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_20 = 5
				local var_555_21 = utf8.len(var_555_19)
				local var_555_22 = var_555_20 <= 0 and var_555_16 or var_555_16 * (var_555_21 / var_555_20)

				if var_555_22 > 0 and var_555_16 < var_555_22 then
					arg_552_1.talkMaxDuration = var_555_22

					if var_555_22 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_22 + var_555_15
					end
				end

				arg_552_1.text_.text = var_555_19
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161133", "story_v_out_322161.awb") ~= 0 then
					local var_555_23 = manager.audio:GetVoiceLength("story_v_out_322161", "322161133", "story_v_out_322161.awb") / 1000

					if var_555_23 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_23 + var_555_15
					end

					if var_555_18.prefab_name ~= "" and arg_552_1.actors_[var_555_18.prefab_name] ~= nil then
						local var_555_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_18.prefab_name].transform, "story_v_out_322161", "322161133", "story_v_out_322161.awb")

						arg_552_1:RecordAudio("322161133", var_555_24)
						arg_552_1:RecordAudio("322161133", var_555_24)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_322161", "322161133", "story_v_out_322161.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_322161", "322161133", "story_v_out_322161.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_25 = math.max(var_555_16, arg_552_1.talkMaxDuration)

			if var_555_15 <= arg_552_1.time_ and arg_552_1.time_ < var_555_15 + var_555_25 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_15) / var_555_25

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_15 + var_555_25 and arg_552_1.time_ < var_555_15 + var_555_25 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_552_1:InitPlayNodeList()
	end,
	Play322161134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 322161134
		arg_556_1.duration_ = 21.47

		local var_556_0 = {
			zh = 13.2,
			ja = 21.466
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play322161135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0
			local var_559_1 = 1.375

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_2 = arg_556_1:FormatText(StoryNameCfg[1367].name)

				arg_556_1.leftNameTxt_.text = var_559_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_3 = arg_556_1:GetWordFromCfg(322161134)
				local var_559_4 = arg_556_1:FormatText(var_559_3.content)

				arg_556_1.text_.text = var_559_4

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_5 = 55
				local var_559_6 = utf8.len(var_559_4)
				local var_559_7 = var_559_5 <= 0 and var_559_1 or var_559_1 * (var_559_6 / var_559_5)

				if var_559_7 > 0 and var_559_1 < var_559_7 then
					arg_556_1.talkMaxDuration = var_559_7

					if var_559_7 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_7 + var_559_0
					end
				end

				arg_556_1.text_.text = var_559_4
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161134", "story_v_out_322161.awb") ~= 0 then
					local var_559_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161134", "story_v_out_322161.awb") / 1000

					if var_559_8 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_8 + var_559_0
					end

					if var_559_3.prefab_name ~= "" and arg_556_1.actors_[var_559_3.prefab_name] ~= nil then
						local var_559_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_3.prefab_name].transform, "story_v_out_322161", "322161134", "story_v_out_322161.awb")

						arg_556_1:RecordAudio("322161134", var_559_9)
						arg_556_1:RecordAudio("322161134", var_559_9)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_322161", "322161134", "story_v_out_322161.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_322161", "322161134", "story_v_out_322161.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_10 = math.max(var_559_1, arg_556_1.talkMaxDuration)

			if var_559_0 <= arg_556_1.time_ and arg_556_1.time_ < var_559_0 + var_559_10 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_0) / var_559_10

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_0 + var_559_10 and arg_556_1.time_ < var_559_0 + var_559_10 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play322161135 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 322161135
		arg_560_1.duration_ = 8.43

		local var_560_0 = {
			zh = 7.066,
			ja = 8.433
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play322161136(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0

			if var_563_0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_1")
			end

			local var_563_1 = 0
			local var_563_2 = 0.775

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_3 = arg_560_1:FormatText(StoryNameCfg[1367].name)

				arg_560_1.leftNameTxt_.text = var_563_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_4 = arg_560_1:GetWordFromCfg(322161135)
				local var_563_5 = arg_560_1:FormatText(var_563_4.content)

				arg_560_1.text_.text = var_563_5

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_6 = 31
				local var_563_7 = utf8.len(var_563_5)
				local var_563_8 = var_563_6 <= 0 and var_563_2 or var_563_2 * (var_563_7 / var_563_6)

				if var_563_8 > 0 and var_563_2 < var_563_8 then
					arg_560_1.talkMaxDuration = var_563_8

					if var_563_8 + var_563_1 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_8 + var_563_1
					end
				end

				arg_560_1.text_.text = var_563_5
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161135", "story_v_out_322161.awb") ~= 0 then
					local var_563_9 = manager.audio:GetVoiceLength("story_v_out_322161", "322161135", "story_v_out_322161.awb") / 1000

					if var_563_9 + var_563_1 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_9 + var_563_1
					end

					if var_563_4.prefab_name ~= "" and arg_560_1.actors_[var_563_4.prefab_name] ~= nil then
						local var_563_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_4.prefab_name].transform, "story_v_out_322161", "322161135", "story_v_out_322161.awb")

						arg_560_1:RecordAudio("322161135", var_563_10)
						arg_560_1:RecordAudio("322161135", var_563_10)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_322161", "322161135", "story_v_out_322161.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_322161", "322161135", "story_v_out_322161.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_11 = math.max(var_563_2, arg_560_1.talkMaxDuration)

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_11 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_1) / var_563_11

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_1 + var_563_11 and arg_560_1.time_ < var_563_1 + var_563_11 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play322161136 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 322161136
		arg_564_1.duration_ = 6.53

		local var_564_0 = {
			zh = 4.666,
			ja = 6.533
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play322161137(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["1044ui_story"].transform
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 then
				arg_564_1.var_.moveOldPos1044ui_story = var_567_0.localPosition
			end

			local var_567_2 = 0.001

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2
				local var_567_4 = Vector3.New(-0.7, -1, -5.93)

				var_567_0.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos1044ui_story, var_567_4, var_567_3)

				local var_567_5 = manager.ui.mainCamera.transform.position - var_567_0.position

				var_567_0.forward = Vector3.New(var_567_5.x, var_567_5.y, var_567_5.z)

				local var_567_6 = var_567_0.localEulerAngles

				var_567_6.z = 0
				var_567_6.x = 0
				var_567_0.localEulerAngles = var_567_6
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 then
				var_567_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_567_7 = manager.ui.mainCamera.transform.position - var_567_0.position

				var_567_0.forward = Vector3.New(var_567_7.x, var_567_7.y, var_567_7.z)

				local var_567_8 = var_567_0.localEulerAngles

				var_567_8.z = 0
				var_567_8.x = 0
				var_567_0.localEulerAngles = var_567_8
			end

			local var_567_9 = arg_564_1.actors_["1211ui_story"].transform
			local var_567_10 = 0

			if var_567_10 < arg_564_1.time_ and arg_564_1.time_ <= var_567_10 + arg_567_0 then
				arg_564_1.var_.moveOldPos1211ui_story = var_567_9.localPosition
			end

			local var_567_11 = 0.001

			if var_567_10 <= arg_564_1.time_ and arg_564_1.time_ < var_567_10 + var_567_11 then
				local var_567_12 = (arg_564_1.time_ - var_567_10) / var_567_11
				local var_567_13 = Vector3.New(0.7, -0.67, -6.07)

				var_567_9.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos1211ui_story, var_567_13, var_567_12)

				local var_567_14 = manager.ui.mainCamera.transform.position - var_567_9.position

				var_567_9.forward = Vector3.New(var_567_14.x, var_567_14.y, var_567_14.z)

				local var_567_15 = var_567_9.localEulerAngles

				var_567_15.z = 0
				var_567_15.x = 0
				var_567_9.localEulerAngles = var_567_15
			end

			if arg_564_1.time_ >= var_567_10 + var_567_11 and arg_564_1.time_ < var_567_10 + var_567_11 + arg_567_0 then
				var_567_9.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_567_16 = manager.ui.mainCamera.transform.position - var_567_9.position

				var_567_9.forward = Vector3.New(var_567_16.x, var_567_16.y, var_567_16.z)

				local var_567_17 = var_567_9.localEulerAngles

				var_567_17.z = 0
				var_567_17.x = 0
				var_567_9.localEulerAngles = var_567_17
			end

			local var_567_18 = arg_564_1.actors_["1211ui_story"]
			local var_567_19 = 0

			if var_567_19 < arg_564_1.time_ and arg_564_1.time_ <= var_567_19 + arg_567_0 and not isNil(var_567_18) and arg_564_1.var_.characterEffect1211ui_story == nil then
				arg_564_1.var_.characterEffect1211ui_story = var_567_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_20 = 0.200000002980232

			if var_567_19 <= arg_564_1.time_ and arg_564_1.time_ < var_567_19 + var_567_20 and not isNil(var_567_18) then
				local var_567_21 = (arg_564_1.time_ - var_567_19) / var_567_20

				if arg_564_1.var_.characterEffect1211ui_story and not isNil(var_567_18) then
					arg_564_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_564_1.time_ >= var_567_19 + var_567_20 and arg_564_1.time_ < var_567_19 + var_567_20 + arg_567_0 and not isNil(var_567_18) and arg_564_1.var_.characterEffect1211ui_story then
				arg_564_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_567_22 = 0

			if var_567_22 < arg_564_1.time_ and arg_564_1.time_ <= var_567_22 + arg_567_0 then
				arg_564_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_2")
			end

			local var_567_23 = 0

			if var_567_23 < arg_564_1.time_ and arg_564_1.time_ <= var_567_23 + arg_567_0 then
				arg_564_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_567_24 = arg_564_1.actors_["1044ui_story"]
			local var_567_25 = 0

			if var_567_25 < arg_564_1.time_ and arg_564_1.time_ <= var_567_25 + arg_567_0 and not isNil(var_567_24) and arg_564_1.var_.characterEffect1044ui_story == nil then
				arg_564_1.var_.characterEffect1044ui_story = var_567_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_26 = 0.200000002980232

			if var_567_25 <= arg_564_1.time_ and arg_564_1.time_ < var_567_25 + var_567_26 and not isNil(var_567_24) then
				local var_567_27 = (arg_564_1.time_ - var_567_25) / var_567_26

				if arg_564_1.var_.characterEffect1044ui_story and not isNil(var_567_24) then
					local var_567_28 = Mathf.Lerp(0, 0.5, var_567_27)

					arg_564_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_564_1.var_.characterEffect1044ui_story.fillRatio = var_567_28
				end
			end

			if arg_564_1.time_ >= var_567_25 + var_567_26 and arg_564_1.time_ < var_567_25 + var_567_26 + arg_567_0 and not isNil(var_567_24) and arg_564_1.var_.characterEffect1044ui_story then
				local var_567_29 = 0.5

				arg_564_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_564_1.var_.characterEffect1044ui_story.fillRatio = var_567_29
			end

			local var_567_30 = 0
			local var_567_31 = 0.5

			if var_567_30 < arg_564_1.time_ and arg_564_1.time_ <= var_567_30 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_32 = arg_564_1:FormatText(StoryNameCfg[37].name)

				arg_564_1.leftNameTxt_.text = var_567_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_33 = arg_564_1:GetWordFromCfg(322161136)
				local var_567_34 = arg_564_1:FormatText(var_567_33.content)

				arg_564_1.text_.text = var_567_34

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_35 = 20
				local var_567_36 = utf8.len(var_567_34)
				local var_567_37 = var_567_35 <= 0 and var_567_31 or var_567_31 * (var_567_36 / var_567_35)

				if var_567_37 > 0 and var_567_31 < var_567_37 then
					arg_564_1.talkMaxDuration = var_567_37

					if var_567_37 + var_567_30 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_37 + var_567_30
					end
				end

				arg_564_1.text_.text = var_567_34
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161136", "story_v_out_322161.awb") ~= 0 then
					local var_567_38 = manager.audio:GetVoiceLength("story_v_out_322161", "322161136", "story_v_out_322161.awb") / 1000

					if var_567_38 + var_567_30 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_38 + var_567_30
					end

					if var_567_33.prefab_name ~= "" and arg_564_1.actors_[var_567_33.prefab_name] ~= nil then
						local var_567_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_33.prefab_name].transform, "story_v_out_322161", "322161136", "story_v_out_322161.awb")

						arg_564_1:RecordAudio("322161136", var_567_39)
						arg_564_1:RecordAudio("322161136", var_567_39)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_322161", "322161136", "story_v_out_322161.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_322161", "322161136", "story_v_out_322161.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_40 = math.max(var_567_31, arg_564_1.talkMaxDuration)

			if var_567_30 <= arg_564_1.time_ and arg_564_1.time_ < var_567_30 + var_567_40 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_30) / var_567_40

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_30 + var_567_40 and arg_564_1.time_ < var_567_30 + var_567_40 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_564_1:InitPlayNodeList()
	end,
	Play322161137 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 322161137
		arg_568_1.duration_ = 7.3

		local var_568_0 = {
			zh = 6.7,
			ja = 7.3
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play322161138(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = arg_568_1.actors_["1044ui_story"].transform
			local var_571_1 = 0

			if var_571_1 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.var_.moveOldPos1044ui_story = var_571_0.localPosition
			end

			local var_571_2 = 0.001

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_2 then
				local var_571_3 = (arg_568_1.time_ - var_571_1) / var_571_2
				local var_571_4 = Vector3.New(0, -1, -5.93)

				var_571_0.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos1044ui_story, var_571_4, var_571_3)

				local var_571_5 = manager.ui.mainCamera.transform.position - var_571_0.position

				var_571_0.forward = Vector3.New(var_571_5.x, var_571_5.y, var_571_5.z)

				local var_571_6 = var_571_0.localEulerAngles

				var_571_6.z = 0
				var_571_6.x = 0
				var_571_0.localEulerAngles = var_571_6
			end

			if arg_568_1.time_ >= var_571_1 + var_571_2 and arg_568_1.time_ < var_571_1 + var_571_2 + arg_571_0 then
				var_571_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_571_7 = manager.ui.mainCamera.transform.position - var_571_0.position

				var_571_0.forward = Vector3.New(var_571_7.x, var_571_7.y, var_571_7.z)

				local var_571_8 = var_571_0.localEulerAngles

				var_571_8.z = 0
				var_571_8.x = 0
				var_571_0.localEulerAngles = var_571_8
			end

			local var_571_9 = arg_568_1.actors_["1211ui_story"].transform
			local var_571_10 = 0

			if var_571_10 < arg_568_1.time_ and arg_568_1.time_ <= var_571_10 + arg_571_0 then
				arg_568_1.var_.moveOldPos1211ui_story = var_571_9.localPosition
			end

			local var_571_11 = 0.001

			if var_571_10 <= arg_568_1.time_ and arg_568_1.time_ < var_571_10 + var_571_11 then
				local var_571_12 = (arg_568_1.time_ - var_571_10) / var_571_11
				local var_571_13 = Vector3.New(0, 100, 0)

				var_571_9.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos1211ui_story, var_571_13, var_571_12)

				local var_571_14 = manager.ui.mainCamera.transform.position - var_571_9.position

				var_571_9.forward = Vector3.New(var_571_14.x, var_571_14.y, var_571_14.z)

				local var_571_15 = var_571_9.localEulerAngles

				var_571_15.z = 0
				var_571_15.x = 0
				var_571_9.localEulerAngles = var_571_15
			end

			if arg_568_1.time_ >= var_571_10 + var_571_11 and arg_568_1.time_ < var_571_10 + var_571_11 + arg_571_0 then
				var_571_9.localPosition = Vector3.New(0, 100, 0)

				local var_571_16 = manager.ui.mainCamera.transform.position - var_571_9.position

				var_571_9.forward = Vector3.New(var_571_16.x, var_571_16.y, var_571_16.z)

				local var_571_17 = var_571_9.localEulerAngles

				var_571_17.z = 0
				var_571_17.x = 0
				var_571_9.localEulerAngles = var_571_17
			end

			local var_571_18 = arg_568_1.actors_["1044ui_story"]
			local var_571_19 = 0

			if var_571_19 < arg_568_1.time_ and arg_568_1.time_ <= var_571_19 + arg_571_0 and not isNil(var_571_18) and arg_568_1.var_.characterEffect1044ui_story == nil then
				arg_568_1.var_.characterEffect1044ui_story = var_571_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_571_20 = 0.2

			if var_571_19 <= arg_568_1.time_ and arg_568_1.time_ < var_571_19 + var_571_20 and not isNil(var_571_18) then
				local var_571_21 = (arg_568_1.time_ - var_571_19) / var_571_20

				if arg_568_1.var_.characterEffect1044ui_story and not isNil(var_571_18) then
					arg_568_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_568_1.time_ >= var_571_19 + var_571_20 and arg_568_1.time_ < var_571_19 + var_571_20 + arg_571_0 and not isNil(var_571_18) and arg_568_1.var_.characterEffect1044ui_story then
				arg_568_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_571_22 = 0

			if var_571_22 < arg_568_1.time_ and arg_568_1.time_ <= var_571_22 + arg_571_0 then
				arg_568_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_2")
			end

			local var_571_23 = 0

			if var_571_23 < arg_568_1.time_ and arg_568_1.time_ <= var_571_23 + arg_571_0 then
				arg_568_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_571_24 = 0
			local var_571_25 = 0.675

			if var_571_24 < arg_568_1.time_ and arg_568_1.time_ <= var_571_24 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_26 = arg_568_1:FormatText(StoryNameCfg[1367].name)

				arg_568_1.leftNameTxt_.text = var_571_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_27 = arg_568_1:GetWordFromCfg(322161137)
				local var_571_28 = arg_568_1:FormatText(var_571_27.content)

				arg_568_1.text_.text = var_571_28

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_29 = 27
				local var_571_30 = utf8.len(var_571_28)
				local var_571_31 = var_571_29 <= 0 and var_571_25 or var_571_25 * (var_571_30 / var_571_29)

				if var_571_31 > 0 and var_571_25 < var_571_31 then
					arg_568_1.talkMaxDuration = var_571_31

					if var_571_31 + var_571_24 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_31 + var_571_24
					end
				end

				arg_568_1.text_.text = var_571_28
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161137", "story_v_out_322161.awb") ~= 0 then
					local var_571_32 = manager.audio:GetVoiceLength("story_v_out_322161", "322161137", "story_v_out_322161.awb") / 1000

					if var_571_32 + var_571_24 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_32 + var_571_24
					end

					if var_571_27.prefab_name ~= "" and arg_568_1.actors_[var_571_27.prefab_name] ~= nil then
						local var_571_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_27.prefab_name].transform, "story_v_out_322161", "322161137", "story_v_out_322161.awb")

						arg_568_1:RecordAudio("322161137", var_571_33)
						arg_568_1:RecordAudio("322161137", var_571_33)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_322161", "322161137", "story_v_out_322161.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_322161", "322161137", "story_v_out_322161.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_34 = math.max(var_571_25, arg_568_1.talkMaxDuration)

			if var_571_24 <= arg_568_1.time_ and arg_568_1.time_ < var_571_24 + var_571_34 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_24) / var_571_34

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_24 + var_571_34 and arg_568_1.time_ < var_571_24 + var_571_34 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_568_1:InitPlayNodeList()
	end,
	Play322161138 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 322161138
		arg_572_1.duration_ = 8.43

		local var_572_0 = {
			zh = 8.433,
			ja = 8.4
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play322161139(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0
			local var_575_1 = 0.8

			if var_575_0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_2 = arg_572_1:FormatText(StoryNameCfg[1367].name)

				arg_572_1.leftNameTxt_.text = var_575_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_3 = arg_572_1:GetWordFromCfg(322161138)
				local var_575_4 = arg_572_1:FormatText(var_575_3.content)

				arg_572_1.text_.text = var_575_4

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_5 = 32
				local var_575_6 = utf8.len(var_575_4)
				local var_575_7 = var_575_5 <= 0 and var_575_1 or var_575_1 * (var_575_6 / var_575_5)

				if var_575_7 > 0 and var_575_1 < var_575_7 then
					arg_572_1.talkMaxDuration = var_575_7

					if var_575_7 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_7 + var_575_0
					end
				end

				arg_572_1.text_.text = var_575_4
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161138", "story_v_out_322161.awb") ~= 0 then
					local var_575_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161138", "story_v_out_322161.awb") / 1000

					if var_575_8 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_8 + var_575_0
					end

					if var_575_3.prefab_name ~= "" and arg_572_1.actors_[var_575_3.prefab_name] ~= nil then
						local var_575_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_3.prefab_name].transform, "story_v_out_322161", "322161138", "story_v_out_322161.awb")

						arg_572_1:RecordAudio("322161138", var_575_9)
						arg_572_1:RecordAudio("322161138", var_575_9)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_322161", "322161138", "story_v_out_322161.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_322161", "322161138", "story_v_out_322161.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_10 = math.max(var_575_1, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_10 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_0) / var_575_10

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_10 and arg_572_1.time_ < var_575_0 + var_575_10 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play322161139 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 322161139
		arg_576_1.duration_ = 4.63

		local var_576_0 = {
			zh = 3.8,
			ja = 4.633
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play322161140(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = 0

			if var_579_0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_579_1 = 0
			local var_579_2 = 0.375

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				local var_579_3 = arg_576_1:FormatText(StoryNameCfg[1367].name)

				arg_576_1.leftNameTxt_.text = var_579_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_4 = arg_576_1:GetWordFromCfg(322161139)
				local var_579_5 = arg_576_1:FormatText(var_579_4.content)

				arg_576_1.text_.text = var_579_5

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_6 = 15
				local var_579_7 = utf8.len(var_579_5)
				local var_579_8 = var_579_6 <= 0 and var_579_2 or var_579_2 * (var_579_7 / var_579_6)

				if var_579_8 > 0 and var_579_2 < var_579_8 then
					arg_576_1.talkMaxDuration = var_579_8

					if var_579_8 + var_579_1 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_8 + var_579_1
					end
				end

				arg_576_1.text_.text = var_579_5
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161139", "story_v_out_322161.awb") ~= 0 then
					local var_579_9 = manager.audio:GetVoiceLength("story_v_out_322161", "322161139", "story_v_out_322161.awb") / 1000

					if var_579_9 + var_579_1 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_9 + var_579_1
					end

					if var_579_4.prefab_name ~= "" and arg_576_1.actors_[var_579_4.prefab_name] ~= nil then
						local var_579_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_4.prefab_name].transform, "story_v_out_322161", "322161139", "story_v_out_322161.awb")

						arg_576_1:RecordAudio("322161139", var_579_10)
						arg_576_1:RecordAudio("322161139", var_579_10)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_322161", "322161139", "story_v_out_322161.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_322161", "322161139", "story_v_out_322161.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_11 = math.max(var_579_2, arg_576_1.talkMaxDuration)

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_11 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_1) / var_579_11

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_1 + var_579_11 and arg_576_1.time_ < var_579_1 + var_579_11 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play322161140 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 322161140
		arg_580_1.duration_ = 14.73

		local var_580_0 = {
			zh = 14.733,
			ja = 13.666
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
				arg_580_0:Play322161141(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 0
			local var_583_1 = 1.45

			if var_583_0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				local var_583_2 = arg_580_1:FormatText(StoryNameCfg[1367].name)

				arg_580_1.leftNameTxt_.text = var_583_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_3 = arg_580_1:GetWordFromCfg(322161140)
				local var_583_4 = arg_580_1:FormatText(var_583_3.content)

				arg_580_1.text_.text = var_583_4

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_5 = 58
				local var_583_6 = utf8.len(var_583_4)
				local var_583_7 = var_583_5 <= 0 and var_583_1 or var_583_1 * (var_583_6 / var_583_5)

				if var_583_7 > 0 and var_583_1 < var_583_7 then
					arg_580_1.talkMaxDuration = var_583_7

					if var_583_7 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_7 + var_583_0
					end
				end

				arg_580_1.text_.text = var_583_4
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161140", "story_v_out_322161.awb") ~= 0 then
					local var_583_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161140", "story_v_out_322161.awb") / 1000

					if var_583_8 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_8 + var_583_0
					end

					if var_583_3.prefab_name ~= "" and arg_580_1.actors_[var_583_3.prefab_name] ~= nil then
						local var_583_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_3.prefab_name].transform, "story_v_out_322161", "322161140", "story_v_out_322161.awb")

						arg_580_1:RecordAudio("322161140", var_583_9)
						arg_580_1:RecordAudio("322161140", var_583_9)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_out_322161", "322161140", "story_v_out_322161.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_out_322161", "322161140", "story_v_out_322161.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_10 = math.max(var_583_1, arg_580_1.talkMaxDuration)

			if var_583_0 <= arg_580_1.time_ and arg_580_1.time_ < var_583_0 + var_583_10 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_0) / var_583_10

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_0 + var_583_10 and arg_580_1.time_ < var_583_0 + var_583_10 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play322161141 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 322161141
		arg_584_1.duration_ = 6.1

		local var_584_0 = {
			zh = 5.666,
			ja = 6.1
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play322161142(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0

			if var_587_0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_0 + arg_587_0 then
				arg_584_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_587_1 = arg_584_1.actors_["1044ui_story"]
			local var_587_2 = 0

			if var_587_2 < arg_584_1.time_ and arg_584_1.time_ <= var_587_2 + arg_587_0 and not isNil(var_587_1) and arg_584_1.var_.characterEffect1044ui_story == nil then
				arg_584_1.var_.characterEffect1044ui_story = var_587_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_587_3 = 0.2

			if var_587_2 <= arg_584_1.time_ and arg_584_1.time_ < var_587_2 + var_587_3 and not isNil(var_587_1) then
				local var_587_4 = (arg_584_1.time_ - var_587_2) / var_587_3

				if arg_584_1.var_.characterEffect1044ui_story and not isNil(var_587_1) then
					arg_584_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_584_1.time_ >= var_587_2 + var_587_3 and arg_584_1.time_ < var_587_2 + var_587_3 + arg_587_0 and not isNil(var_587_1) and arg_584_1.var_.characterEffect1044ui_story then
				arg_584_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_587_5 = 0
			local var_587_6 = 0.55

			if var_587_5 < arg_584_1.time_ and arg_584_1.time_ <= var_587_5 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				local var_587_7 = arg_584_1:FormatText(StoryNameCfg[1367].name)

				arg_584_1.leftNameTxt_.text = var_587_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_8 = arg_584_1:GetWordFromCfg(322161141)
				local var_587_9 = arg_584_1:FormatText(var_587_8.content)

				arg_584_1.text_.text = var_587_9

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_10 = 22
				local var_587_11 = utf8.len(var_587_9)
				local var_587_12 = var_587_10 <= 0 and var_587_6 or var_587_6 * (var_587_11 / var_587_10)

				if var_587_12 > 0 and var_587_6 < var_587_12 then
					arg_584_1.talkMaxDuration = var_587_12

					if var_587_12 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_12 + var_587_5
					end
				end

				arg_584_1.text_.text = var_587_9
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161141", "story_v_out_322161.awb") ~= 0 then
					local var_587_13 = manager.audio:GetVoiceLength("story_v_out_322161", "322161141", "story_v_out_322161.awb") / 1000

					if var_587_13 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_13 + var_587_5
					end

					if var_587_8.prefab_name ~= "" and arg_584_1.actors_[var_587_8.prefab_name] ~= nil then
						local var_587_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_8.prefab_name].transform, "story_v_out_322161", "322161141", "story_v_out_322161.awb")

						arg_584_1:RecordAudio("322161141", var_587_14)
						arg_584_1:RecordAudio("322161141", var_587_14)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_322161", "322161141", "story_v_out_322161.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_322161", "322161141", "story_v_out_322161.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_15 = math.max(var_587_6, arg_584_1.talkMaxDuration)

			if var_587_5 <= arg_584_1.time_ and arg_584_1.time_ < var_587_5 + var_587_15 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_5) / var_587_15

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_5 + var_587_15 and arg_584_1.time_ < var_587_5 + var_587_15 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play322161142 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 322161142
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play322161143(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = arg_588_1.actors_["1044ui_story"]
			local var_591_1 = 0

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.characterEffect1044ui_story == nil then
				arg_588_1.var_.characterEffect1044ui_story = var_591_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_591_2 = 0.200000002980232

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_2 and not isNil(var_591_0) then
				local var_591_3 = (arg_588_1.time_ - var_591_1) / var_591_2

				if arg_588_1.var_.characterEffect1044ui_story and not isNil(var_591_0) then
					local var_591_4 = Mathf.Lerp(0, 0.5, var_591_3)

					arg_588_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_588_1.var_.characterEffect1044ui_story.fillRatio = var_591_4
				end
			end

			if arg_588_1.time_ >= var_591_1 + var_591_2 and arg_588_1.time_ < var_591_1 + var_591_2 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.characterEffect1044ui_story then
				local var_591_5 = 0.5

				arg_588_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_588_1.var_.characterEffect1044ui_story.fillRatio = var_591_5
			end

			local var_591_6 = 0
			local var_591_7 = 0.175

			if var_591_6 < arg_588_1.time_ and arg_588_1.time_ <= var_591_6 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				local var_591_8 = arg_588_1:FormatText(StoryNameCfg[7].name)

				arg_588_1.leftNameTxt_.text = var_591_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, true)
				arg_588_1.iconController_:SetSelectedState("hero")

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_9 = arg_588_1:GetWordFromCfg(322161142)
				local var_591_10 = arg_588_1:FormatText(var_591_9.content)

				arg_588_1.text_.text = var_591_10

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_11 = 7
				local var_591_12 = utf8.len(var_591_10)
				local var_591_13 = var_591_11 <= 0 and var_591_7 or var_591_7 * (var_591_12 / var_591_11)

				if var_591_13 > 0 and var_591_7 < var_591_13 then
					arg_588_1.talkMaxDuration = var_591_13

					if var_591_13 + var_591_6 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_13 + var_591_6
					end
				end

				arg_588_1.text_.text = var_591_10
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_14 = math.max(var_591_7, arg_588_1.talkMaxDuration)

			if var_591_6 <= arg_588_1.time_ and arg_588_1.time_ < var_591_6 + var_591_14 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_6) / var_591_14

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_6 + var_591_14 and arg_588_1.time_ < var_591_6 + var_591_14 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play322161143 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 322161143
		arg_592_1.duration_ = 1

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play322161144(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = arg_592_1.actors_["1044ui_story"]
			local var_595_1 = 0

			if var_595_1 < arg_592_1.time_ and arg_592_1.time_ <= var_595_1 + arg_595_0 and not isNil(var_595_0) and arg_592_1.var_.characterEffect1044ui_story == nil then
				arg_592_1.var_.characterEffect1044ui_story = var_595_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_2 = 0.2

			if var_595_1 <= arg_592_1.time_ and arg_592_1.time_ < var_595_1 + var_595_2 and not isNil(var_595_0) then
				local var_595_3 = (arg_592_1.time_ - var_595_1) / var_595_2

				if arg_592_1.var_.characterEffect1044ui_story and not isNil(var_595_0) then
					arg_592_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_592_1.time_ >= var_595_1 + var_595_2 and arg_592_1.time_ < var_595_1 + var_595_2 + arg_595_0 and not isNil(var_595_0) and arg_592_1.var_.characterEffect1044ui_story then
				arg_592_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_595_4 = 0
			local var_595_5 = 0.05

			if var_595_4 < arg_592_1.time_ and arg_592_1.time_ <= var_595_4 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_6 = arg_592_1:FormatText(StoryNameCfg[1367].name)

				arg_592_1.leftNameTxt_.text = var_595_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_7 = arg_592_1:GetWordFromCfg(322161143)
				local var_595_8 = arg_592_1:FormatText(var_595_7.content)

				arg_592_1.text_.text = var_595_8

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_9 = 2
				local var_595_10 = utf8.len(var_595_8)
				local var_595_11 = var_595_9 <= 0 and var_595_5 or var_595_5 * (var_595_10 / var_595_9)

				if var_595_11 > 0 and var_595_5 < var_595_11 then
					arg_592_1.talkMaxDuration = var_595_11

					if var_595_11 + var_595_4 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_11 + var_595_4
					end
				end

				arg_592_1.text_.text = var_595_8
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161143", "story_v_out_322161.awb") ~= 0 then
					local var_595_12 = manager.audio:GetVoiceLength("story_v_out_322161", "322161143", "story_v_out_322161.awb") / 1000

					if var_595_12 + var_595_4 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_12 + var_595_4
					end

					if var_595_7.prefab_name ~= "" and arg_592_1.actors_[var_595_7.prefab_name] ~= nil then
						local var_595_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_7.prefab_name].transform, "story_v_out_322161", "322161143", "story_v_out_322161.awb")

						arg_592_1:RecordAudio("322161143", var_595_13)
						arg_592_1:RecordAudio("322161143", var_595_13)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_322161", "322161143", "story_v_out_322161.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_322161", "322161143", "story_v_out_322161.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_14 = math.max(var_595_5, arg_592_1.talkMaxDuration)

			if var_595_4 <= arg_592_1.time_ and arg_592_1.time_ < var_595_4 + var_595_14 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_4) / var_595_14

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_4 + var_595_14 and arg_592_1.time_ < var_595_4 + var_595_14 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play322161144 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 322161144
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play322161145(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = arg_596_1.actors_["1044ui_story"]
			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1044ui_story == nil then
				arg_596_1.var_.characterEffect1044ui_story = var_599_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_2 = 0.2

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_2 and not isNil(var_599_0) then
				local var_599_3 = (arg_596_1.time_ - var_599_1) / var_599_2

				if arg_596_1.var_.characterEffect1044ui_story and not isNil(var_599_0) then
					local var_599_4 = Mathf.Lerp(0, 0.5, var_599_3)

					arg_596_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_596_1.var_.characterEffect1044ui_story.fillRatio = var_599_4
				end
			end

			if arg_596_1.time_ >= var_599_1 + var_599_2 and arg_596_1.time_ < var_599_1 + var_599_2 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1044ui_story then
				local var_599_5 = 0.5

				arg_596_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_596_1.var_.characterEffect1044ui_story.fillRatio = var_599_5
			end

			local var_599_6 = 0
			local var_599_7 = 0.575

			if var_599_6 < arg_596_1.time_ and arg_596_1.time_ <= var_599_6 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_8 = arg_596_1:FormatText(StoryNameCfg[7].name)

				arg_596_1.leftNameTxt_.text = var_599_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_9 = arg_596_1:GetWordFromCfg(322161144)
				local var_599_10 = arg_596_1:FormatText(var_599_9.content)

				arg_596_1.text_.text = var_599_10

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_11 = 23
				local var_599_12 = utf8.len(var_599_10)
				local var_599_13 = var_599_11 <= 0 and var_599_7 or var_599_7 * (var_599_12 / var_599_11)

				if var_599_13 > 0 and var_599_7 < var_599_13 then
					arg_596_1.talkMaxDuration = var_599_13

					if var_599_13 + var_599_6 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_13 + var_599_6
					end
				end

				arg_596_1.text_.text = var_599_10
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_14 = math.max(var_599_7, arg_596_1.talkMaxDuration)

			if var_599_6 <= arg_596_1.time_ and arg_596_1.time_ < var_599_6 + var_599_14 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_6) / var_599_14

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_6 + var_599_14 and arg_596_1.time_ < var_599_6 + var_599_14 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play322161145 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 322161145
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play322161146(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0
			local var_603_1 = 0.825

			if var_603_0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_2 = arg_600_1:FormatText(StoryNameCfg[7].name)

				arg_600_1.leftNameTxt_.text = var_603_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_3 = arg_600_1:GetWordFromCfg(322161145)
				local var_603_4 = arg_600_1:FormatText(var_603_3.content)

				arg_600_1.text_.text = var_603_4

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_5 = 33
				local var_603_6 = utf8.len(var_603_4)
				local var_603_7 = var_603_5 <= 0 and var_603_1 or var_603_1 * (var_603_6 / var_603_5)

				if var_603_7 > 0 and var_603_1 < var_603_7 then
					arg_600_1.talkMaxDuration = var_603_7

					if var_603_7 + var_603_0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_7 + var_603_0
					end
				end

				arg_600_1.text_.text = var_603_4
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_8 = math.max(var_603_1, arg_600_1.talkMaxDuration)

			if var_603_0 <= arg_600_1.time_ and arg_600_1.time_ < var_603_0 + var_603_8 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_0) / var_603_8

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_0 + var_603_8 and arg_600_1.time_ < var_603_0 + var_603_8 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play322161146 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 322161146
		arg_604_1.duration_ = 2.83

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play322161147(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["1044ui_story"]
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1044ui_story == nil then
				arg_604_1.var_.characterEffect1044ui_story = var_607_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_2 = 0.200000002980232

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 and not isNil(var_607_0) then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2

				if arg_604_1.var_.characterEffect1044ui_story and not isNil(var_607_0) then
					arg_604_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.characterEffect1044ui_story then
				arg_604_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_607_4 = 0

			if var_607_4 < arg_604_1.time_ and arg_604_1.time_ <= var_607_4 + arg_607_0 then
				arg_604_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_607_5 = 0
			local var_607_6 = 0.2

			if var_607_5 < arg_604_1.time_ and arg_604_1.time_ <= var_607_5 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_7 = arg_604_1:FormatText(StoryNameCfg[1367].name)

				arg_604_1.leftNameTxt_.text = var_607_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_8 = arg_604_1:GetWordFromCfg(322161146)
				local var_607_9 = arg_604_1:FormatText(var_607_8.content)

				arg_604_1.text_.text = var_607_9

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_10 = 8
				local var_607_11 = utf8.len(var_607_9)
				local var_607_12 = var_607_10 <= 0 and var_607_6 or var_607_6 * (var_607_11 / var_607_10)

				if var_607_12 > 0 and var_607_6 < var_607_12 then
					arg_604_1.talkMaxDuration = var_607_12

					if var_607_12 + var_607_5 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_12 + var_607_5
					end
				end

				arg_604_1.text_.text = var_607_9
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161146", "story_v_out_322161.awb") ~= 0 then
					local var_607_13 = manager.audio:GetVoiceLength("story_v_out_322161", "322161146", "story_v_out_322161.awb") / 1000

					if var_607_13 + var_607_5 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_13 + var_607_5
					end

					if var_607_8.prefab_name ~= "" and arg_604_1.actors_[var_607_8.prefab_name] ~= nil then
						local var_607_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_8.prefab_name].transform, "story_v_out_322161", "322161146", "story_v_out_322161.awb")

						arg_604_1:RecordAudio("322161146", var_607_14)
						arg_604_1:RecordAudio("322161146", var_607_14)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_322161", "322161146", "story_v_out_322161.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_322161", "322161146", "story_v_out_322161.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_15 = math.max(var_607_6, arg_604_1.talkMaxDuration)

			if var_607_5 <= arg_604_1.time_ and arg_604_1.time_ < var_607_5 + var_607_15 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_5) / var_607_15

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_5 + var_607_15 and arg_604_1.time_ < var_607_5 + var_607_15 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play322161147 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 322161147
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play322161148(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1044ui_story"]
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.characterEffect1044ui_story == nil then
				arg_608_1.var_.characterEffect1044ui_story = var_611_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_2 = 0.200000002980232

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 and not isNil(var_611_0) then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2

				if arg_608_1.var_.characterEffect1044ui_story and not isNil(var_611_0) then
					local var_611_4 = Mathf.Lerp(0, 0.5, var_611_3)

					arg_608_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_608_1.var_.characterEffect1044ui_story.fillRatio = var_611_4
				end
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.characterEffect1044ui_story then
				local var_611_5 = 0.5

				arg_608_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_608_1.var_.characterEffect1044ui_story.fillRatio = var_611_5
			end

			local var_611_6 = 0
			local var_611_7 = 0.2

			if var_611_6 < arg_608_1.time_ and arg_608_1.time_ <= var_611_6 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_8 = arg_608_1:FormatText(StoryNameCfg[7].name)

				arg_608_1.leftNameTxt_.text = var_611_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_9 = arg_608_1:GetWordFromCfg(322161147)
				local var_611_10 = arg_608_1:FormatText(var_611_9.content)

				arg_608_1.text_.text = var_611_10

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_11 = 8
				local var_611_12 = utf8.len(var_611_10)
				local var_611_13 = var_611_11 <= 0 and var_611_7 or var_611_7 * (var_611_12 / var_611_11)

				if var_611_13 > 0 and var_611_7 < var_611_13 then
					arg_608_1.talkMaxDuration = var_611_13

					if var_611_13 + var_611_6 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_13 + var_611_6
					end
				end

				arg_608_1.text_.text = var_611_10
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_14 = math.max(var_611_7, arg_608_1.talkMaxDuration)

			if var_611_6 <= arg_608_1.time_ and arg_608_1.time_ < var_611_6 + var_611_14 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_6) / var_611_14

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_6 + var_611_14 and arg_608_1.time_ < var_611_6 + var_611_14 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play322161148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 322161148
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play322161149(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = arg_612_1.actors_["1044ui_story"].transform
			local var_615_1 = 0

			if var_615_1 < arg_612_1.time_ and arg_612_1.time_ <= var_615_1 + arg_615_0 then
				arg_612_1.var_.moveOldPos1044ui_story = var_615_0.localPosition
			end

			local var_615_2 = 0.001

			if var_615_1 <= arg_612_1.time_ and arg_612_1.time_ < var_615_1 + var_615_2 then
				local var_615_3 = (arg_612_1.time_ - var_615_1) / var_615_2
				local var_615_4 = Vector3.New(0, 100, 0)

				var_615_0.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos1044ui_story, var_615_4, var_615_3)

				local var_615_5 = manager.ui.mainCamera.transform.position - var_615_0.position

				var_615_0.forward = Vector3.New(var_615_5.x, var_615_5.y, var_615_5.z)

				local var_615_6 = var_615_0.localEulerAngles

				var_615_6.z = 0
				var_615_6.x = 0
				var_615_0.localEulerAngles = var_615_6
			end

			if arg_612_1.time_ >= var_615_1 + var_615_2 and arg_612_1.time_ < var_615_1 + var_615_2 + arg_615_0 then
				var_615_0.localPosition = Vector3.New(0, 100, 0)

				local var_615_7 = manager.ui.mainCamera.transform.position - var_615_0.position

				var_615_0.forward = Vector3.New(var_615_7.x, var_615_7.y, var_615_7.z)

				local var_615_8 = var_615_0.localEulerAngles

				var_615_8.z = 0
				var_615_8.x = 0
				var_615_0.localEulerAngles = var_615_8
			end

			local var_615_9 = 0
			local var_615_10 = 1.45

			if var_615_9 < arg_612_1.time_ and arg_612_1.time_ <= var_615_9 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, false)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_11 = arg_612_1:GetWordFromCfg(322161148)
				local var_615_12 = arg_612_1:FormatText(var_615_11.content)

				arg_612_1.text_.text = var_615_12

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_13 = 58
				local var_615_14 = utf8.len(var_615_12)
				local var_615_15 = var_615_13 <= 0 and var_615_10 or var_615_10 * (var_615_14 / var_615_13)

				if var_615_15 > 0 and var_615_10 < var_615_15 then
					arg_612_1.talkMaxDuration = var_615_15

					if var_615_15 + var_615_9 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_15 + var_615_9
					end
				end

				arg_612_1.text_.text = var_615_12
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_16 = math.max(var_615_10, arg_612_1.talkMaxDuration)

			if var_615_9 <= arg_612_1.time_ and arg_612_1.time_ < var_615_9 + var_615_16 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_9) / var_615_16

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_9 + var_615_16 and arg_612_1.time_ < var_615_9 + var_615_16 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play322161149 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 322161149
		arg_616_1.duration_ = 9.37

		local var_616_0 = {
			zh = 8.5,
			ja = 9.366
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play322161150(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = arg_616_1.actors_["1044ui_story"].transform
			local var_619_1 = 0

			if var_619_1 < arg_616_1.time_ and arg_616_1.time_ <= var_619_1 + arg_619_0 then
				arg_616_1.var_.moveOldPos1044ui_story = var_619_0.localPosition
			end

			local var_619_2 = 0.001

			if var_619_1 <= arg_616_1.time_ and arg_616_1.time_ < var_619_1 + var_619_2 then
				local var_619_3 = (arg_616_1.time_ - var_619_1) / var_619_2
				local var_619_4 = Vector3.New(0, -1, -5.93)

				var_619_0.localPosition = Vector3.Lerp(arg_616_1.var_.moveOldPos1044ui_story, var_619_4, var_619_3)

				local var_619_5 = manager.ui.mainCamera.transform.position - var_619_0.position

				var_619_0.forward = Vector3.New(var_619_5.x, var_619_5.y, var_619_5.z)

				local var_619_6 = var_619_0.localEulerAngles

				var_619_6.z = 0
				var_619_6.x = 0
				var_619_0.localEulerAngles = var_619_6
			end

			if arg_616_1.time_ >= var_619_1 + var_619_2 and arg_616_1.time_ < var_619_1 + var_619_2 + arg_619_0 then
				var_619_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_619_7 = manager.ui.mainCamera.transform.position - var_619_0.position

				var_619_0.forward = Vector3.New(var_619_7.x, var_619_7.y, var_619_7.z)

				local var_619_8 = var_619_0.localEulerAngles

				var_619_8.z = 0
				var_619_8.x = 0
				var_619_0.localEulerAngles = var_619_8
			end

			local var_619_9 = 0

			if var_619_9 < arg_616_1.time_ and arg_616_1.time_ <= var_619_9 + arg_619_0 then
				arg_616_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_619_10 = 0

			if var_619_10 < arg_616_1.time_ and arg_616_1.time_ <= var_619_10 + arg_619_0 then
				arg_616_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_619_11 = arg_616_1.actors_["1044ui_story"]
			local var_619_12 = 0

			if var_619_12 < arg_616_1.time_ and arg_616_1.time_ <= var_619_12 + arg_619_0 and not isNil(var_619_11) and arg_616_1.var_.characterEffect1044ui_story == nil then
				arg_616_1.var_.characterEffect1044ui_story = var_619_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_13 = 0.200000002980232

			if var_619_12 <= arg_616_1.time_ and arg_616_1.time_ < var_619_12 + var_619_13 and not isNil(var_619_11) then
				local var_619_14 = (arg_616_1.time_ - var_619_12) / var_619_13

				if arg_616_1.var_.characterEffect1044ui_story and not isNil(var_619_11) then
					arg_616_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_616_1.time_ >= var_619_12 + var_619_13 and arg_616_1.time_ < var_619_12 + var_619_13 + arg_619_0 and not isNil(var_619_11) and arg_616_1.var_.characterEffect1044ui_story then
				arg_616_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_619_15 = 0
			local var_619_16 = 0.3

			if var_619_15 < arg_616_1.time_ and arg_616_1.time_ <= var_619_15 + arg_619_0 then
				local var_619_17 = "play"
				local var_619_18 = "music"

				arg_616_1:AudioAction(var_619_17, var_619_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_619_19 = ""
				local var_619_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_619_20 ~= "" then
					if arg_616_1.bgmTxt_.text ~= var_619_20 and arg_616_1.bgmTxt_.text ~= "" then
						if arg_616_1.bgmTxt2_.text ~= "" then
							arg_616_1.bgmTxt_.text = arg_616_1.bgmTxt2_.text
						end

						arg_616_1.bgmTxt2_.text = var_619_20

						arg_616_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_616_1.bgmTxt_.text = var_619_20
						arg_616_1.bgmTxt2_.text = var_619_20
					end

					if arg_616_1.bgmTimer then
						arg_616_1.bgmTimer:Stop()

						arg_616_1.bgmTimer = nil
					end

					if arg_616_1.settingData.show_music_name == 1 then
						arg_616_1.musicController:SetSelectedState("show")
						arg_616_1.musicAnimator_:Play("open", 0, 0)

						if arg_616_1.settingData.music_time ~= 0 then
							arg_616_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_616_1.settingData.music_time), function()
								if arg_616_1 == nil or isNil(arg_616_1.bgmTxt_) then
									return
								end

								arg_616_1.musicController:SetSelectedState("hide")
								arg_616_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_619_21 = 0
			local var_619_22 = 0.85

			if var_619_21 < arg_616_1.time_ and arg_616_1.time_ <= var_619_21 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				local var_619_23 = arg_616_1:FormatText(StoryNameCfg[1367].name)

				arg_616_1.leftNameTxt_.text = var_619_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_24 = arg_616_1:GetWordFromCfg(322161149)
				local var_619_25 = arg_616_1:FormatText(var_619_24.content)

				arg_616_1.text_.text = var_619_25

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_26 = 34
				local var_619_27 = utf8.len(var_619_25)
				local var_619_28 = var_619_26 <= 0 and var_619_22 or var_619_22 * (var_619_27 / var_619_26)

				if var_619_28 > 0 and var_619_22 < var_619_28 then
					arg_616_1.talkMaxDuration = var_619_28

					if var_619_28 + var_619_21 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_28 + var_619_21
					end
				end

				arg_616_1.text_.text = var_619_25
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161149", "story_v_out_322161.awb") ~= 0 then
					local var_619_29 = manager.audio:GetVoiceLength("story_v_out_322161", "322161149", "story_v_out_322161.awb") / 1000

					if var_619_29 + var_619_21 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_29 + var_619_21
					end

					if var_619_24.prefab_name ~= "" and arg_616_1.actors_[var_619_24.prefab_name] ~= nil then
						local var_619_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_24.prefab_name].transform, "story_v_out_322161", "322161149", "story_v_out_322161.awb")

						arg_616_1:RecordAudio("322161149", var_619_30)
						arg_616_1:RecordAudio("322161149", var_619_30)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_322161", "322161149", "story_v_out_322161.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_322161", "322161149", "story_v_out_322161.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_31 = math.max(var_619_22, arg_616_1.talkMaxDuration)

			if var_619_21 <= arg_616_1.time_ and arg_616_1.time_ < var_619_21 + var_619_31 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_21) / var_619_31

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_21 + var_619_31 and arg_616_1.time_ < var_619_21 + var_619_31 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_616_1:InitPlayNodeList()
	end,
	Play322161150 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 322161150
		arg_621_1.duration_ = 7.93

		local var_621_0 = {
			zh = 7.933,
			ja = 6.3
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
				arg_621_0:Play322161151(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_624_1 = 0

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_1")
			end

			local var_624_2 = 0
			local var_624_3 = 0.825

			if var_624_2 < arg_621_1.time_ and arg_621_1.time_ <= var_624_2 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_4 = arg_621_1:FormatText(StoryNameCfg[1367].name)

				arg_621_1.leftNameTxt_.text = var_624_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_5 = arg_621_1:GetWordFromCfg(322161150)
				local var_624_6 = arg_621_1:FormatText(var_624_5.content)

				arg_621_1.text_.text = var_624_6

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_7 = 33
				local var_624_8 = utf8.len(var_624_6)
				local var_624_9 = var_624_7 <= 0 and var_624_3 or var_624_3 * (var_624_8 / var_624_7)

				if var_624_9 > 0 and var_624_3 < var_624_9 then
					arg_621_1.talkMaxDuration = var_624_9

					if var_624_9 + var_624_2 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_9 + var_624_2
					end
				end

				arg_621_1.text_.text = var_624_6
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161150", "story_v_out_322161.awb") ~= 0 then
					local var_624_10 = manager.audio:GetVoiceLength("story_v_out_322161", "322161150", "story_v_out_322161.awb") / 1000

					if var_624_10 + var_624_2 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_10 + var_624_2
					end

					if var_624_5.prefab_name ~= "" and arg_621_1.actors_[var_624_5.prefab_name] ~= nil then
						local var_624_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_5.prefab_name].transform, "story_v_out_322161", "322161150", "story_v_out_322161.awb")

						arg_621_1:RecordAudio("322161150", var_624_11)
						arg_621_1:RecordAudio("322161150", var_624_11)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_322161", "322161150", "story_v_out_322161.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_322161", "322161150", "story_v_out_322161.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_12 = math.max(var_624_3, arg_621_1.talkMaxDuration)

			if var_624_2 <= arg_621_1.time_ and arg_621_1.time_ < var_624_2 + var_624_12 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_2) / var_624_12

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_2 + var_624_12 and arg_621_1.time_ < var_624_2 + var_624_12 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play322161151 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 322161151
		arg_625_1.duration_ = 5.8

		local var_625_0 = {
			zh = 5.8,
			ja = 3.766
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play322161152(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0

			if var_628_0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_0 + arg_628_0 then
				arg_625_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_2")
			end

			local var_628_1 = 0
			local var_628_2 = 0.475

			if var_628_1 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_3 = arg_625_1:FormatText(StoryNameCfg[1367].name)

				arg_625_1.leftNameTxt_.text = var_628_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_4 = arg_625_1:GetWordFromCfg(322161151)
				local var_628_5 = arg_625_1:FormatText(var_628_4.content)

				arg_625_1.text_.text = var_628_5

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_6 = 19
				local var_628_7 = utf8.len(var_628_5)
				local var_628_8 = var_628_6 <= 0 and var_628_2 or var_628_2 * (var_628_7 / var_628_6)

				if var_628_8 > 0 and var_628_2 < var_628_8 then
					arg_625_1.talkMaxDuration = var_628_8

					if var_628_8 + var_628_1 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_8 + var_628_1
					end
				end

				arg_625_1.text_.text = var_628_5
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161151", "story_v_out_322161.awb") ~= 0 then
					local var_628_9 = manager.audio:GetVoiceLength("story_v_out_322161", "322161151", "story_v_out_322161.awb") / 1000

					if var_628_9 + var_628_1 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_9 + var_628_1
					end

					if var_628_4.prefab_name ~= "" and arg_625_1.actors_[var_628_4.prefab_name] ~= nil then
						local var_628_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_4.prefab_name].transform, "story_v_out_322161", "322161151", "story_v_out_322161.awb")

						arg_625_1:RecordAudio("322161151", var_628_10)
						arg_625_1:RecordAudio("322161151", var_628_10)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_out_322161", "322161151", "story_v_out_322161.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_out_322161", "322161151", "story_v_out_322161.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_11 = math.max(var_628_2, arg_625_1.talkMaxDuration)

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_11 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_1) / var_628_11

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_1 + var_628_11 and arg_625_1.time_ < var_628_1 + var_628_11 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play322161152 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 322161152
		arg_629_1.duration_ = 87.47

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play322161153(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = arg_629_1.actors_["1044ui_story"].transform
			local var_632_1 = 1.5

			if var_632_1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 then
				arg_629_1.var_.moveOldPos1044ui_story = var_632_0.localPosition
			end

			local var_632_2 = 0.001

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_2 then
				local var_632_3 = (arg_629_1.time_ - var_632_1) / var_632_2
				local var_632_4 = Vector3.New(0, 100, 0)

				var_632_0.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1044ui_story, var_632_4, var_632_3)

				local var_632_5 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_5.x, var_632_5.y, var_632_5.z)

				local var_632_6 = var_632_0.localEulerAngles

				var_632_6.z = 0
				var_632_6.x = 0
				var_632_0.localEulerAngles = var_632_6
			end

			if arg_629_1.time_ >= var_632_1 + var_632_2 and arg_629_1.time_ < var_632_1 + var_632_2 + arg_632_0 then
				var_632_0.localPosition = Vector3.New(0, 100, 0)

				local var_632_7 = manager.ui.mainCamera.transform.position - var_632_0.position

				var_632_0.forward = Vector3.New(var_632_7.x, var_632_7.y, var_632_7.z)

				local var_632_8 = var_632_0.localEulerAngles

				var_632_8.z = 0
				var_632_8.x = 0
				var_632_0.localEulerAngles = var_632_8
			end

			local var_632_9 = 2.46666666666667
			local var_632_10 = 0.3

			if var_632_9 < arg_629_1.time_ and arg_629_1.time_ <= var_632_9 + arg_632_0 then
				local var_632_11 = "play"
				local var_632_12 = "music"

				arg_629_1:AudioAction(var_632_11, var_632_12, "ui_battle", "ui_battle_stopbgm", "")

				local var_632_13 = ""
				local var_632_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_632_14 ~= "" then
					if arg_629_1.bgmTxt_.text ~= var_632_14 and arg_629_1.bgmTxt_.text ~= "" then
						if arg_629_1.bgmTxt2_.text ~= "" then
							arg_629_1.bgmTxt_.text = arg_629_1.bgmTxt2_.text
						end

						arg_629_1.bgmTxt2_.text = var_632_14

						arg_629_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_629_1.bgmTxt_.text = var_632_14
						arg_629_1.bgmTxt2_.text = var_632_14
					end

					if arg_629_1.bgmTimer then
						arg_629_1.bgmTimer:Stop()

						arg_629_1.bgmTimer = nil
					end

					if arg_629_1.settingData.show_music_name == 1 then
						arg_629_1.musicController:SetSelectedState("show")
						arg_629_1.musicAnimator_:Play("open", 0, 0)

						if arg_629_1.settingData.music_time ~= 0 then
							arg_629_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_629_1.settingData.music_time), function()
								if arg_629_1 == nil or isNil(arg_629_1.bgmTxt_) then
									return
								end

								arg_629_1.musicController:SetSelectedState("hide")
								arg_629_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_632_15 = 2.93333333333333
			local var_632_16 = 1

			if var_632_15 < arg_629_1.time_ and arg_629_1.time_ <= var_632_15 + arg_632_0 then
				local var_632_17 = "play"
				local var_632_18 = "music"

				arg_629_1:AudioAction(var_632_17, var_632_18, "bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra.awb")

				local var_632_19 = ""
				local var_632_20 = manager.audio:GetAudioName("bgm_activity_4_5_story_ra", "bgm_activity_4_5_story_ra")

				if var_632_20 ~= "" then
					if arg_629_1.bgmTxt_.text ~= var_632_20 and arg_629_1.bgmTxt_.text ~= "" then
						if arg_629_1.bgmTxt2_.text ~= "" then
							arg_629_1.bgmTxt_.text = arg_629_1.bgmTxt2_.text
						end

						arg_629_1.bgmTxt2_.text = var_632_20

						arg_629_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_629_1.bgmTxt_.text = var_632_20
						arg_629_1.bgmTxt2_.text = var_632_20
					end

					if arg_629_1.bgmTimer then
						arg_629_1.bgmTimer:Stop()

						arg_629_1.bgmTimer = nil
					end

					if arg_629_1.settingData.show_music_name == 1 then
						arg_629_1.musicController:SetSelectedState("show")
						arg_629_1.musicAnimator_:Play("open", 0, 0)

						if arg_629_1.settingData.music_time ~= 0 then
							arg_629_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_629_1.settingData.music_time), function()
								if arg_629_1 == nil or isNil(arg_629_1.bgmTxt_) then
									return
								end

								arg_629_1.musicController:SetSelectedState("hide")
								arg_629_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_632_21 = 2.46666666666667
			local var_632_22 = 1

			if var_632_21 < arg_629_1.time_ and arg_629_1.time_ <= var_632_21 + arg_632_0 then
				local var_632_23 = "stop"
				local var_632_24 = "effect"

				arg_629_1:AudioAction(var_632_23, var_632_24, "se_story_145", "se_story_145_amb_data", "")
			end

			local var_632_25 = 2.56666666666667
			local var_632_26 = 1

			if var_632_25 < arg_629_1.time_ and arg_629_1.time_ <= var_632_25 + arg_632_0 then
				local var_632_27 = "play"
				local var_632_28 = "effect"

				arg_629_1:AudioAction(var_632_27, var_632_28, "se_story_145", "se_story_145_amb_MS2208", "")
			end

			local var_632_29 = 2.46666666666667

			if var_632_29 < arg_629_1.time_ and arg_629_1.time_ <= var_632_29 + arg_632_0 then
				arg_629_1.allBtn_.enabled = false
			end

			local var_632_30 = 1

			if arg_629_1.time_ >= var_632_29 + var_632_30 and arg_629_1.time_ < var_632_29 + var_632_30 + arg_632_0 then
				arg_629_1.allBtn_.enabled = true
			end

			local var_632_31 = 0

			if var_632_31 < arg_629_1.time_ and arg_629_1.time_ <= var_632_31 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_32 = 1.5

			if var_632_31 <= arg_629_1.time_ and arg_629_1.time_ < var_632_31 + var_632_32 then
				local var_632_33 = (arg_629_1.time_ - var_632_31) / var_632_32
				local var_632_34 = Color.New(0, 0, 0)

				var_632_34.a = Mathf.Lerp(0, 1, var_632_33)
				arg_629_1.mask_.color = var_632_34
			end

			if arg_629_1.time_ >= var_632_31 + var_632_32 and arg_629_1.time_ < var_632_31 + var_632_32 + arg_632_0 then
				local var_632_35 = Color.New(0, 0, 0)

				var_632_35.a = 1
				arg_629_1.mask_.color = var_632_35
			end

			local var_632_36 = 1.5

			if var_632_36 < arg_629_1.time_ and arg_629_1.time_ <= var_632_36 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_37 = 2.46666666666667

			if var_632_36 <= arg_629_1.time_ and arg_629_1.time_ < var_632_36 + var_632_37 then
				local var_632_38 = (arg_629_1.time_ - var_632_36) / var_632_37
				local var_632_39 = Color.New(0, 0, 0)

				var_632_39.a = Mathf.Lerp(1, 0, var_632_38)
				arg_629_1.mask_.color = var_632_39
			end

			if arg_629_1.time_ >= var_632_36 + var_632_37 and arg_629_1.time_ < var_632_36 + var_632_37 + arg_632_0 then
				local var_632_40 = Color.New(0, 0, 0)
				local var_632_41 = 0

				arg_629_1.mask_.enabled = false
				var_632_40.a = var_632_41
				arg_629_1.mask_.color = var_632_40
			end

			if arg_629_1.frameCnt_ <= 1 then
				arg_629_1.dialog_:SetActive(false)
			end

			local var_632_42 = 2.46666666666667
			local var_632_43 = 0.475

			if var_632_42 < arg_629_1.time_ and arg_629_1.time_ <= var_632_42 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0

				arg_629_1.dialog_:SetActive(true)

				arg_629_1.dialogCg_.alpha = 0

				local var_632_44 = LeanTween.value(arg_629_1.dialog_, 0, 1, 0.3)

				var_632_44:setOnUpdate(LuaHelper.FloatAction(function(arg_635_0)
					arg_629_1.dialogCg_.alpha = arg_635_0
				end))
				var_632_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_629_1.dialog_)
					var_632_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_629_1.duration_ = arg_629_1.duration_ + 0.3

				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_45 = arg_629_1:FormatText(StoryNameCfg[1367].name)

				arg_629_1.leftNameTxt_.text = var_632_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_46 = arg_629_1:GetWordFromCfg(322161152)
				local var_632_47 = arg_629_1:FormatText(var_632_46.content)

				arg_629_1.text_.text = var_632_47

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_48 = 3
				local var_632_49 = utf8.len(var_632_47)
				local var_632_50 = var_632_48 <= 0 and var_632_43 or var_632_43 * (var_632_49 / var_632_48)

				if var_632_50 > 0 and var_632_43 < var_632_50 then
					arg_629_1.talkMaxDuration = var_632_50
					var_632_42 = var_632_42 + 0.3

					if var_632_50 + var_632_42 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_50 + var_632_42
					end
				end

				arg_629_1.text_.text = var_632_47
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161152", "story_v_out_322161.awb") ~= 0 then
					local var_632_51 = manager.audio:GetVoiceLength("story_v_out_322161", "322161152", "story_v_out_322161.awb") / 1000

					if var_632_51 + var_632_42 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_51 + var_632_42
					end

					if var_632_46.prefab_name ~= "" and arg_629_1.actors_[var_632_46.prefab_name] ~= nil then
						local var_632_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_46.prefab_name].transform, "story_v_out_322161", "322161152", "story_v_out_322161.awb")

						arg_629_1:RecordAudio("322161152", var_632_52)
						arg_629_1:RecordAudio("322161152", var_632_52)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_322161", "322161152", "story_v_out_322161.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_322161", "322161152", "story_v_out_322161.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_53 = var_632_42 + 0.3
			local var_632_54 = math.max(var_632_43, arg_629_1.talkMaxDuration)

			if var_632_53 <= arg_629_1.time_ and arg_629_1.time_ < var_632_53 + var_632_54 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_53) / var_632_54

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_53 + var_632_54 and arg_629_1.time_ < var_632_53 + var_632_54 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
			{
				isPlay = true,
				videoPath = "SofdecAsset/story/story_1032216_loop.usm",
				partLoopVideoPath = "",
				duration = 13.3333333333333,
				className = "StoryPlayBackgroundVideoNode",
				startTime = 1.45,
				videoStopMode = StoryPlayerConst.BACKGROUND_VIDEO_STOP_MODE.MANUAL,
				playMode = StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.LOOP
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_629_1:InitPlayNodeList()
	end,
	Play322161153 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 322161153
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play322161154(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0
			local var_640_1 = 1.075

			if var_640_0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0

				arg_637_1.dialog_:SetActive(true)

				arg_637_1.dialogCg_.alpha = 0

				local var_640_2 = LeanTween.value(arg_637_1.dialog_, 0, 1, 0.3)

				var_640_2:setOnUpdate(LuaHelper.FloatAction(function(arg_641_0)
					arg_637_1.dialogCg_.alpha = arg_641_0
				end))
				var_640_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_637_1.dialog_)
					var_640_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_637_1.duration_ = arg_637_1.duration_ + 0.3

				SetActive(arg_637_1.leftNameGo_, false)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_3 = arg_637_1:GetWordFromCfg(322161153)
				local var_640_4 = arg_637_1:FormatText(var_640_3.content)

				arg_637_1.text_.text = var_640_4

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 43
				local var_640_6 = utf8.len(var_640_4)
				local var_640_7 = var_640_5 <= 0 and var_640_1 or var_640_1 * (var_640_6 / var_640_5)

				if var_640_7 > 0 and var_640_1 < var_640_7 then
					arg_637_1.talkMaxDuration = var_640_7
					var_640_0 = var_640_0 + 0.3

					if var_640_7 + var_640_0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_0
					end
				end

				arg_637_1.text_.text = var_640_4
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_8 = var_640_0 + 0.3
			local var_640_9 = math.max(var_640_1, arg_637_1.talkMaxDuration)

			if var_640_8 <= arg_637_1.time_ and arg_637_1.time_ < var_640_8 + var_640_9 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_8) / var_640_9

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_8 + var_640_9 and arg_637_1.time_ < var_640_8 + var_640_9 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play322161154 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 322161154
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play322161155(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 0
			local var_646_1 = 0.775

			if var_646_0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_2 = arg_643_1:GetWordFromCfg(322161154)
				local var_646_3 = arg_643_1:FormatText(var_646_2.content)

				arg_643_1.text_.text = var_646_3

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_4 = 31
				local var_646_5 = utf8.len(var_646_3)
				local var_646_6 = var_646_4 <= 0 and var_646_1 or var_646_1 * (var_646_5 / var_646_4)

				if var_646_6 > 0 and var_646_1 < var_646_6 then
					arg_643_1.talkMaxDuration = var_646_6

					if var_646_6 + var_646_0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_6 + var_646_0
					end
				end

				arg_643_1.text_.text = var_646_3
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_7 = math.max(var_646_1, arg_643_1.talkMaxDuration)

			if var_646_0 <= arg_643_1.time_ and arg_643_1.time_ < var_646_0 + var_646_7 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_0) / var_646_7

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_0 + var_646_7 and arg_643_1.time_ < var_646_0 + var_646_7 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play322161155 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 322161155
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play322161156(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0
			local var_650_1 = 1.55

			if var_650_0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_2 = arg_647_1:GetWordFromCfg(322161155)
				local var_650_3 = arg_647_1:FormatText(var_650_2.content)

				arg_647_1.text_.text = var_650_3

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 62
				local var_650_5 = utf8.len(var_650_3)
				local var_650_6 = var_650_4 <= 0 and var_650_1 or var_650_1 * (var_650_5 / var_650_4)

				if var_650_6 > 0 and var_650_1 < var_650_6 then
					arg_647_1.talkMaxDuration = var_650_6

					if var_650_6 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_6 + var_650_0
					end
				end

				arg_647_1.text_.text = var_650_3
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_7 = math.max(var_650_1, arg_647_1.talkMaxDuration)

			if var_650_0 <= arg_647_1.time_ and arg_647_1.time_ < var_650_0 + var_650_7 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_0) / var_650_7

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_0 + var_650_7 and arg_647_1.time_ < var_650_0 + var_650_7 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play322161156 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 322161156
		arg_651_1.duration_ = 3.27

		local var_651_0 = {
			zh = 3.266,
			ja = 3.2
		}
		local var_651_1 = manager.audio:GetLocalizationFlag()

		if var_651_0[var_651_1] ~= nil then
			arg_651_1.duration_ = var_651_0[var_651_1]
		end

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play322161157(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0
			local var_654_1 = 0.175

			if var_654_0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_2 = arg_651_1:FormatText(StoryNameCfg[67].name)

				arg_651_1.leftNameTxt_.text = var_654_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_3 = arg_651_1:GetWordFromCfg(322161156)
				local var_654_4 = arg_651_1:FormatText(var_654_3.content)

				arg_651_1.text_.text = var_654_4

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 7
				local var_654_6 = utf8.len(var_654_4)
				local var_654_7 = var_654_5 <= 0 and var_654_1 or var_654_1 * (var_654_6 / var_654_5)

				if var_654_7 > 0 and var_654_1 < var_654_7 then
					arg_651_1.talkMaxDuration = var_654_7

					if var_654_7 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_7 + var_654_0
					end
				end

				arg_651_1.text_.text = var_654_4
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161156", "story_v_out_322161.awb") ~= 0 then
					local var_654_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161156", "story_v_out_322161.awb") / 1000

					if var_654_8 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_8 + var_654_0
					end

					if var_654_3.prefab_name ~= "" and arg_651_1.actors_[var_654_3.prefab_name] ~= nil then
						local var_654_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_3.prefab_name].transform, "story_v_out_322161", "322161156", "story_v_out_322161.awb")

						arg_651_1:RecordAudio("322161156", var_654_9)
						arg_651_1:RecordAudio("322161156", var_654_9)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_out_322161", "322161156", "story_v_out_322161.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_out_322161", "322161156", "story_v_out_322161.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_10 = math.max(var_654_1, arg_651_1.talkMaxDuration)

			if var_654_0 <= arg_651_1.time_ and arg_651_1.time_ < var_654_0 + var_654_10 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_0) / var_654_10

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_0 + var_654_10 and arg_651_1.time_ < var_654_0 + var_654_10 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play322161157 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 322161157
		arg_655_1.duration_ = 8.7

		local var_655_0 = {
			zh = 6.1,
			ja = 8.7
		}
		local var_655_1 = manager.audio:GetLocalizationFlag()

		if var_655_0[var_655_1] ~= nil then
			arg_655_1.duration_ = var_655_0[var_655_1]
		end

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play322161158(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0
			local var_658_1 = 0.625

			if var_658_0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_0 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_2 = arg_655_1:FormatText(StoryNameCfg[1178].name)

				arg_655_1.leftNameTxt_.text = var_658_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_3 = arg_655_1:GetWordFromCfg(322161157)
				local var_658_4 = arg_655_1:FormatText(var_658_3.content)

				arg_655_1.text_.text = var_658_4

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 25
				local var_658_6 = utf8.len(var_658_4)
				local var_658_7 = var_658_5 <= 0 and var_658_1 or var_658_1 * (var_658_6 / var_658_5)

				if var_658_7 > 0 and var_658_1 < var_658_7 then
					arg_655_1.talkMaxDuration = var_658_7

					if var_658_7 + var_658_0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_7 + var_658_0
					end
				end

				arg_655_1.text_.text = var_658_4
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161157", "story_v_out_322161.awb") ~= 0 then
					local var_658_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161157", "story_v_out_322161.awb") / 1000

					if var_658_8 + var_658_0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_8 + var_658_0
					end

					if var_658_3.prefab_name ~= "" and arg_655_1.actors_[var_658_3.prefab_name] ~= nil then
						local var_658_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_3.prefab_name].transform, "story_v_out_322161", "322161157", "story_v_out_322161.awb")

						arg_655_1:RecordAudio("322161157", var_658_9)
						arg_655_1:RecordAudio("322161157", var_658_9)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_out_322161", "322161157", "story_v_out_322161.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_out_322161", "322161157", "story_v_out_322161.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_10 = math.max(var_658_1, arg_655_1.talkMaxDuration)

			if var_658_0 <= arg_655_1.time_ and arg_655_1.time_ < var_658_0 + var_658_10 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_0) / var_658_10

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_0 + var_658_10 and arg_655_1.time_ < var_658_0 + var_658_10 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play322161158 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 322161158
		arg_659_1.duration_ = 7.1

		local var_659_0 = {
			zh = 6.333,
			ja = 7.1
		}
		local var_659_1 = manager.audio:GetLocalizationFlag()

		if var_659_0[var_659_1] ~= nil then
			arg_659_1.duration_ = var_659_0[var_659_1]
		end

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play322161159(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0
			local var_662_1 = 0.775

			if var_662_0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_2 = arg_659_1:FormatText(StoryNameCfg[1178].name)

				arg_659_1.leftNameTxt_.text = var_662_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_3 = arg_659_1:GetWordFromCfg(322161158)
				local var_662_4 = arg_659_1:FormatText(var_662_3.content)

				arg_659_1.text_.text = var_662_4

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_5 = 31
				local var_662_6 = utf8.len(var_662_4)
				local var_662_7 = var_662_5 <= 0 and var_662_1 or var_662_1 * (var_662_6 / var_662_5)

				if var_662_7 > 0 and var_662_1 < var_662_7 then
					arg_659_1.talkMaxDuration = var_662_7

					if var_662_7 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_7 + var_662_0
					end
				end

				arg_659_1.text_.text = var_662_4
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161158", "story_v_out_322161.awb") ~= 0 then
					local var_662_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161158", "story_v_out_322161.awb") / 1000

					if var_662_8 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_8 + var_662_0
					end

					if var_662_3.prefab_name ~= "" and arg_659_1.actors_[var_662_3.prefab_name] ~= nil then
						local var_662_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_3.prefab_name].transform, "story_v_out_322161", "322161158", "story_v_out_322161.awb")

						arg_659_1:RecordAudio("322161158", var_662_9)
						arg_659_1:RecordAudio("322161158", var_662_9)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_out_322161", "322161158", "story_v_out_322161.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_out_322161", "322161158", "story_v_out_322161.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_10 = math.max(var_662_1, arg_659_1.talkMaxDuration)

			if var_662_0 <= arg_659_1.time_ and arg_659_1.time_ < var_662_0 + var_662_10 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_0) / var_662_10

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_0 + var_662_10 and arg_659_1.time_ < var_662_0 + var_662_10 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play322161159 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 322161159
		arg_663_1.duration_ = 7.87

		local var_663_0 = {
			zh = 5.233,
			ja = 7.866
		}
		local var_663_1 = manager.audio:GetLocalizationFlag()

		if var_663_0[var_663_1] ~= nil then
			arg_663_1.duration_ = var_663_0[var_663_1]
		end

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play322161160(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0
			local var_666_1 = 0.475

			if var_666_0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_2 = arg_663_1:FormatText(StoryNameCfg[67].name)

				arg_663_1.leftNameTxt_.text = var_666_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_3 = arg_663_1:GetWordFromCfg(322161159)
				local var_666_4 = arg_663_1:FormatText(var_666_3.content)

				arg_663_1.text_.text = var_666_4

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_5 = 19
				local var_666_6 = utf8.len(var_666_4)
				local var_666_7 = var_666_5 <= 0 and var_666_1 or var_666_1 * (var_666_6 / var_666_5)

				if var_666_7 > 0 and var_666_1 < var_666_7 then
					arg_663_1.talkMaxDuration = var_666_7

					if var_666_7 + var_666_0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_7 + var_666_0
					end
				end

				arg_663_1.text_.text = var_666_4
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161159", "story_v_out_322161.awb") ~= 0 then
					local var_666_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161159", "story_v_out_322161.awb") / 1000

					if var_666_8 + var_666_0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_8 + var_666_0
					end

					if var_666_3.prefab_name ~= "" and arg_663_1.actors_[var_666_3.prefab_name] ~= nil then
						local var_666_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_3.prefab_name].transform, "story_v_out_322161", "322161159", "story_v_out_322161.awb")

						arg_663_1:RecordAudio("322161159", var_666_9)
						arg_663_1:RecordAudio("322161159", var_666_9)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_out_322161", "322161159", "story_v_out_322161.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_out_322161", "322161159", "story_v_out_322161.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_10 = math.max(var_666_1, arg_663_1.talkMaxDuration)

			if var_666_0 <= arg_663_1.time_ and arg_663_1.time_ < var_666_0 + var_666_10 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_0) / var_666_10

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_0 + var_666_10 and arg_663_1.time_ < var_666_0 + var_666_10 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play322161160 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 322161160
		arg_667_1.duration_ = 16.37

		local var_667_0 = {
			zh = 8.666,
			ja = 16.366
		}
		local var_667_1 = manager.audio:GetLocalizationFlag()

		if var_667_0[var_667_1] ~= nil then
			arg_667_1.duration_ = var_667_0[var_667_1]
		end

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play322161161(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0
			local var_670_1 = 0.925

			if var_670_0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_2 = arg_667_1:FormatText(StoryNameCfg[1178].name)

				arg_667_1.leftNameTxt_.text = var_670_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_3 = arg_667_1:GetWordFromCfg(322161160)
				local var_670_4 = arg_667_1:FormatText(var_670_3.content)

				arg_667_1.text_.text = var_670_4

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_5 = 37
				local var_670_6 = utf8.len(var_670_4)
				local var_670_7 = var_670_5 <= 0 and var_670_1 or var_670_1 * (var_670_6 / var_670_5)

				if var_670_7 > 0 and var_670_1 < var_670_7 then
					arg_667_1.talkMaxDuration = var_670_7

					if var_670_7 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_7 + var_670_0
					end
				end

				arg_667_1.text_.text = var_670_4
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161160", "story_v_out_322161.awb") ~= 0 then
					local var_670_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161160", "story_v_out_322161.awb") / 1000

					if var_670_8 + var_670_0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_8 + var_670_0
					end

					if var_670_3.prefab_name ~= "" and arg_667_1.actors_[var_670_3.prefab_name] ~= nil then
						local var_670_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_3.prefab_name].transform, "story_v_out_322161", "322161160", "story_v_out_322161.awb")

						arg_667_1:RecordAudio("322161160", var_670_9)
						arg_667_1:RecordAudio("322161160", var_670_9)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_out_322161", "322161160", "story_v_out_322161.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_out_322161", "322161160", "story_v_out_322161.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_10 = math.max(var_670_1, arg_667_1.talkMaxDuration)

			if var_670_0 <= arg_667_1.time_ and arg_667_1.time_ < var_670_0 + var_670_10 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_0) / var_670_10

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_0 + var_670_10 and arg_667_1.time_ < var_670_0 + var_670_10 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play322161161 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 322161161
		arg_671_1.duration_ = 8.27

		local var_671_0 = {
			zh = 5.266,
			ja = 8.266
		}
		local var_671_1 = manager.audio:GetLocalizationFlag()

		if var_671_0[var_671_1] ~= nil then
			arg_671_1.duration_ = var_671_0[var_671_1]
		end

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play322161162(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0
			local var_674_1 = 0.525

			if var_674_0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_2 = arg_671_1:FormatText(StoryNameCfg[1178].name)

				arg_671_1.leftNameTxt_.text = var_674_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_3 = arg_671_1:GetWordFromCfg(322161161)
				local var_674_4 = arg_671_1:FormatText(var_674_3.content)

				arg_671_1.text_.text = var_674_4

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_5 = 21
				local var_674_6 = utf8.len(var_674_4)
				local var_674_7 = var_674_5 <= 0 and var_674_1 or var_674_1 * (var_674_6 / var_674_5)

				if var_674_7 > 0 and var_674_1 < var_674_7 then
					arg_671_1.talkMaxDuration = var_674_7

					if var_674_7 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_7 + var_674_0
					end
				end

				arg_671_1.text_.text = var_674_4
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161161", "story_v_out_322161.awb") ~= 0 then
					local var_674_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161161", "story_v_out_322161.awb") / 1000

					if var_674_8 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_8 + var_674_0
					end

					if var_674_3.prefab_name ~= "" and arg_671_1.actors_[var_674_3.prefab_name] ~= nil then
						local var_674_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_671_1.actors_[var_674_3.prefab_name].transform, "story_v_out_322161", "322161161", "story_v_out_322161.awb")

						arg_671_1:RecordAudio("322161161", var_674_9)
						arg_671_1:RecordAudio("322161161", var_674_9)
					else
						arg_671_1:AudioAction("play", "voice", "story_v_out_322161", "322161161", "story_v_out_322161.awb")
					end

					arg_671_1:RecordHistoryTalkVoice("story_v_out_322161", "322161161", "story_v_out_322161.awb")
				end

				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_10 = math.max(var_674_1, arg_671_1.talkMaxDuration)

			if var_674_0 <= arg_671_1.time_ and arg_671_1.time_ < var_674_0 + var_674_10 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_0) / var_674_10

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_0 + var_674_10 and arg_671_1.time_ < var_674_0 + var_674_10 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play322161162 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 322161162
		arg_675_1.duration_ = 3.93

		local var_675_0 = {
			zh = 2.933,
			ja = 3.933
		}
		local var_675_1 = manager.audio:GetLocalizationFlag()

		if var_675_0[var_675_1] ~= nil then
			arg_675_1.duration_ = var_675_0[var_675_1]
		end

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play322161163(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0
			local var_678_1 = 0.4

			if var_678_0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_2 = arg_675_1:FormatText(StoryNameCfg[67].name)

				arg_675_1.leftNameTxt_.text = var_678_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_3 = arg_675_1:GetWordFromCfg(322161162)
				local var_678_4 = arg_675_1:FormatText(var_678_3.content)

				arg_675_1.text_.text = var_678_4

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_5 = 16
				local var_678_6 = utf8.len(var_678_4)
				local var_678_7 = var_678_5 <= 0 and var_678_1 or var_678_1 * (var_678_6 / var_678_5)

				if var_678_7 > 0 and var_678_1 < var_678_7 then
					arg_675_1.talkMaxDuration = var_678_7

					if var_678_7 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_7 + var_678_0
					end
				end

				arg_675_1.text_.text = var_678_4
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161162", "story_v_out_322161.awb") ~= 0 then
					local var_678_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161162", "story_v_out_322161.awb") / 1000

					if var_678_8 + var_678_0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_8 + var_678_0
					end

					if var_678_3.prefab_name ~= "" and arg_675_1.actors_[var_678_3.prefab_name] ~= nil then
						local var_678_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_3.prefab_name].transform, "story_v_out_322161", "322161162", "story_v_out_322161.awb")

						arg_675_1:RecordAudio("322161162", var_678_9)
						arg_675_1:RecordAudio("322161162", var_678_9)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_out_322161", "322161162", "story_v_out_322161.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_out_322161", "322161162", "story_v_out_322161.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_10 = math.max(var_678_1, arg_675_1.talkMaxDuration)

			if var_678_0 <= arg_675_1.time_ and arg_675_1.time_ < var_678_0 + var_678_10 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_0) / var_678_10

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_0 + var_678_10 and arg_675_1.time_ < var_678_0 + var_678_10 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play322161163 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 322161163
		arg_679_1.duration_ = 5.1

		local var_679_0 = {
			zh = 4.033,
			ja = 5.1
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play322161164(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 0
			local var_682_1 = 0.35

			if var_682_0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_2 = arg_679_1:FormatText(StoryNameCfg[1178].name)

				arg_679_1.leftNameTxt_.text = var_682_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_3 = arg_679_1:GetWordFromCfg(322161163)
				local var_682_4 = arg_679_1:FormatText(var_682_3.content)

				arg_679_1.text_.text = var_682_4

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_5 = 14
				local var_682_6 = utf8.len(var_682_4)
				local var_682_7 = var_682_5 <= 0 and var_682_1 or var_682_1 * (var_682_6 / var_682_5)

				if var_682_7 > 0 and var_682_1 < var_682_7 then
					arg_679_1.talkMaxDuration = var_682_7

					if var_682_7 + var_682_0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_7 + var_682_0
					end
				end

				arg_679_1.text_.text = var_682_4
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161163", "story_v_out_322161.awb") ~= 0 then
					local var_682_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161163", "story_v_out_322161.awb") / 1000

					if var_682_8 + var_682_0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_8 + var_682_0
					end

					if var_682_3.prefab_name ~= "" and arg_679_1.actors_[var_682_3.prefab_name] ~= nil then
						local var_682_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_3.prefab_name].transform, "story_v_out_322161", "322161163", "story_v_out_322161.awb")

						arg_679_1:RecordAudio("322161163", var_682_9)
						arg_679_1:RecordAudio("322161163", var_682_9)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_out_322161", "322161163", "story_v_out_322161.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_out_322161", "322161163", "story_v_out_322161.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_10 = math.max(var_682_1, arg_679_1.talkMaxDuration)

			if var_682_0 <= arg_679_1.time_ and arg_679_1.time_ < var_682_0 + var_682_10 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_0) / var_682_10

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_0 + var_682_10 and arg_679_1.time_ < var_682_0 + var_682_10 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play322161164 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 322161164
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play322161165(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0
			local var_686_1 = 1.075

			if var_686_0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_2 = arg_683_1:GetWordFromCfg(322161164)
				local var_686_3 = arg_683_1:FormatText(var_686_2.content)

				arg_683_1.text_.text = var_686_3

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_4 = 43
				local var_686_5 = utf8.len(var_686_3)
				local var_686_6 = var_686_4 <= 0 and var_686_1 or var_686_1 * (var_686_5 / var_686_4)

				if var_686_6 > 0 and var_686_1 < var_686_6 then
					arg_683_1.talkMaxDuration = var_686_6

					if var_686_6 + var_686_0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_6 + var_686_0
					end
				end

				arg_683_1.text_.text = var_686_3
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_7 = math.max(var_686_1, arg_683_1.talkMaxDuration)

			if var_686_0 <= arg_683_1.time_ and arg_683_1.time_ < var_686_0 + var_686_7 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_0) / var_686_7

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_0 + var_686_7 and arg_683_1.time_ < var_686_0 + var_686_7 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play322161165 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 322161165
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play322161166(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0
			local var_690_1 = 0.425

			if var_690_0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, false)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_2 = arg_687_1:GetWordFromCfg(322161165)
				local var_690_3 = arg_687_1:FormatText(var_690_2.content)

				arg_687_1.text_.text = var_690_3

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_4 = 17
				local var_690_5 = utf8.len(var_690_3)
				local var_690_6 = var_690_4 <= 0 and var_690_1 or var_690_1 * (var_690_5 / var_690_4)

				if var_690_6 > 0 and var_690_1 < var_690_6 then
					arg_687_1.talkMaxDuration = var_690_6

					if var_690_6 + var_690_0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_6 + var_690_0
					end
				end

				arg_687_1.text_.text = var_690_3
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_7 = math.max(var_690_1, arg_687_1.talkMaxDuration)

			if var_690_0 <= arg_687_1.time_ and arg_687_1.time_ < var_690_0 + var_690_7 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_0) / var_690_7

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_0 + var_690_7 and arg_687_1.time_ < var_690_0 + var_690_7 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play322161166 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 322161166
		arg_691_1.duration_ = 12.57

		local var_691_0 = {
			zh = 9.633,
			ja = 12.566
		}
		local var_691_1 = manager.audio:GetLocalizationFlag()

		if var_691_0[var_691_1] ~= nil then
			arg_691_1.duration_ = var_691_0[var_691_1]
		end

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play322161167(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0
			local var_694_1 = 1.025

			if var_694_0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_2 = arg_691_1:FormatText(StoryNameCfg[1178].name)

				arg_691_1.leftNameTxt_.text = var_694_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_3 = arg_691_1:GetWordFromCfg(322161166)
				local var_694_4 = arg_691_1:FormatText(var_694_3.content)

				arg_691_1.text_.text = var_694_4

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_5 = 41
				local var_694_6 = utf8.len(var_694_4)
				local var_694_7 = var_694_5 <= 0 and var_694_1 or var_694_1 * (var_694_6 / var_694_5)

				if var_694_7 > 0 and var_694_1 < var_694_7 then
					arg_691_1.talkMaxDuration = var_694_7

					if var_694_7 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_7 + var_694_0
					end
				end

				arg_691_1.text_.text = var_694_4
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161166", "story_v_out_322161.awb") ~= 0 then
					local var_694_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161166", "story_v_out_322161.awb") / 1000

					if var_694_8 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_8 + var_694_0
					end

					if var_694_3.prefab_name ~= "" and arg_691_1.actors_[var_694_3.prefab_name] ~= nil then
						local var_694_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_3.prefab_name].transform, "story_v_out_322161", "322161166", "story_v_out_322161.awb")

						arg_691_1:RecordAudio("322161166", var_694_9)
						arg_691_1:RecordAudio("322161166", var_694_9)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_out_322161", "322161166", "story_v_out_322161.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_out_322161", "322161166", "story_v_out_322161.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_10 = math.max(var_694_1, arg_691_1.talkMaxDuration)

			if var_694_0 <= arg_691_1.time_ and arg_691_1.time_ < var_694_0 + var_694_10 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_0) / var_694_10

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_0 + var_694_10 and arg_691_1.time_ < var_694_0 + var_694_10 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play322161167 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 322161167
		arg_695_1.duration_ = 6.43

		local var_695_0 = {
			zh = 4.833,
			ja = 6.433
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
				arg_695_0:Play322161168(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 0
			local var_698_1 = 0.6

			if var_698_0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_2 = arg_695_1:FormatText(StoryNameCfg[67].name)

				arg_695_1.leftNameTxt_.text = var_698_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_3 = arg_695_1:GetWordFromCfg(322161167)
				local var_698_4 = arg_695_1:FormatText(var_698_3.content)

				arg_695_1.text_.text = var_698_4

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_5 = 24
				local var_698_6 = utf8.len(var_698_4)
				local var_698_7 = var_698_5 <= 0 and var_698_1 or var_698_1 * (var_698_6 / var_698_5)

				if var_698_7 > 0 and var_698_1 < var_698_7 then
					arg_695_1.talkMaxDuration = var_698_7

					if var_698_7 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_7 + var_698_0
					end
				end

				arg_695_1.text_.text = var_698_4
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161167", "story_v_out_322161.awb") ~= 0 then
					local var_698_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161167", "story_v_out_322161.awb") / 1000

					if var_698_8 + var_698_0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_8 + var_698_0
					end

					if var_698_3.prefab_name ~= "" and arg_695_1.actors_[var_698_3.prefab_name] ~= nil then
						local var_698_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_3.prefab_name].transform, "story_v_out_322161", "322161167", "story_v_out_322161.awb")

						arg_695_1:RecordAudio("322161167", var_698_9)
						arg_695_1:RecordAudio("322161167", var_698_9)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_out_322161", "322161167", "story_v_out_322161.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_out_322161", "322161167", "story_v_out_322161.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_10 = math.max(var_698_1, arg_695_1.talkMaxDuration)

			if var_698_0 <= arg_695_1.time_ and arg_695_1.time_ < var_698_0 + var_698_10 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_0) / var_698_10

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_0 + var_698_10 and arg_695_1.time_ < var_698_0 + var_698_10 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play322161168 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 322161168
		arg_699_1.duration_ = 8.4

		local var_699_0 = {
			zh = 4.666,
			ja = 8.4
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
				arg_699_0:Play322161169(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = 0
			local var_702_1 = 0.45

			if var_702_0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_0 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_2 = arg_699_1:FormatText(StoryNameCfg[1178].name)

				arg_699_1.leftNameTxt_.text = var_702_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_3 = arg_699_1:GetWordFromCfg(322161168)
				local var_702_4 = arg_699_1:FormatText(var_702_3.content)

				arg_699_1.text_.text = var_702_4

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_5 = 18
				local var_702_6 = utf8.len(var_702_4)
				local var_702_7 = var_702_5 <= 0 and var_702_1 or var_702_1 * (var_702_6 / var_702_5)

				if var_702_7 > 0 and var_702_1 < var_702_7 then
					arg_699_1.talkMaxDuration = var_702_7

					if var_702_7 + var_702_0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_7 + var_702_0
					end
				end

				arg_699_1.text_.text = var_702_4
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161168", "story_v_out_322161.awb") ~= 0 then
					local var_702_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161168", "story_v_out_322161.awb") / 1000

					if var_702_8 + var_702_0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_8 + var_702_0
					end

					if var_702_3.prefab_name ~= "" and arg_699_1.actors_[var_702_3.prefab_name] ~= nil then
						local var_702_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_3.prefab_name].transform, "story_v_out_322161", "322161168", "story_v_out_322161.awb")

						arg_699_1:RecordAudio("322161168", var_702_9)
						arg_699_1:RecordAudio("322161168", var_702_9)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_322161", "322161168", "story_v_out_322161.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_322161", "322161168", "story_v_out_322161.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_10 = math.max(var_702_1, arg_699_1.talkMaxDuration)

			if var_702_0 <= arg_699_1.time_ and arg_699_1.time_ < var_702_0 + var_702_10 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_0) / var_702_10

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_0 + var_702_10 and arg_699_1.time_ < var_702_0 + var_702_10 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play322161169 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 322161169
		arg_703_1.duration_ = 10.43

		local var_703_0 = {
			zh = 7.5,
			ja = 10.433
		}
		local var_703_1 = manager.audio:GetLocalizationFlag()

		if var_703_0[var_703_1] ~= nil then
			arg_703_1.duration_ = var_703_0[var_703_1]
		end

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play322161170(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = 0
			local var_706_1 = 0.825

			if var_706_0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_0 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_2 = arg_703_1:FormatText(StoryNameCfg[67].name)

				arg_703_1.leftNameTxt_.text = var_706_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_3 = arg_703_1:GetWordFromCfg(322161169)
				local var_706_4 = arg_703_1:FormatText(var_706_3.content)

				arg_703_1.text_.text = var_706_4

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_5 = 33
				local var_706_6 = utf8.len(var_706_4)
				local var_706_7 = var_706_5 <= 0 and var_706_1 or var_706_1 * (var_706_6 / var_706_5)

				if var_706_7 > 0 and var_706_1 < var_706_7 then
					arg_703_1.talkMaxDuration = var_706_7

					if var_706_7 + var_706_0 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_7 + var_706_0
					end
				end

				arg_703_1.text_.text = var_706_4
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161169", "story_v_out_322161.awb") ~= 0 then
					local var_706_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161169", "story_v_out_322161.awb") / 1000

					if var_706_8 + var_706_0 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_8 + var_706_0
					end

					if var_706_3.prefab_name ~= "" and arg_703_1.actors_[var_706_3.prefab_name] ~= nil then
						local var_706_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_703_1.actors_[var_706_3.prefab_name].transform, "story_v_out_322161", "322161169", "story_v_out_322161.awb")

						arg_703_1:RecordAudio("322161169", var_706_9)
						arg_703_1:RecordAudio("322161169", var_706_9)
					else
						arg_703_1:AudioAction("play", "voice", "story_v_out_322161", "322161169", "story_v_out_322161.awb")
					end

					arg_703_1:RecordHistoryTalkVoice("story_v_out_322161", "322161169", "story_v_out_322161.awb")
				end

				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_10 = math.max(var_706_1, arg_703_1.talkMaxDuration)

			if var_706_0 <= arg_703_1.time_ and arg_703_1.time_ < var_706_0 + var_706_10 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_0) / var_706_10

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_0 + var_706_10 and arg_703_1.time_ < var_706_0 + var_706_10 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play322161170 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 322161170
		arg_707_1.duration_ = 6.07

		local var_707_0 = {
			zh = 2.333,
			ja = 6.066
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
				arg_707_0:Play322161171(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0
			local var_710_1 = 0.3

			if var_710_0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_2 = arg_707_1:FormatText(StoryNameCfg[1178].name)

				arg_707_1.leftNameTxt_.text = var_710_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_3 = arg_707_1:GetWordFromCfg(322161170)
				local var_710_4 = arg_707_1:FormatText(var_710_3.content)

				arg_707_1.text_.text = var_710_4

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_5 = 12
				local var_710_6 = utf8.len(var_710_4)
				local var_710_7 = var_710_5 <= 0 and var_710_1 or var_710_1 * (var_710_6 / var_710_5)

				if var_710_7 > 0 and var_710_1 < var_710_7 then
					arg_707_1.talkMaxDuration = var_710_7

					if var_710_7 + var_710_0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_7 + var_710_0
					end
				end

				arg_707_1.text_.text = var_710_4
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161170", "story_v_out_322161.awb") ~= 0 then
					local var_710_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161170", "story_v_out_322161.awb") / 1000

					if var_710_8 + var_710_0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_8 + var_710_0
					end

					if var_710_3.prefab_name ~= "" and arg_707_1.actors_[var_710_3.prefab_name] ~= nil then
						local var_710_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_3.prefab_name].transform, "story_v_out_322161", "322161170", "story_v_out_322161.awb")

						arg_707_1:RecordAudio("322161170", var_710_9)
						arg_707_1:RecordAudio("322161170", var_710_9)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_out_322161", "322161170", "story_v_out_322161.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_out_322161", "322161170", "story_v_out_322161.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_10 = math.max(var_710_1, arg_707_1.talkMaxDuration)

			if var_710_0 <= arg_707_1.time_ and arg_707_1.time_ < var_710_0 + var_710_10 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_0) / var_710_10

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_0 + var_710_10 and arg_707_1.time_ < var_710_0 + var_710_10 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play322161171 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 322161171
		arg_711_1.duration_ = 5.93

		local var_711_0 = {
			zh = 5.766,
			ja = 5.933
		}
		local var_711_1 = manager.audio:GetLocalizationFlag()

		if var_711_0[var_711_1] ~= nil then
			arg_711_1.duration_ = var_711_0[var_711_1]
		end

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play322161172(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0
			local var_714_1 = 0.525

			if var_714_0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_2 = arg_711_1:FormatText(StoryNameCfg[67].name)

				arg_711_1.leftNameTxt_.text = var_714_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_3 = arg_711_1:GetWordFromCfg(322161171)
				local var_714_4 = arg_711_1:FormatText(var_714_3.content)

				arg_711_1.text_.text = var_714_4

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_5 = 21
				local var_714_6 = utf8.len(var_714_4)
				local var_714_7 = var_714_5 <= 0 and var_714_1 or var_714_1 * (var_714_6 / var_714_5)

				if var_714_7 > 0 and var_714_1 < var_714_7 then
					arg_711_1.talkMaxDuration = var_714_7

					if var_714_7 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_7 + var_714_0
					end
				end

				arg_711_1.text_.text = var_714_4
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161171", "story_v_out_322161.awb") ~= 0 then
					local var_714_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161171", "story_v_out_322161.awb") / 1000

					if var_714_8 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_8 + var_714_0
					end

					if var_714_3.prefab_name ~= "" and arg_711_1.actors_[var_714_3.prefab_name] ~= nil then
						local var_714_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_3.prefab_name].transform, "story_v_out_322161", "322161171", "story_v_out_322161.awb")

						arg_711_1:RecordAudio("322161171", var_714_9)
						arg_711_1:RecordAudio("322161171", var_714_9)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_out_322161", "322161171", "story_v_out_322161.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_out_322161", "322161171", "story_v_out_322161.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_10 = math.max(var_714_1, arg_711_1.talkMaxDuration)

			if var_714_0 <= arg_711_1.time_ and arg_711_1.time_ < var_714_0 + var_714_10 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_0) / var_714_10

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_0 + var_714_10 and arg_711_1.time_ < var_714_0 + var_714_10 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play322161172 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 322161172
		arg_715_1.duration_ = 7.23

		local var_715_0 = {
			zh = 5.1,
			ja = 7.233
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play322161173(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0
			local var_718_1 = 0.525

			if var_718_0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_2 = arg_715_1:FormatText(StoryNameCfg[1178].name)

				arg_715_1.leftNameTxt_.text = var_718_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_3 = arg_715_1:GetWordFromCfg(322161172)
				local var_718_4 = arg_715_1:FormatText(var_718_3.content)

				arg_715_1.text_.text = var_718_4

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_5 = 21
				local var_718_6 = utf8.len(var_718_4)
				local var_718_7 = var_718_5 <= 0 and var_718_1 or var_718_1 * (var_718_6 / var_718_5)

				if var_718_7 > 0 and var_718_1 < var_718_7 then
					arg_715_1.talkMaxDuration = var_718_7

					if var_718_7 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_7 + var_718_0
					end
				end

				arg_715_1.text_.text = var_718_4
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161172", "story_v_out_322161.awb") ~= 0 then
					local var_718_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161172", "story_v_out_322161.awb") / 1000

					if var_718_8 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_8 + var_718_0
					end

					if var_718_3.prefab_name ~= "" and arg_715_1.actors_[var_718_3.prefab_name] ~= nil then
						local var_718_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_3.prefab_name].transform, "story_v_out_322161", "322161172", "story_v_out_322161.awb")

						arg_715_1:RecordAudio("322161172", var_718_9)
						arg_715_1:RecordAudio("322161172", var_718_9)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_out_322161", "322161172", "story_v_out_322161.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_out_322161", "322161172", "story_v_out_322161.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_10 = math.max(var_718_1, arg_715_1.talkMaxDuration)

			if var_718_0 <= arg_715_1.time_ and arg_715_1.time_ < var_718_0 + var_718_10 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_0) / var_718_10

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_0 + var_718_10 and arg_715_1.time_ < var_718_0 + var_718_10 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play322161173 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 322161173
		arg_719_1.duration_ = 12.93

		local var_719_0 = {
			zh = 8.533,
			ja = 12.933
		}
		local var_719_1 = manager.audio:GetLocalizationFlag()

		if var_719_0[var_719_1] ~= nil then
			arg_719_1.duration_ = var_719_0[var_719_1]
		end

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play322161174(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0
			local var_722_1 = 0.9

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_2 = arg_719_1:FormatText(StoryNameCfg[1178].name)

				arg_719_1.leftNameTxt_.text = var_722_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_3 = arg_719_1:GetWordFromCfg(322161173)
				local var_722_4 = arg_719_1:FormatText(var_722_3.content)

				arg_719_1.text_.text = var_722_4

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_5 = 36
				local var_722_6 = utf8.len(var_722_4)
				local var_722_7 = var_722_5 <= 0 and var_722_1 or var_722_1 * (var_722_6 / var_722_5)

				if var_722_7 > 0 and var_722_1 < var_722_7 then
					arg_719_1.talkMaxDuration = var_722_7

					if var_722_7 + var_722_0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_7 + var_722_0
					end
				end

				arg_719_1.text_.text = var_722_4
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161173", "story_v_out_322161.awb") ~= 0 then
					local var_722_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161173", "story_v_out_322161.awb") / 1000

					if var_722_8 + var_722_0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_8 + var_722_0
					end

					if var_722_3.prefab_name ~= "" and arg_719_1.actors_[var_722_3.prefab_name] ~= nil then
						local var_722_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_3.prefab_name].transform, "story_v_out_322161", "322161173", "story_v_out_322161.awb")

						arg_719_1:RecordAudio("322161173", var_722_9)
						arg_719_1:RecordAudio("322161173", var_722_9)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_out_322161", "322161173", "story_v_out_322161.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_out_322161", "322161173", "story_v_out_322161.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_10 = math.max(var_722_1, arg_719_1.talkMaxDuration)

			if var_722_0 <= arg_719_1.time_ and arg_719_1.time_ < var_722_0 + var_722_10 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_0) / var_722_10

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_0 + var_722_10 and arg_719_1.time_ < var_722_0 + var_722_10 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play322161174 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 322161174
		arg_723_1.duration_ = 16.23

		local var_723_0 = {
			zh = 9.3,
			ja = 16.233
		}
		local var_723_1 = manager.audio:GetLocalizationFlag()

		if var_723_0[var_723_1] ~= nil then
			arg_723_1.duration_ = var_723_0[var_723_1]
		end

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play322161175(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = 0
			local var_726_1 = 1.1

			if var_726_0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				local var_726_2 = arg_723_1:FormatText(StoryNameCfg[1178].name)

				arg_723_1.leftNameTxt_.text = var_726_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_3 = arg_723_1:GetWordFromCfg(322161174)
				local var_726_4 = arg_723_1:FormatText(var_726_3.content)

				arg_723_1.text_.text = var_726_4

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_5 = 44
				local var_726_6 = utf8.len(var_726_4)
				local var_726_7 = var_726_5 <= 0 and var_726_1 or var_726_1 * (var_726_6 / var_726_5)

				if var_726_7 > 0 and var_726_1 < var_726_7 then
					arg_723_1.talkMaxDuration = var_726_7

					if var_726_7 + var_726_0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_7 + var_726_0
					end
				end

				arg_723_1.text_.text = var_726_4
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161174", "story_v_out_322161.awb") ~= 0 then
					local var_726_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161174", "story_v_out_322161.awb") / 1000

					if var_726_8 + var_726_0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_8 + var_726_0
					end

					if var_726_3.prefab_name ~= "" and arg_723_1.actors_[var_726_3.prefab_name] ~= nil then
						local var_726_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_3.prefab_name].transform, "story_v_out_322161", "322161174", "story_v_out_322161.awb")

						arg_723_1:RecordAudio("322161174", var_726_9)
						arg_723_1:RecordAudio("322161174", var_726_9)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_out_322161", "322161174", "story_v_out_322161.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_out_322161", "322161174", "story_v_out_322161.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_10 = math.max(var_726_1, arg_723_1.talkMaxDuration)

			if var_726_0 <= arg_723_1.time_ and arg_723_1.time_ < var_726_0 + var_726_10 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_0) / var_726_10

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_0 + var_726_10 and arg_723_1.time_ < var_726_0 + var_726_10 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play322161175 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 322161175
		arg_727_1.duration_ = 1.73

		local var_727_0 = {
			zh = 1.733,
			ja = 1.7
		}
		local var_727_1 = manager.audio:GetLocalizationFlag()

		if var_727_0[var_727_1] ~= nil then
			arg_727_1.duration_ = var_727_0[var_727_1]
		end

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play322161176(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = 0
			local var_730_1 = 0.175

			if var_730_0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_0 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				local var_730_2 = arg_727_1:FormatText(StoryNameCfg[67].name)

				arg_727_1.leftNameTxt_.text = var_730_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_3 = arg_727_1:GetWordFromCfg(322161175)
				local var_730_4 = arg_727_1:FormatText(var_730_3.content)

				arg_727_1.text_.text = var_730_4

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_5 = 7
				local var_730_6 = utf8.len(var_730_4)
				local var_730_7 = var_730_5 <= 0 and var_730_1 or var_730_1 * (var_730_6 / var_730_5)

				if var_730_7 > 0 and var_730_1 < var_730_7 then
					arg_727_1.talkMaxDuration = var_730_7

					if var_730_7 + var_730_0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_7 + var_730_0
					end
				end

				arg_727_1.text_.text = var_730_4
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161175", "story_v_out_322161.awb") ~= 0 then
					local var_730_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161175", "story_v_out_322161.awb") / 1000

					if var_730_8 + var_730_0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_8 + var_730_0
					end

					if var_730_3.prefab_name ~= "" and arg_727_1.actors_[var_730_3.prefab_name] ~= nil then
						local var_730_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_727_1.actors_[var_730_3.prefab_name].transform, "story_v_out_322161", "322161175", "story_v_out_322161.awb")

						arg_727_1:RecordAudio("322161175", var_730_9)
						arg_727_1:RecordAudio("322161175", var_730_9)
					else
						arg_727_1:AudioAction("play", "voice", "story_v_out_322161", "322161175", "story_v_out_322161.awb")
					end

					arg_727_1:RecordHistoryTalkVoice("story_v_out_322161", "322161175", "story_v_out_322161.awb")
				end

				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_10 = math.max(var_730_1, arg_727_1.talkMaxDuration)

			if var_730_0 <= arg_727_1.time_ and arg_727_1.time_ < var_730_0 + var_730_10 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_0) / var_730_10

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_0 + var_730_10 and arg_727_1.time_ < var_730_0 + var_730_10 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play322161176 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 322161176
		arg_731_1.duration_ = 15.57

		local var_731_0 = {
			zh = 9.233,
			ja = 15.566
		}
		local var_731_1 = manager.audio:GetLocalizationFlag()

		if var_731_0[var_731_1] ~= nil then
			arg_731_1.duration_ = var_731_0[var_731_1]
		end

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play322161177(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0
			local var_734_1 = 1.05

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_2 = arg_731_1:FormatText(StoryNameCfg[1178].name)

				arg_731_1.leftNameTxt_.text = var_734_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_3 = arg_731_1:GetWordFromCfg(322161176)
				local var_734_4 = arg_731_1:FormatText(var_734_3.content)

				arg_731_1.text_.text = var_734_4

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_5 = 42
				local var_734_6 = utf8.len(var_734_4)
				local var_734_7 = var_734_5 <= 0 and var_734_1 or var_734_1 * (var_734_6 / var_734_5)

				if var_734_7 > 0 and var_734_1 < var_734_7 then
					arg_731_1.talkMaxDuration = var_734_7

					if var_734_7 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_7 + var_734_0
					end
				end

				arg_731_1.text_.text = var_734_4
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161176", "story_v_out_322161.awb") ~= 0 then
					local var_734_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161176", "story_v_out_322161.awb") / 1000

					if var_734_8 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_8 + var_734_0
					end

					if var_734_3.prefab_name ~= "" and arg_731_1.actors_[var_734_3.prefab_name] ~= nil then
						local var_734_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_3.prefab_name].transform, "story_v_out_322161", "322161176", "story_v_out_322161.awb")

						arg_731_1:RecordAudio("322161176", var_734_9)
						arg_731_1:RecordAudio("322161176", var_734_9)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_out_322161", "322161176", "story_v_out_322161.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_out_322161", "322161176", "story_v_out_322161.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_10 = math.max(var_734_1, arg_731_1.talkMaxDuration)

			if var_734_0 <= arg_731_1.time_ and arg_731_1.time_ < var_734_0 + var_734_10 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_0) / var_734_10

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_0 + var_734_10 and arg_731_1.time_ < var_734_0 + var_734_10 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play322161177 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 322161177
		arg_735_1.duration_ = 28.63

		local var_735_0 = {
			zh = 14.9,
			ja = 28.633
		}
		local var_735_1 = manager.audio:GetLocalizationFlag()

		if var_735_0[var_735_1] ~= nil then
			arg_735_1.duration_ = var_735_0[var_735_1]
		end

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play322161178(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = 0
			local var_738_1 = 1.625

			if var_738_0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_0 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				local var_738_2 = arg_735_1:FormatText(StoryNameCfg[1178].name)

				arg_735_1.leftNameTxt_.text = var_738_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_3 = arg_735_1:GetWordFromCfg(322161177)
				local var_738_4 = arg_735_1:FormatText(var_738_3.content)

				arg_735_1.text_.text = var_738_4

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_5 = 65
				local var_738_6 = utf8.len(var_738_4)
				local var_738_7 = var_738_5 <= 0 and var_738_1 or var_738_1 * (var_738_6 / var_738_5)

				if var_738_7 > 0 and var_738_1 < var_738_7 then
					arg_735_1.talkMaxDuration = var_738_7

					if var_738_7 + var_738_0 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_7 + var_738_0
					end
				end

				arg_735_1.text_.text = var_738_4
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161177", "story_v_out_322161.awb") ~= 0 then
					local var_738_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161177", "story_v_out_322161.awb") / 1000

					if var_738_8 + var_738_0 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_8 + var_738_0
					end

					if var_738_3.prefab_name ~= "" and arg_735_1.actors_[var_738_3.prefab_name] ~= nil then
						local var_738_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_735_1.actors_[var_738_3.prefab_name].transform, "story_v_out_322161", "322161177", "story_v_out_322161.awb")

						arg_735_1:RecordAudio("322161177", var_738_9)
						arg_735_1:RecordAudio("322161177", var_738_9)
					else
						arg_735_1:AudioAction("play", "voice", "story_v_out_322161", "322161177", "story_v_out_322161.awb")
					end

					arg_735_1:RecordHistoryTalkVoice("story_v_out_322161", "322161177", "story_v_out_322161.awb")
				end

				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_10 = math.max(var_738_1, arg_735_1.talkMaxDuration)

			if var_738_0 <= arg_735_1.time_ and arg_735_1.time_ < var_738_0 + var_738_10 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_0) / var_738_10

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_0 + var_738_10 and arg_735_1.time_ < var_738_0 + var_738_10 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play322161178 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 322161178
		arg_739_1.duration_ = 15.87

		local var_739_0 = {
			zh = 12.3,
			ja = 15.866
		}
		local var_739_1 = manager.audio:GetLocalizationFlag()

		if var_739_0[var_739_1] ~= nil then
			arg_739_1.duration_ = var_739_0[var_739_1]
		end

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play322161179(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = 0
			local var_742_1 = 1.175

			if var_742_0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_0 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				local var_742_2 = arg_739_1:FormatText(StoryNameCfg[1178].name)

				arg_739_1.leftNameTxt_.text = var_742_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_3 = arg_739_1:GetWordFromCfg(322161178)
				local var_742_4 = arg_739_1:FormatText(var_742_3.content)

				arg_739_1.text_.text = var_742_4

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_5 = 47
				local var_742_6 = utf8.len(var_742_4)
				local var_742_7 = var_742_5 <= 0 and var_742_1 or var_742_1 * (var_742_6 / var_742_5)

				if var_742_7 > 0 and var_742_1 < var_742_7 then
					arg_739_1.talkMaxDuration = var_742_7

					if var_742_7 + var_742_0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_7 + var_742_0
					end
				end

				arg_739_1.text_.text = var_742_4
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161178", "story_v_out_322161.awb") ~= 0 then
					local var_742_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161178", "story_v_out_322161.awb") / 1000

					if var_742_8 + var_742_0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_8 + var_742_0
					end

					if var_742_3.prefab_name ~= "" and arg_739_1.actors_[var_742_3.prefab_name] ~= nil then
						local var_742_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_739_1.actors_[var_742_3.prefab_name].transform, "story_v_out_322161", "322161178", "story_v_out_322161.awb")

						arg_739_1:RecordAudio("322161178", var_742_9)
						arg_739_1:RecordAudio("322161178", var_742_9)
					else
						arg_739_1:AudioAction("play", "voice", "story_v_out_322161", "322161178", "story_v_out_322161.awb")
					end

					arg_739_1:RecordHistoryTalkVoice("story_v_out_322161", "322161178", "story_v_out_322161.awb")
				end

				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_10 = math.max(var_742_1, arg_739_1.talkMaxDuration)

			if var_742_0 <= arg_739_1.time_ and arg_739_1.time_ < var_742_0 + var_742_10 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_0) / var_742_10

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_0 + var_742_10 and arg_739_1.time_ < var_742_0 + var_742_10 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play322161179 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 322161179
		arg_743_1.duration_ = 1.8

		local var_743_0 = {
			zh = 1.8,
			ja = 1.766
		}
		local var_743_1 = manager.audio:GetLocalizationFlag()

		if var_743_0[var_743_1] ~= nil then
			arg_743_1.duration_ = var_743_0[var_743_1]
		end

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play322161180(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = 0
			local var_746_1 = 0.15

			if var_746_0 < arg_743_1.time_ and arg_743_1.time_ <= var_746_0 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				local var_746_2 = arg_743_1:FormatText(StoryNameCfg[67].name)

				arg_743_1.leftNameTxt_.text = var_746_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_3 = arg_743_1:GetWordFromCfg(322161179)
				local var_746_4 = arg_743_1:FormatText(var_746_3.content)

				arg_743_1.text_.text = var_746_4

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_5 = 6
				local var_746_6 = utf8.len(var_746_4)
				local var_746_7 = var_746_5 <= 0 and var_746_1 or var_746_1 * (var_746_6 / var_746_5)

				if var_746_7 > 0 and var_746_1 < var_746_7 then
					arg_743_1.talkMaxDuration = var_746_7

					if var_746_7 + var_746_0 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_7 + var_746_0
					end
				end

				arg_743_1.text_.text = var_746_4
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161179", "story_v_out_322161.awb") ~= 0 then
					local var_746_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161179", "story_v_out_322161.awb") / 1000

					if var_746_8 + var_746_0 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_8 + var_746_0
					end

					if var_746_3.prefab_name ~= "" and arg_743_1.actors_[var_746_3.prefab_name] ~= nil then
						local var_746_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_743_1.actors_[var_746_3.prefab_name].transform, "story_v_out_322161", "322161179", "story_v_out_322161.awb")

						arg_743_1:RecordAudio("322161179", var_746_9)
						arg_743_1:RecordAudio("322161179", var_746_9)
					else
						arg_743_1:AudioAction("play", "voice", "story_v_out_322161", "322161179", "story_v_out_322161.awb")
					end

					arg_743_1:RecordHistoryTalkVoice("story_v_out_322161", "322161179", "story_v_out_322161.awb")
				end

				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_10 = math.max(var_746_1, arg_743_1.talkMaxDuration)

			if var_746_0 <= arg_743_1.time_ and arg_743_1.time_ < var_746_0 + var_746_10 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_0) / var_746_10

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_0 + var_746_10 and arg_743_1.time_ < var_746_0 + var_746_10 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	Play322161180 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 322161180
		arg_747_1.duration_ = 1

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play322161181(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = 0
			local var_750_1 = 0.05

			if var_750_0 < arg_747_1.time_ and arg_747_1.time_ <= var_750_0 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				local var_750_2 = arg_747_1:FormatText(StoryNameCfg[1178].name)

				arg_747_1.leftNameTxt_.text = var_750_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, false)
				arg_747_1.callingController_:SetSelectedState("normal")

				local var_750_3 = arg_747_1:GetWordFromCfg(322161180)
				local var_750_4 = arg_747_1:FormatText(var_750_3.content)

				arg_747_1.text_.text = var_750_4

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_5 = 2
				local var_750_6 = utf8.len(var_750_4)
				local var_750_7 = var_750_5 <= 0 and var_750_1 or var_750_1 * (var_750_6 / var_750_5)

				if var_750_7 > 0 and var_750_1 < var_750_7 then
					arg_747_1.talkMaxDuration = var_750_7

					if var_750_7 + var_750_0 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_7 + var_750_0
					end
				end

				arg_747_1.text_.text = var_750_4
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161180", "story_v_out_322161.awb") ~= 0 then
					local var_750_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161180", "story_v_out_322161.awb") / 1000

					if var_750_8 + var_750_0 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_8 + var_750_0
					end

					if var_750_3.prefab_name ~= "" and arg_747_1.actors_[var_750_3.prefab_name] ~= nil then
						local var_750_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_747_1.actors_[var_750_3.prefab_name].transform, "story_v_out_322161", "322161180", "story_v_out_322161.awb")

						arg_747_1:RecordAudio("322161180", var_750_9)
						arg_747_1:RecordAudio("322161180", var_750_9)
					else
						arg_747_1:AudioAction("play", "voice", "story_v_out_322161", "322161180", "story_v_out_322161.awb")
					end

					arg_747_1:RecordHistoryTalkVoice("story_v_out_322161", "322161180", "story_v_out_322161.awb")
				end

				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_10 = math.max(var_750_1, arg_747_1.talkMaxDuration)

			if var_750_0 <= arg_747_1.time_ and arg_747_1.time_ < var_750_0 + var_750_10 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_0) / var_750_10

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_0 + var_750_10 and arg_747_1.time_ < var_750_0 + var_750_10 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	Play322161181 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 322161181
		arg_751_1.duration_ = 11.23

		local var_751_0 = {
			zh = 5.466,
			ja = 11.233
		}
		local var_751_1 = manager.audio:GetLocalizationFlag()

		if var_751_0[var_751_1] ~= nil then
			arg_751_1.duration_ = var_751_0[var_751_1]
		end

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play322161182(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			local var_754_0 = 0
			local var_754_1 = 0.625

			if var_754_0 < arg_751_1.time_ and arg_751_1.time_ <= var_754_0 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				local var_754_2 = arg_751_1:FormatText(StoryNameCfg[67].name)

				arg_751_1.leftNameTxt_.text = var_754_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_3 = arg_751_1:GetWordFromCfg(322161181)
				local var_754_4 = arg_751_1:FormatText(var_754_3.content)

				arg_751_1.text_.text = var_754_4

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_5 = 25
				local var_754_6 = utf8.len(var_754_4)
				local var_754_7 = var_754_5 <= 0 and var_754_1 or var_754_1 * (var_754_6 / var_754_5)

				if var_754_7 > 0 and var_754_1 < var_754_7 then
					arg_751_1.talkMaxDuration = var_754_7

					if var_754_7 + var_754_0 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_7 + var_754_0
					end
				end

				arg_751_1.text_.text = var_754_4
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161181", "story_v_out_322161.awb") ~= 0 then
					local var_754_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161181", "story_v_out_322161.awb") / 1000

					if var_754_8 + var_754_0 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_8 + var_754_0
					end

					if var_754_3.prefab_name ~= "" and arg_751_1.actors_[var_754_3.prefab_name] ~= nil then
						local var_754_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_751_1.actors_[var_754_3.prefab_name].transform, "story_v_out_322161", "322161181", "story_v_out_322161.awb")

						arg_751_1:RecordAudio("322161181", var_754_9)
						arg_751_1:RecordAudio("322161181", var_754_9)
					else
						arg_751_1:AudioAction("play", "voice", "story_v_out_322161", "322161181", "story_v_out_322161.awb")
					end

					arg_751_1:RecordHistoryTalkVoice("story_v_out_322161", "322161181", "story_v_out_322161.awb")
				end

				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_10 = math.max(var_754_1, arg_751_1.talkMaxDuration)

			if var_754_0 <= arg_751_1.time_ and arg_751_1.time_ < var_754_0 + var_754_10 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_0) / var_754_10

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_0 + var_754_10 and arg_751_1.time_ < var_754_0 + var_754_10 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {}

		arg_751_1:InitPlayNodeList()
	end,
	Play322161182 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 322161182
		arg_755_1.duration_ = 11.93

		local var_755_0 = {
			zh = 8.4,
			ja = 11.933
		}
		local var_755_1 = manager.audio:GetLocalizationFlag()

		if var_755_0[var_755_1] ~= nil then
			arg_755_1.duration_ = var_755_0[var_755_1]
		end

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play322161183(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			local var_758_0 = 0
			local var_758_1 = 0.95

			if var_758_0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_0 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				local var_758_2 = arg_755_1:FormatText(StoryNameCfg[67].name)

				arg_755_1.leftNameTxt_.text = var_758_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_3 = arg_755_1:GetWordFromCfg(322161182)
				local var_758_4 = arg_755_1:FormatText(var_758_3.content)

				arg_755_1.text_.text = var_758_4

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_5 = 38
				local var_758_6 = utf8.len(var_758_4)
				local var_758_7 = var_758_5 <= 0 and var_758_1 or var_758_1 * (var_758_6 / var_758_5)

				if var_758_7 > 0 and var_758_1 < var_758_7 then
					arg_755_1.talkMaxDuration = var_758_7

					if var_758_7 + var_758_0 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_7 + var_758_0
					end
				end

				arg_755_1.text_.text = var_758_4
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161182", "story_v_out_322161.awb") ~= 0 then
					local var_758_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161182", "story_v_out_322161.awb") / 1000

					if var_758_8 + var_758_0 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_8 + var_758_0
					end

					if var_758_3.prefab_name ~= "" and arg_755_1.actors_[var_758_3.prefab_name] ~= nil then
						local var_758_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_755_1.actors_[var_758_3.prefab_name].transform, "story_v_out_322161", "322161182", "story_v_out_322161.awb")

						arg_755_1:RecordAudio("322161182", var_758_9)
						arg_755_1:RecordAudio("322161182", var_758_9)
					else
						arg_755_1:AudioAction("play", "voice", "story_v_out_322161", "322161182", "story_v_out_322161.awb")
					end

					arg_755_1:RecordHistoryTalkVoice("story_v_out_322161", "322161182", "story_v_out_322161.awb")
				end

				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_10 = math.max(var_758_1, arg_755_1.talkMaxDuration)

			if var_758_0 <= arg_755_1.time_ and arg_755_1.time_ < var_758_0 + var_758_10 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_0) / var_758_10

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_0 + var_758_10 and arg_755_1.time_ < var_758_0 + var_758_10 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play322161183 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 322161183
		arg_759_1.duration_ = 7.33

		local var_759_0 = {
			zh = 7.333,
			ja = 7.1
		}
		local var_759_1 = manager.audio:GetLocalizationFlag()

		if var_759_0[var_759_1] ~= nil then
			arg_759_1.duration_ = var_759_0[var_759_1]
		end

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play322161184(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = 0
			local var_762_1 = 0.55

			if var_762_0 < arg_759_1.time_ and arg_759_1.time_ <= var_762_0 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				local var_762_2 = arg_759_1:FormatText(StoryNameCfg[1178].name)

				arg_759_1.leftNameTxt_.text = var_762_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_3 = arg_759_1:GetWordFromCfg(322161183)
				local var_762_4 = arg_759_1:FormatText(var_762_3.content)

				arg_759_1.text_.text = var_762_4

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_5 = 22
				local var_762_6 = utf8.len(var_762_4)
				local var_762_7 = var_762_5 <= 0 and var_762_1 or var_762_1 * (var_762_6 / var_762_5)

				if var_762_7 > 0 and var_762_1 < var_762_7 then
					arg_759_1.talkMaxDuration = var_762_7

					if var_762_7 + var_762_0 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_7 + var_762_0
					end
				end

				arg_759_1.text_.text = var_762_4
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161183", "story_v_out_322161.awb") ~= 0 then
					local var_762_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161183", "story_v_out_322161.awb") / 1000

					if var_762_8 + var_762_0 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_8 + var_762_0
					end

					if var_762_3.prefab_name ~= "" and arg_759_1.actors_[var_762_3.prefab_name] ~= nil then
						local var_762_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_759_1.actors_[var_762_3.prefab_name].transform, "story_v_out_322161", "322161183", "story_v_out_322161.awb")

						arg_759_1:RecordAudio("322161183", var_762_9)
						arg_759_1:RecordAudio("322161183", var_762_9)
					else
						arg_759_1:AudioAction("play", "voice", "story_v_out_322161", "322161183", "story_v_out_322161.awb")
					end

					arg_759_1:RecordHistoryTalkVoice("story_v_out_322161", "322161183", "story_v_out_322161.awb")
				end

				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_10 = math.max(var_762_1, arg_759_1.talkMaxDuration)

			if var_762_0 <= arg_759_1.time_ and arg_759_1.time_ < var_762_0 + var_762_10 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_0) / var_762_10

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_0 + var_762_10 and arg_759_1.time_ < var_762_0 + var_762_10 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {}

		arg_759_1:InitPlayNodeList()
	end,
	Play322161184 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 322161184
		arg_763_1.duration_ = 1.63

		local var_763_0 = {
			zh = 1.633,
			ja = 1.3
		}
		local var_763_1 = manager.audio:GetLocalizationFlag()

		if var_763_0[var_763_1] ~= nil then
			arg_763_1.duration_ = var_763_0[var_763_1]
		end

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play322161185(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = 0
			local var_766_1 = 0.15

			if var_766_0 < arg_763_1.time_ and arg_763_1.time_ <= var_766_0 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				local var_766_2 = arg_763_1:FormatText(StoryNameCfg[67].name)

				arg_763_1.leftNameTxt_.text = var_766_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_3 = arg_763_1:GetWordFromCfg(322161184)
				local var_766_4 = arg_763_1:FormatText(var_766_3.content)

				arg_763_1.text_.text = var_766_4

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_5 = 6
				local var_766_6 = utf8.len(var_766_4)
				local var_766_7 = var_766_5 <= 0 and var_766_1 or var_766_1 * (var_766_6 / var_766_5)

				if var_766_7 > 0 and var_766_1 < var_766_7 then
					arg_763_1.talkMaxDuration = var_766_7

					if var_766_7 + var_766_0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_7 + var_766_0
					end
				end

				arg_763_1.text_.text = var_766_4
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161184", "story_v_out_322161.awb") ~= 0 then
					local var_766_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161184", "story_v_out_322161.awb") / 1000

					if var_766_8 + var_766_0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_8 + var_766_0
					end

					if var_766_3.prefab_name ~= "" and arg_763_1.actors_[var_766_3.prefab_name] ~= nil then
						local var_766_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_763_1.actors_[var_766_3.prefab_name].transform, "story_v_out_322161", "322161184", "story_v_out_322161.awb")

						arg_763_1:RecordAudio("322161184", var_766_9)
						arg_763_1:RecordAudio("322161184", var_766_9)
					else
						arg_763_1:AudioAction("play", "voice", "story_v_out_322161", "322161184", "story_v_out_322161.awb")
					end

					arg_763_1:RecordHistoryTalkVoice("story_v_out_322161", "322161184", "story_v_out_322161.awb")
				end

				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_10 = math.max(var_766_1, arg_763_1.talkMaxDuration)

			if var_766_0 <= arg_763_1.time_ and arg_763_1.time_ < var_766_0 + var_766_10 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_0) / var_766_10

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_0 + var_766_10 and arg_763_1.time_ < var_766_0 + var_766_10 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play322161185 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 322161185
		arg_767_1.duration_ = 6.63

		local var_767_0 = {
			zh = 3.9,
			ja = 6.633
		}
		local var_767_1 = manager.audio:GetLocalizationFlag()

		if var_767_0[var_767_1] ~= nil then
			arg_767_1.duration_ = var_767_0[var_767_1]
		end

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play322161186(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = 0
			local var_770_1 = 0.325

			if var_770_0 < arg_767_1.time_ and arg_767_1.time_ <= var_770_0 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				local var_770_2 = arg_767_1:FormatText(StoryNameCfg[1178].name)

				arg_767_1.leftNameTxt_.text = var_770_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_3 = arg_767_1:GetWordFromCfg(322161185)
				local var_770_4 = arg_767_1:FormatText(var_770_3.content)

				arg_767_1.text_.text = var_770_4

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_5 = 13
				local var_770_6 = utf8.len(var_770_4)
				local var_770_7 = var_770_5 <= 0 and var_770_1 or var_770_1 * (var_770_6 / var_770_5)

				if var_770_7 > 0 and var_770_1 < var_770_7 then
					arg_767_1.talkMaxDuration = var_770_7

					if var_770_7 + var_770_0 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_7 + var_770_0
					end
				end

				arg_767_1.text_.text = var_770_4
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161185", "story_v_out_322161.awb") ~= 0 then
					local var_770_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161185", "story_v_out_322161.awb") / 1000

					if var_770_8 + var_770_0 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_8 + var_770_0
					end

					if var_770_3.prefab_name ~= "" and arg_767_1.actors_[var_770_3.prefab_name] ~= nil then
						local var_770_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_767_1.actors_[var_770_3.prefab_name].transform, "story_v_out_322161", "322161185", "story_v_out_322161.awb")

						arg_767_1:RecordAudio("322161185", var_770_9)
						arg_767_1:RecordAudio("322161185", var_770_9)
					else
						arg_767_1:AudioAction("play", "voice", "story_v_out_322161", "322161185", "story_v_out_322161.awb")
					end

					arg_767_1:RecordHistoryTalkVoice("story_v_out_322161", "322161185", "story_v_out_322161.awb")
				end

				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_10 = math.max(var_770_1, arg_767_1.talkMaxDuration)

			if var_770_0 <= arg_767_1.time_ and arg_767_1.time_ < var_770_0 + var_770_10 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_0) / var_770_10

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_0 + var_770_10 and arg_767_1.time_ < var_770_0 + var_770_10 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {}

		arg_767_1:InitPlayNodeList()
	end,
	Play322161186 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 322161186
		arg_771_1.duration_ = 5

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play322161187(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = 0
			local var_774_1 = 0.725

			if var_774_0 < arg_771_1.time_ and arg_771_1.time_ <= var_774_0 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, false)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_2 = arg_771_1:GetWordFromCfg(322161186)
				local var_774_3 = arg_771_1:FormatText(var_774_2.content)

				arg_771_1.text_.text = var_774_3

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_4 = 29
				local var_774_5 = utf8.len(var_774_3)
				local var_774_6 = var_774_4 <= 0 and var_774_1 or var_774_1 * (var_774_5 / var_774_4)

				if var_774_6 > 0 and var_774_1 < var_774_6 then
					arg_771_1.talkMaxDuration = var_774_6

					if var_774_6 + var_774_0 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_6 + var_774_0
					end
				end

				arg_771_1.text_.text = var_774_3
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_7 = math.max(var_774_1, arg_771_1.talkMaxDuration)

			if var_774_0 <= arg_771_1.time_ and arg_771_1.time_ < var_774_0 + var_774_7 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_0) / var_774_7

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_0 + var_774_7 and arg_771_1.time_ < var_774_0 + var_774_7 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play322161187 = function(arg_775_0, arg_775_1)
		arg_775_1.time_ = 0
		arg_775_1.frameCnt_ = 0
		arg_775_1.state_ = "playing"
		arg_775_1.curTalkId_ = 322161187
		arg_775_1.duration_ = 8

		local var_775_0 = {
			zh = 5.433,
			ja = 8
		}
		local var_775_1 = manager.audio:GetLocalizationFlag()

		if var_775_0[var_775_1] ~= nil then
			arg_775_1.duration_ = var_775_0[var_775_1]
		end

		SetActive(arg_775_1.tipsGo_, false)

		function arg_775_1.onSingleLineFinish_()
			arg_775_1.onSingleLineUpdate_ = nil
			arg_775_1.onSingleLineFinish_ = nil
			arg_775_1.state_ = "waiting"
		end

		function arg_775_1.playNext_(arg_777_0)
			if arg_777_0 == 1 then
				arg_775_0:Play322161188(arg_775_1)
			end
		end

		function arg_775_1.onSingleLineUpdate_(arg_778_0)
			local var_778_0 = 0
			local var_778_1 = 0.525

			if var_778_0 < arg_775_1.time_ and arg_775_1.time_ <= var_778_0 + arg_778_0 then
				arg_775_1.talkMaxDuration = 0
				arg_775_1.dialogCg_.alpha = 1

				arg_775_1.dialog_:SetActive(true)
				SetActive(arg_775_1.leftNameGo_, true)

				local var_778_2 = arg_775_1:FormatText(StoryNameCfg[1178].name)

				arg_775_1.leftNameTxt_.text = var_778_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_775_1.leftNameTxt_.transform)

				arg_775_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_775_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_775_1:RecordName(arg_775_1.leftNameTxt_.text)
				SetActive(arg_775_1.iconTrs_.gameObject, false)
				arg_775_1.callingController_:SetSelectedState("normal")

				local var_778_3 = arg_775_1:GetWordFromCfg(322161187)
				local var_778_4 = arg_775_1:FormatText(var_778_3.content)

				arg_775_1.text_.text = var_778_4

				LuaForUtil.ClearLinePrefixSymbol(arg_775_1.text_)

				local var_778_5 = 21
				local var_778_6 = utf8.len(var_778_4)
				local var_778_7 = var_778_5 <= 0 and var_778_1 or var_778_1 * (var_778_6 / var_778_5)

				if var_778_7 > 0 and var_778_1 < var_778_7 then
					arg_775_1.talkMaxDuration = var_778_7

					if var_778_7 + var_778_0 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_7 + var_778_0
					end
				end

				arg_775_1.text_.text = var_778_4
				arg_775_1.typewritter.percent = 0

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161187", "story_v_out_322161.awb") ~= 0 then
					local var_778_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161187", "story_v_out_322161.awb") / 1000

					if var_778_8 + var_778_0 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_8 + var_778_0
					end

					if var_778_3.prefab_name ~= "" and arg_775_1.actors_[var_778_3.prefab_name] ~= nil then
						local var_778_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_775_1.actors_[var_778_3.prefab_name].transform, "story_v_out_322161", "322161187", "story_v_out_322161.awb")

						arg_775_1:RecordAudio("322161187", var_778_9)
						arg_775_1:RecordAudio("322161187", var_778_9)
					else
						arg_775_1:AudioAction("play", "voice", "story_v_out_322161", "322161187", "story_v_out_322161.awb")
					end

					arg_775_1:RecordHistoryTalkVoice("story_v_out_322161", "322161187", "story_v_out_322161.awb")
				end

				arg_775_1:RecordContent(arg_775_1.text_.text)
			end

			local var_778_10 = math.max(var_778_1, arg_775_1.talkMaxDuration)

			if var_778_0 <= arg_775_1.time_ and arg_775_1.time_ < var_778_0 + var_778_10 then
				arg_775_1.typewritter.percent = (arg_775_1.time_ - var_778_0) / var_778_10

				arg_775_1.typewritter:SetDirty()
			end

			if arg_775_1.time_ >= var_778_0 + var_778_10 and arg_775_1.time_ < var_778_0 + var_778_10 + arg_778_0 then
				arg_775_1.typewritter.percent = 1

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(true)
			end
		end

		arg_775_1.nodeConfigList_ = {}

		arg_775_1:InitPlayNodeList()
	end,
	Play322161188 = function(arg_779_0, arg_779_1)
		arg_779_1.time_ = 0
		arg_779_1.frameCnt_ = 0
		arg_779_1.state_ = "playing"
		arg_779_1.curTalkId_ = 322161188
		arg_779_1.duration_ = 5.1

		local var_779_0 = {
			zh = 4.866,
			ja = 5.1
		}
		local var_779_1 = manager.audio:GetLocalizationFlag()

		if var_779_0[var_779_1] ~= nil then
			arg_779_1.duration_ = var_779_0[var_779_1]
		end

		SetActive(arg_779_1.tipsGo_, false)

		function arg_779_1.onSingleLineFinish_()
			arg_779_1.onSingleLineUpdate_ = nil
			arg_779_1.onSingleLineFinish_ = nil
			arg_779_1.state_ = "waiting"
		end

		function arg_779_1.playNext_(arg_781_0)
			if arg_781_0 == 1 then
				arg_779_0:Play322161189(arg_779_1)
			end
		end

		function arg_779_1.onSingleLineUpdate_(arg_782_0)
			local var_782_0 = 0
			local var_782_1 = 0.475

			if var_782_0 < arg_779_1.time_ and arg_779_1.time_ <= var_782_0 + arg_782_0 then
				arg_779_1.talkMaxDuration = 0
				arg_779_1.dialogCg_.alpha = 1

				arg_779_1.dialog_:SetActive(true)
				SetActive(arg_779_1.leftNameGo_, true)

				local var_782_2 = arg_779_1:FormatText(StoryNameCfg[67].name)

				arg_779_1.leftNameTxt_.text = var_782_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_779_1.leftNameTxt_.transform)

				arg_779_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_779_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_779_1:RecordName(arg_779_1.leftNameTxt_.text)
				SetActive(arg_779_1.iconTrs_.gameObject, false)
				arg_779_1.callingController_:SetSelectedState("normal")

				local var_782_3 = arg_779_1:GetWordFromCfg(322161188)
				local var_782_4 = arg_779_1:FormatText(var_782_3.content)

				arg_779_1.text_.text = var_782_4

				LuaForUtil.ClearLinePrefixSymbol(arg_779_1.text_)

				local var_782_5 = 19
				local var_782_6 = utf8.len(var_782_4)
				local var_782_7 = var_782_5 <= 0 and var_782_1 or var_782_1 * (var_782_6 / var_782_5)

				if var_782_7 > 0 and var_782_1 < var_782_7 then
					arg_779_1.talkMaxDuration = var_782_7

					if var_782_7 + var_782_0 > arg_779_1.duration_ then
						arg_779_1.duration_ = var_782_7 + var_782_0
					end
				end

				arg_779_1.text_.text = var_782_4
				arg_779_1.typewritter.percent = 0

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161188", "story_v_out_322161.awb") ~= 0 then
					local var_782_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161188", "story_v_out_322161.awb") / 1000

					if var_782_8 + var_782_0 > arg_779_1.duration_ then
						arg_779_1.duration_ = var_782_8 + var_782_0
					end

					if var_782_3.prefab_name ~= "" and arg_779_1.actors_[var_782_3.prefab_name] ~= nil then
						local var_782_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_779_1.actors_[var_782_3.prefab_name].transform, "story_v_out_322161", "322161188", "story_v_out_322161.awb")

						arg_779_1:RecordAudio("322161188", var_782_9)
						arg_779_1:RecordAudio("322161188", var_782_9)
					else
						arg_779_1:AudioAction("play", "voice", "story_v_out_322161", "322161188", "story_v_out_322161.awb")
					end

					arg_779_1:RecordHistoryTalkVoice("story_v_out_322161", "322161188", "story_v_out_322161.awb")
				end

				arg_779_1:RecordContent(arg_779_1.text_.text)
			end

			local var_782_10 = math.max(var_782_1, arg_779_1.talkMaxDuration)

			if var_782_0 <= arg_779_1.time_ and arg_779_1.time_ < var_782_0 + var_782_10 then
				arg_779_1.typewritter.percent = (arg_779_1.time_ - var_782_0) / var_782_10

				arg_779_1.typewritter:SetDirty()
			end

			if arg_779_1.time_ >= var_782_0 + var_782_10 and arg_779_1.time_ < var_782_0 + var_782_10 + arg_782_0 then
				arg_779_1.typewritter.percent = 1

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(true)
			end
		end

		arg_779_1.nodeConfigList_ = {}

		arg_779_1:InitPlayNodeList()
	end,
	Play322161189 = function(arg_783_0, arg_783_1)
		arg_783_1.time_ = 0
		arg_783_1.frameCnt_ = 0
		arg_783_1.state_ = "playing"
		arg_783_1.curTalkId_ = 322161189
		arg_783_1.duration_ = 9.97

		local var_783_0 = {
			zh = 7.566,
			ja = 9.966
		}
		local var_783_1 = manager.audio:GetLocalizationFlag()

		if var_783_0[var_783_1] ~= nil then
			arg_783_1.duration_ = var_783_0[var_783_1]
		end

		SetActive(arg_783_1.tipsGo_, false)

		function arg_783_1.onSingleLineFinish_()
			arg_783_1.onSingleLineUpdate_ = nil
			arg_783_1.onSingleLineFinish_ = nil
			arg_783_1.state_ = "waiting"
		end

		function arg_783_1.playNext_(arg_785_0)
			if arg_785_0 == 1 then
				arg_783_0:Play322161190(arg_783_1)
			end
		end

		function arg_783_1.onSingleLineUpdate_(arg_786_0)
			local var_786_0 = 0
			local var_786_1 = 0.6

			if var_786_0 < arg_783_1.time_ and arg_783_1.time_ <= var_786_0 + arg_786_0 then
				arg_783_1.talkMaxDuration = 0
				arg_783_1.dialogCg_.alpha = 1

				arg_783_1.dialog_:SetActive(true)
				SetActive(arg_783_1.leftNameGo_, true)

				local var_786_2 = arg_783_1:FormatText(StoryNameCfg[1178].name)

				arg_783_1.leftNameTxt_.text = var_786_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_783_1.leftNameTxt_.transform)

				arg_783_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_783_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_783_1:RecordName(arg_783_1.leftNameTxt_.text)
				SetActive(arg_783_1.iconTrs_.gameObject, false)
				arg_783_1.callingController_:SetSelectedState("normal")

				local var_786_3 = arg_783_1:GetWordFromCfg(322161189)
				local var_786_4 = arg_783_1:FormatText(var_786_3.content)

				arg_783_1.text_.text = var_786_4

				LuaForUtil.ClearLinePrefixSymbol(arg_783_1.text_)

				local var_786_5 = 24
				local var_786_6 = utf8.len(var_786_4)
				local var_786_7 = var_786_5 <= 0 and var_786_1 or var_786_1 * (var_786_6 / var_786_5)

				if var_786_7 > 0 and var_786_1 < var_786_7 then
					arg_783_1.talkMaxDuration = var_786_7

					if var_786_7 + var_786_0 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_7 + var_786_0
					end
				end

				arg_783_1.text_.text = var_786_4
				arg_783_1.typewritter.percent = 0

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161189", "story_v_out_322161.awb") ~= 0 then
					local var_786_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161189", "story_v_out_322161.awb") / 1000

					if var_786_8 + var_786_0 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_8 + var_786_0
					end

					if var_786_3.prefab_name ~= "" and arg_783_1.actors_[var_786_3.prefab_name] ~= nil then
						local var_786_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_783_1.actors_[var_786_3.prefab_name].transform, "story_v_out_322161", "322161189", "story_v_out_322161.awb")

						arg_783_1:RecordAudio("322161189", var_786_9)
						arg_783_1:RecordAudio("322161189", var_786_9)
					else
						arg_783_1:AudioAction("play", "voice", "story_v_out_322161", "322161189", "story_v_out_322161.awb")
					end

					arg_783_1:RecordHistoryTalkVoice("story_v_out_322161", "322161189", "story_v_out_322161.awb")
				end

				arg_783_1:RecordContent(arg_783_1.text_.text)
			end

			local var_786_10 = math.max(var_786_1, arg_783_1.talkMaxDuration)

			if var_786_0 <= arg_783_1.time_ and arg_783_1.time_ < var_786_0 + var_786_10 then
				arg_783_1.typewritter.percent = (arg_783_1.time_ - var_786_0) / var_786_10

				arg_783_1.typewritter:SetDirty()
			end

			if arg_783_1.time_ >= var_786_0 + var_786_10 and arg_783_1.time_ < var_786_0 + var_786_10 + arg_786_0 then
				arg_783_1.typewritter.percent = 1

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(true)
			end
		end

		arg_783_1.nodeConfigList_ = {}

		arg_783_1:InitPlayNodeList()
	end,
	Play322161190 = function(arg_787_0, arg_787_1)
		arg_787_1.time_ = 0
		arg_787_1.frameCnt_ = 0
		arg_787_1.state_ = "playing"
		arg_787_1.curTalkId_ = 322161190
		arg_787_1.duration_ = 20.73

		local var_787_0 = {
			zh = 13.633,
			ja = 20.733
		}
		local var_787_1 = manager.audio:GetLocalizationFlag()

		if var_787_0[var_787_1] ~= nil then
			arg_787_1.duration_ = var_787_0[var_787_1]
		end

		SetActive(arg_787_1.tipsGo_, false)

		function arg_787_1.onSingleLineFinish_()
			arg_787_1.onSingleLineUpdate_ = nil
			arg_787_1.onSingleLineFinish_ = nil
			arg_787_1.state_ = "waiting"
		end

		function arg_787_1.playNext_(arg_789_0)
			if arg_789_0 == 1 then
				arg_787_0:Play322161191(arg_787_1)
			end
		end

		function arg_787_1.onSingleLineUpdate_(arg_790_0)
			local var_790_0 = 0
			local var_790_1 = 1.375

			if var_790_0 < arg_787_1.time_ and arg_787_1.time_ <= var_790_0 + arg_790_0 then
				arg_787_1.talkMaxDuration = 0
				arg_787_1.dialogCg_.alpha = 1

				arg_787_1.dialog_:SetActive(true)
				SetActive(arg_787_1.leftNameGo_, true)

				local var_790_2 = arg_787_1:FormatText(StoryNameCfg[1178].name)

				arg_787_1.leftNameTxt_.text = var_790_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_787_1.leftNameTxt_.transform)

				arg_787_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_787_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_787_1:RecordName(arg_787_1.leftNameTxt_.text)
				SetActive(arg_787_1.iconTrs_.gameObject, false)
				arg_787_1.callingController_:SetSelectedState("normal")

				local var_790_3 = arg_787_1:GetWordFromCfg(322161190)
				local var_790_4 = arg_787_1:FormatText(var_790_3.content)

				arg_787_1.text_.text = var_790_4

				LuaForUtil.ClearLinePrefixSymbol(arg_787_1.text_)

				local var_790_5 = 55
				local var_790_6 = utf8.len(var_790_4)
				local var_790_7 = var_790_5 <= 0 and var_790_1 or var_790_1 * (var_790_6 / var_790_5)

				if var_790_7 > 0 and var_790_1 < var_790_7 then
					arg_787_1.talkMaxDuration = var_790_7

					if var_790_7 + var_790_0 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_7 + var_790_0
					end
				end

				arg_787_1.text_.text = var_790_4
				arg_787_1.typewritter.percent = 0

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161190", "story_v_out_322161.awb") ~= 0 then
					local var_790_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161190", "story_v_out_322161.awb") / 1000

					if var_790_8 + var_790_0 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_8 + var_790_0
					end

					if var_790_3.prefab_name ~= "" and arg_787_1.actors_[var_790_3.prefab_name] ~= nil then
						local var_790_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_787_1.actors_[var_790_3.prefab_name].transform, "story_v_out_322161", "322161190", "story_v_out_322161.awb")

						arg_787_1:RecordAudio("322161190", var_790_9)
						arg_787_1:RecordAudio("322161190", var_790_9)
					else
						arg_787_1:AudioAction("play", "voice", "story_v_out_322161", "322161190", "story_v_out_322161.awb")
					end

					arg_787_1:RecordHistoryTalkVoice("story_v_out_322161", "322161190", "story_v_out_322161.awb")
				end

				arg_787_1:RecordContent(arg_787_1.text_.text)
			end

			local var_790_10 = math.max(var_790_1, arg_787_1.talkMaxDuration)

			if var_790_0 <= arg_787_1.time_ and arg_787_1.time_ < var_790_0 + var_790_10 then
				arg_787_1.typewritter.percent = (arg_787_1.time_ - var_790_0) / var_790_10

				arg_787_1.typewritter:SetDirty()
			end

			if arg_787_1.time_ >= var_790_0 + var_790_10 and arg_787_1.time_ < var_790_0 + var_790_10 + arg_790_0 then
				arg_787_1.typewritter.percent = 1

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(true)
			end
		end

		arg_787_1.nodeConfigList_ = {}

		arg_787_1:InitPlayNodeList()
	end,
	Play322161191 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 322161191
		arg_791_1.duration_ = 18.67

		local var_791_0 = {
			zh = 11.033,
			ja = 18.666
		}
		local var_791_1 = manager.audio:GetLocalizationFlag()

		if var_791_0[var_791_1] ~= nil then
			arg_791_1.duration_ = var_791_0[var_791_1]
		end

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play322161192(arg_791_1)
			end
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			local var_794_0 = 0
			local var_794_1 = 1.2

			if var_794_0 < arg_791_1.time_ and arg_791_1.time_ <= var_794_0 + arg_794_0 then
				arg_791_1.talkMaxDuration = 0
				arg_791_1.dialogCg_.alpha = 1

				arg_791_1.dialog_:SetActive(true)
				SetActive(arg_791_1.leftNameGo_, true)

				local var_794_2 = arg_791_1:FormatText(StoryNameCfg[1178].name)

				arg_791_1.leftNameTxt_.text = var_794_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_791_1.leftNameTxt_.transform)

				arg_791_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_791_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_791_1:RecordName(arg_791_1.leftNameTxt_.text)
				SetActive(arg_791_1.iconTrs_.gameObject, false)
				arg_791_1.callingController_:SetSelectedState("normal")

				local var_794_3 = arg_791_1:GetWordFromCfg(322161191)
				local var_794_4 = arg_791_1:FormatText(var_794_3.content)

				arg_791_1.text_.text = var_794_4

				LuaForUtil.ClearLinePrefixSymbol(arg_791_1.text_)

				local var_794_5 = 48
				local var_794_6 = utf8.len(var_794_4)
				local var_794_7 = var_794_5 <= 0 and var_794_1 or var_794_1 * (var_794_6 / var_794_5)

				if var_794_7 > 0 and var_794_1 < var_794_7 then
					arg_791_1.talkMaxDuration = var_794_7

					if var_794_7 + var_794_0 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_7 + var_794_0
					end
				end

				arg_791_1.text_.text = var_794_4
				arg_791_1.typewritter.percent = 0

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161191", "story_v_out_322161.awb") ~= 0 then
					local var_794_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161191", "story_v_out_322161.awb") / 1000

					if var_794_8 + var_794_0 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_8 + var_794_0
					end

					if var_794_3.prefab_name ~= "" and arg_791_1.actors_[var_794_3.prefab_name] ~= nil then
						local var_794_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_791_1.actors_[var_794_3.prefab_name].transform, "story_v_out_322161", "322161191", "story_v_out_322161.awb")

						arg_791_1:RecordAudio("322161191", var_794_9)
						arg_791_1:RecordAudio("322161191", var_794_9)
					else
						arg_791_1:AudioAction("play", "voice", "story_v_out_322161", "322161191", "story_v_out_322161.awb")
					end

					arg_791_1:RecordHistoryTalkVoice("story_v_out_322161", "322161191", "story_v_out_322161.awb")
				end

				arg_791_1:RecordContent(arg_791_1.text_.text)
			end

			local var_794_10 = math.max(var_794_1, arg_791_1.talkMaxDuration)

			if var_794_0 <= arg_791_1.time_ and arg_791_1.time_ < var_794_0 + var_794_10 then
				arg_791_1.typewritter.percent = (arg_791_1.time_ - var_794_0) / var_794_10

				arg_791_1.typewritter:SetDirty()
			end

			if arg_791_1.time_ >= var_794_0 + var_794_10 and arg_791_1.time_ < var_794_0 + var_794_10 + arg_794_0 then
				arg_791_1.typewritter.percent = 1

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(true)
			end
		end

		arg_791_1.nodeConfigList_ = {}

		arg_791_1:InitPlayNodeList()
	end,
	Play322161192 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 322161192
		arg_795_1.duration_ = 9.67

		local var_795_0 = {
			zh = 6.533,
			ja = 9.666
		}
		local var_795_1 = manager.audio:GetLocalizationFlag()

		if var_795_0[var_795_1] ~= nil then
			arg_795_1.duration_ = var_795_0[var_795_1]
		end

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play322161193(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = 0
			local var_798_1 = 0.675

			if var_798_0 < arg_795_1.time_ and arg_795_1.time_ <= var_798_0 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, true)

				local var_798_2 = arg_795_1:FormatText(StoryNameCfg[1178].name)

				arg_795_1.leftNameTxt_.text = var_798_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_795_1.leftNameTxt_.transform)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1.leftNameTxt_.text)
				SetActive(arg_795_1.iconTrs_.gameObject, false)
				arg_795_1.callingController_:SetSelectedState("normal")

				local var_798_3 = arg_795_1:GetWordFromCfg(322161192)
				local var_798_4 = arg_795_1:FormatText(var_798_3.content)

				arg_795_1.text_.text = var_798_4

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_5 = 27
				local var_798_6 = utf8.len(var_798_4)
				local var_798_7 = var_798_5 <= 0 and var_798_1 or var_798_1 * (var_798_6 / var_798_5)

				if var_798_7 > 0 and var_798_1 < var_798_7 then
					arg_795_1.talkMaxDuration = var_798_7

					if var_798_7 + var_798_0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_7 + var_798_0
					end
				end

				arg_795_1.text_.text = var_798_4
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161192", "story_v_out_322161.awb") ~= 0 then
					local var_798_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161192", "story_v_out_322161.awb") / 1000

					if var_798_8 + var_798_0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_8 + var_798_0
					end

					if var_798_3.prefab_name ~= "" and arg_795_1.actors_[var_798_3.prefab_name] ~= nil then
						local var_798_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_795_1.actors_[var_798_3.prefab_name].transform, "story_v_out_322161", "322161192", "story_v_out_322161.awb")

						arg_795_1:RecordAudio("322161192", var_798_9)
						arg_795_1:RecordAudio("322161192", var_798_9)
					else
						arg_795_1:AudioAction("play", "voice", "story_v_out_322161", "322161192", "story_v_out_322161.awb")
					end

					arg_795_1:RecordHistoryTalkVoice("story_v_out_322161", "322161192", "story_v_out_322161.awb")
				end

				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_10 = math.max(var_798_1, arg_795_1.talkMaxDuration)

			if var_798_0 <= arg_795_1.time_ and arg_795_1.time_ < var_798_0 + var_798_10 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - var_798_0) / var_798_10

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= var_798_0 + var_798_10 and arg_795_1.time_ < var_798_0 + var_798_10 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {}

		arg_795_1:InitPlayNodeList()
	end,
	Play322161193 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 322161193
		arg_799_1.duration_ = 5.5

		local var_799_0 = {
			zh = 4.166,
			ja = 5.5
		}
		local var_799_1 = manager.audio:GetLocalizationFlag()

		if var_799_0[var_799_1] ~= nil then
			arg_799_1.duration_ = var_799_0[var_799_1]
		end

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play322161194(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			local var_802_0 = 0
			local var_802_1 = 0.4

			if var_802_0 < arg_799_1.time_ and arg_799_1.time_ <= var_802_0 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				local var_802_2 = arg_799_1:FormatText(StoryNameCfg[67].name)

				arg_799_1.leftNameTxt_.text = var_802_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, false)
				arg_799_1.callingController_:SetSelectedState("normal")

				local var_802_3 = arg_799_1:GetWordFromCfg(322161193)
				local var_802_4 = arg_799_1:FormatText(var_802_3.content)

				arg_799_1.text_.text = var_802_4

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_5 = 16
				local var_802_6 = utf8.len(var_802_4)
				local var_802_7 = var_802_5 <= 0 and var_802_1 or var_802_1 * (var_802_6 / var_802_5)

				if var_802_7 > 0 and var_802_1 < var_802_7 then
					arg_799_1.talkMaxDuration = var_802_7

					if var_802_7 + var_802_0 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_7 + var_802_0
					end
				end

				arg_799_1.text_.text = var_802_4
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161193", "story_v_out_322161.awb") ~= 0 then
					local var_802_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161193", "story_v_out_322161.awb") / 1000

					if var_802_8 + var_802_0 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_8 + var_802_0
					end

					if var_802_3.prefab_name ~= "" and arg_799_1.actors_[var_802_3.prefab_name] ~= nil then
						local var_802_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_799_1.actors_[var_802_3.prefab_name].transform, "story_v_out_322161", "322161193", "story_v_out_322161.awb")

						arg_799_1:RecordAudio("322161193", var_802_9)
						arg_799_1:RecordAudio("322161193", var_802_9)
					else
						arg_799_1:AudioAction("play", "voice", "story_v_out_322161", "322161193", "story_v_out_322161.awb")
					end

					arg_799_1:RecordHistoryTalkVoice("story_v_out_322161", "322161193", "story_v_out_322161.awb")
				end

				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_10 = math.max(var_802_1, arg_799_1.talkMaxDuration)

			if var_802_0 <= arg_799_1.time_ and arg_799_1.time_ < var_802_0 + var_802_10 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_0) / var_802_10

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_0 + var_802_10 and arg_799_1.time_ < var_802_0 + var_802_10 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {}

		arg_799_1:InitPlayNodeList()
	end,
	Play322161194 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 322161194
		arg_803_1.duration_ = 9.5

		local var_803_0 = {
			zh = 5.933,
			ja = 9.5
		}
		local var_803_1 = manager.audio:GetLocalizationFlag()

		if var_803_0[var_803_1] ~= nil then
			arg_803_1.duration_ = var_803_0[var_803_1]
		end

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play322161195(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			local var_806_0 = 0
			local var_806_1 = 0.575

			if var_806_0 < arg_803_1.time_ and arg_803_1.time_ <= var_806_0 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0
				arg_803_1.dialogCg_.alpha = 1

				arg_803_1.dialog_:SetActive(true)
				SetActive(arg_803_1.leftNameGo_, true)

				local var_806_2 = arg_803_1:FormatText(StoryNameCfg[1178].name)

				arg_803_1.leftNameTxt_.text = var_806_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_803_1.leftNameTxt_.transform)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1.leftNameTxt_.text)
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_3 = arg_803_1:GetWordFromCfg(322161194)
				local var_806_4 = arg_803_1:FormatText(var_806_3.content)

				arg_803_1.text_.text = var_806_4

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_5 = 23
				local var_806_6 = utf8.len(var_806_4)
				local var_806_7 = var_806_5 <= 0 and var_806_1 or var_806_1 * (var_806_6 / var_806_5)

				if var_806_7 > 0 and var_806_1 < var_806_7 then
					arg_803_1.talkMaxDuration = var_806_7

					if var_806_7 + var_806_0 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_7 + var_806_0
					end
				end

				arg_803_1.text_.text = var_806_4
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161194", "story_v_out_322161.awb") ~= 0 then
					local var_806_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161194", "story_v_out_322161.awb") / 1000

					if var_806_8 + var_806_0 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_8 + var_806_0
					end

					if var_806_3.prefab_name ~= "" and arg_803_1.actors_[var_806_3.prefab_name] ~= nil then
						local var_806_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_803_1.actors_[var_806_3.prefab_name].transform, "story_v_out_322161", "322161194", "story_v_out_322161.awb")

						arg_803_1:RecordAudio("322161194", var_806_9)
						arg_803_1:RecordAudio("322161194", var_806_9)
					else
						arg_803_1:AudioAction("play", "voice", "story_v_out_322161", "322161194", "story_v_out_322161.awb")
					end

					arg_803_1:RecordHistoryTalkVoice("story_v_out_322161", "322161194", "story_v_out_322161.awb")
				end

				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_10 = math.max(var_806_1, arg_803_1.talkMaxDuration)

			if var_806_0 <= arg_803_1.time_ and arg_803_1.time_ < var_806_0 + var_806_10 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_0) / var_806_10

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_0 + var_806_10 and arg_803_1.time_ < var_806_0 + var_806_10 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {}

		arg_803_1:InitPlayNodeList()
	end,
	Play322161195 = function(arg_807_0, arg_807_1)
		arg_807_1.time_ = 0
		arg_807_1.frameCnt_ = 0
		arg_807_1.state_ = "playing"
		arg_807_1.curTalkId_ = 322161195
		arg_807_1.duration_ = 15.07

		local var_807_0 = {
			zh = 11.7,
			ja = 15.066
		}
		local var_807_1 = manager.audio:GetLocalizationFlag()

		if var_807_0[var_807_1] ~= nil then
			arg_807_1.duration_ = var_807_0[var_807_1]
		end

		SetActive(arg_807_1.tipsGo_, false)

		function arg_807_1.onSingleLineFinish_()
			arg_807_1.onSingleLineUpdate_ = nil
			arg_807_1.onSingleLineFinish_ = nil
			arg_807_1.state_ = "waiting"
		end

		function arg_807_1.playNext_(arg_809_0)
			if arg_809_0 == 1 then
				arg_807_0:Play322161196(arg_807_1)
			end
		end

		function arg_807_1.onSingleLineUpdate_(arg_810_0)
			local var_810_0 = 0
			local var_810_1 = 1.275

			if var_810_0 < arg_807_1.time_ and arg_807_1.time_ <= var_810_0 + arg_810_0 then
				arg_807_1.talkMaxDuration = 0
				arg_807_1.dialogCg_.alpha = 1

				arg_807_1.dialog_:SetActive(true)
				SetActive(arg_807_1.leftNameGo_, true)

				local var_810_2 = arg_807_1:FormatText(StoryNameCfg[1178].name)

				arg_807_1.leftNameTxt_.text = var_810_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_807_1.leftNameTxt_.transform)

				arg_807_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_807_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_807_1:RecordName(arg_807_1.leftNameTxt_.text)
				SetActive(arg_807_1.iconTrs_.gameObject, false)
				arg_807_1.callingController_:SetSelectedState("normal")

				local var_810_3 = arg_807_1:GetWordFromCfg(322161195)
				local var_810_4 = arg_807_1:FormatText(var_810_3.content)

				arg_807_1.text_.text = var_810_4

				LuaForUtil.ClearLinePrefixSymbol(arg_807_1.text_)

				local var_810_5 = 51
				local var_810_6 = utf8.len(var_810_4)
				local var_810_7 = var_810_5 <= 0 and var_810_1 or var_810_1 * (var_810_6 / var_810_5)

				if var_810_7 > 0 and var_810_1 < var_810_7 then
					arg_807_1.talkMaxDuration = var_810_7

					if var_810_7 + var_810_0 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_7 + var_810_0
					end
				end

				arg_807_1.text_.text = var_810_4
				arg_807_1.typewritter.percent = 0

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161195", "story_v_out_322161.awb") ~= 0 then
					local var_810_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161195", "story_v_out_322161.awb") / 1000

					if var_810_8 + var_810_0 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_8 + var_810_0
					end

					if var_810_3.prefab_name ~= "" and arg_807_1.actors_[var_810_3.prefab_name] ~= nil then
						local var_810_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_807_1.actors_[var_810_3.prefab_name].transform, "story_v_out_322161", "322161195", "story_v_out_322161.awb")

						arg_807_1:RecordAudio("322161195", var_810_9)
						arg_807_1:RecordAudio("322161195", var_810_9)
					else
						arg_807_1:AudioAction("play", "voice", "story_v_out_322161", "322161195", "story_v_out_322161.awb")
					end

					arg_807_1:RecordHistoryTalkVoice("story_v_out_322161", "322161195", "story_v_out_322161.awb")
				end

				arg_807_1:RecordContent(arg_807_1.text_.text)
			end

			local var_810_10 = math.max(var_810_1, arg_807_1.talkMaxDuration)

			if var_810_0 <= arg_807_1.time_ and arg_807_1.time_ < var_810_0 + var_810_10 then
				arg_807_1.typewritter.percent = (arg_807_1.time_ - var_810_0) / var_810_10

				arg_807_1.typewritter:SetDirty()
			end

			if arg_807_1.time_ >= var_810_0 + var_810_10 and arg_807_1.time_ < var_810_0 + var_810_10 + arg_810_0 then
				arg_807_1.typewritter.percent = 1

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(true)
			end
		end

		arg_807_1.nodeConfigList_ = {}

		arg_807_1:InitPlayNodeList()
	end,
	Play322161196 = function(arg_811_0, arg_811_1)
		arg_811_1.time_ = 0
		arg_811_1.frameCnt_ = 0
		arg_811_1.state_ = "playing"
		arg_811_1.curTalkId_ = 322161196
		arg_811_1.duration_ = 22.4

		local var_811_0 = {
			zh = 14.4,
			ja = 22.4
		}
		local var_811_1 = manager.audio:GetLocalizationFlag()

		if var_811_0[var_811_1] ~= nil then
			arg_811_1.duration_ = var_811_0[var_811_1]
		end

		SetActive(arg_811_1.tipsGo_, false)

		function arg_811_1.onSingleLineFinish_()
			arg_811_1.onSingleLineUpdate_ = nil
			arg_811_1.onSingleLineFinish_ = nil
			arg_811_1.state_ = "waiting"
		end

		function arg_811_1.playNext_(arg_813_0)
			if arg_813_0 == 1 then
				arg_811_0:Play322161197(arg_811_1)
			end
		end

		function arg_811_1.onSingleLineUpdate_(arg_814_0)
			local var_814_0 = 0
			local var_814_1 = 1.3

			if var_814_0 < arg_811_1.time_ and arg_811_1.time_ <= var_814_0 + arg_814_0 then
				arg_811_1.talkMaxDuration = 0
				arg_811_1.dialogCg_.alpha = 1

				arg_811_1.dialog_:SetActive(true)
				SetActive(arg_811_1.leftNameGo_, true)

				local var_814_2 = arg_811_1:FormatText(StoryNameCfg[1178].name)

				arg_811_1.leftNameTxt_.text = var_814_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_811_1.leftNameTxt_.transform)

				arg_811_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_811_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_811_1:RecordName(arg_811_1.leftNameTxt_.text)
				SetActive(arg_811_1.iconTrs_.gameObject, false)
				arg_811_1.callingController_:SetSelectedState("normal")

				local var_814_3 = arg_811_1:GetWordFromCfg(322161196)
				local var_814_4 = arg_811_1:FormatText(var_814_3.content)

				arg_811_1.text_.text = var_814_4

				LuaForUtil.ClearLinePrefixSymbol(arg_811_1.text_)

				local var_814_5 = 52
				local var_814_6 = utf8.len(var_814_4)
				local var_814_7 = var_814_5 <= 0 and var_814_1 or var_814_1 * (var_814_6 / var_814_5)

				if var_814_7 > 0 and var_814_1 < var_814_7 then
					arg_811_1.talkMaxDuration = var_814_7

					if var_814_7 + var_814_0 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_7 + var_814_0
					end
				end

				arg_811_1.text_.text = var_814_4
				arg_811_1.typewritter.percent = 0

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161196", "story_v_out_322161.awb") ~= 0 then
					local var_814_8 = manager.audio:GetVoiceLength("story_v_out_322161", "322161196", "story_v_out_322161.awb") / 1000

					if var_814_8 + var_814_0 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_8 + var_814_0
					end

					if var_814_3.prefab_name ~= "" and arg_811_1.actors_[var_814_3.prefab_name] ~= nil then
						local var_814_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_811_1.actors_[var_814_3.prefab_name].transform, "story_v_out_322161", "322161196", "story_v_out_322161.awb")

						arg_811_1:RecordAudio("322161196", var_814_9)
						arg_811_1:RecordAudio("322161196", var_814_9)
					else
						arg_811_1:AudioAction("play", "voice", "story_v_out_322161", "322161196", "story_v_out_322161.awb")
					end

					arg_811_1:RecordHistoryTalkVoice("story_v_out_322161", "322161196", "story_v_out_322161.awb")
				end

				arg_811_1:RecordContent(arg_811_1.text_.text)
			end

			local var_814_10 = math.max(var_814_1, arg_811_1.talkMaxDuration)

			if var_814_0 <= arg_811_1.time_ and arg_811_1.time_ < var_814_0 + var_814_10 then
				arg_811_1.typewritter.percent = (arg_811_1.time_ - var_814_0) / var_814_10

				arg_811_1.typewritter:SetDirty()
			end

			if arg_811_1.time_ >= var_814_0 + var_814_10 and arg_811_1.time_ < var_814_0 + var_814_10 + arg_814_0 then
				arg_811_1.typewritter.percent = 1

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(true)
			end
		end

		arg_811_1.nodeConfigList_ = {}

		arg_811_1:InitPlayNodeList()
	end,
	Play322161197 = function(arg_815_0, arg_815_1)
		arg_815_1.time_ = 0
		arg_815_1.frameCnt_ = 0
		arg_815_1.state_ = "playing"
		arg_815_1.curTalkId_ = 322161197
		arg_815_1.duration_ = 82.71

		SetActive(arg_815_1.tipsGo_, false)

		function arg_815_1.onSingleLineFinish_()
			arg_815_1.onSingleLineUpdate_ = nil
			arg_815_1.onSingleLineFinish_ = nil
			arg_815_1.state_ = "waiting"
			arg_815_1.auto_ = false
		end

		function arg_815_1.playNext_(arg_817_0)
			arg_815_1.onStoryFinished_()
		end

		function arg_815_1.onSingleLineUpdate_(arg_818_0)
			local var_818_0 = 0.5

			if var_818_0 < arg_815_1.time_ and arg_815_1.time_ <= var_818_0 + arg_818_0 then
				SetActive(arg_815_1.dialog_, false)
				SetActive(arg_815_1.allBtn_.gameObject, false)
				arg_815_1.hideBtnsController_:SetSelectedIndex(1)
				arg_815_1:StopAllVoice()

				arg_815_1.marker = "1032216stop1"

				manager.video:Play("SofdecAsset/story/story_1032216.usm", function(arg_819_0)
					arg_815_1:Skip(arg_819_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_820_0)
					if arg_820_0 then
						arg_815_1.state_ = "pause"
					else
						arg_815_1.state_ = "playing"
					end
				end, 1032216)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_818_1 = 80.375

			if var_818_0 <= arg_815_1.time_ and arg_815_1.time_ < var_818_0 + var_818_1 then
				-- block empty
			end

			if arg_815_1.time_ >= var_818_0 + var_818_1 and arg_815_1.time_ < var_818_0 + var_818_1 + arg_818_0 then
				arg_815_1.marker = ""
			end

			local var_818_2 = 0

			if var_818_2 < arg_815_1.time_ and arg_815_1.time_ <= var_818_2 + arg_818_0 then
				arg_815_1.mask_.enabled = true
				arg_815_1.mask_.raycastTarget = true

				arg_815_1:SetGaussion(false)
			end

			local var_818_3 = 0.5

			if var_818_2 <= arg_815_1.time_ and arg_815_1.time_ < var_818_2 + var_818_3 then
				local var_818_4 = (arg_815_1.time_ - var_818_2) / var_818_3
				local var_818_5 = Color.New(0, 0, 0)

				var_818_5.a = Mathf.Lerp(0, 1, var_818_4)
				arg_815_1.mask_.color = var_818_5
			end

			if arg_815_1.time_ >= var_818_2 + var_818_3 and arg_815_1.time_ < var_818_2 + var_818_3 + arg_818_0 then
				local var_818_6 = Color.New(0, 0, 0)

				var_818_6.a = 1
				arg_815_1.mask_.color = var_818_6
			end

			local var_818_7 = 0.5

			if var_818_7 < arg_815_1.time_ and arg_815_1.time_ <= var_818_7 + arg_818_0 then
				arg_815_1.mask_.enabled = true
				arg_815_1.mask_.raycastTarget = true

				arg_815_1:SetGaussion(false)
			end

			local var_818_8 = 0.5

			if var_818_7 <= arg_815_1.time_ and arg_815_1.time_ < var_818_7 + var_818_8 then
				local var_818_9 = (arg_815_1.time_ - var_818_7) / var_818_8
				local var_818_10 = Color.New(0, 0, 0)

				var_818_10.a = Mathf.Lerp(1, 0, var_818_9)
				arg_815_1.mask_.color = var_818_10
			end

			if arg_815_1.time_ >= var_818_7 + var_818_8 and arg_815_1.time_ < var_818_7 + var_818_8 + arg_818_0 then
				local var_818_11 = Color.New(0, 0, 0)
				local var_818_12 = 0

				arg_815_1.mask_.enabled = false
				var_818_11.a = var_818_12
				arg_815_1.mask_.color = var_818_11
			end
		end

		arg_815_1.nodeConfigList_ = {
			{
				isPlay = false,
				videoPath = "",
				partLoopVideoPath = "",
				duration = 1.08333333333333,
				className = "StoryPlayBackgroundVideoNode",
				startTime = 0.5,
				videoStopMode = StoryPlayerConst.BACKGROUND_VIDEO_STOP_MODE.MANUAL,
				playMode = StoryPlayerConst.BACKGROUND_VIDEO_PLAY_MODE.LOOP
			}
		}

		arg_815_1:InitPlayNodeList()
	end,
	Play322161127 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 322161127
		arg_821_1.duration_ = 3.6

		local var_821_0 = {
			zh = 3.466,
			ja = 3.6
		}
		local var_821_1 = manager.audio:GetLocalizationFlag()

		if var_821_0[var_821_1] ~= nil then
			arg_821_1.duration_ = var_821_0[var_821_1]
		end

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play322161128(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			local var_824_0 = arg_821_1.actors_["1044ui_story"].transform
			local var_824_1 = 0

			if var_824_1 < arg_821_1.time_ and arg_821_1.time_ <= var_824_1 + arg_824_0 then
				arg_821_1.var_.moveOldPos1044ui_story = var_824_0.localPosition
			end

			local var_824_2 = 0.001

			if var_824_1 <= arg_821_1.time_ and arg_821_1.time_ < var_824_1 + var_824_2 then
				local var_824_3 = (arg_821_1.time_ - var_824_1) / var_824_2
				local var_824_4 = Vector3.New(0, -1, -5.93)

				var_824_0.localPosition = Vector3.Lerp(arg_821_1.var_.moveOldPos1044ui_story, var_824_4, var_824_3)

				local var_824_5 = manager.ui.mainCamera.transform.position - var_824_0.position

				var_824_0.forward = Vector3.New(var_824_5.x, var_824_5.y, var_824_5.z)

				local var_824_6 = var_824_0.localEulerAngles

				var_824_6.z = 0
				var_824_6.x = 0
				var_824_0.localEulerAngles = var_824_6
			end

			if arg_821_1.time_ >= var_824_1 + var_824_2 and arg_821_1.time_ < var_824_1 + var_824_2 + arg_824_0 then
				var_824_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_824_7 = manager.ui.mainCamera.transform.position - var_824_0.position

				var_824_0.forward = Vector3.New(var_824_7.x, var_824_7.y, var_824_7.z)

				local var_824_8 = var_824_0.localEulerAngles

				var_824_8.z = 0
				var_824_8.x = 0
				var_824_0.localEulerAngles = var_824_8
			end

			local var_824_9 = "1044ui_story"

			if arg_821_1.actors_[var_824_9] == nil then
				local var_824_10 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_824_10) then
					local var_824_11 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_821_1.stage_.transform)

					var_824_11.name = var_824_9
					var_824_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_821_1.actors_[var_824_9] = var_824_11

					local var_824_12 = var_824_11:GetComponentInChildren(typeof(CharacterEffect))

					var_824_12.enabled = true

					local var_824_13 = GameObjectTools.GetOrAddComponent(var_824_11, typeof(DynamicBoneHelper))

					if var_824_13 then
						var_824_13:EnableDynamicBone(false)
					end

					arg_821_1:ShowWeapon(var_824_12.transform, false)

					arg_821_1.var_[var_824_9 .. "Animator"] = var_824_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_821_1.var_[var_824_9 .. "Animator"].applyRootMotion = true
					arg_821_1.var_[var_824_9 .. "LipSync"] = var_824_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_824_14 = 0

			if var_824_14 < arg_821_1.time_ and arg_821_1.time_ <= var_824_14 + arg_824_0 then
				arg_821_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_2")
			end

			local var_824_15 = "1044ui_story"

			if arg_821_1.actors_[var_824_15] == nil then
				local var_824_16 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_824_16) then
					local var_824_17 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_821_1.stage_.transform)

					var_824_17.name = var_824_15
					var_824_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_821_1.actors_[var_824_15] = var_824_17

					local var_824_18 = var_824_17:GetComponentInChildren(typeof(CharacterEffect))

					var_824_18.enabled = true

					local var_824_19 = GameObjectTools.GetOrAddComponent(var_824_17, typeof(DynamicBoneHelper))

					if var_824_19 then
						var_824_19:EnableDynamicBone(false)
					end

					arg_821_1:ShowWeapon(var_824_18.transform, false)

					arg_821_1.var_[var_824_15 .. "Animator"] = var_824_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_821_1.var_[var_824_15 .. "Animator"].applyRootMotion = true
					arg_821_1.var_[var_824_15 .. "LipSync"] = var_824_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_824_20 = 0

			if var_824_20 < arg_821_1.time_ and arg_821_1.time_ <= var_824_20 + arg_824_0 then
				arg_821_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_824_21 = arg_821_1.actors_["1044ui_story"]
			local var_824_22 = 0

			if var_824_22 < arg_821_1.time_ and arg_821_1.time_ <= var_824_22 + arg_824_0 and not isNil(var_824_21) and arg_821_1.var_.characterEffect1044ui_story == nil then
				arg_821_1.var_.characterEffect1044ui_story = var_824_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_824_23 = 0.2

			if var_824_22 <= arg_821_1.time_ and arg_821_1.time_ < var_824_22 + var_824_23 and not isNil(var_824_21) then
				local var_824_24 = (arg_821_1.time_ - var_824_22) / var_824_23

				if arg_821_1.var_.characterEffect1044ui_story and not isNil(var_824_21) then
					arg_821_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_821_1.time_ >= var_824_22 + var_824_23 and arg_821_1.time_ < var_824_22 + var_824_23 + arg_824_0 and not isNil(var_824_21) and arg_821_1.var_.characterEffect1044ui_story then
				arg_821_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_824_25 = 0
			local var_824_26 = 0.2

			if var_824_25 < arg_821_1.time_ and arg_821_1.time_ <= var_824_25 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0
				arg_821_1.dialogCg_.alpha = 1

				arg_821_1.dialog_:SetActive(true)
				SetActive(arg_821_1.leftNameGo_, true)

				local var_824_27 = arg_821_1:FormatText(StoryNameCfg[1367].name)

				arg_821_1.leftNameTxt_.text = var_824_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_28 = arg_821_1:GetWordFromCfg(322161127)
				local var_824_29 = arg_821_1:FormatText(var_824_28.content)

				arg_821_1.text_.text = var_824_29

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_30 = 8
				local var_824_31 = utf8.len(var_824_29)
				local var_824_32 = var_824_30 <= 0 and var_824_26 or var_824_26 * (var_824_31 / var_824_30)

				if var_824_32 > 0 and var_824_26 < var_824_32 then
					arg_821_1.talkMaxDuration = var_824_32

					if var_824_32 + var_824_25 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_32 + var_824_25
					end
				end

				arg_821_1.text_.text = var_824_29
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322161", "322161127", "story_v_out_322161.awb") ~= 0 then
					local var_824_33 = manager.audio:GetVoiceLength("story_v_out_322161", "322161127", "story_v_out_322161.awb") / 1000

					if var_824_33 + var_824_25 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_33 + var_824_25
					end

					if var_824_28.prefab_name ~= "" and arg_821_1.actors_[var_824_28.prefab_name] ~= nil then
						local var_824_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_821_1.actors_[var_824_28.prefab_name].transform, "story_v_out_322161", "322161127", "story_v_out_322161.awb")

						arg_821_1:RecordAudio("322161127", var_824_34)
						arg_821_1:RecordAudio("322161127", var_824_34)
					else
						arg_821_1:AudioAction("play", "voice", "story_v_out_322161", "322161127", "story_v_out_322161.awb")
					end

					arg_821_1:RecordHistoryTalkVoice("story_v_out_322161", "322161127", "story_v_out_322161.awb")
				end

				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_35 = math.max(var_824_26, arg_821_1.talkMaxDuration)

			if var_824_25 <= arg_821_1.time_ and arg_821_1.time_ < var_824_25 + var_824_35 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_25) / var_824_35

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_25 + var_824_35 and arg_821_1.time_ < var_824_25 + var_824_35 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_821_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0510",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/MS2210",
		"SofdecAsset/story/story_1032216.usm"
	},
	voices = {
		"story_v_out_322161.awb"
	},
	skipMarkers = {
		322161197
	}
}
