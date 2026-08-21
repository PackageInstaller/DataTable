return {
	Play320251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320251001
		arg_1_1.duration_ = 11

		local var_1_0 = {
			zh = 9.7,
			ja = 11
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
				arg_1_0:Play320251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST61"

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
				local var_4_5 = arg_1_1.bgs_.ST61

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
					if iter_4_0 ~= "ST61" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = "1089ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1089ui_story"].transform
			local var_4_30 = 1.699999999999

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1089ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.1, -6.17)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1089ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1089ui_story"]
			local var_4_39 = 1.699999999999

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1089ui_story == nil then
				arg_1_1.var_.characterEffect1089ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1089ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1089ui_story then
				arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_4_42 = 1.699999999998

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_1")
			end

			local var_4_43 = 1.699999999999

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
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

			local var_4_50 = 0.333333333333333
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

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
			local var_4_57 = 0.775

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[1031].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(320251001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251001", "story_v_out_320251.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_320251", "320251001", "story_v_out_320251.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_320251", "320251001", "story_v_out_320251.awb")

						arg_1_1:RecordAudio("320251001", var_4_66)
						arg_1_1:RecordAudio("320251001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320251", "320251001", "story_v_out_320251.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320251", "320251001", "story_v_out_320251.awb")
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.699999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play320251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320251002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play320251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1089ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1089ui_story == nil then
				arg_9_1.var_.characterEffect1089ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1089ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1089ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1089ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1089ui_story.fillRatio = var_12_5
			end

			local var_12_6 = arg_9_1.actors_["1089ui_story"].transform
			local var_12_7 = 0

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.var_.moveOldPos1089ui_story = var_12_6.localPosition
			end

			local var_12_8 = 0.001

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_7) / var_12_8
				local var_12_10 = Vector3.New(0, 100, 0)

				var_12_6.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1089ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_6.position

				var_12_6.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_6.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_6.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_7 + var_12_8 and arg_9_1.time_ < var_12_7 + var_12_8 + arg_12_0 then
				var_12_6.localPosition = Vector3.New(0, 100, 0)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_6.position

				var_12_6.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_6.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_6.localEulerAngles = var_12_14
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

				local var_12_17 = arg_9_1:GetWordFromCfg(320251002)
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
				actorName = "1089ui_story",
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
	Play320251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320251003
		arg_13_1.duration_ = 2.47

		local var_13_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_13_0:Play320251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1056ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["1056ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1056ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1, -5.75)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1056ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1, -5.75)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1056ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1056ui_story == nil then
				arg_13_1.var_.characterEffect1056ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1056ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1056ui_story then
				arg_13_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_16_20 = arg_13_1.actors_["1089ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos1089ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(0, 100, 0)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1089ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(0, 100, 0)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = 0
			local var_16_30 = 0.15

			if var_16_29 < arg_13_1.time_ and arg_13_1.time_ <= var_16_29 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_31 = arg_13_1:FormatText(StoryNameCfg[605].name)

				arg_13_1.leftNameTxt_.text = var_16_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_32 = arg_13_1:GetWordFromCfg(320251003)
				local var_16_33 = arg_13_1:FormatText(var_16_32.content)

				arg_13_1.text_.text = var_16_33

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_34 = 6
				local var_16_35 = utf8.len(var_16_33)
				local var_16_36 = var_16_34 <= 0 and var_16_30 or var_16_30 * (var_16_35 / var_16_34)

				if var_16_36 > 0 and var_16_30 < var_16_36 then
					arg_13_1.talkMaxDuration = var_16_36

					if var_16_36 + var_16_29 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_36 + var_16_29
					end
				end

				arg_13_1.text_.text = var_16_33
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251003", "story_v_out_320251.awb") ~= 0 then
					local var_16_37 = manager.audio:GetVoiceLength("story_v_out_320251", "320251003", "story_v_out_320251.awb") / 1000

					if var_16_37 + var_16_29 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_37 + var_16_29
					end

					if var_16_32.prefab_name ~= "" and arg_13_1.actors_[var_16_32.prefab_name] ~= nil then
						local var_16_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_32.prefab_name].transform, "story_v_out_320251", "320251003", "story_v_out_320251.awb")

						arg_13_1:RecordAudio("320251003", var_16_38)
						arg_13_1:RecordAudio("320251003", var_16_38)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320251", "320251003", "story_v_out_320251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320251", "320251003", "story_v_out_320251.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_39 = math.max(var_16_30, arg_13_1.talkMaxDuration)

			if var_16_29 <= arg_13_1.time_ and arg_13_1.time_ < var_16_29 + var_16_39 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_29) / var_16_39

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_29 + var_16_39 and arg_13_1.time_ < var_16_29 + var_16_39 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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

		arg_13_1:InitPlayNodeList()
	end,
	Play320251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320251004
		arg_17_1.duration_ = 3.37

		local var_17_0 = {
			zh = 3.366,
			ja = 3.066
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
				arg_17_0:Play320251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1089ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1089ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1089ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1089ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1089ui_story == nil then
				arg_17_1.var_.characterEffect1089ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1089ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1089ui_story then
				arg_17_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action6_2")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_20_15 = arg_17_1.actors_["1056ui_story"].transform
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.var_.moveOldPos1056ui_story = var_20_15.localPosition
			end

			local var_20_17 = 0.001

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Vector3.New(0.7, -1, -5.75)

				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1056ui_story, var_20_19, var_20_18)

				local var_20_20 = manager.ui.mainCamera.transform.position - var_20_15.position

				var_20_15.forward = Vector3.New(var_20_20.x, var_20_20.y, var_20_20.z)

				local var_20_21 = var_20_15.localEulerAngles

				var_20_21.z = 0
				var_20_21.x = 0
				var_20_15.localEulerAngles = var_20_21
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				var_20_15.localPosition = Vector3.New(0.7, -1, -5.75)

				local var_20_22 = manager.ui.mainCamera.transform.position - var_20_15.position

				var_20_15.forward = Vector3.New(var_20_22.x, var_20_22.y, var_20_22.z)

				local var_20_23 = var_20_15.localEulerAngles

				var_20_23.z = 0
				var_20_23.x = 0
				var_20_15.localEulerAngles = var_20_23
			end

			local var_20_24 = arg_17_1.actors_["1056ui_story"]
			local var_20_25 = 0

			if var_20_25 < arg_17_1.time_ and arg_17_1.time_ <= var_20_25 + arg_20_0 and not isNil(var_20_24) and arg_17_1.var_.characterEffect1056ui_story == nil then
				arg_17_1.var_.characterEffect1056ui_story = var_20_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_26 = 0.200000002980232

			if var_20_25 <= arg_17_1.time_ and arg_17_1.time_ < var_20_25 + var_20_26 and not isNil(var_20_24) then
				local var_20_27 = (arg_17_1.time_ - var_20_25) / var_20_26

				if arg_17_1.var_.characterEffect1056ui_story and not isNil(var_20_24) then
					local var_20_28 = Mathf.Lerp(0, 0.5, var_20_27)

					arg_17_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1056ui_story.fillRatio = var_20_28
				end
			end

			if arg_17_1.time_ >= var_20_25 + var_20_26 and arg_17_1.time_ < var_20_25 + var_20_26 + arg_20_0 and not isNil(var_20_24) and arg_17_1.var_.characterEffect1056ui_story then
				local var_20_29 = 0.5

				arg_17_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1056ui_story.fillRatio = var_20_29
			end

			local var_20_30 = 0
			local var_20_31 = 0.15

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_32 = arg_17_1:FormatText(StoryNameCfg[1031].name)

				arg_17_1.leftNameTxt_.text = var_20_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_33 = arg_17_1:GetWordFromCfg(320251004)
				local var_20_34 = arg_17_1:FormatText(var_20_33.content)

				arg_17_1.text_.text = var_20_34

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_35 = 6
				local var_20_36 = utf8.len(var_20_34)
				local var_20_37 = var_20_35 <= 0 and var_20_31 or var_20_31 * (var_20_36 / var_20_35)

				if var_20_37 > 0 and var_20_31 < var_20_37 then
					arg_17_1.talkMaxDuration = var_20_37

					if var_20_37 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_34
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251004", "story_v_out_320251.awb") ~= 0 then
					local var_20_38 = manager.audio:GetVoiceLength("story_v_out_320251", "320251004", "story_v_out_320251.awb") / 1000

					if var_20_38 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_38 + var_20_30
					end

					if var_20_33.prefab_name ~= "" and arg_17_1.actors_[var_20_33.prefab_name] ~= nil then
						local var_20_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_33.prefab_name].transform, "story_v_out_320251", "320251004", "story_v_out_320251.awb")

						arg_17_1:RecordAudio("320251004", var_20_39)
						arg_17_1:RecordAudio("320251004", var_20_39)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320251", "320251004", "story_v_out_320251.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320251", "320251004", "story_v_out_320251.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_40 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_40 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_40

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_40 and arg_17_1.time_ < var_20_30 + var_20_40 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
				actorName = "1056ui_story",
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
	Play320251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320251005
		arg_21_1.duration_ = 8.27

		local var_21_0 = {
			zh = 8.266,
			ja = 6.466
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
				arg_21_0:Play320251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.925

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1031].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(320251005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 37
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251005", "story_v_out_320251.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251005", "story_v_out_320251.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_320251", "320251005", "story_v_out_320251.awb")

						arg_21_1:RecordAudio("320251005", var_24_9)
						arg_21_1:RecordAudio("320251005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320251", "320251005", "story_v_out_320251.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320251", "320251005", "story_v_out_320251.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play320251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320251006
		arg_25_1.duration_ = 8.1

		local var_25_0 = {
			zh = 7.1,
			ja = 8.1
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
				arg_25_0:Play320251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.8

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[1031].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(320251006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251006", "story_v_out_320251.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251006", "story_v_out_320251.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_320251", "320251006", "story_v_out_320251.awb")

						arg_25_1:RecordAudio("320251006", var_28_9)
						arg_25_1:RecordAudio("320251006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320251", "320251006", "story_v_out_320251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320251", "320251006", "story_v_out_320251.awb")
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
	Play320251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320251007
		arg_29_1.duration_ = 4.07

		local var_29_0 = {
			zh = 2.8,
			ja = 4.066
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
				arg_29_0:Play320251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1056ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1056ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0.7, -1, -5.75)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1056ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0.7, -1, -5.75)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1056ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1056ui_story == nil then
				arg_29_1.var_.characterEffect1056ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1056ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1056ui_story then
				arg_29_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_1")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_15 = arg_29_1.actors_["1089ui_story"]
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.characterEffect1089ui_story == nil then
				arg_29_1.var_.characterEffect1089ui_story = var_32_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_17 = 0.200000002980232

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 and not isNil(var_32_15) then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17

				if arg_29_1.var_.characterEffect1089ui_story and not isNil(var_32_15) then
					local var_32_19 = Mathf.Lerp(0, 0.5, var_32_18)

					arg_29_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1089ui_story.fillRatio = var_32_19
				end
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.characterEffect1089ui_story then
				local var_32_20 = 0.5

				arg_29_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1089ui_story.fillRatio = var_32_20
			end

			local var_32_21 = 0
			local var_32_22 = 0.225

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_23 = arg_29_1:FormatText(StoryNameCfg[605].name)

				arg_29_1.leftNameTxt_.text = var_32_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_24 = arg_29_1:GetWordFromCfg(320251007)
				local var_32_25 = arg_29_1:FormatText(var_32_24.content)

				arg_29_1.text_.text = var_32_25

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_26 = 9
				local var_32_27 = utf8.len(var_32_25)
				local var_32_28 = var_32_26 <= 0 and var_32_22 or var_32_22 * (var_32_27 / var_32_26)

				if var_32_28 > 0 and var_32_22 < var_32_28 then
					arg_29_1.talkMaxDuration = var_32_28

					if var_32_28 + var_32_21 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_21
					end
				end

				arg_29_1.text_.text = var_32_25
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251007", "story_v_out_320251.awb") ~= 0 then
					local var_32_29 = manager.audio:GetVoiceLength("story_v_out_320251", "320251007", "story_v_out_320251.awb") / 1000

					if var_32_29 + var_32_21 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_29 + var_32_21
					end

					if var_32_24.prefab_name ~= "" and arg_29_1.actors_[var_32_24.prefab_name] ~= nil then
						local var_32_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_24.prefab_name].transform, "story_v_out_320251", "320251007", "story_v_out_320251.awb")

						arg_29_1:RecordAudio("320251007", var_32_30)
						arg_29_1:RecordAudio("320251007", var_32_30)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320251", "320251007", "story_v_out_320251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320251", "320251007", "story_v_out_320251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_31 = math.max(var_32_22, arg_29_1.talkMaxDuration)

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_31 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_21) / var_32_31

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_21 + var_32_31 and arg_29_1.time_ < var_32_21 + var_32_31 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320251008
		arg_33_1.duration_ = 7.1

		local var_33_0 = {
			zh = 7.1,
			ja = 6.833
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
				arg_33_0:Play320251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1089ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1089ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1089ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1089ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1089ui_story == nil then
				arg_33_1.var_.characterEffect1089ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1089ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1089ui_story then
				arg_33_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_36_14 = arg_33_1.actors_["1056ui_story"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1056ui_story == nil then
				arg_33_1.var_.characterEffect1056ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.characterEffect1056ui_story and not isNil(var_36_14) then
					local var_36_18 = Mathf.Lerp(0, 0.5, var_36_17)

					arg_33_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1056ui_story.fillRatio = var_36_18
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1056ui_story then
				local var_36_19 = 0.5

				arg_33_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1056ui_story.fillRatio = var_36_19
			end

			local var_36_20 = 0
			local var_36_21 = 0.6

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_22 = arg_33_1:FormatText(StoryNameCfg[1031].name)

				arg_33_1.leftNameTxt_.text = var_36_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_23 = arg_33_1:GetWordFromCfg(320251008)
				local var_36_24 = arg_33_1:FormatText(var_36_23.content)

				arg_33_1.text_.text = var_36_24

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_25 = 24
				local var_36_26 = utf8.len(var_36_24)
				local var_36_27 = var_36_25 <= 0 and var_36_21 or var_36_21 * (var_36_26 / var_36_25)

				if var_36_27 > 0 and var_36_21 < var_36_27 then
					arg_33_1.talkMaxDuration = var_36_27

					if var_36_27 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_27 + var_36_20
					end
				end

				arg_33_1.text_.text = var_36_24
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251008", "story_v_out_320251.awb") ~= 0 then
					local var_36_28 = manager.audio:GetVoiceLength("story_v_out_320251", "320251008", "story_v_out_320251.awb") / 1000

					if var_36_28 + var_36_20 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_20
					end

					if var_36_23.prefab_name ~= "" and arg_33_1.actors_[var_36_23.prefab_name] ~= nil then
						local var_36_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_23.prefab_name].transform, "story_v_out_320251", "320251008", "story_v_out_320251.awb")

						arg_33_1:RecordAudio("320251008", var_36_29)
						arg_33_1:RecordAudio("320251008", var_36_29)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320251", "320251008", "story_v_out_320251.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320251", "320251008", "story_v_out_320251.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_30 = math.max(var_36_21, arg_33_1.talkMaxDuration)

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_30 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_30

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_30 and arg_33_1.time_ < var_36_20 + var_36_30 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play320251009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320251009
		arg_37_1.duration_ = 7.9

		local var_37_0 = {
			zh = 7.9,
			ja = 6.533
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
				arg_37_0:Play320251010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.75

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1031].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(320251009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251009", "story_v_out_320251.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251009", "story_v_out_320251.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_320251", "320251009", "story_v_out_320251.awb")

						arg_37_1:RecordAudio("320251009", var_40_9)
						arg_37_1:RecordAudio("320251009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320251", "320251009", "story_v_out_320251.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320251", "320251009", "story_v_out_320251.awb")
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
	Play320251010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320251010
		arg_41_1.duration_ = 2.97

		local var_41_0 = {
			zh = 2.666,
			ja = 2.966
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
				arg_41_0:Play320251011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1056ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1056ui_story == nil then
				arg_41_1.var_.characterEffect1056ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1056ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1056ui_story then
				arg_41_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_2")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_6 = arg_41_1.actors_["1089ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1089ui_story == nil then
				arg_41_1.var_.characterEffect1089ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1089ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1089ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1089ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1089ui_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 0.325

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[605].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(320251010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251010", "story_v_out_320251.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251010", "story_v_out_320251.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_320251", "320251010", "story_v_out_320251.awb")

						arg_41_1:RecordAudio("320251010", var_44_21)
						arg_41_1:RecordAudio("320251010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320251", "320251010", "story_v_out_320251.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320251", "320251010", "story_v_out_320251.awb")
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
	Play320251011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320251011
		arg_45_1.duration_ = 11.67

		local var_45_0 = {
			zh = 11.5,
			ja = 11.666
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
				arg_45_0:Play320251012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.575

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[605].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(320251011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 63
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251011", "story_v_out_320251.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251011", "story_v_out_320251.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_320251", "320251011", "story_v_out_320251.awb")

						arg_45_1:RecordAudio("320251011", var_48_9)
						arg_45_1:RecordAudio("320251011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320251", "320251011", "story_v_out_320251.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320251", "320251011", "story_v_out_320251.awb")
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
	Play320251012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320251012
		arg_49_1.duration_ = 11.4

		local var_49_0 = {
			zh = 11.4,
			ja = 7.1
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
				arg_49_0:Play320251013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.45

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[605].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(320251012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 58
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251012", "story_v_out_320251.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251012", "story_v_out_320251.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_320251", "320251012", "story_v_out_320251.awb")

						arg_49_1:RecordAudio("320251012", var_52_9)
						arg_49_1:RecordAudio("320251012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320251", "320251012", "story_v_out_320251.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320251", "320251012", "story_v_out_320251.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320251013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320251013
		arg_53_1.duration_ = 7.43

		local var_53_0 = {
			zh = 5.933,
			ja = 7.433
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
				arg_53_0:Play320251014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action10_1")
			end

			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.8

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_4 = arg_53_1:FormatText(StoryNameCfg[605].name)

				arg_53_1.leftNameTxt_.text = var_56_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:GetWordFromCfg(320251013)
				local var_56_6 = arg_53_1:FormatText(var_56_5.content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 32
				local var_56_8 = utf8.len(var_56_6)
				local var_56_9 = var_56_7 <= 0 and var_56_3 or var_56_3 * (var_56_8 / var_56_7)

				if var_56_9 > 0 and var_56_3 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251013", "story_v_out_320251.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251013", "story_v_out_320251.awb") / 1000

					if var_56_10 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_2
					end

					if var_56_5.prefab_name ~= "" and arg_53_1.actors_[var_56_5.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_5.prefab_name].transform, "story_v_out_320251", "320251013", "story_v_out_320251.awb")

						arg_53_1:RecordAudio("320251013", var_56_11)
						arg_53_1:RecordAudio("320251013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320251", "320251013", "story_v_out_320251.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320251", "320251013", "story_v_out_320251.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_12 and arg_53_1.time_ < var_56_2 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320251014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320251014
		arg_57_1.duration_ = 7.5

		local var_57_0 = {
			zh = 7.5,
			ja = 6.833
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
				arg_57_0:Play320251015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1089ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1089ui_story == nil then
				arg_57_1.var_.characterEffect1089ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1089ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1089ui_story then
				arg_57_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_6 = arg_57_1.actors_["1056ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1056ui_story == nil then
				arg_57_1.var_.characterEffect1056ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect1056ui_story and not isNil(var_60_6) then
					local var_60_10 = Mathf.Lerp(0, 0.5, var_60_9)

					arg_57_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1056ui_story.fillRatio = var_60_10
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1056ui_story then
				local var_60_11 = 0.5

				arg_57_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1056ui_story.fillRatio = var_60_11
			end

			local var_60_12 = 0
			local var_60_13 = 0.775

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[1031].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(320251014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 31
				local var_60_18 = utf8.len(var_60_16)
				local var_60_19 = var_60_17 <= 0 and var_60_13 or var_60_13 * (var_60_18 / var_60_17)

				if var_60_19 > 0 and var_60_13 < var_60_19 then
					arg_57_1.talkMaxDuration = var_60_19

					if var_60_19 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251014", "story_v_out_320251.awb") ~= 0 then
					local var_60_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251014", "story_v_out_320251.awb") / 1000

					if var_60_20 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_320251", "320251014", "story_v_out_320251.awb")

						arg_57_1:RecordAudio("320251014", var_60_21)
						arg_57_1:RecordAudio("320251014", var_60_21)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320251", "320251014", "story_v_out_320251.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320251", "320251014", "story_v_out_320251.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_22 and arg_57_1.time_ < var_60_12 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320251015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320251015
		arg_61_1.duration_ = 5.23

		local var_61_0 = {
			zh = 3.6,
			ja = 5.233
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
				arg_61_0:Play320251016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1056ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1056ui_story == nil then
				arg_61_1.var_.characterEffect1056ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1056ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1056ui_story then
				arg_61_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action10_2")
			end

			local var_64_5 = arg_61_1.actors_["1089ui_story"]
			local var_64_6 = 0

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1089ui_story == nil then
				arg_61_1.var_.characterEffect1089ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.200000002980232

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_7 and not isNil(var_64_5) then
				local var_64_8 = (arg_61_1.time_ - var_64_6) / var_64_7

				if arg_61_1.var_.characterEffect1089ui_story and not isNil(var_64_5) then
					local var_64_9 = Mathf.Lerp(0, 0.5, var_64_8)

					arg_61_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1089ui_story.fillRatio = var_64_9
				end
			end

			if arg_61_1.time_ >= var_64_6 + var_64_7 and arg_61_1.time_ < var_64_6 + var_64_7 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1089ui_story then
				local var_64_10 = 0.5

				arg_61_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1089ui_story.fillRatio = var_64_10
			end

			local var_64_11 = 0
			local var_64_12 = 0.45

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_13 = arg_61_1:FormatText(StoryNameCfg[605].name)

				arg_61_1.leftNameTxt_.text = var_64_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(320251015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 18
				local var_64_17 = utf8.len(var_64_15)
				local var_64_18 = var_64_16 <= 0 and var_64_12 or var_64_12 * (var_64_17 / var_64_16)

				if var_64_18 > 0 and var_64_12 < var_64_18 then
					arg_61_1.talkMaxDuration = var_64_18

					if var_64_18 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251015", "story_v_out_320251.awb") ~= 0 then
					local var_64_19 = manager.audio:GetVoiceLength("story_v_out_320251", "320251015", "story_v_out_320251.awb") / 1000

					if var_64_19 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_11
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_320251", "320251015", "story_v_out_320251.awb")

						arg_61_1:RecordAudio("320251015", var_64_20)
						arg_61_1:RecordAudio("320251015", var_64_20)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320251", "320251015", "story_v_out_320251.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320251", "320251015", "story_v_out_320251.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_21 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_21 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_21

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_21 and arg_61_1.time_ < var_64_11 + var_64_21 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play320251016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320251016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play320251017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1056ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1056ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1056ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1056ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1056ui_story == nil then
				arg_65_1.var_.characterEffect1056ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1056ui_story and not isNil(var_68_9) then
					local var_68_13 = Mathf.Lerp(0, 0.5, var_68_12)

					arg_65_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1056ui_story.fillRatio = var_68_13
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1056ui_story then
				local var_68_14 = 0.5

				arg_65_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1056ui_story.fillRatio = var_68_14
			end

			local var_68_15 = arg_65_1.actors_["1089ui_story"].transform
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.var_.moveOldPos1089ui_story = var_68_15.localPosition
			end

			local var_68_17 = 0.001

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17
				local var_68_19 = Vector3.New(0, 100, 0)

				var_68_15.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1089ui_story, var_68_19, var_68_18)

				local var_68_20 = manager.ui.mainCamera.transform.position - var_68_15.position

				var_68_15.forward = Vector3.New(var_68_20.x, var_68_20.y, var_68_20.z)

				local var_68_21 = var_68_15.localEulerAngles

				var_68_21.z = 0
				var_68_21.x = 0
				var_68_15.localEulerAngles = var_68_21
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				var_68_15.localPosition = Vector3.New(0, 100, 0)

				local var_68_22 = manager.ui.mainCamera.transform.position - var_68_15.position

				var_68_15.forward = Vector3.New(var_68_22.x, var_68_22.y, var_68_22.z)

				local var_68_23 = var_68_15.localEulerAngles

				var_68_23.z = 0
				var_68_23.x = 0
				var_68_15.localEulerAngles = var_68_23
			end

			local var_68_24 = arg_65_1.actors_["1089ui_story"]
			local var_68_25 = 0

			if var_68_25 < arg_65_1.time_ and arg_65_1.time_ <= var_68_25 + arg_68_0 and not isNil(var_68_24) and arg_65_1.var_.characterEffect1089ui_story == nil then
				arg_65_1.var_.characterEffect1089ui_story = var_68_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_26 = 0.200000002980232

			if var_68_25 <= arg_65_1.time_ and arg_65_1.time_ < var_68_25 + var_68_26 and not isNil(var_68_24) then
				local var_68_27 = (arg_65_1.time_ - var_68_25) / var_68_26

				if arg_65_1.var_.characterEffect1089ui_story and not isNil(var_68_24) then
					local var_68_28 = Mathf.Lerp(0, 0.5, var_68_27)

					arg_65_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1089ui_story.fillRatio = var_68_28
				end
			end

			if arg_65_1.time_ >= var_68_25 + var_68_26 and arg_65_1.time_ < var_68_25 + var_68_26 + arg_68_0 and not isNil(var_68_24) and arg_65_1.var_.characterEffect1089ui_story then
				local var_68_29 = 0.5

				arg_65_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1089ui_story.fillRatio = var_68_29
			end

			local var_68_30 = 0
			local var_68_31 = 1.35

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_32 = arg_65_1:GetWordFromCfg(320251016)
				local var_68_33 = arg_65_1:FormatText(var_68_32.content)

				arg_65_1.text_.text = var_68_33

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_34 = 54
				local var_68_35 = utf8.len(var_68_33)
				local var_68_36 = var_68_34 <= 0 and var_68_31 or var_68_31 * (var_68_35 / var_68_34)

				if var_68_36 > 0 and var_68_31 < var_68_36 then
					arg_65_1.talkMaxDuration = var_68_36

					if var_68_36 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_36 + var_68_30
					end
				end

				arg_65_1.text_.text = var_68_33
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_37 = math.max(var_68_31, arg_65_1.talkMaxDuration)

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_37 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_30) / var_68_37

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_30 + var_68_37 and arg_65_1.time_ < var_68_30 + var_68_37 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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

		arg_65_1:InitPlayNodeList()
	end,
	Play320251017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320251017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320251018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.375

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(320251017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 55
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320251018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320251018
		arg_73_1.duration_ = 6.4

		local var_73_0 = {
			zh = 4.766,
			ja = 6.4
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
				arg_73_0:Play320251019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1089ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1089ui_story == nil then
				arg_73_1.var_.characterEffect1089ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1089ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1089ui_story then
				arg_73_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_76_5 = arg_73_1.actors_["1089ui_story"].transform
			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.var_.moveOldPos1089ui_story = var_76_5.localPosition
			end

			local var_76_7 = 0.001

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_7 then
				local var_76_8 = (arg_73_1.time_ - var_76_6) / var_76_7
				local var_76_9 = Vector3.New(0, -1.1, -6.17)

				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1089ui_story, var_76_9, var_76_8)

				local var_76_10 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_10.x, var_76_10.y, var_76_10.z)

				local var_76_11 = var_76_5.localEulerAngles

				var_76_11.z = 0
				var_76_11.x = 0
				var_76_5.localEulerAngles = var_76_11
			end

			if arg_73_1.time_ >= var_76_6 + var_76_7 and arg_73_1.time_ < var_76_6 + var_76_7 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_76_12 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_12.x, var_76_12.y, var_76_12.z)

				local var_76_13 = var_76_5.localEulerAngles

				var_76_13.z = 0
				var_76_13.x = 0
				var_76_5.localEulerAngles = var_76_13
			end

			local var_76_14 = 0
			local var_76_15 = 0.5

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_16 = arg_73_1:FormatText(StoryNameCfg[1031].name)

				arg_73_1.leftNameTxt_.text = var_76_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_17 = arg_73_1:GetWordFromCfg(320251018)
				local var_76_18 = arg_73_1:FormatText(var_76_17.content)

				arg_73_1.text_.text = var_76_18

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_19 = 20
				local var_76_20 = utf8.len(var_76_18)
				local var_76_21 = var_76_19 <= 0 and var_76_15 or var_76_15 * (var_76_20 / var_76_19)

				if var_76_21 > 0 and var_76_15 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21

					if var_76_21 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_14
					end
				end

				arg_73_1.text_.text = var_76_18
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251018", "story_v_out_320251.awb") ~= 0 then
					local var_76_22 = manager.audio:GetVoiceLength("story_v_out_320251", "320251018", "story_v_out_320251.awb") / 1000

					if var_76_22 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_14
					end

					if var_76_17.prefab_name ~= "" and arg_73_1.actors_[var_76_17.prefab_name] ~= nil then
						local var_76_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_17.prefab_name].transform, "story_v_out_320251", "320251018", "story_v_out_320251.awb")

						arg_73_1:RecordAudio("320251018", var_76_23)
						arg_73_1:RecordAudio("320251018", var_76_23)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320251", "320251018", "story_v_out_320251.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320251", "320251018", "story_v_out_320251.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_24 = math.max(var_76_15, arg_73_1.talkMaxDuration)

			if var_76_14 <= arg_73_1.time_ and arg_73_1.time_ < var_76_14 + var_76_24 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_14) / var_76_24

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_14 + var_76_24 and arg_73_1.time_ < var_76_14 + var_76_24 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play320251019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320251019
		arg_77_1.duration_ = 8.03

		local var_77_0 = {
			zh = 6.13266666666667,
			ja = 8.03266666666667
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
				arg_77_0:Play320251020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "L02f"

			if arg_77_1.bgs_[var_80_0] == nil then
				local var_80_1 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_0)
				var_80_1.name = var_80_0
				var_80_1.transform.parent = arg_77_1.stage_.transform
				var_80_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_0] = var_80_1
			end

			local var_80_2 = 1.9

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				local var_80_3 = manager.ui.mainCamera.transform.localPosition
				local var_80_4 = Vector3.New(0, 0, 10) + Vector3.New(var_80_3.x, var_80_3.y, 0)
				local var_80_5 = arg_77_1.bgs_.L02f

				var_80_5.transform.localPosition = var_80_4
				var_80_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_6 = var_80_5:GetComponent("SpriteRenderer")

				if var_80_6 and var_80_6.sprite then
					local var_80_7 = (var_80_5.transform.localPosition - var_80_3).z
					local var_80_8 = manager.ui.mainCameraCom_
					local var_80_9 = 2 * var_80_7 * Mathf.Tan(var_80_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_10 = var_80_9 * var_80_8.aspect
					local var_80_11 = var_80_6.sprite.bounds.size.x
					local var_80_12 = var_80_6.sprite.bounds.size.y
					local var_80_13 = var_80_10 / var_80_11
					local var_80_14 = var_80_9 / var_80_12
					local var_80_15 = var_80_14 < var_80_13 and var_80_13 or var_80_14

					var_80_5.transform.localScale = Vector3.New(var_80_15, var_80_15, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "L02f" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_17 = 1.93400000184774

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17
				local var_80_19 = Color.New(0, 0, 0)

				var_80_19.a = Mathf.Lerp(0, 1, var_80_18)
				arg_77_1.mask_.color = var_80_19
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				local var_80_20 = Color.New(0, 0, 0)

				var_80_20.a = 1
				arg_77_1.mask_.color = var_80_20
			end

			local var_80_21 = 1.93400000184774

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_22 = 1.43266666481892

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Color.New(0, 0, 0)

				var_80_24.a = Mathf.Lerp(1, 0, var_80_23)
				arg_77_1.mask_.color = var_80_24
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				local var_80_25 = Color.New(0, 0, 0)
				local var_80_26 = 0

				arg_77_1.mask_.enabled = false
				var_80_25.a = var_80_26
				arg_77_1.mask_.color = var_80_25
			end

			local var_80_27 = arg_77_1.actors_["1089ui_story"].transform
			local var_80_28 = 1.9

			if var_80_28 < arg_77_1.time_ and arg_77_1.time_ <= var_80_28 + arg_80_0 then
				arg_77_1.var_.moveOldPos1089ui_story = var_80_27.localPosition
			end

			local var_80_29 = 0.001

			if var_80_28 <= arg_77_1.time_ and arg_77_1.time_ < var_80_28 + var_80_29 then
				local var_80_30 = (arg_77_1.time_ - var_80_28) / var_80_29
				local var_80_31 = Vector3.New(0, 100, 0)

				var_80_27.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1089ui_story, var_80_31, var_80_30)

				local var_80_32 = manager.ui.mainCamera.transform.position - var_80_27.position

				var_80_27.forward = Vector3.New(var_80_32.x, var_80_32.y, var_80_32.z)

				local var_80_33 = var_80_27.localEulerAngles

				var_80_33.z = 0
				var_80_33.x = 0
				var_80_27.localEulerAngles = var_80_33
			end

			if arg_77_1.time_ >= var_80_28 + var_80_29 and arg_77_1.time_ < var_80_28 + var_80_29 + arg_80_0 then
				var_80_27.localPosition = Vector3.New(0, 100, 0)

				local var_80_34 = manager.ui.mainCamera.transform.position - var_80_27.position

				var_80_27.forward = Vector3.New(var_80_34.x, var_80_34.y, var_80_34.z)

				local var_80_35 = var_80_27.localEulerAngles

				var_80_35.z = 0
				var_80_35.x = 0
				var_80_27.localEulerAngles = var_80_35
			end

			local var_80_36 = 0
			local var_80_37 = 0.2

			if var_80_36 < arg_77_1.time_ and arg_77_1.time_ <= var_80_36 + arg_80_0 then
				local var_80_38 = "play"
				local var_80_39 = "music"

				arg_77_1:AudioAction(var_80_38, var_80_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_80_40 = ""
				local var_80_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_80_41 ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_41 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_41

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_41
						arg_77_1.bgmTxt2_.text = var_80_41
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_80_42 = 1.36666666666667
			local var_80_43 = 1

			if var_80_42 < arg_77_1.time_ and arg_77_1.time_ <= var_80_42 + arg_80_0 then
				local var_80_44 = "play"
				local var_80_45 = "music"

				arg_77_1:AudioAction(var_80_44, var_80_45, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_80_46 = ""
				local var_80_47 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if var_80_47 ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_47 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_47

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_47
						arg_77_1.bgmTxt2_.text = var_80_47
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_48 = 3.36666666666667
			local var_80_49 = 0.3

			if var_80_48 < arg_77_1.time_ and arg_77_1.time_ <= var_80_48 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_50 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_50:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_77_1.dialogCg_.alpha = arg_83_0
				end))
				var_80_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_51 = arg_77_1:FormatText(StoryNameCfg[1044].name)

				arg_77_1.leftNameTxt_.text = var_80_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_52 = arg_77_1:GetWordFromCfg(320251019)
				local var_80_53 = arg_77_1:FormatText(var_80_52.content)

				arg_77_1.text_.text = var_80_53

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_54 = 12
				local var_80_55 = utf8.len(var_80_53)
				local var_80_56 = var_80_54 <= 0 and var_80_49 or var_80_49 * (var_80_55 / var_80_54)

				if var_80_56 > 0 and var_80_49 < var_80_56 then
					arg_77_1.talkMaxDuration = var_80_56
					var_80_48 = var_80_48 + 0.3

					if var_80_56 + var_80_48 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_56 + var_80_48
					end
				end

				arg_77_1.text_.text = var_80_53
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251019", "story_v_out_320251.awb") ~= 0 then
					local var_80_57 = manager.audio:GetVoiceLength("story_v_out_320251", "320251019", "story_v_out_320251.awb") / 1000

					if var_80_57 + var_80_48 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_57 + var_80_48
					end

					if var_80_52.prefab_name ~= "" and arg_77_1.actors_[var_80_52.prefab_name] ~= nil then
						local var_80_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_52.prefab_name].transform, "story_v_out_320251", "320251019", "story_v_out_320251.awb")

						arg_77_1:RecordAudio("320251019", var_80_58)
						arg_77_1:RecordAudio("320251019", var_80_58)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320251", "320251019", "story_v_out_320251.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320251", "320251019", "story_v_out_320251.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_59 = var_80_48 + 0.3
			local var_80_60 = math.max(var_80_49, arg_77_1.talkMaxDuration)

			if var_80_59 <= arg_77_1.time_ and arg_77_1.time_ < var_80_59 + var_80_60 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_59) / var_80_60

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_59 + var_80_60 and arg_77_1.time_ < var_80_59 + var_80_60 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play320251020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320251020
		arg_85_1.duration_ = 6.7

		local var_85_0 = {
			zh = 5,
			ja = 6.7
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
				arg_85_0:Play320251021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "10100ui_story"

			if arg_85_1.actors_[var_88_0] == nil then
				local var_88_1 = Asset.Load("Char/" .. "10100ui_story")

				if not isNil(var_88_1) then
					local var_88_2 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_85_1.stage_.transform)

					var_88_2.name = var_88_0
					var_88_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_85_1.actors_[var_88_0] = var_88_2

					local var_88_3 = var_88_2:GetComponentInChildren(typeof(CharacterEffect))

					var_88_3.enabled = true

					local var_88_4 = GameObjectTools.GetOrAddComponent(var_88_2, typeof(DynamicBoneHelper))

					if var_88_4 then
						var_88_4:EnableDynamicBone(false)
					end

					arg_85_1:ShowWeapon(var_88_3.transform, false)

					arg_85_1.var_[var_88_0 .. "Animator"] = var_88_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_85_1.var_[var_88_0 .. "Animator"].applyRootMotion = true
					arg_85_1.var_[var_88_0 .. "LipSync"] = var_88_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_88_5 = arg_85_1.actors_["10100ui_story"].transform
			local var_88_6 = 0

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.var_.moveOldPos10100ui_story = var_88_5.localPosition
			end

			local var_88_7 = 0.001

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_7 then
				local var_88_8 = (arg_85_1.time_ - var_88_6) / var_88_7
				local var_88_9 = Vector3.New(0, -1.16, -6.25)

				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10100ui_story, var_88_9, var_88_8)

				local var_88_10 = manager.ui.mainCamera.transform.position - var_88_5.position

				var_88_5.forward = Vector3.New(var_88_10.x, var_88_10.y, var_88_10.z)

				local var_88_11 = var_88_5.localEulerAngles

				var_88_11.z = 0
				var_88_11.x = 0
				var_88_5.localEulerAngles = var_88_11
			end

			if arg_85_1.time_ >= var_88_6 + var_88_7 and arg_85_1.time_ < var_88_6 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_88_12 = manager.ui.mainCamera.transform.position - var_88_5.position

				var_88_5.forward = Vector3.New(var_88_12.x, var_88_12.y, var_88_12.z)

				local var_88_13 = var_88_5.localEulerAngles

				var_88_13.z = 0
				var_88_13.x = 0
				var_88_5.localEulerAngles = var_88_13
			end

			local var_88_14 = arg_85_1.actors_["10100ui_story"]
			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.characterEffect10100ui_story == nil then
				arg_85_1.var_.characterEffect10100ui_story = var_88_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_16 = 0.200000002980232

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_16 and not isNil(var_88_14) then
				local var_88_17 = (arg_85_1.time_ - var_88_15) / var_88_16

				if arg_85_1.var_.characterEffect10100ui_story and not isNil(var_88_14) then
					arg_85_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_15 + var_88_16 and arg_85_1.time_ < var_88_15 + var_88_16 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.characterEffect10100ui_story then
				arg_85_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_88_18 = 0

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_88_19 = 0

			if var_88_19 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_88_20 = 0
			local var_88_21 = 0.675

			if var_88_20 < arg_85_1.time_ and arg_85_1.time_ <= var_88_20 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_22 = arg_85_1:FormatText(StoryNameCfg[1021].name)

				arg_85_1.leftNameTxt_.text = var_88_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_23 = arg_85_1:GetWordFromCfg(320251020)
				local var_88_24 = arg_85_1:FormatText(var_88_23.content)

				arg_85_1.text_.text = var_88_24

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_25 = 27
				local var_88_26 = utf8.len(var_88_24)
				local var_88_27 = var_88_25 <= 0 and var_88_21 or var_88_21 * (var_88_26 / var_88_25)

				if var_88_27 > 0 and var_88_21 < var_88_27 then
					arg_85_1.talkMaxDuration = var_88_27

					if var_88_27 + var_88_20 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_27 + var_88_20
					end
				end

				arg_85_1.text_.text = var_88_24
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251020", "story_v_out_320251.awb") ~= 0 then
					local var_88_28 = manager.audio:GetVoiceLength("story_v_out_320251", "320251020", "story_v_out_320251.awb") / 1000

					if var_88_28 + var_88_20 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_20
					end

					if var_88_23.prefab_name ~= "" and arg_85_1.actors_[var_88_23.prefab_name] ~= nil then
						local var_88_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_23.prefab_name].transform, "story_v_out_320251", "320251020", "story_v_out_320251.awb")

						arg_85_1:RecordAudio("320251020", var_88_29)
						arg_85_1:RecordAudio("320251020", var_88_29)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320251", "320251020", "story_v_out_320251.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320251", "320251020", "story_v_out_320251.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_30 = math.max(var_88_21, arg_85_1.talkMaxDuration)

			if var_88_20 <= arg_85_1.time_ and arg_85_1.time_ < var_88_20 + var_88_30 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_20) / var_88_30

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_20 + var_88_30 and arg_85_1.time_ < var_88_20 + var_88_30 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play320251021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320251021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play320251022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10100ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10100ui_story == nil then
				arg_89_1.var_.characterEffect10100ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10100ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10100ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10100ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10100ui_story.fillRatio = var_92_5
			end

			local var_92_6 = arg_89_1.actors_["10100ui_story"].transform
			local var_92_7 = 0

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.var_.moveOldPos10100ui_story = var_92_6.localPosition
			end

			local var_92_8 = 0.001

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 then
				local var_92_9 = (arg_89_1.time_ - var_92_7) / var_92_8
				local var_92_10 = Vector3.New(0, 100, 0)

				var_92_6.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10100ui_story, var_92_10, var_92_9)

				local var_92_11 = manager.ui.mainCamera.transform.position - var_92_6.position

				var_92_6.forward = Vector3.New(var_92_11.x, var_92_11.y, var_92_11.z)

				local var_92_12 = var_92_6.localEulerAngles

				var_92_12.z = 0
				var_92_12.x = 0
				var_92_6.localEulerAngles = var_92_12
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 then
				var_92_6.localPosition = Vector3.New(0, 100, 0)

				local var_92_13 = manager.ui.mainCamera.transform.position - var_92_6.position

				var_92_6.forward = Vector3.New(var_92_13.x, var_92_13.y, var_92_13.z)

				local var_92_14 = var_92_6.localEulerAngles

				var_92_14.z = 0
				var_92_14.x = 0
				var_92_6.localEulerAngles = var_92_14
			end

			local var_92_15 = 0
			local var_92_16 = 0.9

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_17 = arg_89_1:GetWordFromCfg(320251021)
				local var_92_18 = arg_89_1:FormatText(var_92_17.content)

				arg_89_1.text_.text = var_92_18

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_19 = 36
				local var_92_20 = utf8.len(var_92_18)
				local var_92_21 = var_92_19 <= 0 and var_92_16 or var_92_16 * (var_92_20 / var_92_19)

				if var_92_21 > 0 and var_92_16 < var_92_21 then
					arg_89_1.talkMaxDuration = var_92_21

					if var_92_21 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_21 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_18
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_22 and arg_89_1.time_ < var_92_15 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320251022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320251022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play320251023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.325

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

				local var_96_2 = arg_93_1:GetWordFromCfg(320251022)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 53
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
	Play320251023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320251023
		arg_97_1.duration_ = 10.33

		local var_97_0 = {
			zh = 8.766,
			ja = 10.333
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
				arg_97_0:Play320251024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10100ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10100ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -1.16, -6.25)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10100ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10100ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10100ui_story == nil then
				arg_97_1.var_.characterEffect10100ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10100ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10100ui_story then
				arg_97_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_100_14 = 0
			local var_100_15 = 1.25

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_16 = arg_97_1:FormatText(StoryNameCfg[1021].name)

				arg_97_1.leftNameTxt_.text = var_100_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_17 = arg_97_1:GetWordFromCfg(320251023)
				local var_100_18 = arg_97_1:FormatText(var_100_17.content)

				arg_97_1.text_.text = var_100_18

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_19 = 50
				local var_100_20 = utf8.len(var_100_18)
				local var_100_21 = var_100_19 <= 0 and var_100_15 or var_100_15 * (var_100_20 / var_100_19)

				if var_100_21 > 0 and var_100_15 < var_100_21 then
					arg_97_1.talkMaxDuration = var_100_21

					if var_100_21 + var_100_14 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_21 + var_100_14
					end
				end

				arg_97_1.text_.text = var_100_18
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251023", "story_v_out_320251.awb") ~= 0 then
					local var_100_22 = manager.audio:GetVoiceLength("story_v_out_320251", "320251023", "story_v_out_320251.awb") / 1000

					if var_100_22 + var_100_14 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_14
					end

					if var_100_17.prefab_name ~= "" and arg_97_1.actors_[var_100_17.prefab_name] ~= nil then
						local var_100_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_17.prefab_name].transform, "story_v_out_320251", "320251023", "story_v_out_320251.awb")

						arg_97_1:RecordAudio("320251023", var_100_23)
						arg_97_1:RecordAudio("320251023", var_100_23)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320251", "320251023", "story_v_out_320251.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320251", "320251023", "story_v_out_320251.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_24 = math.max(var_100_15, arg_97_1.talkMaxDuration)

			if var_100_14 <= arg_97_1.time_ and arg_97_1.time_ < var_100_14 + var_100_24 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_14) / var_100_24

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_14 + var_100_24 and arg_97_1.time_ < var_100_14 + var_100_24 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320251024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320251024
		arg_101_1.duration_ = 10.63

		local var_101_0 = {
			zh = 6.933,
			ja = 10.633
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
				arg_101_0:Play320251025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10100ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10100ui_story == nil then
				arg_101_1.var_.characterEffect10100ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10100ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10100ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10100ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10100ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 0.925

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[1044].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_9 = arg_101_1:GetWordFromCfg(320251024)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 37
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251024", "story_v_out_320251.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251024", "story_v_out_320251.awb") / 1000

					if var_104_14 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_6
					end

					if var_104_9.prefab_name ~= "" and arg_101_1.actors_[var_104_9.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_9.prefab_name].transform, "story_v_out_320251", "320251024", "story_v_out_320251.awb")

						arg_101_1:RecordAudio("320251024", var_104_15)
						arg_101_1:RecordAudio("320251024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320251", "320251024", "story_v_out_320251.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320251", "320251024", "story_v_out_320251.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_16 and arg_101_1.time_ < var_104_6 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320251025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320251025
		arg_105_1.duration_ = 9.57

		local var_105_0 = {
			zh = 2.6,
			ja = 9.566
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
				arg_105_0:Play320251026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10100ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10100ui_story == nil then
				arg_105_1.var_.characterEffect10100ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect10100ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10100ui_story then
				arg_105_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_108_4 = 0
			local var_108_5 = 0.275

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_6 = arg_105_1:FormatText(StoryNameCfg[1021].name)

				arg_105_1.leftNameTxt_.text = var_108_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(320251025)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 11
				local var_108_10 = utf8.len(var_108_8)
				local var_108_11 = var_108_9 <= 0 and var_108_5 or var_108_5 * (var_108_10 / var_108_9)

				if var_108_11 > 0 and var_108_5 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251025", "story_v_out_320251.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251025", "story_v_out_320251.awb") / 1000

					if var_108_12 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_4
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_320251", "320251025", "story_v_out_320251.awb")

						arg_105_1:RecordAudio("320251025", var_108_13)
						arg_105_1:RecordAudio("320251025", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320251", "320251025", "story_v_out_320251.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320251", "320251025", "story_v_out_320251.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_14 and arg_105_1.time_ < var_108_4 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320251026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320251026
		arg_109_1.duration_ = 2.93

		local var_109_0 = {
			zh = 1.366,
			ja = 2.933
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
				arg_109_0:Play320251027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10100ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10100ui_story == nil then
				arg_109_1.var_.characterEffect10100ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10100ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10100ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10100ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10100ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.125

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[1044].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(320251026)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 5
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251026", "story_v_out_320251.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251026", "story_v_out_320251.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_out_320251", "320251026", "story_v_out_320251.awb")

						arg_109_1:RecordAudio("320251026", var_112_15)
						arg_109_1:RecordAudio("320251026", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320251", "320251026", "story_v_out_320251.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320251", "320251026", "story_v_out_320251.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_16 and arg_109_1.time_ < var_112_6 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320251027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320251027
		arg_113_1.duration_ = 7.4

		local var_113_0 = {
			zh = 4.3,
			ja = 7.4
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
				arg_113_0:Play320251028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10100ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10100ui_story == nil then
				arg_113_1.var_.characterEffect10100ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect10100ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10100ui_story then
				arg_113_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_116_4 = 0
			local var_116_5 = 0.6

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_6 = arg_113_1:FormatText(StoryNameCfg[1021].name)

				arg_113_1.leftNameTxt_.text = var_116_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(320251027)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 24
				local var_116_10 = utf8.len(var_116_8)
				local var_116_11 = var_116_9 <= 0 and var_116_5 or var_116_5 * (var_116_10 / var_116_9)

				if var_116_11 > 0 and var_116_5 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251027", "story_v_out_320251.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251027", "story_v_out_320251.awb") / 1000

					if var_116_12 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_4
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_320251", "320251027", "story_v_out_320251.awb")

						arg_113_1:RecordAudio("320251027", var_116_13)
						arg_113_1:RecordAudio("320251027", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320251", "320251027", "story_v_out_320251.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320251", "320251027", "story_v_out_320251.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_14 and arg_113_1.time_ < var_116_4 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play320251028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320251028
		arg_117_1.duration_ = 4.07

		local var_117_0 = {
			zh = 3.166,
			ja = 4.066
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
				arg_117_0:Play320251029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10100ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10100ui_story == nil then
				arg_117_1.var_.characterEffect10100ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect10100ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10100ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10100ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10100ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.325

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[1044].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(320251028)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 13
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251028", "story_v_out_320251.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251028", "story_v_out_320251.awb") / 1000

					if var_120_14 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_6
					end

					if var_120_9.prefab_name ~= "" and arg_117_1.actors_[var_120_9.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_9.prefab_name].transform, "story_v_out_320251", "320251028", "story_v_out_320251.awb")

						arg_117_1:RecordAudio("320251028", var_120_15)
						arg_117_1:RecordAudio("320251028", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_320251", "320251028", "story_v_out_320251.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_320251", "320251028", "story_v_out_320251.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_16 and arg_117_1.time_ < var_120_6 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play320251029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320251029
		arg_121_1.duration_ = 6.9

		local var_121_0 = {
			zh = 6.9,
			ja = 4.966
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
				arg_121_0:Play320251030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10100ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10100ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -1.16, -6.25)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10100ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -1.16, -6.25)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10100ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10100ui_story == nil then
				arg_121_1.var_.characterEffect10100ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect10100ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10100ui_story then
				arg_121_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_1")
			end

			local var_124_14 = 0
			local var_124_15 = 0.9

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_16 = arg_121_1:FormatText(StoryNameCfg[1021].name)

				arg_121_1.leftNameTxt_.text = var_124_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_17 = arg_121_1:GetWordFromCfg(320251029)
				local var_124_18 = arg_121_1:FormatText(var_124_17.content)

				arg_121_1.text_.text = var_124_18

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_19 = 36
				local var_124_20 = utf8.len(var_124_18)
				local var_124_21 = var_124_19 <= 0 and var_124_15 or var_124_15 * (var_124_20 / var_124_19)

				if var_124_21 > 0 and var_124_15 < var_124_21 then
					arg_121_1.talkMaxDuration = var_124_21

					if var_124_21 + var_124_14 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_21 + var_124_14
					end
				end

				arg_121_1.text_.text = var_124_18
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251029", "story_v_out_320251.awb") ~= 0 then
					local var_124_22 = manager.audio:GetVoiceLength("story_v_out_320251", "320251029", "story_v_out_320251.awb") / 1000

					if var_124_22 + var_124_14 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_14
					end

					if var_124_17.prefab_name ~= "" and arg_121_1.actors_[var_124_17.prefab_name] ~= nil then
						local var_124_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_17.prefab_name].transform, "story_v_out_320251", "320251029", "story_v_out_320251.awb")

						arg_121_1:RecordAudio("320251029", var_124_23)
						arg_121_1:RecordAudio("320251029", var_124_23)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_320251", "320251029", "story_v_out_320251.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_320251", "320251029", "story_v_out_320251.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_24 = math.max(var_124_15, arg_121_1.talkMaxDuration)

			if var_124_14 <= arg_121_1.time_ and arg_121_1.time_ < var_124_14 + var_124_24 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_14) / var_124_24

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_14 + var_124_24 and arg_121_1.time_ < var_124_14 + var_124_24 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320251030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320251030
		arg_125_1.duration_ = 10.73

		local var_125_0 = {
			zh = 10.733,
			ja = 10.333
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
				arg_125_0:Play320251031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_128_1 = 0
			local var_128_2 = 1.375

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_3 = arg_125_1:FormatText(StoryNameCfg[1021].name)

				arg_125_1.leftNameTxt_.text = var_128_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(320251030)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_6 = 55
				local var_128_7 = utf8.len(var_128_5)
				local var_128_8 = var_128_6 <= 0 and var_128_2 or var_128_2 * (var_128_7 / var_128_6)

				if var_128_8 > 0 and var_128_2 < var_128_8 then
					arg_125_1.talkMaxDuration = var_128_8

					if var_128_8 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251030", "story_v_out_320251.awb") ~= 0 then
					local var_128_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251030", "story_v_out_320251.awb") / 1000

					if var_128_9 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_1
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_320251", "320251030", "story_v_out_320251.awb")

						arg_125_1:RecordAudio("320251030", var_128_10)
						arg_125_1:RecordAudio("320251030", var_128_10)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320251", "320251030", "story_v_out_320251.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320251", "320251030", "story_v_out_320251.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_11 and arg_125_1.time_ < var_128_1 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320251031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320251031
		arg_129_1.duration_ = 13.83

		local var_129_0 = {
			zh = 8.8,
			ja = 13.833
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
				arg_129_0:Play320251032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.975

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[1021].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(320251031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 39
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251031", "story_v_out_320251.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251031", "story_v_out_320251.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_320251", "320251031", "story_v_out_320251.awb")

						arg_129_1:RecordAudio("320251031", var_132_9)
						arg_129_1:RecordAudio("320251031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_320251", "320251031", "story_v_out_320251.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_320251", "320251031", "story_v_out_320251.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play320251032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320251032
		arg_133_1.duration_ = 2.33

		local var_133_0 = {
			zh = 1.8,
			ja = 2.333
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
				arg_133_0:Play320251033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10100ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10100ui_story == nil then
				arg_133_1.var_.characterEffect10100ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10100ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10100ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10100ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10100ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 0.125

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[1066].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_9 = arg_133_1:GetWordFromCfg(320251032)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 5
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251032", "story_v_out_320251.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251032", "story_v_out_320251.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_out_320251", "320251032", "story_v_out_320251.awb")

						arg_133_1:RecordAudio("320251032", var_136_15)
						arg_133_1:RecordAudio("320251032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320251", "320251032", "story_v_out_320251.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320251", "320251032", "story_v_out_320251.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play320251033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320251033
		arg_137_1.duration_ = 12

		local var_137_0 = {
			zh = 9.8,
			ja = 12
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
				arg_137_0:Play320251034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10100ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10100ui_story == nil then
				arg_137_1.var_.characterEffect10100ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect10100ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10100ui_story then
				arg_137_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_140_4 = 0
			local var_140_5 = 1

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_6 = arg_137_1:FormatText(StoryNameCfg[1021].name)

				arg_137_1.leftNameTxt_.text = var_140_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(320251033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 40
				local var_140_10 = utf8.len(var_140_8)
				local var_140_11 = var_140_9 <= 0 and var_140_5 or var_140_5 * (var_140_10 / var_140_9)

				if var_140_11 > 0 and var_140_5 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251033", "story_v_out_320251.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251033", "story_v_out_320251.awb") / 1000

					if var_140_12 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_4
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_320251", "320251033", "story_v_out_320251.awb")

						arg_137_1:RecordAudio("320251033", var_140_13)
						arg_137_1:RecordAudio("320251033", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320251", "320251033", "story_v_out_320251.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320251", "320251033", "story_v_out_320251.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_14 and arg_137_1.time_ < var_140_4 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320251034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320251034
		arg_141_1.duration_ = 9.57

		local var_141_0 = {
			zh = 8.6,
			ja = 9.566
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
				arg_141_0:Play320251035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10100ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10100ui_story == nil then
				arg_141_1.var_.characterEffect10100ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10100ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10100ui_story then
				arg_141_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action5_2")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_144_6 = 0
			local var_144_7 = 1.225

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[1021].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(320251034)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 49
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251034", "story_v_out_320251.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_320251", "320251034", "story_v_out_320251.awb") / 1000

					if var_144_14 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_6
					end

					if var_144_9.prefab_name ~= "" and arg_141_1.actors_[var_144_9.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_9.prefab_name].transform, "story_v_out_320251", "320251034", "story_v_out_320251.awb")

						arg_141_1:RecordAudio("320251034", var_144_15)
						arg_141_1:RecordAudio("320251034", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320251", "320251034", "story_v_out_320251.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320251", "320251034", "story_v_out_320251.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_16 and arg_141_1.time_ < var_144_6 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play320251035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320251035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play320251036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10100ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10100ui_story == nil then
				arg_145_1.var_.characterEffect10100ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect10100ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10100ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10100ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10100ui_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 0.775

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(320251035)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 31
				local var_148_11 = utf8.len(var_148_9)
				local var_148_12 = var_148_10 <= 0 and var_148_7 or var_148_7 * (var_148_11 / var_148_10)

				if var_148_12 > 0 and var_148_7 < var_148_12 then
					arg_145_1.talkMaxDuration = var_148_12

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_13 and arg_145_1.time_ < var_148_6 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320251036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320251036
		arg_149_1.duration_ = 14.13

		local var_149_0 = {
			zh = 14.133,
			ja = 12.866
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320251037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10100ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10100ui_story == nil then
				arg_149_1.var_.characterEffect10100ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10100ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10100ui_story then
				arg_149_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_152_4 = 0
			local var_152_5 = 1.35

			if var_152_4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_6 = arg_149_1:FormatText(StoryNameCfg[1021].name)

				arg_149_1.leftNameTxt_.text = var_152_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:GetWordFromCfg(320251036)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 54
				local var_152_10 = utf8.len(var_152_8)
				local var_152_11 = var_152_9 <= 0 and var_152_5 or var_152_5 * (var_152_10 / var_152_9)

				if var_152_11 > 0 and var_152_5 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251036", "story_v_out_320251.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_320251", "320251036", "story_v_out_320251.awb") / 1000

					if var_152_12 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_4
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_320251", "320251036", "story_v_out_320251.awb")

						arg_149_1:RecordAudio("320251036", var_152_13)
						arg_149_1:RecordAudio("320251036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_320251", "320251036", "story_v_out_320251.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_320251", "320251036", "story_v_out_320251.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_14 and arg_149_1.time_ < var_152_4 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play320251037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320251037
		arg_153_1.duration_ = 9.4

		local var_153_0 = {
			zh = 8.766,
			ja = 9.4
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play320251038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.925

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[1021].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(320251037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 37
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251037", "story_v_out_320251.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251037", "story_v_out_320251.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_320251", "320251037", "story_v_out_320251.awb")

						arg_153_1:RecordAudio("320251037", var_156_9)
						arg_153_1:RecordAudio("320251037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320251", "320251037", "story_v_out_320251.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320251", "320251037", "story_v_out_320251.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play320251038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320251038
		arg_157_1.duration_ = 15.17

		local var_157_0 = {
			zh = 10.7,
			ja = 15.166
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320251039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action18_1")
			end

			local var_160_1 = 0
			local var_160_2 = 1.15

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_3 = arg_157_1:FormatText(StoryNameCfg[1021].name)

				arg_157_1.leftNameTxt_.text = var_160_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(320251038)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 46
				local var_160_7 = utf8.len(var_160_5)
				local var_160_8 = var_160_6 <= 0 and var_160_2 or var_160_2 * (var_160_7 / var_160_6)

				if var_160_8 > 0 and var_160_2 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251038", "story_v_out_320251.awb") ~= 0 then
					local var_160_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251038", "story_v_out_320251.awb") / 1000

					if var_160_9 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_1
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_out_320251", "320251038", "story_v_out_320251.awb")

						arg_157_1:RecordAudio("320251038", var_160_10)
						arg_157_1:RecordAudio("320251038", var_160_10)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_320251", "320251038", "story_v_out_320251.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_320251", "320251038", "story_v_out_320251.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_11 and arg_157_1.time_ < var_160_1 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320251039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320251039
		arg_161_1.duration_ = 14.7

		local var_161_0 = {
			zh = 13.033,
			ja = 14.7
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
				arg_161_0:Play320251040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.55

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[1021].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(320251039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 62
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251039", "story_v_out_320251.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251039", "story_v_out_320251.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_320251", "320251039", "story_v_out_320251.awb")

						arg_161_1:RecordAudio("320251039", var_164_9)
						arg_161_1:RecordAudio("320251039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320251", "320251039", "story_v_out_320251.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320251", "320251039", "story_v_out_320251.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play320251040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320251040
		arg_165_1.duration_ = 13.87

		local var_165_0 = {
			zh = 9.1,
			ja = 13.866
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play320251041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 1.25

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[1021].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(320251040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 50
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251040", "story_v_out_320251.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251040", "story_v_out_320251.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_320251", "320251040", "story_v_out_320251.awb")

						arg_165_1:RecordAudio("320251040", var_168_9)
						arg_165_1:RecordAudio("320251040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320251", "320251040", "story_v_out_320251.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320251", "320251040", "story_v_out_320251.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play320251041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320251041
		arg_169_1.duration_ = 14.3

		local var_169_0 = {
			zh = 11.5,
			ja = 14.3
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
				arg_169_0:Play320251042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action41821")
			end

			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_2 = 0
			local var_172_3 = 1.275

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_4 = arg_169_1:FormatText(StoryNameCfg[1021].name)

				arg_169_1.leftNameTxt_.text = var_172_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_5 = arg_169_1:GetWordFromCfg(320251041)
				local var_172_6 = arg_169_1:FormatText(var_172_5.content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 52
				local var_172_8 = utf8.len(var_172_6)
				local var_172_9 = var_172_7 <= 0 and var_172_3 or var_172_3 * (var_172_8 / var_172_7)

				if var_172_9 > 0 and var_172_3 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251041", "story_v_out_320251.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_320251", "320251041", "story_v_out_320251.awb") / 1000

					if var_172_10 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_2
					end

					if var_172_5.prefab_name ~= "" and arg_169_1.actors_[var_172_5.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_5.prefab_name].transform, "story_v_out_320251", "320251041", "story_v_out_320251.awb")

						arg_169_1:RecordAudio("320251041", var_172_11)
						arg_169_1:RecordAudio("320251041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320251", "320251041", "story_v_out_320251.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320251", "320251041", "story_v_out_320251.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_12 and arg_169_1.time_ < var_172_2 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320251042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320251042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320251043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10100ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10100ui_story == nil then
				arg_173_1.var_.characterEffect10100ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect10100ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10100ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10100ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10100ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0.333333333333333
			local var_176_7 = 1

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				local var_176_8 = "play"
				local var_176_9 = "effect"

				arg_173_1:AudioAction(var_176_8, var_176_9, "se_story_122_battle", "se_story_122_battle_adminshoot_hit", "")
			end

			local var_176_10 = 0.333333333333333
			local var_176_11 = 1

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				local var_176_12 = "play"
				local var_176_13 = "effect"

				arg_173_1:AudioAction(var_176_12, var_176_13, "se_story_127", "se_story_127_noise", "")
			end

			local var_176_14 = 0
			local var_176_15 = 1.35

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_16 = arg_173_1:GetWordFromCfg(320251042)
				local var_176_17 = arg_173_1:FormatText(var_176_16.content)

				arg_173_1.text_.text = var_176_17

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_18 = 54
				local var_176_19 = utf8.len(var_176_17)
				local var_176_20 = var_176_18 <= 0 and var_176_15 or var_176_15 * (var_176_19 / var_176_18)

				if var_176_20 > 0 and var_176_15 < var_176_20 then
					arg_173_1.talkMaxDuration = var_176_20

					if var_176_20 + var_176_14 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_14
					end
				end

				arg_173_1.text_.text = var_176_17
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_21 = math.max(var_176_15, arg_173_1.talkMaxDuration)

			if var_176_14 <= arg_173_1.time_ and arg_173_1.time_ < var_176_14 + var_176_21 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_14) / var_176_21

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_14 + var_176_21 and arg_173_1.time_ < var_176_14 + var_176_21 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320251043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320251043
		arg_177_1.duration_ = 8.43

		local var_177_0 = {
			zh = 8.433,
			ja = 7.533
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
				arg_177_0:Play320251044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10100ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10100ui_story == nil then
				arg_177_1.var_.characterEffect10100ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect10100ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10100ui_story then
				arg_177_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action21_2")
			end

			local var_180_5 = 0
			local var_180_6 = 1

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				local var_180_7 = "stop"
				local var_180_8 = "effect"

				arg_177_1:AudioAction(var_180_7, var_180_8, "se_story_127", "se_story_127_noise", "")
			end

			local var_180_9 = 0
			local var_180_10 = 1.175

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_11 = arg_177_1:FormatText(StoryNameCfg[1021].name)

				arg_177_1.leftNameTxt_.text = var_180_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_12 = arg_177_1:GetWordFromCfg(320251043)
				local var_180_13 = arg_177_1:FormatText(var_180_12.content)

				arg_177_1.text_.text = var_180_13

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_14 = 47
				local var_180_15 = utf8.len(var_180_13)
				local var_180_16 = var_180_14 <= 0 and var_180_10 or var_180_10 * (var_180_15 / var_180_14)

				if var_180_16 > 0 and var_180_10 < var_180_16 then
					arg_177_1.talkMaxDuration = var_180_16

					if var_180_16 + var_180_9 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_9
					end
				end

				arg_177_1.text_.text = var_180_13
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251043", "story_v_out_320251.awb") ~= 0 then
					local var_180_17 = manager.audio:GetVoiceLength("story_v_out_320251", "320251043", "story_v_out_320251.awb") / 1000

					if var_180_17 + var_180_9 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_17 + var_180_9
					end

					if var_180_12.prefab_name ~= "" and arg_177_1.actors_[var_180_12.prefab_name] ~= nil then
						local var_180_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_12.prefab_name].transform, "story_v_out_320251", "320251043", "story_v_out_320251.awb")

						arg_177_1:RecordAudio("320251043", var_180_18)
						arg_177_1:RecordAudio("320251043", var_180_18)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320251", "320251043", "story_v_out_320251.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320251", "320251043", "story_v_out_320251.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_19 = math.max(var_180_10, arg_177_1.talkMaxDuration)

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_19 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_9) / var_180_19

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_9 + var_180_19 and arg_177_1.time_ < var_180_9 + var_180_19 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320251044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320251044
		arg_181_1.duration_ = 5.57

		local var_181_0 = {
			zh = 3.833,
			ja = 5.566
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
				arg_181_0:Play320251045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.45

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[1021].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(320251044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 18
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251044", "story_v_out_320251.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251044", "story_v_out_320251.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_320251", "320251044", "story_v_out_320251.awb")

						arg_181_1:RecordAudio("320251044", var_184_9)
						arg_181_1:RecordAudio("320251044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320251", "320251044", "story_v_out_320251.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320251", "320251044", "story_v_out_320251.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play320251045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320251045
		arg_185_1.duration_ = 7.87

		local var_185_0 = {
			zh = 6.46733333518108,
			ja = 7.86733333518108
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
				arg_185_0:Play320251046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 2

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_1 = manager.ui.mainCamera.transform.localPosition
				local var_188_2 = Vector3.New(0, 0, 10) + Vector3.New(var_188_1.x, var_188_1.y, 0)
				local var_188_3 = arg_185_1.bgs_.ST61

				var_188_3.transform.localPosition = var_188_2
				var_188_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_4 = var_188_3:GetComponent("SpriteRenderer")

				if var_188_4 and var_188_4.sprite then
					local var_188_5 = (var_188_3.transform.localPosition - var_188_1).z
					local var_188_6 = manager.ui.mainCameraCom_
					local var_188_7 = 2 * var_188_5 * Mathf.Tan(var_188_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_188_8 = var_188_7 * var_188_6.aspect
					local var_188_9 = var_188_4.sprite.bounds.size.x
					local var_188_10 = var_188_4.sprite.bounds.size.y
					local var_188_11 = var_188_8 / var_188_9
					local var_188_12 = var_188_7 / var_188_10
					local var_188_13 = var_188_12 < var_188_11 and var_188_11 or var_188_12

					var_188_3.transform.localScale = Vector3.New(var_188_13, var_188_13, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "ST61" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_15 = 2

			if var_188_14 <= arg_185_1.time_ and arg_185_1.time_ < var_188_14 + var_188_15 then
				local var_188_16 = (arg_185_1.time_ - var_188_14) / var_188_15
				local var_188_17 = Color.New(0, 0, 0)

				var_188_17.a = Mathf.Lerp(0, 1, var_188_16)
				arg_185_1.mask_.color = var_188_17
			end

			if arg_185_1.time_ >= var_188_14 + var_188_15 and arg_185_1.time_ < var_188_14 + var_188_15 + arg_188_0 then
				local var_188_18 = Color.New(0, 0, 0)

				var_188_18.a = 1
				arg_185_1.mask_.color = var_188_18
			end

			local var_188_19 = 2

			if var_188_19 < arg_185_1.time_ and arg_185_1.time_ <= var_188_19 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_20 = 2

			if var_188_19 <= arg_185_1.time_ and arg_185_1.time_ < var_188_19 + var_188_20 then
				local var_188_21 = (arg_185_1.time_ - var_188_19) / var_188_20
				local var_188_22 = Color.New(0, 0, 0)

				var_188_22.a = Mathf.Lerp(1, 0, var_188_21)
				arg_185_1.mask_.color = var_188_22
			end

			if arg_185_1.time_ >= var_188_19 + var_188_20 and arg_185_1.time_ < var_188_19 + var_188_20 + arg_188_0 then
				local var_188_23 = Color.New(0, 0, 0)
				local var_188_24 = 0

				arg_185_1.mask_.enabled = false
				var_188_23.a = var_188_24
				arg_185_1.mask_.color = var_188_23
			end

			local var_188_25 = arg_185_1.actors_["10100ui_story"].transform
			local var_188_26 = 1.96666666666667

			if var_188_26 < arg_185_1.time_ and arg_185_1.time_ <= var_188_26 + arg_188_0 then
				arg_185_1.var_.moveOldPos10100ui_story = var_188_25.localPosition
			end

			local var_188_27 = 0.001

			if var_188_26 <= arg_185_1.time_ and arg_185_1.time_ < var_188_26 + var_188_27 then
				local var_188_28 = (arg_185_1.time_ - var_188_26) / var_188_27
				local var_188_29 = Vector3.New(0, 100, 0)

				var_188_25.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10100ui_story, var_188_29, var_188_28)

				local var_188_30 = manager.ui.mainCamera.transform.position - var_188_25.position

				var_188_25.forward = Vector3.New(var_188_30.x, var_188_30.y, var_188_30.z)

				local var_188_31 = var_188_25.localEulerAngles

				var_188_31.z = 0
				var_188_31.x = 0
				var_188_25.localEulerAngles = var_188_31
			end

			if arg_185_1.time_ >= var_188_26 + var_188_27 and arg_185_1.time_ < var_188_26 + var_188_27 + arg_188_0 then
				var_188_25.localPosition = Vector3.New(0, 100, 0)

				local var_188_32 = manager.ui.mainCamera.transform.position - var_188_25.position

				var_188_25.forward = Vector3.New(var_188_32.x, var_188_32.y, var_188_32.z)

				local var_188_33 = var_188_25.localEulerAngles

				var_188_33.z = 0
				var_188_33.x = 0
				var_188_25.localEulerAngles = var_188_33
			end

			local var_188_34 = arg_185_1.actors_["1089ui_story"].transform
			local var_188_35 = 3.73333333333333

			if var_188_35 < arg_185_1.time_ and arg_185_1.time_ <= var_188_35 + arg_188_0 then
				arg_185_1.var_.moveOldPos1089ui_story = var_188_34.localPosition
			end

			local var_188_36 = 0.001

			if var_188_35 <= arg_185_1.time_ and arg_185_1.time_ < var_188_35 + var_188_36 then
				local var_188_37 = (arg_185_1.time_ - var_188_35) / var_188_36
				local var_188_38 = Vector3.New(0, -1.1, -6.17)

				var_188_34.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1089ui_story, var_188_38, var_188_37)

				local var_188_39 = manager.ui.mainCamera.transform.position - var_188_34.position

				var_188_34.forward = Vector3.New(var_188_39.x, var_188_39.y, var_188_39.z)

				local var_188_40 = var_188_34.localEulerAngles

				var_188_40.z = 0
				var_188_40.x = 0
				var_188_34.localEulerAngles = var_188_40
			end

			if arg_185_1.time_ >= var_188_35 + var_188_36 and arg_185_1.time_ < var_188_35 + var_188_36 + arg_188_0 then
				var_188_34.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_188_41 = manager.ui.mainCamera.transform.position - var_188_34.position

				var_188_34.forward = Vector3.New(var_188_41.x, var_188_41.y, var_188_41.z)

				local var_188_42 = var_188_34.localEulerAngles

				var_188_42.z = 0
				var_188_42.x = 0
				var_188_34.localEulerAngles = var_188_42
			end

			local var_188_43 = arg_185_1.actors_["1089ui_story"]
			local var_188_44 = 3.73333333333333

			if var_188_44 < arg_185_1.time_ and arg_185_1.time_ <= var_188_44 + arg_188_0 and not isNil(var_188_43) and arg_185_1.var_.characterEffect1089ui_story == nil then
				arg_185_1.var_.characterEffect1089ui_story = var_188_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_45 = 0.200000002980232

			if var_188_44 <= arg_185_1.time_ and arg_185_1.time_ < var_188_44 + var_188_45 and not isNil(var_188_43) then
				local var_188_46 = (arg_185_1.time_ - var_188_44) / var_188_45

				if arg_185_1.var_.characterEffect1089ui_story and not isNil(var_188_43) then
					arg_185_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_44 + var_188_45 and arg_185_1.time_ < var_188_44 + var_188_45 + arg_188_0 and not isNil(var_188_43) and arg_185_1.var_.characterEffect1089ui_story then
				arg_185_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_188_47 = 3.73333333333333

			if var_188_47 < arg_185_1.time_ and arg_185_1.time_ <= var_188_47 + arg_188_0 then
				arg_185_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_188_48 = 3.73333333333333

			if var_188_48 < arg_185_1.time_ and arg_185_1.time_ <= var_188_48 + arg_188_0 then
				arg_185_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_49 = 3.76733333518108
			local var_188_50 = 0.325

			if var_188_49 < arg_185_1.time_ and arg_185_1.time_ <= var_188_49 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_51 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_51:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_52 = arg_185_1:FormatText(StoryNameCfg[1031].name)

				arg_185_1.leftNameTxt_.text = var_188_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_53 = arg_185_1:GetWordFromCfg(320251045)
				local var_188_54 = arg_185_1:FormatText(var_188_53.content)

				arg_185_1.text_.text = var_188_54

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_55 = 13
				local var_188_56 = utf8.len(var_188_54)
				local var_188_57 = var_188_55 <= 0 and var_188_50 or var_188_50 * (var_188_56 / var_188_55)

				if var_188_57 > 0 and var_188_50 < var_188_57 then
					arg_185_1.talkMaxDuration = var_188_57
					var_188_49 = var_188_49 + 0.3

					if var_188_57 + var_188_49 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_57 + var_188_49
					end
				end

				arg_185_1.text_.text = var_188_54
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251045", "story_v_out_320251.awb") ~= 0 then
					local var_188_58 = manager.audio:GetVoiceLength("story_v_out_320251", "320251045", "story_v_out_320251.awb") / 1000

					if var_188_58 + var_188_49 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_58 + var_188_49
					end

					if var_188_53.prefab_name ~= "" and arg_185_1.actors_[var_188_53.prefab_name] ~= nil then
						local var_188_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_53.prefab_name].transform, "story_v_out_320251", "320251045", "story_v_out_320251.awb")

						arg_185_1:RecordAudio("320251045", var_188_59)
						arg_185_1:RecordAudio("320251045", var_188_59)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320251", "320251045", "story_v_out_320251.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320251", "320251045", "story_v_out_320251.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_60 = var_188_49 + 0.3
			local var_188_61 = math.max(var_188_50, arg_185_1.talkMaxDuration)

			if var_188_60 <= arg_185_1.time_ and arg_185_1.time_ < var_188_60 + var_188_61 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_60) / var_188_61

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_60 + var_188_61 and arg_185_1.time_ < var_188_60 + var_188_61 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play320251046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 320251046
		arg_191_1.duration_ = 12.53

		local var_191_0 = {
			zh = 7.9,
			ja = 12.533
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
				arg_191_0:Play320251047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.85

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[1031].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(320251046)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 34
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251046", "story_v_out_320251.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251046", "story_v_out_320251.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_320251", "320251046", "story_v_out_320251.awb")

						arg_191_1:RecordAudio("320251046", var_194_9)
						arg_191_1:RecordAudio("320251046", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_320251", "320251046", "story_v_out_320251.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_320251", "320251046", "story_v_out_320251.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play320251047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 320251047
		arg_195_1.duration_ = 12.93

		local var_195_0 = {
			zh = 11.533,
			ja = 12.933
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play320251048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_198_1 = 0
			local var_198_2 = 1.4

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_3 = arg_195_1:FormatText(StoryNameCfg[1031].name)

				arg_195_1.leftNameTxt_.text = var_198_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(320251047)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_6 = 56
				local var_198_7 = utf8.len(var_198_5)
				local var_198_8 = var_198_6 <= 0 and var_198_2 or var_198_2 * (var_198_7 / var_198_6)

				if var_198_8 > 0 and var_198_2 < var_198_8 then
					arg_195_1.talkMaxDuration = var_198_8

					if var_198_8 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251047", "story_v_out_320251.awb") ~= 0 then
					local var_198_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251047", "story_v_out_320251.awb") / 1000

					if var_198_9 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_1
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_out_320251", "320251047", "story_v_out_320251.awb")

						arg_195_1:RecordAudio("320251047", var_198_10)
						arg_195_1:RecordAudio("320251047", var_198_10)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_320251", "320251047", "story_v_out_320251.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_320251", "320251047", "story_v_out_320251.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_11 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_11 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_11

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_11 and arg_195_1.time_ < var_198_1 + var_198_11 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play320251048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 320251048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play320251049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1089ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1089ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1089ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["1089ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1089ui_story == nil then
				arg_199_1.var_.characterEffect1089ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect1089ui_story and not isNil(var_202_9) then
					local var_202_13 = Mathf.Lerp(0, 0.5, var_202_12)

					arg_199_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1089ui_story.fillRatio = var_202_13
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect1089ui_story then
				local var_202_14 = 0.5

				arg_199_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1089ui_story.fillRatio = var_202_14
			end

			local var_202_15 = 0
			local var_202_16 = 0.975

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_17 = arg_199_1:GetWordFromCfg(320251048)
				local var_202_18 = arg_199_1:FormatText(var_202_17.content)

				arg_199_1.text_.text = var_202_18

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_19 = 39
				local var_202_20 = utf8.len(var_202_18)
				local var_202_21 = var_202_19 <= 0 and var_202_16 or var_202_16 * (var_202_20 / var_202_19)

				if var_202_21 > 0 and var_202_16 < var_202_21 then
					arg_199_1.talkMaxDuration = var_202_21

					if var_202_21 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_21 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_18
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_22 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_22 and arg_199_1.time_ < var_202_15 + var_202_22 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play320251049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 320251049
		arg_203_1.duration_ = 5.1

		local var_203_0 = {
			zh = 3.833,
			ja = 5.1
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play320251050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1056ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1056ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -1, -5.75)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1056ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1056ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1056ui_story == nil then
				arg_203_1.var_.characterEffect1056ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1056ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1056ui_story then
				arg_203_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_15 = 0
			local var_206_16 = 0.475

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[605].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(320251049)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 19
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251049", "story_v_out_320251.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_320251", "320251049", "story_v_out_320251.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_320251", "320251049", "story_v_out_320251.awb")

						arg_203_1:RecordAudio("320251049", var_206_24)
						arg_203_1:RecordAudio("320251049", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_320251", "320251049", "story_v_out_320251.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_320251", "320251049", "story_v_out_320251.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play320251050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 320251050
		arg_207_1.duration_ = 12.8

		local var_207_0 = {
			zh = 12.8,
			ja = 9.533
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
				arg_207_0:Play320251051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1089ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1089ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1089ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["1089ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1089ui_story == nil then
				arg_207_1.var_.characterEffect1089ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 and not isNil(var_210_9) then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect1089ui_story and not isNil(var_210_9) then
					arg_207_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and not isNil(var_210_9) and arg_207_1.var_.characterEffect1089ui_story then
				arg_207_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_210_13 = 0

			if var_210_13 < arg_207_1.time_ and arg_207_1.time_ <= var_210_13 + arg_210_0 then
				arg_207_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action432")
			end

			local var_210_14 = arg_207_1.actors_["1056ui_story"].transform
			local var_210_15 = 0

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.var_.moveOldPos1056ui_story = var_210_14.localPosition
			end

			local var_210_16 = 0.001

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_16 then
				local var_210_17 = (arg_207_1.time_ - var_210_15) / var_210_16
				local var_210_18 = Vector3.New(0.7, -1, -5.75)

				var_210_14.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1056ui_story, var_210_18, var_210_17)

				local var_210_19 = manager.ui.mainCamera.transform.position - var_210_14.position

				var_210_14.forward = Vector3.New(var_210_19.x, var_210_19.y, var_210_19.z)

				local var_210_20 = var_210_14.localEulerAngles

				var_210_20.z = 0
				var_210_20.x = 0
				var_210_14.localEulerAngles = var_210_20
			end

			if arg_207_1.time_ >= var_210_15 + var_210_16 and arg_207_1.time_ < var_210_15 + var_210_16 + arg_210_0 then
				var_210_14.localPosition = Vector3.New(0.7, -1, -5.75)

				local var_210_21 = manager.ui.mainCamera.transform.position - var_210_14.position

				var_210_14.forward = Vector3.New(var_210_21.x, var_210_21.y, var_210_21.z)

				local var_210_22 = var_210_14.localEulerAngles

				var_210_22.z = 0
				var_210_22.x = 0
				var_210_14.localEulerAngles = var_210_22
			end

			local var_210_23 = arg_207_1.actors_["1056ui_story"]
			local var_210_24 = 0

			if var_210_24 < arg_207_1.time_ and arg_207_1.time_ <= var_210_24 + arg_210_0 and not isNil(var_210_23) and arg_207_1.var_.characterEffect1056ui_story == nil then
				arg_207_1.var_.characterEffect1056ui_story = var_210_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_25 = 0.200000002980232

			if var_210_24 <= arg_207_1.time_ and arg_207_1.time_ < var_210_24 + var_210_25 and not isNil(var_210_23) then
				local var_210_26 = (arg_207_1.time_ - var_210_24) / var_210_25

				if arg_207_1.var_.characterEffect1056ui_story and not isNil(var_210_23) then
					local var_210_27 = Mathf.Lerp(0, 0.5, var_210_26)

					arg_207_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1056ui_story.fillRatio = var_210_27
				end
			end

			if arg_207_1.time_ >= var_210_24 + var_210_25 and arg_207_1.time_ < var_210_24 + var_210_25 + arg_210_0 and not isNil(var_210_23) and arg_207_1.var_.characterEffect1056ui_story then
				local var_210_28 = 0.5

				arg_207_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1056ui_story.fillRatio = var_210_28
			end

			local var_210_29 = 0
			local var_210_30 = 1.15

			if var_210_29 < arg_207_1.time_ and arg_207_1.time_ <= var_210_29 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_31 = arg_207_1:FormatText(StoryNameCfg[1031].name)

				arg_207_1.leftNameTxt_.text = var_210_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_32 = arg_207_1:GetWordFromCfg(320251050)
				local var_210_33 = arg_207_1:FormatText(var_210_32.content)

				arg_207_1.text_.text = var_210_33

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_34 = 46
				local var_210_35 = utf8.len(var_210_33)
				local var_210_36 = var_210_34 <= 0 and var_210_30 or var_210_30 * (var_210_35 / var_210_34)

				if var_210_36 > 0 and var_210_30 < var_210_36 then
					arg_207_1.talkMaxDuration = var_210_36

					if var_210_36 + var_210_29 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_36 + var_210_29
					end
				end

				arg_207_1.text_.text = var_210_33
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251050", "story_v_out_320251.awb") ~= 0 then
					local var_210_37 = manager.audio:GetVoiceLength("story_v_out_320251", "320251050", "story_v_out_320251.awb") / 1000

					if var_210_37 + var_210_29 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_29
					end

					if var_210_32.prefab_name ~= "" and arg_207_1.actors_[var_210_32.prefab_name] ~= nil then
						local var_210_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_32.prefab_name].transform, "story_v_out_320251", "320251050", "story_v_out_320251.awb")

						arg_207_1:RecordAudio("320251050", var_210_38)
						arg_207_1:RecordAudio("320251050", var_210_38)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_320251", "320251050", "story_v_out_320251.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_320251", "320251050", "story_v_out_320251.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_39 = math.max(var_210_30, arg_207_1.talkMaxDuration)

			if var_210_29 <= arg_207_1.time_ and arg_207_1.time_ < var_210_29 + var_210_39 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_29) / var_210_39

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_29 + var_210_39 and arg_207_1.time_ < var_210_29 + var_210_39 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play320251051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 320251051
		arg_211_1.duration_ = 3.9

		local var_211_0 = {
			zh = 3.9,
			ja = 2.366
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play320251052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1056ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1056ui_story == nil then
				arg_211_1.var_.characterEffect1056ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1056ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1056ui_story then
				arg_211_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_214_4 = 0

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action2_1")
			end

			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_214_6 = arg_211_1.actors_["1089ui_story"]
			local var_214_7 = 0

			if var_214_7 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect1089ui_story == nil then
				arg_211_1.var_.characterEffect1089ui_story = var_214_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_8 = 0.200000002980232

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_8 and not isNil(var_214_6) then
				local var_214_9 = (arg_211_1.time_ - var_214_7) / var_214_8

				if arg_211_1.var_.characterEffect1089ui_story and not isNil(var_214_6) then
					local var_214_10 = Mathf.Lerp(0, 0.5, var_214_9)

					arg_211_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1089ui_story.fillRatio = var_214_10
				end
			end

			if arg_211_1.time_ >= var_214_7 + var_214_8 and arg_211_1.time_ < var_214_7 + var_214_8 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect1089ui_story then
				local var_214_11 = 0.5

				arg_211_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1089ui_story.fillRatio = var_214_11
			end

			local var_214_12 = 0
			local var_214_13 = 0.275

			if var_214_12 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_14 = arg_211_1:FormatText(StoryNameCfg[605].name)

				arg_211_1.leftNameTxt_.text = var_214_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_15 = arg_211_1:GetWordFromCfg(320251051)
				local var_214_16 = arg_211_1:FormatText(var_214_15.content)

				arg_211_1.text_.text = var_214_16

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_17 = 11
				local var_214_18 = utf8.len(var_214_16)
				local var_214_19 = var_214_17 <= 0 and var_214_13 or var_214_13 * (var_214_18 / var_214_17)

				if var_214_19 > 0 and var_214_13 < var_214_19 then
					arg_211_1.talkMaxDuration = var_214_19

					if var_214_19 + var_214_12 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_19 + var_214_12
					end
				end

				arg_211_1.text_.text = var_214_16
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251051", "story_v_out_320251.awb") ~= 0 then
					local var_214_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251051", "story_v_out_320251.awb") / 1000

					if var_214_20 + var_214_12 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_20 + var_214_12
					end

					if var_214_15.prefab_name ~= "" and arg_211_1.actors_[var_214_15.prefab_name] ~= nil then
						local var_214_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_15.prefab_name].transform, "story_v_out_320251", "320251051", "story_v_out_320251.awb")

						arg_211_1:RecordAudio("320251051", var_214_21)
						arg_211_1:RecordAudio("320251051", var_214_21)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_320251", "320251051", "story_v_out_320251.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_320251", "320251051", "story_v_out_320251.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_22 = math.max(var_214_13, arg_211_1.talkMaxDuration)

			if var_214_12 <= arg_211_1.time_ and arg_211_1.time_ < var_214_12 + var_214_22 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_12) / var_214_22

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_12 + var_214_22 and arg_211_1.time_ < var_214_12 + var_214_22 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play320251052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 320251052
		arg_215_1.duration_ = 13.3

		local var_215_0 = {
			zh = 11.5,
			ja = 13.3
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
				arg_215_0:Play320251053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1056ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1056ui_story == nil then
				arg_215_1.var_.characterEffect1056ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1056ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1056ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1056ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1056ui_story.fillRatio = var_218_5
			end

			local var_218_6 = arg_215_1.actors_["1089ui_story"]
			local var_218_7 = 0

			if var_218_7 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect1089ui_story == nil then
				arg_215_1.var_.characterEffect1089ui_story = var_218_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_8 = 0.200000002980232

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_8 and not isNil(var_218_6) then
				local var_218_9 = (arg_215_1.time_ - var_218_7) / var_218_8

				if arg_215_1.var_.characterEffect1089ui_story and not isNil(var_218_6) then
					arg_215_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_7 + var_218_8 and arg_215_1.time_ < var_218_7 + var_218_8 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect1089ui_story then
				arg_215_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_218_11 = 0

			if var_218_11 < arg_215_1.time_ and arg_215_1.time_ <= var_218_11 + arg_218_0 then
				arg_215_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_218_12 = 0
			local var_218_13 = 1.15

			if var_218_12 < arg_215_1.time_ and arg_215_1.time_ <= var_218_12 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_14 = arg_215_1:FormatText(StoryNameCfg[1031].name)

				arg_215_1.leftNameTxt_.text = var_218_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_15 = arg_215_1:GetWordFromCfg(320251052)
				local var_218_16 = arg_215_1:FormatText(var_218_15.content)

				arg_215_1.text_.text = var_218_16

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_17 = 46
				local var_218_18 = utf8.len(var_218_16)
				local var_218_19 = var_218_17 <= 0 and var_218_13 or var_218_13 * (var_218_18 / var_218_17)

				if var_218_19 > 0 and var_218_13 < var_218_19 then
					arg_215_1.talkMaxDuration = var_218_19

					if var_218_19 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_19 + var_218_12
					end
				end

				arg_215_1.text_.text = var_218_16
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251052", "story_v_out_320251.awb") ~= 0 then
					local var_218_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251052", "story_v_out_320251.awb") / 1000

					if var_218_20 + var_218_12 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_20 + var_218_12
					end

					if var_218_15.prefab_name ~= "" and arg_215_1.actors_[var_218_15.prefab_name] ~= nil then
						local var_218_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_15.prefab_name].transform, "story_v_out_320251", "320251052", "story_v_out_320251.awb")

						arg_215_1:RecordAudio("320251052", var_218_21)
						arg_215_1:RecordAudio("320251052", var_218_21)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_320251", "320251052", "story_v_out_320251.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_320251", "320251052", "story_v_out_320251.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = math.max(var_218_13, arg_215_1.talkMaxDuration)

			if var_218_12 <= arg_215_1.time_ and arg_215_1.time_ < var_218_12 + var_218_22 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_12) / var_218_22

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_12 + var_218_22 and arg_215_1.time_ < var_218_12 + var_218_22 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play320251053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 320251053
		arg_219_1.duration_ = 11.37

		local var_219_0 = {
			zh = 8.4,
			ja = 11.366
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
				arg_219_0:Play320251054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_222_1 = 0
			local var_222_2 = 0.825

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_3 = arg_219_1:FormatText(StoryNameCfg[1031].name)

				arg_219_1.leftNameTxt_.text = var_222_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(320251053)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_6 = 33
				local var_222_7 = utf8.len(var_222_5)
				local var_222_8 = var_222_6 <= 0 and var_222_2 or var_222_2 * (var_222_7 / var_222_6)

				if var_222_8 > 0 and var_222_2 < var_222_8 then
					arg_219_1.talkMaxDuration = var_222_8

					if var_222_8 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251053", "story_v_out_320251.awb") ~= 0 then
					local var_222_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251053", "story_v_out_320251.awb") / 1000

					if var_222_9 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_1
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_320251", "320251053", "story_v_out_320251.awb")

						arg_219_1:RecordAudio("320251053", var_222_10)
						arg_219_1:RecordAudio("320251053", var_222_10)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_320251", "320251053", "story_v_out_320251.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_320251", "320251053", "story_v_out_320251.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_11 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_11 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_11

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_11 and arg_219_1.time_ < var_222_1 + var_222_11 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play320251054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 320251054
		arg_223_1.duration_ = 5.73

		local var_223_0 = {
			zh = 5.69933333333333,
			ja = 5.73333333333333
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
				arg_223_0:Play320251055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 2

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				local var_226_1 = manager.ui.mainCamera.transform.localPosition
				local var_226_2 = Vector3.New(0, 0, 10) + Vector3.New(var_226_1.x, var_226_1.y, 0)
				local var_226_3 = arg_223_1.bgs_.L02f

				var_226_3.transform.localPosition = var_226_2
				var_226_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_4 = var_226_3:GetComponent("SpriteRenderer")

				if var_226_4 and var_226_4.sprite then
					local var_226_5 = (var_226_3.transform.localPosition - var_226_1).z
					local var_226_6 = manager.ui.mainCameraCom_
					local var_226_7 = 2 * var_226_5 * Mathf.Tan(var_226_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_226_8 = var_226_7 * var_226_6.aspect
					local var_226_9 = var_226_4.sprite.bounds.size.x
					local var_226_10 = var_226_4.sprite.bounds.size.y
					local var_226_11 = var_226_8 / var_226_9
					local var_226_12 = var_226_7 / var_226_10
					local var_226_13 = var_226_12 < var_226_11 and var_226_11 or var_226_12

					var_226_3.transform.localScale = Vector3.New(var_226_13, var_226_13, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "L02f" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_14 = 0

			if var_226_14 < arg_223_1.time_ and arg_223_1.time_ <= var_226_14 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			local var_226_15 = 0.3

			if arg_223_1.time_ >= var_226_14 + var_226_15 and arg_223_1.time_ < var_226_14 + var_226_15 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_17 = 2

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 then
				local var_226_18 = (arg_223_1.time_ - var_226_16) / var_226_17
				local var_226_19 = Color.New(0, 0, 0)

				var_226_19.a = Mathf.Lerp(0, 1, var_226_18)
				arg_223_1.mask_.color = var_226_19
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 then
				local var_226_20 = Color.New(0, 0, 0)

				var_226_20.a = 1
				arg_223_1.mask_.color = var_226_20
			end

			local var_226_21 = 2

			if var_226_21 < arg_223_1.time_ and arg_223_1.time_ <= var_226_21 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_22 = 1.43333333333333

			if var_226_21 <= arg_223_1.time_ and arg_223_1.time_ < var_226_21 + var_226_22 then
				local var_226_23 = (arg_223_1.time_ - var_226_21) / var_226_22
				local var_226_24 = Color.New(0, 0, 0)

				var_226_24.a = Mathf.Lerp(1, 0, var_226_23)
				arg_223_1.mask_.color = var_226_24
			end

			if arg_223_1.time_ >= var_226_21 + var_226_22 and arg_223_1.time_ < var_226_21 + var_226_22 + arg_226_0 then
				local var_226_25 = Color.New(0, 0, 0)
				local var_226_26 = 0

				arg_223_1.mask_.enabled = false
				var_226_25.a = var_226_26
				arg_223_1.mask_.color = var_226_25
			end

			local var_226_27 = arg_223_1.actors_["1056ui_story"].transform
			local var_226_28 = 1.96666666666667

			if var_226_28 < arg_223_1.time_ and arg_223_1.time_ <= var_226_28 + arg_226_0 then
				arg_223_1.var_.moveOldPos1056ui_story = var_226_27.localPosition
			end

			local var_226_29 = 0.001

			if var_226_28 <= arg_223_1.time_ and arg_223_1.time_ < var_226_28 + var_226_29 then
				local var_226_30 = (arg_223_1.time_ - var_226_28) / var_226_29
				local var_226_31 = Vector3.New(0, 100, 0)

				var_226_27.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1056ui_story, var_226_31, var_226_30)

				local var_226_32 = manager.ui.mainCamera.transform.position - var_226_27.position

				var_226_27.forward = Vector3.New(var_226_32.x, var_226_32.y, var_226_32.z)

				local var_226_33 = var_226_27.localEulerAngles

				var_226_33.z = 0
				var_226_33.x = 0
				var_226_27.localEulerAngles = var_226_33
			end

			if arg_223_1.time_ >= var_226_28 + var_226_29 and arg_223_1.time_ < var_226_28 + var_226_29 + arg_226_0 then
				var_226_27.localPosition = Vector3.New(0, 100, 0)

				local var_226_34 = manager.ui.mainCamera.transform.position - var_226_27.position

				var_226_27.forward = Vector3.New(var_226_34.x, var_226_34.y, var_226_34.z)

				local var_226_35 = var_226_27.localEulerAngles

				var_226_35.z = 0
				var_226_35.x = 0
				var_226_27.localEulerAngles = var_226_35
			end

			local var_226_36 = arg_223_1.actors_["1089ui_story"].transform
			local var_226_37 = 1.96666666666667

			if var_226_37 < arg_223_1.time_ and arg_223_1.time_ <= var_226_37 + arg_226_0 then
				arg_223_1.var_.moveOldPos1089ui_story = var_226_36.localPosition
			end

			local var_226_38 = 0.001

			if var_226_37 <= arg_223_1.time_ and arg_223_1.time_ < var_226_37 + var_226_38 then
				local var_226_39 = (arg_223_1.time_ - var_226_37) / var_226_38
				local var_226_40 = Vector3.New(0, 100, 0)

				var_226_36.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1089ui_story, var_226_40, var_226_39)

				local var_226_41 = manager.ui.mainCamera.transform.position - var_226_36.position

				var_226_36.forward = Vector3.New(var_226_41.x, var_226_41.y, var_226_41.z)

				local var_226_42 = var_226_36.localEulerAngles

				var_226_42.z = 0
				var_226_42.x = 0
				var_226_36.localEulerAngles = var_226_42
			end

			if arg_223_1.time_ >= var_226_37 + var_226_38 and arg_223_1.time_ < var_226_37 + var_226_38 + arg_226_0 then
				var_226_36.localPosition = Vector3.New(0, 100, 0)

				local var_226_43 = manager.ui.mainCamera.transform.position - var_226_36.position

				var_226_36.forward = Vector3.New(var_226_43.x, var_226_43.y, var_226_43.z)

				local var_226_44 = var_226_36.localEulerAngles

				var_226_44.z = 0
				var_226_44.x = 0
				var_226_36.localEulerAngles = var_226_44
			end

			local var_226_45 = 1.76666666666667
			local var_226_46 = 1

			if var_226_45 < arg_223_1.time_ and arg_223_1.time_ <= var_226_45 + arg_226_0 then
				local var_226_47 = "play"
				local var_226_48 = "music"

				arg_223_1:AudioAction(var_226_47, var_226_48, "se_story_15", "se_story_15_gun07", "")

				local var_226_49 = ""
				local var_226_50 = manager.audio:GetAudioName("se_story_15", "se_story_15_gun07")

				if var_226_50 ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_50 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_50

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_50
						arg_223_1.bgmTxt2_.text = var_226_50
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_226_51 = 0
			local var_226_52 = 0.2

			if var_226_51 < arg_223_1.time_ and arg_223_1.time_ <= var_226_51 + arg_226_0 then
				local var_226_53 = "play"
				local var_226_54 = "music"

				arg_223_1:AudioAction(var_226_53, var_226_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_226_55 = ""
				local var_226_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_226_56 ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_56 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_56

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_56
						arg_223_1.bgmTxt2_.text = var_226_56
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_226_57 = 1.33333333333333
			local var_226_58 = 1

			if var_226_57 < arg_223_1.time_ and arg_223_1.time_ <= var_226_57 + arg_226_0 then
				local var_226_59 = "play"
				local var_226_60 = "music"

				arg_223_1:AudioAction(var_226_59, var_226_60, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_226_61 = ""
				local var_226_62 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_226_62 ~= "" then
					if arg_223_1.bgmTxt_.text ~= var_226_62 and arg_223_1.bgmTxt_.text ~= "" then
						if arg_223_1.bgmTxt2_.text ~= "" then
							arg_223_1.bgmTxt_.text = arg_223_1.bgmTxt2_.text
						end

						arg_223_1.bgmTxt2_.text = var_226_62

						arg_223_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_223_1.bgmTxt_.text = var_226_62
						arg_223_1.bgmTxt2_.text = var_226_62
					end

					if arg_223_1.bgmTimer then
						arg_223_1.bgmTimer:Stop()

						arg_223_1.bgmTimer = nil
					end

					if arg_223_1.settingData.show_music_name == 1 then
						arg_223_1.musicController:SetSelectedState("show")
						arg_223_1.musicAnimator_:Play("open", 0, 0)

						if arg_223_1.settingData.music_time ~= 0 then
							arg_223_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_223_1.settingData.music_time), function()
								if arg_223_1 == nil or isNil(arg_223_1.bgmTxt_) then
									return
								end

								arg_223_1.musicController:SetSelectedState("hide")
								arg_223_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_63 = 3.43333333333333
			local var_226_64 = 0.3

			if var_226_63 < arg_223_1.time_ and arg_223_1.time_ <= var_226_63 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_65 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_65:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_223_1.dialogCg_.alpha = arg_230_0
				end))
				var_226_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_66 = arg_223_1:FormatText(StoryNameCfg[1066].name)

				arg_223_1.leftNameTxt_.text = var_226_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_67 = arg_223_1:GetWordFromCfg(320251054)
				local var_226_68 = arg_223_1:FormatText(var_226_67.content)

				arg_223_1.text_.text = var_226_68

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_69 = 12
				local var_226_70 = utf8.len(var_226_68)
				local var_226_71 = var_226_69 <= 0 and var_226_64 or var_226_64 * (var_226_70 / var_226_69)

				if var_226_71 > 0 and var_226_64 < var_226_71 then
					arg_223_1.talkMaxDuration = var_226_71
					var_226_63 = var_226_63 + 0.3

					if var_226_71 + var_226_63 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_71 + var_226_63
					end
				end

				arg_223_1.text_.text = var_226_68
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251054", "story_v_out_320251.awb") ~= 0 then
					local var_226_72 = manager.audio:GetVoiceLength("story_v_out_320251", "320251054", "story_v_out_320251.awb") / 1000

					if var_226_72 + var_226_63 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_72 + var_226_63
					end

					if var_226_67.prefab_name ~= "" and arg_223_1.actors_[var_226_67.prefab_name] ~= nil then
						local var_226_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_67.prefab_name].transform, "story_v_out_320251", "320251054", "story_v_out_320251.awb")

						arg_223_1:RecordAudio("320251054", var_226_73)
						arg_223_1:RecordAudio("320251054", var_226_73)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_320251", "320251054", "story_v_out_320251.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_320251", "320251054", "story_v_out_320251.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_74 = var_226_63 + 0.3
			local var_226_75 = math.max(var_226_64, arg_223_1.talkMaxDuration)

			if var_226_74 <= arg_223_1.time_ and arg_223_1.time_ < var_226_74 + var_226_75 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_74) / var_226_75

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_74 + var_226_75 and arg_223_1.time_ < var_226_74 + var_226_75 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play320251055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 320251055
		arg_232_1.duration_ = 4.3

		local var_232_0 = {
			zh = 4.233,
			ja = 4.3
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play320251056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.6

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_2 = arg_232_1:FormatText(StoryNameCfg[1035].name)

				arg_232_1.leftNameTxt_.text = var_235_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:GetWordFromCfg(320251055)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 24
				local var_235_6 = utf8.len(var_235_4)
				local var_235_7 = var_235_5 <= 0 and var_235_1 or var_235_1 * (var_235_6 / var_235_5)

				if var_235_7 > 0 and var_235_1 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251055", "story_v_out_320251.awb") ~= 0 then
					local var_235_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251055", "story_v_out_320251.awb") / 1000

					if var_235_8 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_8 + var_235_0
					end

					if var_235_3.prefab_name ~= "" and arg_232_1.actors_[var_235_3.prefab_name] ~= nil then
						local var_235_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_3.prefab_name].transform, "story_v_out_320251", "320251055", "story_v_out_320251.awb")

						arg_232_1:RecordAudio("320251055", var_235_9)
						arg_232_1:RecordAudio("320251055", var_235_9)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_320251", "320251055", "story_v_out_320251.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_320251", "320251055", "story_v_out_320251.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_10 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_10 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_10

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_10 and arg_232_1.time_ < var_235_0 + var_235_10 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play320251056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 320251056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play320251057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 1.3

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_2 = arg_236_1:GetWordFromCfg(320251056)
				local var_239_3 = arg_236_1:FormatText(var_239_2.content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 52
				local var_239_5 = utf8.len(var_239_3)
				local var_239_6 = var_239_4 <= 0 and var_239_1 or var_239_1 * (var_239_5 / var_239_4)

				if var_239_6 > 0 and var_239_1 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_7 and arg_236_1.time_ < var_239_0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play320251057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 320251057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play320251058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 1.025

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(320251057)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 41
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_7 and arg_240_1.time_ < var_243_0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play320251058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 320251058
		arg_244_1.duration_ = 2.93

		local var_244_0 = {
			zh = 2.8,
			ja = 2.933
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
				arg_244_0:Play320251059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.275

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[1035].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(320251058)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 11
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251058", "story_v_out_320251.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251058", "story_v_out_320251.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_320251", "320251058", "story_v_out_320251.awb")

						arg_244_1:RecordAudio("320251058", var_247_9)
						arg_244_1:RecordAudio("320251058", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_320251", "320251058", "story_v_out_320251.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_320251", "320251058", "story_v_out_320251.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_10 and arg_244_1.time_ < var_247_0 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play320251059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 320251059
		arg_248_1.duration_ = 4.23

		local var_248_0 = {
			zh = 3.533,
			ja = 4.233
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
				arg_248_0:Play320251060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.175

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[36].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(320251059)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251059", "story_v_out_320251.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251059", "story_v_out_320251.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_320251", "320251059", "story_v_out_320251.awb")

						arg_248_1:RecordAudio("320251059", var_251_9)
						arg_248_1:RecordAudio("320251059", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_320251", "320251059", "story_v_out_320251.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_320251", "320251059", "story_v_out_320251.awb")
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
	Play320251060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 320251060
		arg_252_1.duration_ = 6.37

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play320251061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_1 = 1

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_1 then
				local var_255_2 = (arg_252_1.time_ - var_255_0) / var_255_1
				local var_255_3 = Color.New(1, 1, 1)

				var_255_3.a = Mathf.Lerp(1, 0, var_255_2)
				arg_252_1.mask_.color = var_255_3
			end

			if arg_252_1.time_ >= var_255_0 + var_255_1 and arg_252_1.time_ < var_255_0 + var_255_1 + arg_255_0 then
				local var_255_4 = Color.New(1, 1, 1)
				local var_255_5 = 0

				arg_252_1.mask_.enabled = false
				var_255_4.a = var_255_5
				arg_252_1.mask_.color = var_255_4
			end

			local var_255_6 = 0.333333333333333
			local var_255_7 = 1

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				local var_255_8 = "play"
				local var_255_9 = "effect"

				arg_252_1:AudioAction(var_255_8, var_255_9, "se_story_123_01", "se_story_123_01_gun", "")
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_10 = 1.36666666666667
			local var_255_11 = 1.05

			if var_255_10 < arg_252_1.time_ and arg_252_1.time_ <= var_255_10 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_12 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_12:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_13 = arg_252_1:GetWordFromCfg(320251060)
				local var_255_14 = arg_252_1:FormatText(var_255_13.content)

				arg_252_1.text_.text = var_255_14

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_15 = 42
				local var_255_16 = utf8.len(var_255_14)
				local var_255_17 = var_255_15 <= 0 and var_255_11 or var_255_11 * (var_255_16 / var_255_15)

				if var_255_17 > 0 and var_255_11 < var_255_17 then
					arg_252_1.talkMaxDuration = var_255_17
					var_255_10 = var_255_10 + 0.3

					if var_255_17 + var_255_10 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_17 + var_255_10
					end
				end

				arg_252_1.text_.text = var_255_14
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_18 = var_255_10 + 0.3
			local var_255_19 = math.max(var_255_11, arg_252_1.talkMaxDuration)

			if var_255_18 <= arg_252_1.time_ and arg_252_1.time_ < var_255_18 + var_255_19 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_18) / var_255_19

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_18 + var_255_19 and arg_252_1.time_ < var_255_18 + var_255_19 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play320251061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 320251061
		arg_258_1.duration_ = 4.1

		local var_258_0 = {
			zh = 3.8,
			ja = 4.1
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
				arg_258_0:Play320251062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.45

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[1066].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:GetWordFromCfg(320251061)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 18
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251061", "story_v_out_320251.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251061", "story_v_out_320251.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_out_320251", "320251061", "story_v_out_320251.awb")

						arg_258_1:RecordAudio("320251061", var_261_9)
						arg_258_1:RecordAudio("320251061", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_320251", "320251061", "story_v_out_320251.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_320251", "320251061", "story_v_out_320251.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play320251062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 320251062
		arg_262_1.duration_ = 6.13

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play320251063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = manager.ui.mainCamera.transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				local var_265_2 = arg_262_1.var_.effect777
				local var_265_3
				local var_265_4 = var_265_0

				if not var_265_2 then
					var_265_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning"), var_265_4)
					var_265_2.name = "777"
					arg_262_1.var_.effect777 = var_265_2
				else
					var_265_2.transform:SetParent(var_265_4)
				end

				var_265_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_265_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_265_5 = manager.ui.mainCamera.transform
			local var_265_6 = 0

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				local var_265_7 = arg_262_1.var_.effect888
				local var_265_8
				local var_265_9 = var_265_5

				if not var_265_7 then
					var_265_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), var_265_9)
					var_265_7.name = "888"
					arg_262_1.var_.effect888 = var_265_7
				else
					var_265_7.transform:SetParent(var_265_9)
				end

				var_265_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_265_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_11 = 1

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / var_265_11
				local var_265_13 = Color.New(0.4433962, 0.04392132, 0.04392132)

				var_265_13.a = Mathf.Lerp(1, 0, var_265_12)
				arg_262_1.mask_.color = var_265_13
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 then
				local var_265_14 = Color.New(0.4433962, 0.04392132, 0.04392132)
				local var_265_15 = 0

				arg_262_1.mask_.enabled = false
				var_265_14.a = var_265_15
				arg_262_1.mask_.color = var_265_14
			end

			local var_265_16 = 0

			if var_265_16 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			local var_265_17 = 1.5

			if arg_262_1.time_ >= var_265_16 + var_265_17 and arg_262_1.time_ < var_265_16 + var_265_17 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			local var_265_18 = 0.266666666666667
			local var_265_19 = 1

			if var_265_18 < arg_262_1.time_ and arg_262_1.time_ <= var_265_18 + arg_265_0 then
				local var_265_20 = "play"
				local var_265_21 = "effect"

				arg_262_1:AudioAction(var_265_20, var_265_21, "se_story_15", "se_story_15_gun02", "")
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_22 = 1.13333333333333
			local var_265_23 = 1.5

			if var_265_22 < arg_262_1.time_ and arg_262_1.time_ <= var_265_22 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_24 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_24:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_25 = arg_262_1:GetWordFromCfg(320251062)
				local var_265_26 = arg_262_1:FormatText(var_265_25.content)

				arg_262_1.text_.text = var_265_26

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_27 = 60
				local var_265_28 = utf8.len(var_265_26)
				local var_265_29 = var_265_27 <= 0 and var_265_23 or var_265_23 * (var_265_28 / var_265_27)

				if var_265_29 > 0 and var_265_23 < var_265_29 then
					arg_262_1.talkMaxDuration = var_265_29
					var_265_22 = var_265_22 + 0.3

					if var_265_29 + var_265_22 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_29 + var_265_22
					end
				end

				arg_262_1.text_.text = var_265_26
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_30 = var_265_22 + 0.3
			local var_265_31 = math.max(var_265_23, arg_262_1.talkMaxDuration)

			if var_265_30 <= arg_262_1.time_ and arg_262_1.time_ < var_265_30 + var_265_31 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_30) / var_265_31

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_30 + var_265_31 and arg_262_1.time_ < var_265_30 + var_265_31 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play320251063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 320251063
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play320251064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 1.375

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_2 = arg_268_1:GetWordFromCfg(320251063)
				local var_271_3 = arg_268_1:FormatText(var_271_2.content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 55
				local var_271_5 = utf8.len(var_271_3)
				local var_271_6 = var_271_4 <= 0 and var_271_1 or var_271_1 * (var_271_5 / var_271_4)

				if var_271_6 > 0 and var_271_1 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_7 and arg_268_1.time_ < var_271_0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play320251064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 320251064
		arg_272_1.duration_ = 1.43

		local var_272_0 = {
			zh = 1.433,
			ja = 1.2
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play320251065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.075

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[1066].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(320251064)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 3
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251064", "story_v_out_320251.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251064", "story_v_out_320251.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_320251", "320251064", "story_v_out_320251.awb")

						arg_272_1:RecordAudio("320251064", var_275_9)
						arg_272_1:RecordAudio("320251064", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_320251", "320251064", "story_v_out_320251.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_320251", "320251064", "story_v_out_320251.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play320251065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 320251065
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play320251066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 1

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				local var_279_2 = "play"
				local var_279_3 = "music"

				arg_276_1:AudioAction(var_279_2, var_279_3, "se_story_side_1148", "se_story_1148_explosion", "")

				local var_279_4 = ""
				local var_279_5 = manager.audio:GetAudioName("se_story_side_1148", "se_story_1148_explosion")

				if var_279_5 ~= "" then
					if arg_276_1.bgmTxt_.text ~= var_279_5 and arg_276_1.bgmTxt_.text ~= "" then
						if arg_276_1.bgmTxt2_.text ~= "" then
							arg_276_1.bgmTxt_.text = arg_276_1.bgmTxt2_.text
						end

						arg_276_1.bgmTxt2_.text = var_279_5

						arg_276_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_276_1.bgmTxt_.text = var_279_5
						arg_276_1.bgmTxt2_.text = var_279_5
					end

					if arg_276_1.bgmTimer then
						arg_276_1.bgmTimer:Stop()

						arg_276_1.bgmTimer = nil
					end

					if arg_276_1.settingData.show_music_name == 1 then
						arg_276_1.musicController:SetSelectedState("show")
						arg_276_1.musicAnimator_:Play("open", 0, 0)

						if arg_276_1.settingData.music_time ~= 0 then
							arg_276_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_276_1.settingData.music_time), function()
								if arg_276_1 == nil or isNil(arg_276_1.bgmTxt_) then
									return
								end

								arg_276_1.musicController:SetSelectedState("hide")
								arg_276_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_279_6 = 0
			local var_279_7 = 0.8

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_8 = arg_276_1:GetWordFromCfg(320251065)
				local var_279_9 = arg_276_1:FormatText(var_279_8.content)

				arg_276_1.text_.text = var_279_9

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 32
				local var_279_11 = utf8.len(var_279_9)
				local var_279_12 = var_279_10 <= 0 and var_279_7 or var_279_7 * (var_279_11 / var_279_10)

				if var_279_12 > 0 and var_279_7 < var_279_12 then
					arg_276_1.talkMaxDuration = var_279_12

					if var_279_12 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_12 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_9
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_13 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_13 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_13

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_13 and arg_276_1.time_ < var_279_6 + var_279_13 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play320251066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320251066
		arg_281_1.duration_ = 3.03

		local var_281_0 = {
			zh = 2.133,
			ja = 3.033
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
				arg_281_0:Play320251067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.175

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[1035].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(320251066)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251066", "story_v_out_320251.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251066", "story_v_out_320251.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_320251", "320251066", "story_v_out_320251.awb")

						arg_281_1:RecordAudio("320251066", var_284_9)
						arg_281_1:RecordAudio("320251066", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320251", "320251066", "story_v_out_320251.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320251", "320251066", "story_v_out_320251.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320251067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320251067
		arg_285_1.duration_ = 5.57

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play320251068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_1 = 0.166666666666667

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_1 then
				local var_288_2 = (arg_285_1.time_ - var_288_0) / var_288_1
				local var_288_3 = Color.New(1, 1, 1)

				var_288_3.a = Mathf.Lerp(1, 0, var_288_2)
				arg_285_1.mask_.color = var_288_3
			end

			if arg_285_1.time_ >= var_288_0 + var_288_1 and arg_285_1.time_ < var_288_0 + var_288_1 + arg_288_0 then
				local var_288_4 = Color.New(1, 1, 1)
				local var_288_5 = 0

				arg_285_1.mask_.enabled = false
				var_288_4.a = var_288_5
				arg_285_1.mask_.color = var_288_4
			end

			local var_288_6 = manager.ui.mainCamera.transform
			local var_288_7 = 0.166666666666667

			if var_288_7 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 then
				arg_285_1.var_.shakeOldPos = var_288_6.localPosition
			end

			local var_288_8 = 0.566666666666667

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_8 then
				local var_288_9 = (arg_285_1.time_ - var_288_7) / 0.066
				local var_288_10, var_288_11 = math.modf(var_288_9)

				var_288_6.localPosition = Vector3.New(var_288_11 * 0.13, var_288_11 * 0.13, var_288_11 * 0.13) + arg_285_1.var_.shakeOldPos
			end

			if arg_285_1.time_ >= var_288_7 + var_288_8 and arg_285_1.time_ < var_288_7 + var_288_8 + arg_288_0 then
				var_288_6.localPosition = arg_285_1.var_.shakeOldPos
			end

			local var_288_12 = 0.166666666666667
			local var_288_13 = 1

			if var_288_12 < arg_285_1.time_ and arg_285_1.time_ <= var_288_12 + arg_288_0 then
				local var_288_14 = "play"
				local var_288_15 = "effect"

				arg_285_1:AudioAction(var_288_14, var_288_15, "se_story_122_01", "se_story_122_01_signal", "")
			end

			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.allBtn_.enabled = false
			end

			local var_288_17 = 0.733333333333333

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 then
				arg_285_1.allBtn_.enabled = true
			end

			if arg_285_1.frameCnt_ <= 1 then
				arg_285_1.dialog_:SetActive(false)
			end

			local var_288_18 = 0.566666666666667
			local var_288_19 = 0.9

			if var_288_18 < arg_285_1.time_ and arg_285_1.time_ <= var_288_18 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				arg_285_1.dialog_:SetActive(true)

				arg_285_1.dialogCg_.alpha = 0

				local var_288_20 = LeanTween.value(arg_285_1.dialog_, 0, 1, 0.3)

				var_288_20:setOnUpdate(LuaHelper.FloatAction(function(arg_289_0)
					arg_285_1.dialogCg_.alpha = arg_289_0
				end))
				var_288_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_285_1.dialog_)
					var_288_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_285_1.duration_ = arg_285_1.duration_ + 0.3

				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_21 = arg_285_1:GetWordFromCfg(320251067)
				local var_288_22 = arg_285_1:FormatText(var_288_21.content)

				arg_285_1.text_.text = var_288_22

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_23 = 36
				local var_288_24 = utf8.len(var_288_22)
				local var_288_25 = var_288_23 <= 0 and var_288_19 or var_288_19 * (var_288_24 / var_288_23)

				if var_288_25 > 0 and var_288_19 < var_288_25 then
					arg_285_1.talkMaxDuration = var_288_25
					var_288_18 = var_288_18 + 0.3

					if var_288_25 + var_288_18 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_25 + var_288_18
					end
				end

				arg_285_1.text_.text = var_288_22
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_26 = var_288_18 + 0.3
			local var_288_27 = math.max(var_288_19, arg_285_1.talkMaxDuration)

			if var_288_26 <= arg_285_1.time_ and arg_285_1.time_ < var_288_26 + var_288_27 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_26) / var_288_27

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_26 + var_288_27 and arg_285_1.time_ < var_288_26 + var_288_27 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play320251068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 320251068
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play320251069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 1.7

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_2 = arg_291_1:GetWordFromCfg(320251068)
				local var_294_3 = arg_291_1:FormatText(var_294_2.content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 68
				local var_294_5 = utf8.len(var_294_3)
				local var_294_6 = var_294_4 <= 0 and var_294_1 or var_294_1 * (var_294_5 / var_294_4)

				if var_294_6 > 0 and var_294_1 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_7 and arg_291_1.time_ < var_294_0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play320251069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 320251069
		arg_295_1.duration_ = 3.9

		local var_295_0 = {
			zh = 3.266,
			ja = 3.9
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
				arg_295_0:Play320251070(arg_295_1)
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

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[36].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(320251069)
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

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251069", "story_v_out_320251.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251069", "story_v_out_320251.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_320251", "320251069", "story_v_out_320251.awb")

						arg_295_1:RecordAudio("320251069", var_298_9)
						arg_295_1:RecordAudio("320251069", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_320251", "320251069", "story_v_out_320251.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_320251", "320251069", "story_v_out_320251.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play320251070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 320251070
		arg_299_1.duration_ = 3.2

		local var_299_0 = {
			zh = 2.033,
			ja = 3.2
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
				arg_299_0:Play320251071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.25

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[1066].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:GetWordFromCfg(320251070)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 10
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251070", "story_v_out_320251.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251070", "story_v_out_320251.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_320251", "320251070", "story_v_out_320251.awb")

						arg_299_1:RecordAudio("320251070", var_302_9)
						arg_299_1:RecordAudio("320251070", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_320251", "320251070", "story_v_out_320251.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_320251", "320251070", "story_v_out_320251.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_10 and arg_299_1.time_ < var_302_0 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play320251071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 320251071
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play320251072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 1.425

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_2 = arg_303_1:GetWordFromCfg(320251071)
				local var_306_3 = arg_303_1:FormatText(var_306_2.content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 57
				local var_306_5 = utf8.len(var_306_3)
				local var_306_6 = var_306_4 <= 0 and var_306_1 or var_306_1 * (var_306_5 / var_306_4)

				if var_306_6 > 0 and var_306_1 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_7 and arg_303_1.time_ < var_306_0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play320251072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 320251072
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play320251073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 1.5

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_2 = arg_307_1:GetWordFromCfg(320251072)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 60
				local var_310_5 = utf8.len(var_310_3)
				local var_310_6 = var_310_4 <= 0 and var_310_1 or var_310_1 * (var_310_5 / var_310_4)

				if var_310_6 > 0 and var_310_1 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_7 and arg_307_1.time_ < var_310_0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play320251073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 320251073
		arg_311_1.duration_ = 3.43

		local var_311_0 = {
			zh = 3.433,
			ja = 1.833
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play320251074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.15

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[1066].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:GetWordFromCfg(320251073)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 6
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251073", "story_v_out_320251.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251073", "story_v_out_320251.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_out_320251", "320251073", "story_v_out_320251.awb")

						arg_311_1:RecordAudio("320251073", var_314_9)
						arg_311_1:RecordAudio("320251073", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_320251", "320251073", "story_v_out_320251.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_320251", "320251073", "story_v_out_320251.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_10 and arg_311_1.time_ < var_314_0 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play320251074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 320251074
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play320251075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.925

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_2 = arg_315_1:GetWordFromCfg(320251074)
				local var_318_3 = arg_315_1:FormatText(var_318_2.content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 37
				local var_318_5 = utf8.len(var_318_3)
				local var_318_6 = var_318_4 <= 0 and var_318_1 or var_318_1 * (var_318_5 / var_318_4)

				if var_318_6 > 0 and var_318_1 < var_318_6 then
					arg_315_1.talkMaxDuration = var_318_6

					if var_318_6 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_6 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_7 and arg_315_1.time_ < var_318_0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play320251075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 320251075
		arg_319_1.duration_ = 6

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play320251076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.366666666666667

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_1 = 0.633333333333333

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_1 then
				local var_322_2 = (arg_319_1.time_ - var_322_0) / var_322_1
				local var_322_3 = Color.New(1, 1, 1)

				var_322_3.a = Mathf.Lerp(1, 0, var_322_2)
				arg_319_1.mask_.color = var_322_3
			end

			if arg_319_1.time_ >= var_322_0 + var_322_1 and arg_319_1.time_ < var_322_0 + var_322_1 + arg_322_0 then
				local var_322_4 = Color.New(1, 1, 1)
				local var_322_5 = 0

				arg_319_1.mask_.enabled = false
				var_322_4.a = var_322_5
				arg_319_1.mask_.color = var_322_4
			end

			local var_322_6 = manager.ui.mainCamera.transform
			local var_322_7 = 0

			if var_322_7 < arg_319_1.time_ and arg_319_1.time_ <= var_322_7 + arg_322_0 then
				arg_319_1.var_.shakeOldPos = var_322_6.localPosition
			end

			local var_322_8 = 0.666666666666667

			if var_322_7 <= arg_319_1.time_ and arg_319_1.time_ < var_322_7 + var_322_8 then
				local var_322_9 = (arg_319_1.time_ - var_322_7) / 0.066
				local var_322_10, var_322_11 = math.modf(var_322_9)

				var_322_6.localPosition = Vector3.New(var_322_11 * 0.13, var_322_11 * 0.13, var_322_11 * 0.13) + arg_319_1.var_.shakeOldPos
			end

			if arg_319_1.time_ >= var_322_7 + var_322_8 and arg_319_1.time_ < var_322_7 + var_322_8 + arg_322_0 then
				var_322_6.localPosition = arg_319_1.var_.shakeOldPos
			end

			local var_322_12 = manager.ui.mainCamera.transform
			local var_322_13 = 0.366666666666667

			if var_322_13 < arg_319_1.time_ and arg_319_1.time_ <= var_322_13 + arg_322_0 then
				local var_322_14 = arg_319_1.var_.effect777

				if var_322_14 then
					Object.Destroy(var_322_14)

					arg_319_1.var_.effect777 = nil
				end
			end

			local var_322_15 = manager.ui.mainCamera.transform
			local var_322_16 = 0.366666666666667

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				local var_322_17 = arg_319_1.var_.effect888

				if var_322_17 then
					Object.Destroy(var_322_17)

					arg_319_1.var_.effect888 = nil
				end
			end

			local var_322_18 = 0.2
			local var_322_19 = 1

			if var_322_18 < arg_319_1.time_ and arg_319_1.time_ <= var_322_18 + arg_322_0 then
				local var_322_20 = "play"
				local var_322_21 = "effect"

				arg_319_1:AudioAction(var_322_20, var_322_21, "se_story_137", "se_story_137_carbrake", "")
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_22 = 1
			local var_322_23 = 1.475

			if var_322_22 < arg_319_1.time_ and arg_319_1.time_ <= var_322_22 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_24 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_24:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_25 = arg_319_1:GetWordFromCfg(320251075)
				local var_322_26 = arg_319_1:FormatText(var_322_25.content)

				arg_319_1.text_.text = var_322_26

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_27 = 59
				local var_322_28 = utf8.len(var_322_26)
				local var_322_29 = var_322_27 <= 0 and var_322_23 or var_322_23 * (var_322_28 / var_322_27)

				if var_322_29 > 0 and var_322_23 < var_322_29 then
					arg_319_1.talkMaxDuration = var_322_29
					var_322_22 = var_322_22 + 0.3

					if var_322_29 + var_322_22 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_29 + var_322_22
					end
				end

				arg_319_1.text_.text = var_322_26
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_30 = var_322_22 + 0.3
			local var_322_31 = math.max(var_322_23, arg_319_1.talkMaxDuration)

			if var_322_30 <= arg_319_1.time_ and arg_319_1.time_ < var_322_30 + var_322_31 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_30) / var_322_31

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_30 + var_322_31 and arg_319_1.time_ < var_322_30 + var_322_31 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play320251076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 320251076
		arg_325_1.duration_ = 3.07

		local var_325_0 = {
			zh = 1.066,
			ja = 3.066
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play320251077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.175

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[1035].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(320251076)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 7
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251076", "story_v_out_320251.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251076", "story_v_out_320251.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_out_320251", "320251076", "story_v_out_320251.awb")

						arg_325_1:RecordAudio("320251076", var_328_9)
						arg_325_1:RecordAudio("320251076", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_320251", "320251076", "story_v_out_320251.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_320251", "320251076", "story_v_out_320251.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play320251077 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 320251077
		arg_329_1.duration_ = 3.2

		local var_329_0 = {
			zh = 2.433,
			ja = 3.2
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play320251078(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = "1156ui_story"

			if arg_329_1.actors_[var_332_0] == nil then
				local var_332_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_332_1) then
					local var_332_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_329_1.stage_.transform)

					var_332_2.name = var_332_0
					var_332_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_329_1.actors_[var_332_0] = var_332_2

					local var_332_3 = var_332_2:GetComponentInChildren(typeof(CharacterEffect))

					var_332_3.enabled = true

					local var_332_4 = GameObjectTools.GetOrAddComponent(var_332_2, typeof(DynamicBoneHelper))

					if var_332_4 then
						var_332_4:EnableDynamicBone(false)
					end

					arg_329_1:ShowWeapon(var_332_3.transform, false)

					arg_329_1.var_[var_332_0 .. "Animator"] = var_332_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_329_1.var_[var_332_0 .. "Animator"].applyRootMotion = true
					arg_329_1.var_[var_332_0 .. "LipSync"] = var_332_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_332_5 = arg_329_1.actors_["1156ui_story"].transform
			local var_332_6 = 0

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.var_.moveOldPos1156ui_story = var_332_5.localPosition
			end

			local var_332_7 = 0.001

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_7 then
				local var_332_8 = (arg_329_1.time_ - var_332_6) / var_332_7
				local var_332_9 = Vector3.New(0, -1.1, -6.18)

				var_332_5.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1156ui_story, var_332_9, var_332_8)

				local var_332_10 = manager.ui.mainCamera.transform.position - var_332_5.position

				var_332_5.forward = Vector3.New(var_332_10.x, var_332_10.y, var_332_10.z)

				local var_332_11 = var_332_5.localEulerAngles

				var_332_11.z = 0
				var_332_11.x = 0
				var_332_5.localEulerAngles = var_332_11
			end

			if arg_329_1.time_ >= var_332_6 + var_332_7 and arg_329_1.time_ < var_332_6 + var_332_7 + arg_332_0 then
				var_332_5.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_332_12 = manager.ui.mainCamera.transform.position - var_332_5.position

				var_332_5.forward = Vector3.New(var_332_12.x, var_332_12.y, var_332_12.z)

				local var_332_13 = var_332_5.localEulerAngles

				var_332_13.z = 0
				var_332_13.x = 0
				var_332_5.localEulerAngles = var_332_13
			end

			local var_332_14 = arg_329_1.actors_["1156ui_story"]
			local var_332_15 = 0

			if var_332_15 < arg_329_1.time_ and arg_329_1.time_ <= var_332_15 + arg_332_0 and not isNil(var_332_14) and arg_329_1.var_.characterEffect1156ui_story == nil then
				arg_329_1.var_.characterEffect1156ui_story = var_332_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_16 = 0.200000002980232

			if var_332_15 <= arg_329_1.time_ and arg_329_1.time_ < var_332_15 + var_332_16 and not isNil(var_332_14) then
				local var_332_17 = (arg_329_1.time_ - var_332_15) / var_332_16

				if arg_329_1.var_.characterEffect1156ui_story and not isNil(var_332_14) then
					arg_329_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_15 + var_332_16 and arg_329_1.time_ < var_332_15 + var_332_16 + arg_332_0 and not isNil(var_332_14) and arg_329_1.var_.characterEffect1156ui_story then
				arg_329_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_332_18 = 0

			if var_332_18 < arg_329_1.time_ and arg_329_1.time_ <= var_332_18 + arg_332_0 then
				arg_329_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action3_1")
			end

			local var_332_19 = 0

			if var_332_19 < arg_329_1.time_ and arg_329_1.time_ <= var_332_19 + arg_332_0 then
				arg_329_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_332_20 = 0
			local var_332_21 = 0.325

			if var_332_20 < arg_329_1.time_ and arg_329_1.time_ <= var_332_20 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_22 = arg_329_1:FormatText(StoryNameCfg[605].name)

				arg_329_1.leftNameTxt_.text = var_332_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_23 = arg_329_1:GetWordFromCfg(320251077)
				local var_332_24 = arg_329_1:FormatText(var_332_23.content)

				arg_329_1.text_.text = var_332_24

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_25 = 13
				local var_332_26 = utf8.len(var_332_24)
				local var_332_27 = var_332_25 <= 0 and var_332_21 or var_332_21 * (var_332_26 / var_332_25)

				if var_332_27 > 0 and var_332_21 < var_332_27 then
					arg_329_1.talkMaxDuration = var_332_27

					if var_332_27 + var_332_20 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_27 + var_332_20
					end
				end

				arg_329_1.text_.text = var_332_24
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251077", "story_v_out_320251.awb") ~= 0 then
					local var_332_28 = manager.audio:GetVoiceLength("story_v_out_320251", "320251077", "story_v_out_320251.awb") / 1000

					if var_332_28 + var_332_20 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_28 + var_332_20
					end

					if var_332_23.prefab_name ~= "" and arg_329_1.actors_[var_332_23.prefab_name] ~= nil then
						local var_332_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_23.prefab_name].transform, "story_v_out_320251", "320251077", "story_v_out_320251.awb")

						arg_329_1:RecordAudio("320251077", var_332_29)
						arg_329_1:RecordAudio("320251077", var_332_29)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_320251", "320251077", "story_v_out_320251.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_320251", "320251077", "story_v_out_320251.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_30 = math.max(var_332_21, arg_329_1.talkMaxDuration)

			if var_332_20 <= arg_329_1.time_ and arg_329_1.time_ < var_332_20 + var_332_30 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_20) / var_332_30

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_20 + var_332_30 and arg_329_1.time_ < var_332_20 + var_332_30 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play320251078 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 320251078
		arg_333_1.duration_ = 2.67

		local var_333_0 = {
			zh = 2.4,
			ja = 2.666
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play320251079(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1156ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1156ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(0, 100, 0)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1156ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, 100, 0)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1156ui_story"]
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1156ui_story == nil then
				arg_333_1.var_.characterEffect1156ui_story = var_336_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_11 = 0.200000002980232

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 and not isNil(var_336_9) then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11

				if arg_333_1.var_.characterEffect1156ui_story and not isNil(var_336_9) then
					local var_336_13 = Mathf.Lerp(0, 0.5, var_336_12)

					arg_333_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1156ui_story.fillRatio = var_336_13
				end
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1156ui_story then
				local var_336_14 = 0.5

				arg_333_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1156ui_story.fillRatio = var_336_14
			end

			local var_336_15 = arg_333_1.actors_["1089ui_story"].transform
			local var_336_16 = 0

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.var_.moveOldPos1089ui_story = var_336_15.localPosition
			end

			local var_336_17 = 0.001

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_17 then
				local var_336_18 = (arg_333_1.time_ - var_336_16) / var_336_17
				local var_336_19 = Vector3.New(0, -1.1, -6.17)

				var_336_15.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1089ui_story, var_336_19, var_336_18)

				local var_336_20 = manager.ui.mainCamera.transform.position - var_336_15.position

				var_336_15.forward = Vector3.New(var_336_20.x, var_336_20.y, var_336_20.z)

				local var_336_21 = var_336_15.localEulerAngles

				var_336_21.z = 0
				var_336_21.x = 0
				var_336_15.localEulerAngles = var_336_21
			end

			if arg_333_1.time_ >= var_336_16 + var_336_17 and arg_333_1.time_ < var_336_16 + var_336_17 + arg_336_0 then
				var_336_15.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_336_22 = manager.ui.mainCamera.transform.position - var_336_15.position

				var_336_15.forward = Vector3.New(var_336_22.x, var_336_22.y, var_336_22.z)

				local var_336_23 = var_336_15.localEulerAngles

				var_336_23.z = 0
				var_336_23.x = 0
				var_336_15.localEulerAngles = var_336_23
			end

			local var_336_24 = arg_333_1.actors_["1089ui_story"]
			local var_336_25 = 0

			if var_336_25 < arg_333_1.time_ and arg_333_1.time_ <= var_336_25 + arg_336_0 and not isNil(var_336_24) and arg_333_1.var_.characterEffect1089ui_story == nil then
				arg_333_1.var_.characterEffect1089ui_story = var_336_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_26 = 0.200000002980232

			if var_336_25 <= arg_333_1.time_ and arg_333_1.time_ < var_336_25 + var_336_26 and not isNil(var_336_24) then
				local var_336_27 = (arg_333_1.time_ - var_336_25) / var_336_26

				if arg_333_1.var_.characterEffect1089ui_story and not isNil(var_336_24) then
					arg_333_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_25 + var_336_26 and arg_333_1.time_ < var_336_25 + var_336_26 + arg_336_0 and not isNil(var_336_24) and arg_333_1.var_.characterEffect1089ui_story then
				arg_333_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_336_28 = 0

			if var_336_28 < arg_333_1.time_ and arg_333_1.time_ <= var_336_28 + arg_336_0 then
				arg_333_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_336_29 = 0

			if var_336_29 < arg_333_1.time_ and arg_333_1.time_ <= var_336_29 + arg_336_0 then
				arg_333_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_336_30 = 0
			local var_336_31 = 0.125

			if var_336_30 < arg_333_1.time_ and arg_333_1.time_ <= var_336_30 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_32 = arg_333_1:FormatText(StoryNameCfg[1031].name)

				arg_333_1.leftNameTxt_.text = var_336_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_33 = arg_333_1:GetWordFromCfg(320251078)
				local var_336_34 = arg_333_1:FormatText(var_336_33.content)

				arg_333_1.text_.text = var_336_34

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_35 = 5
				local var_336_36 = utf8.len(var_336_34)
				local var_336_37 = var_336_35 <= 0 and var_336_31 or var_336_31 * (var_336_36 / var_336_35)

				if var_336_37 > 0 and var_336_31 < var_336_37 then
					arg_333_1.talkMaxDuration = var_336_37

					if var_336_37 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_37 + var_336_30
					end
				end

				arg_333_1.text_.text = var_336_34
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251078", "story_v_out_320251.awb") ~= 0 then
					local var_336_38 = manager.audio:GetVoiceLength("story_v_out_320251", "320251078", "story_v_out_320251.awb") / 1000

					if var_336_38 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_38 + var_336_30
					end

					if var_336_33.prefab_name ~= "" and arg_333_1.actors_[var_336_33.prefab_name] ~= nil then
						local var_336_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_33.prefab_name].transform, "story_v_out_320251", "320251078", "story_v_out_320251.awb")

						arg_333_1:RecordAudio("320251078", var_336_39)
						arg_333_1:RecordAudio("320251078", var_336_39)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_320251", "320251078", "story_v_out_320251.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_320251", "320251078", "story_v_out_320251.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_40 = math.max(var_336_31, arg_333_1.talkMaxDuration)

			if var_336_30 <= arg_333_1.time_ and arg_333_1.time_ < var_336_30 + var_336_40 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_30) / var_336_40

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_30 + var_336_40 and arg_333_1.time_ < var_336_30 + var_336_40 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play320251079 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 320251079
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play320251080(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1089ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1089ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(0, 100, 0)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1089ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, 100, 0)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = arg_337_1.actors_["1089ui_story"]
			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect1089ui_story == nil then
				arg_337_1.var_.characterEffect1089ui_story = var_340_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_11 = 0.200000002980232

			if var_340_10 <= arg_337_1.time_ and arg_337_1.time_ < var_340_10 + var_340_11 and not isNil(var_340_9) then
				local var_340_12 = (arg_337_1.time_ - var_340_10) / var_340_11

				if arg_337_1.var_.characterEffect1089ui_story and not isNil(var_340_9) then
					local var_340_13 = Mathf.Lerp(0, 0.5, var_340_12)

					arg_337_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1089ui_story.fillRatio = var_340_13
				end
			end

			if arg_337_1.time_ >= var_340_10 + var_340_11 and arg_337_1.time_ < var_340_10 + var_340_11 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect1089ui_story then
				local var_340_14 = 0.5

				arg_337_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1089ui_story.fillRatio = var_340_14
			end

			local var_340_15 = 0.45
			local var_340_16 = 1

			if var_340_15 < arg_337_1.time_ and arg_337_1.time_ <= var_340_15 + arg_340_0 then
				local var_340_17 = "play"
				local var_340_18 = "effect"

				arg_337_1:AudioAction(var_340_17, var_340_18, "se_story_130", "se_story_130_gun", "")
			end

			local var_340_19 = 0
			local var_340_20 = 1.45

			if var_340_19 < arg_337_1.time_ and arg_337_1.time_ <= var_340_19 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_21 = arg_337_1:GetWordFromCfg(320251079)
				local var_340_22 = arg_337_1:FormatText(var_340_21.content)

				arg_337_1.text_.text = var_340_22

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_23 = 58
				local var_340_24 = utf8.len(var_340_22)
				local var_340_25 = var_340_23 <= 0 and var_340_20 or var_340_20 * (var_340_24 / var_340_23)

				if var_340_25 > 0 and var_340_20 < var_340_25 then
					arg_337_1.talkMaxDuration = var_340_25

					if var_340_25 + var_340_19 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_25 + var_340_19
					end
				end

				arg_337_1.text_.text = var_340_22
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_26 = math.max(var_340_20, arg_337_1.talkMaxDuration)

			if var_340_19 <= arg_337_1.time_ and arg_337_1.time_ < var_340_19 + var_340_26 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_19) / var_340_26

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_19 + var_340_26 and arg_337_1.time_ < var_340_19 + var_340_26 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play320251080 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 320251080
		arg_341_1.duration_ = 5.8

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play320251081(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_1 = 0.333333333333333

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_1 then
				local var_344_2 = (arg_341_1.time_ - var_344_0) / var_344_1
				local var_344_3 = Color.New(0.2169811, 0.04161461, 0.02354041)

				var_344_3.a = Mathf.Lerp(1, 0, var_344_2)
				arg_341_1.mask_.color = var_344_3
			end

			if arg_341_1.time_ >= var_344_0 + var_344_1 and arg_341_1.time_ < var_344_0 + var_344_1 + arg_344_0 then
				local var_344_4 = Color.New(0.2169811, 0.04161461, 0.02354041)
				local var_344_5 = 0

				arg_341_1.mask_.enabled = false
				var_344_4.a = var_344_5
				arg_341_1.mask_.color = var_344_4
			end

			local var_344_6 = 0.333333333333333

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.mask_.enabled = true
				arg_341_1.mask_.raycastTarget = true

				arg_341_1:SetGaussion(false)
			end

			local var_344_7 = 0.333333333333333

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_7 then
				local var_344_8 = (arg_341_1.time_ - var_344_6) / var_344_7
				local var_344_9 = Color.New(0.2169811, 0.04161461, 0.02354041)

				var_344_9.a = Mathf.Lerp(1, 0, var_344_8)
				arg_341_1.mask_.color = var_344_9
			end

			if arg_341_1.time_ >= var_344_6 + var_344_7 and arg_341_1.time_ < var_344_6 + var_344_7 + arg_344_0 then
				local var_344_10 = Color.New(0.2169811, 0.04161461, 0.02354041)
				local var_344_11 = 0

				arg_341_1.mask_.enabled = false
				var_344_10.a = var_344_11
				arg_341_1.mask_.color = var_344_10
			end

			local var_344_12 = 0
			local var_344_13 = 1

			if var_344_12 < arg_341_1.time_ and arg_341_1.time_ <= var_344_12 + arg_344_0 then
				local var_344_14 = "play"
				local var_344_15 = "effect"

				arg_341_1:AudioAction(var_344_14, var_344_15, "se_story_130", "se_story_130_gun", "")
			end

			if arg_341_1.frameCnt_ <= 1 then
				arg_341_1.dialog_:SetActive(false)
			end

			local var_344_16 = 0.8
			local var_344_17 = 1.4

			if var_344_16 < arg_341_1.time_ and arg_341_1.time_ <= var_344_16 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0

				arg_341_1.dialog_:SetActive(true)

				arg_341_1.dialogCg_.alpha = 0

				local var_344_18 = LeanTween.value(arg_341_1.dialog_, 0, 1, 0.3)

				var_344_18:setOnUpdate(LuaHelper.FloatAction(function(arg_345_0)
					arg_341_1.dialogCg_.alpha = arg_345_0
				end))
				var_344_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_341_1.dialog_)
					var_344_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_341_1.duration_ = arg_341_1.duration_ + 0.3

				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_19 = arg_341_1:GetWordFromCfg(320251080)
				local var_344_20 = arg_341_1:FormatText(var_344_19.content)

				arg_341_1.text_.text = var_344_20

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_21 = 56
				local var_344_22 = utf8.len(var_344_20)
				local var_344_23 = var_344_21 <= 0 and var_344_17 or var_344_17 * (var_344_22 / var_344_21)

				if var_344_23 > 0 and var_344_17 < var_344_23 then
					arg_341_1.talkMaxDuration = var_344_23
					var_344_16 = var_344_16 + 0.3

					if var_344_23 + var_344_16 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_23 + var_344_16
					end
				end

				arg_341_1.text_.text = var_344_20
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_24 = var_344_16 + 0.3
			local var_344_25 = math.max(var_344_17, arg_341_1.talkMaxDuration)

			if var_344_24 <= arg_341_1.time_ and arg_341_1.time_ < var_344_24 + var_344_25 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_24) / var_344_25

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_24 + var_344_25 and arg_341_1.time_ < var_344_24 + var_344_25 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play320251081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 320251081
		arg_347_1.duration_ = 4.23

		local var_347_0 = {
			zh = 2.533,
			ja = 4.233
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play320251082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.3

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[605].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(320251081)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 12
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251081", "story_v_out_320251.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251081", "story_v_out_320251.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_320251", "320251081", "story_v_out_320251.awb")

						arg_347_1:RecordAudio("320251081", var_350_9)
						arg_347_1:RecordAudio("320251081", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_320251", "320251081", "story_v_out_320251.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_320251", "320251081", "story_v_out_320251.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play320251082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 320251082
		arg_351_1.duration_ = 4.17

		local var_351_0 = {
			zh = 2.333,
			ja = 4.166
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play320251083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.275

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[1031].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(320251082)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 11
				local var_354_6 = utf8.len(var_354_4)
				local var_354_7 = var_354_5 <= 0 and var_354_1 or var_354_1 * (var_354_6 / var_354_5)

				if var_354_7 > 0 and var_354_1 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251082", "story_v_out_320251.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251082", "story_v_out_320251.awb") / 1000

					if var_354_8 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_0
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_320251", "320251082", "story_v_out_320251.awb")

						arg_351_1:RecordAudio("320251082", var_354_9)
						arg_351_1:RecordAudio("320251082", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_320251", "320251082", "story_v_out_320251.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_320251", "320251082", "story_v_out_320251.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_10 and arg_351_1.time_ < var_354_0 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play320251083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 320251083
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play320251084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 1.375

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:GetWordFromCfg(320251083)
				local var_358_3 = arg_355_1:FormatText(var_358_2.content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 55
				local var_358_5 = utf8.len(var_358_3)
				local var_358_6 = var_358_4 <= 0 and var_358_1 or var_358_1 * (var_358_5 / var_358_4)

				if var_358_6 > 0 and var_358_1 < var_358_6 then
					arg_355_1.talkMaxDuration = var_358_6

					if var_358_6 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_7 and arg_355_1.time_ < var_358_0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play320251084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 320251084
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play320251085(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.333333333333333
			local var_362_1 = 1

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				local var_362_2 = "play"
				local var_362_3 = "effect"

				arg_359_1:AudioAction(var_362_2, var_362_3, "se_story_16", "se_story_16_smash02", "")
			end

			local var_362_4 = 0
			local var_362_5 = 1.55

			if var_362_4 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(320251084)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_8 = 62
				local var_362_9 = utf8.len(var_362_7)
				local var_362_10 = var_362_8 <= 0 and var_362_5 or var_362_5 * (var_362_9 / var_362_8)

				if var_362_10 > 0 and var_362_5 < var_362_10 then
					arg_359_1.talkMaxDuration = var_362_10

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_11 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_11 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_11

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_11 and arg_359_1.time_ < var_362_4 + var_362_11 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play320251085 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 320251085
		arg_363_1.duration_ = 6.57

		local var_363_0 = {
			zh = 3.9,
			ja = 6.566
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play320251086(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.175

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[36].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4043")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(320251085)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 7
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251085", "story_v_out_320251.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251085", "story_v_out_320251.awb") / 1000

					if var_366_8 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_0
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_320251", "320251085", "story_v_out_320251.awb")

						arg_363_1:RecordAudio("320251085", var_366_9)
						arg_363_1:RecordAudio("320251085", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_320251", "320251085", "story_v_out_320251.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_320251", "320251085", "story_v_out_320251.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_10 and arg_363_1.time_ < var_366_0 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play320251086 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 320251086
		arg_367_1.duration_ = 6.23

		local var_367_0 = {
			zh = 4.266,
			ja = 6.233
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play320251087(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 0.65

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_2 = arg_367_1:FormatText(StoryNameCfg[605].name)

				arg_367_1.leftNameTxt_.text = var_370_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(320251086)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 26
				local var_370_6 = utf8.len(var_370_4)
				local var_370_7 = var_370_5 <= 0 and var_370_1 or var_370_1 * (var_370_6 / var_370_5)

				if var_370_7 > 0 and var_370_1 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251086", "story_v_out_320251.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251086", "story_v_out_320251.awb") / 1000

					if var_370_8 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_0
					end

					if var_370_3.prefab_name ~= "" and arg_367_1.actors_[var_370_3.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_3.prefab_name].transform, "story_v_out_320251", "320251086", "story_v_out_320251.awb")

						arg_367_1:RecordAudio("320251086", var_370_9)
						arg_367_1:RecordAudio("320251086", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_320251", "320251086", "story_v_out_320251.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_320251", "320251086", "story_v_out_320251.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_10 and arg_367_1.time_ < var_370_0 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play320251087 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 320251087
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play320251088(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 1.4

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_2 = arg_371_1:GetWordFromCfg(320251087)
				local var_374_3 = arg_371_1:FormatText(var_374_2.content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 56
				local var_374_5 = utf8.len(var_374_3)
				local var_374_6 = var_374_4 <= 0 and var_374_1 or var_374_1 * (var_374_5 / var_374_4)

				if var_374_6 > 0 and var_374_1 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_7 and arg_371_1.time_ < var_374_0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play320251088 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 320251088
		arg_375_1.duration_ = 5.73

		local var_375_0 = {
			zh = 4.4,
			ja = 5.733
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play320251089(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1156ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1156ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(0, -1.1, -6.18)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1156ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["1156ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1156ui_story == nil then
				arg_375_1.var_.characterEffect1156ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect1156ui_story and not isNil(var_378_9) then
					arg_375_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1156ui_story then
				arg_375_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_378_13 = 0

			if var_378_13 < arg_375_1.time_ and arg_375_1.time_ <= var_378_13 + arg_378_0 then
				arg_375_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			local var_378_14 = 0

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_378_15 = 0
			local var_378_16 = 0.65

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[605].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(320251088)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 26
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251088", "story_v_out_320251.awb") ~= 0 then
					local var_378_23 = manager.audio:GetVoiceLength("story_v_out_320251", "320251088", "story_v_out_320251.awb") / 1000

					if var_378_23 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_23 + var_378_15
					end

					if var_378_18.prefab_name ~= "" and arg_375_1.actors_[var_378_18.prefab_name] ~= nil then
						local var_378_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_18.prefab_name].transform, "story_v_out_320251", "320251088", "story_v_out_320251.awb")

						arg_375_1:RecordAudio("320251088", var_378_24)
						arg_375_1:RecordAudio("320251088", var_378_24)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_320251", "320251088", "story_v_out_320251.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_320251", "320251088", "story_v_out_320251.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_25 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_25 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_25

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_25 and arg_375_1.time_ < var_378_15 + var_378_25 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play320251089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 320251089
		arg_379_1.duration_ = 10.3

		local var_379_0 = {
			zh = 6.8,
			ja = 10.3
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play320251090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1156ui_story"].transform
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.var_.moveOldPos1156ui_story = var_382_0.localPosition
			end

			local var_382_2 = 0.001

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2
				local var_382_4 = Vector3.New(0, 100, 0)

				var_382_0.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1156ui_story, var_382_4, var_382_3)

				local var_382_5 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_5.x, var_382_5.y, var_382_5.z)

				local var_382_6 = var_382_0.localEulerAngles

				var_382_6.z = 0
				var_382_6.x = 0
				var_382_0.localEulerAngles = var_382_6
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 then
				var_382_0.localPosition = Vector3.New(0, 100, 0)

				local var_382_7 = manager.ui.mainCamera.transform.position - var_382_0.position

				var_382_0.forward = Vector3.New(var_382_7.x, var_382_7.y, var_382_7.z)

				local var_382_8 = var_382_0.localEulerAngles

				var_382_8.z = 0
				var_382_8.x = 0
				var_382_0.localEulerAngles = var_382_8
			end

			local var_382_9 = arg_379_1.actors_["1156ui_story"]
			local var_382_10 = 0

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1156ui_story == nil then
				arg_379_1.var_.characterEffect1156ui_story = var_382_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_11 = 0.200000002980232

			if var_382_10 <= arg_379_1.time_ and arg_379_1.time_ < var_382_10 + var_382_11 and not isNil(var_382_9) then
				local var_382_12 = (arg_379_1.time_ - var_382_10) / var_382_11

				if arg_379_1.var_.characterEffect1156ui_story and not isNil(var_382_9) then
					local var_382_13 = Mathf.Lerp(0, 0.5, var_382_12)

					arg_379_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1156ui_story.fillRatio = var_382_13
				end
			end

			if arg_379_1.time_ >= var_382_10 + var_382_11 and arg_379_1.time_ < var_382_10 + var_382_11 + arg_382_0 and not isNil(var_382_9) and arg_379_1.var_.characterEffect1156ui_story then
				local var_382_14 = 0.5

				arg_379_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1156ui_story.fillRatio = var_382_14
			end

			local var_382_15 = arg_379_1.actors_["1089ui_story"].transform
			local var_382_16 = 0

			if var_382_16 < arg_379_1.time_ and arg_379_1.time_ <= var_382_16 + arg_382_0 then
				arg_379_1.var_.moveOldPos1089ui_story = var_382_15.localPosition
			end

			local var_382_17 = 0.001

			if var_382_16 <= arg_379_1.time_ and arg_379_1.time_ < var_382_16 + var_382_17 then
				local var_382_18 = (arg_379_1.time_ - var_382_16) / var_382_17
				local var_382_19 = Vector3.New(0, -1.1, -6.17)

				var_382_15.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1089ui_story, var_382_19, var_382_18)

				local var_382_20 = manager.ui.mainCamera.transform.position - var_382_15.position

				var_382_15.forward = Vector3.New(var_382_20.x, var_382_20.y, var_382_20.z)

				local var_382_21 = var_382_15.localEulerAngles

				var_382_21.z = 0
				var_382_21.x = 0
				var_382_15.localEulerAngles = var_382_21
			end

			if arg_379_1.time_ >= var_382_16 + var_382_17 and arg_379_1.time_ < var_382_16 + var_382_17 + arg_382_0 then
				var_382_15.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_382_22 = manager.ui.mainCamera.transform.position - var_382_15.position

				var_382_15.forward = Vector3.New(var_382_22.x, var_382_22.y, var_382_22.z)

				local var_382_23 = var_382_15.localEulerAngles

				var_382_23.z = 0
				var_382_23.x = 0
				var_382_15.localEulerAngles = var_382_23
			end

			local var_382_24 = arg_379_1.actors_["1089ui_story"]
			local var_382_25 = 0

			if var_382_25 < arg_379_1.time_ and arg_379_1.time_ <= var_382_25 + arg_382_0 and not isNil(var_382_24) and arg_379_1.var_.characterEffect1089ui_story == nil then
				arg_379_1.var_.characterEffect1089ui_story = var_382_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_26 = 0.200000002980232

			if var_382_25 <= arg_379_1.time_ and arg_379_1.time_ < var_382_25 + var_382_26 and not isNil(var_382_24) then
				local var_382_27 = (arg_379_1.time_ - var_382_25) / var_382_26

				if arg_379_1.var_.characterEffect1089ui_story and not isNil(var_382_24) then
					arg_379_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_25 + var_382_26 and arg_379_1.time_ < var_382_25 + var_382_26 + arg_382_0 and not isNil(var_382_24) and arg_379_1.var_.characterEffect1089ui_story then
				arg_379_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_382_28 = 0

			if var_382_28 < arg_379_1.time_ and arg_379_1.time_ <= var_382_28 + arg_382_0 then
				arg_379_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_382_29 = 0

			if var_382_29 < arg_379_1.time_ and arg_379_1.time_ <= var_382_29 + arg_382_0 then
				arg_379_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_382_30 = 0
			local var_382_31 = 0.675

			if var_382_30 < arg_379_1.time_ and arg_379_1.time_ <= var_382_30 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_32 = arg_379_1:FormatText(StoryNameCfg[1031].name)

				arg_379_1.leftNameTxt_.text = var_382_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_33 = arg_379_1:GetWordFromCfg(320251089)
				local var_382_34 = arg_379_1:FormatText(var_382_33.content)

				arg_379_1.text_.text = var_382_34

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_35 = 27
				local var_382_36 = utf8.len(var_382_34)
				local var_382_37 = var_382_35 <= 0 and var_382_31 or var_382_31 * (var_382_36 / var_382_35)

				if var_382_37 > 0 and var_382_31 < var_382_37 then
					arg_379_1.talkMaxDuration = var_382_37

					if var_382_37 + var_382_30 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_37 + var_382_30
					end
				end

				arg_379_1.text_.text = var_382_34
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251089", "story_v_out_320251.awb") ~= 0 then
					local var_382_38 = manager.audio:GetVoiceLength("story_v_out_320251", "320251089", "story_v_out_320251.awb") / 1000

					if var_382_38 + var_382_30 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_38 + var_382_30
					end

					if var_382_33.prefab_name ~= "" and arg_379_1.actors_[var_382_33.prefab_name] ~= nil then
						local var_382_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_33.prefab_name].transform, "story_v_out_320251", "320251089", "story_v_out_320251.awb")

						arg_379_1:RecordAudio("320251089", var_382_39)
						arg_379_1:RecordAudio("320251089", var_382_39)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_320251", "320251089", "story_v_out_320251.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_320251", "320251089", "story_v_out_320251.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_40 = math.max(var_382_31, arg_379_1.talkMaxDuration)

			if var_382_30 <= arg_379_1.time_ and arg_379_1.time_ < var_382_30 + var_382_40 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_30) / var_382_40

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_30 + var_382_40 and arg_379_1.time_ < var_382_30 + var_382_40 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play320251090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 320251090
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play320251091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1089ui_story"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos1089ui_story = var_386_0.localPosition
			end

			local var_386_2 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2
				local var_386_4 = Vector3.New(0, 100, 0)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1089ui_story, var_386_4, var_386_3)

				local var_386_5 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_5.x, var_386_5.y, var_386_5.z)

				local var_386_6 = var_386_0.localEulerAngles

				var_386_6.z = 0
				var_386_6.x = 0
				var_386_0.localEulerAngles = var_386_6
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(0, 100, 0)

				local var_386_7 = manager.ui.mainCamera.transform.position - var_386_0.position

				var_386_0.forward = Vector3.New(var_386_7.x, var_386_7.y, var_386_7.z)

				local var_386_8 = var_386_0.localEulerAngles

				var_386_8.z = 0
				var_386_8.x = 0
				var_386_0.localEulerAngles = var_386_8
			end

			local var_386_9 = arg_383_1.actors_["1089ui_story"]
			local var_386_10 = 0

			if var_386_10 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1089ui_story == nil then
				arg_383_1.var_.characterEffect1089ui_story = var_386_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_11 and not isNil(var_386_9) then
				local var_386_12 = (arg_383_1.time_ - var_386_10) / var_386_11

				if arg_383_1.var_.characterEffect1089ui_story and not isNil(var_386_9) then
					local var_386_13 = Mathf.Lerp(0, 0.5, var_386_12)

					arg_383_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1089ui_story.fillRatio = var_386_13
				end
			end

			if arg_383_1.time_ >= var_386_10 + var_386_11 and arg_383_1.time_ < var_386_10 + var_386_11 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1089ui_story then
				local var_386_14 = 0.5

				arg_383_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1089ui_story.fillRatio = var_386_14
			end

			local var_386_15 = 0
			local var_386_16 = 1.225

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_17 = arg_383_1:GetWordFromCfg(320251090)
				local var_386_18 = arg_383_1:FormatText(var_386_17.content)

				arg_383_1.text_.text = var_386_18

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_19 = 49
				local var_386_20 = utf8.len(var_386_18)
				local var_386_21 = var_386_19 <= 0 and var_386_16 or var_386_16 * (var_386_20 / var_386_19)

				if var_386_21 > 0 and var_386_16 < var_386_21 then
					arg_383_1.talkMaxDuration = var_386_21

					if var_386_21 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_21 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_18
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_22 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_22 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_22

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_22 and arg_383_1.time_ < var_386_15 + var_386_22 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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

		arg_383_1:InitPlayNodeList()
	end,
	Play320251091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 320251091
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play320251092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 1.175

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(320251091)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 47
				local var_390_5 = utf8.len(var_390_3)
				local var_390_6 = var_390_4 <= 0 and var_390_1 or var_390_1 * (var_390_5 / var_390_4)

				if var_390_6 > 0 and var_390_1 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_7 and arg_387_1.time_ < var_390_0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play320251092 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 320251092
		arg_391_1.duration_ = 3.7

		local var_391_0 = {
			zh = 2.5,
			ja = 3.7
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play320251093(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.225

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_2 = arg_391_1:FormatText(StoryNameCfg[1031].name)

				arg_391_1.leftNameTxt_.text = var_394_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:GetWordFromCfg(320251092)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 9
				local var_394_6 = utf8.len(var_394_4)
				local var_394_7 = var_394_5 <= 0 and var_394_1 or var_394_1 * (var_394_6 / var_394_5)

				if var_394_7 > 0 and var_394_1 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251092", "story_v_out_320251.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251092", "story_v_out_320251.awb") / 1000

					if var_394_8 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_0
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_out_320251", "320251092", "story_v_out_320251.awb")

						arg_391_1:RecordAudio("320251092", var_394_9)
						arg_391_1:RecordAudio("320251092", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_320251", "320251092", "story_v_out_320251.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_320251", "320251092", "story_v_out_320251.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_10 and arg_391_1.time_ < var_394_0 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play320251093 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 320251093
		arg_395_1.duration_ = 5.95

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play320251094(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0

			if var_398_0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_0 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_1 = 0.333333333333333

			if var_398_0 <= arg_395_1.time_ and arg_395_1.time_ < var_398_0 + var_398_1 then
				local var_398_2 = (arg_395_1.time_ - var_398_0) / var_398_1
				local var_398_3 = Color.New(1, 1, 1)

				var_398_3.a = Mathf.Lerp(1, 0, var_398_2)
				arg_395_1.mask_.color = var_398_3
			end

			if arg_395_1.time_ >= var_398_0 + var_398_1 and arg_395_1.time_ < var_398_0 + var_398_1 + arg_398_0 then
				local var_398_4 = Color.New(1, 1, 1)
				local var_398_5 = 0

				arg_395_1.mask_.enabled = false
				var_398_4.a = var_398_5
				arg_395_1.mask_.color = var_398_4
			end

			local var_398_6 = manager.ui.mainCamera.transform
			local var_398_7 = 0.166666666666667

			if var_398_7 < arg_395_1.time_ and arg_395_1.time_ <= var_398_7 + arg_398_0 then
				local var_398_8 = arg_395_1.var_.effect775
				local var_398_9
				local var_398_10 = var_398_6

				if not var_398_8 then
					var_398_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_398_10)
					var_398_8.name = "775"
					arg_395_1.var_.effect775 = var_398_8
				else
					var_398_8.transform:SetParent(var_398_10)
				end

				var_398_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_398_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_398_11 = manager.ui.mainCamera.transform
			local var_398_12 = 0

			if var_398_12 < arg_395_1.time_ and arg_395_1.time_ <= var_398_12 + arg_398_0 then
				arg_395_1.var_.shakeOldPos = var_398_11.localPosition
			end

			local var_398_13 = 0.733333333333333

			if var_398_12 <= arg_395_1.time_ and arg_395_1.time_ < var_398_12 + var_398_13 then
				local var_398_14 = (arg_395_1.time_ - var_398_12) / 0.066
				local var_398_15, var_398_16 = math.modf(var_398_14)

				var_398_11.localPosition = Vector3.New(var_398_16 * 0.13, var_398_16 * 0.13, var_398_16 * 0.13) + arg_395_1.var_.shakeOldPos
			end

			if arg_395_1.time_ >= var_398_12 + var_398_13 and arg_395_1.time_ < var_398_12 + var_398_13 + arg_398_0 then
				var_398_11.localPosition = arg_395_1.var_.shakeOldPos
			end

			local var_398_17 = 0.566666666666667
			local var_398_18 = 1

			if var_398_17 < arg_395_1.time_ and arg_395_1.time_ <= var_398_17 + arg_398_0 then
				local var_398_19 = "play"
				local var_398_20 = "effect"

				arg_395_1:AudioAction(var_398_19, var_398_20, "se_story_123_01", "se_story_123_01_gun", "")
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_21 = 0.954727101372555
			local var_398_22 = 1.075

			if var_398_21 < arg_395_1.time_ and arg_395_1.time_ <= var_398_21 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_23 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_23:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_24 = arg_395_1:GetWordFromCfg(320251093)
				local var_398_25 = arg_395_1:FormatText(var_398_24.content)

				arg_395_1.text_.text = var_398_25

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_26 = 43
				local var_398_27 = utf8.len(var_398_25)
				local var_398_28 = var_398_26 <= 0 and var_398_22 or var_398_22 * (var_398_27 / var_398_26)

				if var_398_28 > 0 and var_398_22 < var_398_28 then
					arg_395_1.talkMaxDuration = var_398_28
					var_398_21 = var_398_21 + 0.3

					if var_398_28 + var_398_21 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_28 + var_398_21
					end
				end

				arg_395_1.text_.text = var_398_25
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_29 = var_398_21 + 0.3
			local var_398_30 = math.max(var_398_22, arg_395_1.talkMaxDuration)

			if var_398_29 <= arg_395_1.time_ and arg_395_1.time_ < var_398_29 + var_398_30 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_29) / var_398_30

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_29 + var_398_30 and arg_395_1.time_ < var_398_29 + var_398_30 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play320251094 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 320251094
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play320251095(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 1.775

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(320251094)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 71
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play320251095 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 320251095
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play320251096(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 1

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				local var_408_2 = "play"
				local var_408_3 = "effect"

				arg_405_1:AudioAction(var_408_2, var_408_3, "se_story_1", "se_story_1_gun_load", "")
			end

			local var_408_4 = 0
			local var_408_5 = 1.3

			if var_408_4 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(320251095)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_8 = 52
				local var_408_9 = utf8.len(var_408_7)
				local var_408_10 = var_408_8 <= 0 and var_408_5 or var_408_5 * (var_408_9 / var_408_8)

				if var_408_10 > 0 and var_408_5 < var_408_10 then
					arg_405_1.talkMaxDuration = var_408_10

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_11 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_11 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_11

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_11 and arg_405_1.time_ < var_408_4 + var_408_11 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play320251096 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 320251096
		arg_409_1.duration_ = 6.1

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play320251097(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = manager.ui.mainCamera.transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				local var_412_2 = arg_409_1.var_.effect321
				local var_412_3
				local var_412_4 = var_412_0

				if not var_412_2 then
					var_412_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui"), var_412_4)
					var_412_2.name = "321"
					arg_409_1.var_.effect321 = var_412_2
				else
					var_412_2.transform:SetParent(var_412_4)
				end

				var_412_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_412_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_412_5 = manager.ui.mainCameraCom_
				local var_412_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_412_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_412_7 = var_412_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_412_8 = 15
				local var_412_9 = 2 * var_412_8 * Mathf.Tan(var_412_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_412_5.aspect
				local var_412_10 = 1
				local var_412_11 = 1.7777777777777777

				if var_412_11 < var_412_5.aspect then
					var_412_10 = var_412_9 / (2 * var_412_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_412_11)
				end

				for iter_412_0, iter_412_1 in ipairs(var_412_7) do
					local var_412_12 = iter_412_1.transform.localScale

					iter_412_1.transform.localScale = Vector3.New(var_412_12.x / var_412_6 * var_412_10, var_412_12.y / var_412_6, var_412_12.z)
				end
			end

			local var_412_13 = manager.ui.mainCamera.transform
			local var_412_14 = 0

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 then
				local var_412_15 = arg_409_1.var_.effect772

				if var_412_15 then
					Object.Destroy(var_412_15)

					arg_409_1.var_.effect772 = nil
				end
			end

			local var_412_16 = 0

			if var_412_16 < arg_409_1.time_ and arg_409_1.time_ <= var_412_16 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_17 = 0.866666666666667

			if var_412_16 <= arg_409_1.time_ and arg_409_1.time_ < var_412_16 + var_412_17 then
				local var_412_18 = (arg_409_1.time_ - var_412_16) / var_412_17
				local var_412_19 = Color.New(1, 1, 1)

				var_412_19.a = Mathf.Lerp(1, 0, var_412_18)
				arg_409_1.mask_.color = var_412_19
			end

			if arg_409_1.time_ >= var_412_16 + var_412_17 and arg_409_1.time_ < var_412_16 + var_412_17 + arg_412_0 then
				local var_412_20 = Color.New(1, 1, 1)
				local var_412_21 = 0

				arg_409_1.mask_.enabled = false
				var_412_20.a = var_412_21
				arg_409_1.mask_.color = var_412_20
			end

			local var_412_22 = 0.866666666666667
			local var_412_23 = 1

			if var_412_22 < arg_409_1.time_ and arg_409_1.time_ <= var_412_22 + arg_412_0 then
				local var_412_24 = "play"
				local var_412_25 = "effect"

				arg_409_1:AudioAction(var_412_24, var_412_25, "se_story_16", "se_story_16_gun03", "")
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_26 = 1.1
			local var_412_27 = 1.6

			if var_412_26 < arg_409_1.time_ and arg_409_1.time_ <= var_412_26 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_28 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_28:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_29 = arg_409_1:GetWordFromCfg(320251096)
				local var_412_30 = arg_409_1:FormatText(var_412_29.content)

				arg_409_1.text_.text = var_412_30

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_31 = 64
				local var_412_32 = utf8.len(var_412_30)
				local var_412_33 = var_412_31 <= 0 and var_412_27 or var_412_27 * (var_412_32 / var_412_31)

				if var_412_33 > 0 and var_412_27 < var_412_33 then
					arg_409_1.talkMaxDuration = var_412_33
					var_412_26 = var_412_26 + 0.3

					if var_412_33 + var_412_26 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_33 + var_412_26
					end
				end

				arg_409_1.text_.text = var_412_30
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_34 = var_412_26 + 0.3
			local var_412_35 = math.max(var_412_27, arg_409_1.talkMaxDuration)

			if var_412_34 <= arg_409_1.time_ and arg_409_1.time_ < var_412_34 + var_412_35 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_34) / var_412_35

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_34 + var_412_35 and arg_409_1.time_ < var_412_34 + var_412_35 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play320251097 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 320251097
		arg_415_1.duration_ = 5.33

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play320251098(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 1.7

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				local var_418_1 = manager.ui.mainCamera.transform.localPosition
				local var_418_2 = Vector3.New(0, 0, 10) + Vector3.New(var_418_1.x, var_418_1.y, 0)
				local var_418_3 = arg_415_1.bgs_.L02f

				var_418_3.transform.localPosition = var_418_2
				var_418_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_4 = var_418_3:GetComponent("SpriteRenderer")

				if var_418_4 and var_418_4.sprite then
					local var_418_5 = (var_418_3.transform.localPosition - var_418_1).z
					local var_418_6 = manager.ui.mainCameraCom_
					local var_418_7 = 2 * var_418_5 * Mathf.Tan(var_418_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_418_8 = var_418_7 * var_418_6.aspect
					local var_418_9 = var_418_4.sprite.bounds.size.x
					local var_418_10 = var_418_4.sprite.bounds.size.y
					local var_418_11 = var_418_8 / var_418_9
					local var_418_12 = var_418_7 / var_418_10
					local var_418_13 = var_418_12 < var_418_11 and var_418_11 or var_418_12

					var_418_3.transform.localScale = Vector3.New(var_418_13, var_418_13, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "L02f" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_14 = 0

			if var_418_14 < arg_415_1.time_ and arg_415_1.time_ <= var_418_14 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			local var_418_15 = 0.3

			if arg_415_1.time_ >= var_418_14 + var_418_15 and arg_415_1.time_ < var_418_14 + var_418_15 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end

			local var_418_16 = 0

			if var_418_16 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_17 = 1.7

			if var_418_16 <= arg_415_1.time_ and arg_415_1.time_ < var_418_16 + var_418_17 then
				local var_418_18 = (arg_415_1.time_ - var_418_16) / var_418_17
				local var_418_19 = Color.New(0, 0, 0)

				var_418_19.a = Mathf.Lerp(0, 1, var_418_18)
				arg_415_1.mask_.color = var_418_19
			end

			if arg_415_1.time_ >= var_418_16 + var_418_17 and arg_415_1.time_ < var_418_16 + var_418_17 + arg_418_0 then
				local var_418_20 = Color.New(0, 0, 0)

				var_418_20.a = 1
				arg_415_1.mask_.color = var_418_20
			end

			local var_418_21 = 1.7

			if var_418_21 < arg_415_1.time_ and arg_415_1.time_ <= var_418_21 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_22 = 2

			if var_418_21 <= arg_415_1.time_ and arg_415_1.time_ < var_418_21 + var_418_22 then
				local var_418_23 = (arg_415_1.time_ - var_418_21) / var_418_22
				local var_418_24 = Color.New(0, 0, 0)

				var_418_24.a = Mathf.Lerp(1, 0, var_418_23)
				arg_415_1.mask_.color = var_418_24
			end

			if arg_415_1.time_ >= var_418_21 + var_418_22 and arg_415_1.time_ < var_418_21 + var_418_22 + arg_418_0 then
				local var_418_25 = Color.New(0, 0, 0)
				local var_418_26 = 0

				arg_415_1.mask_.enabled = false
				var_418_25.a = var_418_26
				arg_415_1.mask_.color = var_418_25
			end

			local var_418_27 = arg_415_1.actors_["1156ui_story"].transform
			local var_418_28 = 3.33333333333333

			if var_418_28 < arg_415_1.time_ and arg_415_1.time_ <= var_418_28 + arg_418_0 then
				arg_415_1.var_.moveOldPos1156ui_story = var_418_27.localPosition
			end

			local var_418_29 = 0.001

			if var_418_28 <= arg_415_1.time_ and arg_415_1.time_ < var_418_28 + var_418_29 then
				local var_418_30 = (arg_415_1.time_ - var_418_28) / var_418_29
				local var_418_31 = Vector3.New(0, -1.1, -6.18)

				var_418_27.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1156ui_story, var_418_31, var_418_30)

				local var_418_32 = manager.ui.mainCamera.transform.position - var_418_27.position

				var_418_27.forward = Vector3.New(var_418_32.x, var_418_32.y, var_418_32.z)

				local var_418_33 = var_418_27.localEulerAngles

				var_418_33.z = 0
				var_418_33.x = 0
				var_418_27.localEulerAngles = var_418_33
			end

			if arg_415_1.time_ >= var_418_28 + var_418_29 and arg_415_1.time_ < var_418_28 + var_418_29 + arg_418_0 then
				var_418_27.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_418_34 = manager.ui.mainCamera.transform.position - var_418_27.position

				var_418_27.forward = Vector3.New(var_418_34.x, var_418_34.y, var_418_34.z)

				local var_418_35 = var_418_27.localEulerAngles

				var_418_35.z = 0
				var_418_35.x = 0
				var_418_27.localEulerAngles = var_418_35
			end

			local var_418_36 = arg_415_1.actors_["1156ui_story"]
			local var_418_37 = 3.33333333333333

			if var_418_37 < arg_415_1.time_ and arg_415_1.time_ <= var_418_37 + arg_418_0 and not isNil(var_418_36) and arg_415_1.var_.characterEffect1156ui_story == nil then
				arg_415_1.var_.characterEffect1156ui_story = var_418_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_38 = 0.200000002980232

			if var_418_37 <= arg_415_1.time_ and arg_415_1.time_ < var_418_37 + var_418_38 and not isNil(var_418_36) then
				local var_418_39 = (arg_415_1.time_ - var_418_37) / var_418_38

				if arg_415_1.var_.characterEffect1156ui_story and not isNil(var_418_36) then
					arg_415_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_37 + var_418_38 and arg_415_1.time_ < var_418_37 + var_418_38 + arg_418_0 and not isNil(var_418_36) and arg_415_1.var_.characterEffect1156ui_story then
				arg_415_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_418_40 = 3.33333333333333

			if var_418_40 < arg_415_1.time_ and arg_415_1.time_ <= var_418_40 + arg_418_0 then
				arg_415_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action12_1")
			end

			local var_418_41 = 3.33333333333333

			if var_418_41 < arg_415_1.time_ and arg_415_1.time_ <= var_418_41 + arg_418_0 then
				arg_415_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_418_42 = manager.ui.mainCamera.transform
			local var_418_43 = 1.7

			if var_418_43 < arg_415_1.time_ and arg_415_1.time_ <= var_418_43 + arg_418_0 then
				local var_418_44 = arg_415_1.var_.effect321

				if var_418_44 then
					Object.Destroy(var_418_44)

					arg_415_1.var_.effect321 = nil
				end
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_45 = 3.575
			local var_418_46 = 0.125

			if var_418_45 < arg_415_1.time_ and arg_415_1.time_ <= var_418_45 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_47 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_47:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_48 = arg_415_1:FormatText(StoryNameCfg[605].name)

				arg_415_1.leftNameTxt_.text = var_418_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_49 = arg_415_1:GetWordFromCfg(320251097)
				local var_418_50 = arg_415_1:FormatText(var_418_49.content)

				arg_415_1.text_.text = var_418_50

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_51 = 5
				local var_418_52 = utf8.len(var_418_50)
				local var_418_53 = var_418_51 <= 0 and var_418_46 or var_418_46 * (var_418_52 / var_418_51)

				if var_418_53 > 0 and var_418_46 < var_418_53 then
					arg_415_1.talkMaxDuration = var_418_53
					var_418_45 = var_418_45 + 0.3

					if var_418_53 + var_418_45 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_53 + var_418_45
					end
				end

				arg_415_1.text_.text = var_418_50
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251097", "story_v_out_320251.awb") ~= 0 then
					local var_418_54 = manager.audio:GetVoiceLength("story_v_out_320251", "320251097", "story_v_out_320251.awb") / 1000

					if var_418_54 + var_418_45 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_54 + var_418_45
					end

					if var_418_49.prefab_name ~= "" and arg_415_1.actors_[var_418_49.prefab_name] ~= nil then
						local var_418_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_49.prefab_name].transform, "story_v_out_320251", "320251097", "story_v_out_320251.awb")

						arg_415_1:RecordAudio("320251097", var_418_55)
						arg_415_1:RecordAudio("320251097", var_418_55)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_320251", "320251097", "story_v_out_320251.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_320251", "320251097", "story_v_out_320251.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_56 = var_418_45 + 0.3
			local var_418_57 = math.max(var_418_46, arg_415_1.talkMaxDuration)

			if var_418_56 <= arg_415_1.time_ and arg_415_1.time_ < var_418_56 + var_418_57 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_56) / var_418_57

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_56 + var_418_57 and arg_415_1.time_ < var_418_56 + var_418_57 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play320251098 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 320251098
		arg_421_1.duration_ = 3.7

		local var_421_0 = {
			zh = 3.7,
			ja = 3.633
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play320251099(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1156ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1156ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, 100, 0)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1156ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, 100, 0)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = arg_421_1.actors_["1156ui_story"]
			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1156ui_story == nil then
				arg_421_1.var_.characterEffect1156ui_story = var_424_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_11 = 0.200000002980232

			if var_424_10 <= arg_421_1.time_ and arg_421_1.time_ < var_424_10 + var_424_11 and not isNil(var_424_9) then
				local var_424_12 = (arg_421_1.time_ - var_424_10) / var_424_11

				if arg_421_1.var_.characterEffect1156ui_story and not isNil(var_424_9) then
					local var_424_13 = Mathf.Lerp(0, 0.5, var_424_12)

					arg_421_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1156ui_story.fillRatio = var_424_13
				end
			end

			if arg_421_1.time_ >= var_424_10 + var_424_11 and arg_421_1.time_ < var_424_10 + var_424_11 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1156ui_story then
				local var_424_14 = 0.5

				arg_421_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1156ui_story.fillRatio = var_424_14
			end

			local var_424_15 = arg_421_1.actors_["1089ui_story"].transform
			local var_424_16 = 0

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1.var_.moveOldPos1089ui_story = var_424_15.localPosition
			end

			local var_424_17 = 0.001

			if var_424_16 <= arg_421_1.time_ and arg_421_1.time_ < var_424_16 + var_424_17 then
				local var_424_18 = (arg_421_1.time_ - var_424_16) / var_424_17
				local var_424_19 = Vector3.New(0, -1.1, -6.17)

				var_424_15.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1089ui_story, var_424_19, var_424_18)

				local var_424_20 = manager.ui.mainCamera.transform.position - var_424_15.position

				var_424_15.forward = Vector3.New(var_424_20.x, var_424_20.y, var_424_20.z)

				local var_424_21 = var_424_15.localEulerAngles

				var_424_21.z = 0
				var_424_21.x = 0
				var_424_15.localEulerAngles = var_424_21
			end

			if arg_421_1.time_ >= var_424_16 + var_424_17 and arg_421_1.time_ < var_424_16 + var_424_17 + arg_424_0 then
				var_424_15.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_424_22 = manager.ui.mainCamera.transform.position - var_424_15.position

				var_424_15.forward = Vector3.New(var_424_22.x, var_424_22.y, var_424_22.z)

				local var_424_23 = var_424_15.localEulerAngles

				var_424_23.z = 0
				var_424_23.x = 0
				var_424_15.localEulerAngles = var_424_23
			end

			local var_424_24 = arg_421_1.actors_["1089ui_story"]
			local var_424_25 = 0

			if var_424_25 < arg_421_1.time_ and arg_421_1.time_ <= var_424_25 + arg_424_0 and not isNil(var_424_24) and arg_421_1.var_.characterEffect1089ui_story == nil then
				arg_421_1.var_.characterEffect1089ui_story = var_424_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_26 = 0.200000002980232

			if var_424_25 <= arg_421_1.time_ and arg_421_1.time_ < var_424_25 + var_424_26 and not isNil(var_424_24) then
				local var_424_27 = (arg_421_1.time_ - var_424_25) / var_424_26

				if arg_421_1.var_.characterEffect1089ui_story and not isNil(var_424_24) then
					arg_421_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_25 + var_424_26 and arg_421_1.time_ < var_424_25 + var_424_26 + arg_424_0 and not isNil(var_424_24) and arg_421_1.var_.characterEffect1089ui_story then
				arg_421_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_424_28 = 0

			if var_424_28 < arg_421_1.time_ and arg_421_1.time_ <= var_424_28 + arg_424_0 then
				arg_421_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			local var_424_29 = 0

			if var_424_29 < arg_421_1.time_ and arg_421_1.time_ <= var_424_29 + arg_424_0 then
				arg_421_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_424_30 = 0
			local var_424_31 = 0.325

			if var_424_30 < arg_421_1.time_ and arg_421_1.time_ <= var_424_30 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_32 = arg_421_1:FormatText(StoryNameCfg[1031].name)

				arg_421_1.leftNameTxt_.text = var_424_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_33 = arg_421_1:GetWordFromCfg(320251098)
				local var_424_34 = arg_421_1:FormatText(var_424_33.content)

				arg_421_1.text_.text = var_424_34

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_35 = 13
				local var_424_36 = utf8.len(var_424_34)
				local var_424_37 = var_424_35 <= 0 and var_424_31 or var_424_31 * (var_424_36 / var_424_35)

				if var_424_37 > 0 and var_424_31 < var_424_37 then
					arg_421_1.talkMaxDuration = var_424_37

					if var_424_37 + var_424_30 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_37 + var_424_30
					end
				end

				arg_421_1.text_.text = var_424_34
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251098", "story_v_out_320251.awb") ~= 0 then
					local var_424_38 = manager.audio:GetVoiceLength("story_v_out_320251", "320251098", "story_v_out_320251.awb") / 1000

					if var_424_38 + var_424_30 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_38 + var_424_30
					end

					if var_424_33.prefab_name ~= "" and arg_421_1.actors_[var_424_33.prefab_name] ~= nil then
						local var_424_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_33.prefab_name].transform, "story_v_out_320251", "320251098", "story_v_out_320251.awb")

						arg_421_1:RecordAudio("320251098", var_424_39)
						arg_421_1:RecordAudio("320251098", var_424_39)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_320251", "320251098", "story_v_out_320251.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_320251", "320251098", "story_v_out_320251.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_40 = math.max(var_424_31, arg_421_1.talkMaxDuration)

			if var_424_30 <= arg_421_1.time_ and arg_421_1.time_ < var_424_30 + var_424_40 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_30) / var_424_40

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_30 + var_424_40 and arg_421_1.time_ < var_424_30 + var_424_40 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play320251099 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 320251099
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play320251100(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1089ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos1089ui_story = var_428_0.localPosition
			end

			local var_428_2 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2
				local var_428_4 = Vector3.New(0, 100, 0)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1089ui_story, var_428_4, var_428_3)

				local var_428_5 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_5.x, var_428_5.y, var_428_5.z)

				local var_428_6 = var_428_0.localEulerAngles

				var_428_6.z = 0
				var_428_6.x = 0
				var_428_0.localEulerAngles = var_428_6
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0, 100, 0)

				local var_428_7 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_7.x, var_428_7.y, var_428_7.z)

				local var_428_8 = var_428_0.localEulerAngles

				var_428_8.z = 0
				var_428_8.x = 0
				var_428_0.localEulerAngles = var_428_8
			end

			local var_428_9 = arg_425_1.actors_["1089ui_story"]
			local var_428_10 = 0

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1089ui_story == nil then
				arg_425_1.var_.characterEffect1089ui_story = var_428_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_11 = 0.200000002980232

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_11 and not isNil(var_428_9) then
				local var_428_12 = (arg_425_1.time_ - var_428_10) / var_428_11

				if arg_425_1.var_.characterEffect1089ui_story and not isNil(var_428_9) then
					local var_428_13 = Mathf.Lerp(0, 0.5, var_428_12)

					arg_425_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1089ui_story.fillRatio = var_428_13
				end
			end

			if arg_425_1.time_ >= var_428_10 + var_428_11 and arg_425_1.time_ < var_428_10 + var_428_11 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect1089ui_story then
				local var_428_14 = 0.5

				arg_425_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1089ui_story.fillRatio = var_428_14
			end

			local var_428_15 = 0
			local var_428_16 = 0.775

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_17 = arg_425_1:GetWordFromCfg(320251099)
				local var_428_18 = arg_425_1:FormatText(var_428_17.content)

				arg_425_1.text_.text = var_428_18

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_19 = 31
				local var_428_20 = utf8.len(var_428_18)
				local var_428_21 = var_428_19 <= 0 and var_428_16 or var_428_16 * (var_428_20 / var_428_19)

				if var_428_21 > 0 and var_428_16 < var_428_21 then
					arg_425_1.talkMaxDuration = var_428_21

					if var_428_21 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_21 + var_428_15
					end
				end

				arg_425_1.text_.text = var_428_18
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_22 = math.max(var_428_16, arg_425_1.talkMaxDuration)

			if var_428_15 <= arg_425_1.time_ and arg_425_1.time_ < var_428_15 + var_428_22 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_15) / var_428_22

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_15 + var_428_22 and arg_425_1.time_ < var_428_15 + var_428_22 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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

		arg_425_1:InitPlayNodeList()
	end,
	Play320251100 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 320251100
		arg_429_1.duration_ = 7.33

		local var_429_0 = {
			zh = 6.833,
			ja = 7.333
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play320251101(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1156ui_story"].transform
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.var_.moveOldPos1156ui_story = var_432_0.localPosition
			end

			local var_432_2 = 0.001

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2
				local var_432_4 = Vector3.New(0.9, -1.1, -6.18)

				var_432_0.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1156ui_story, var_432_4, var_432_3)

				local var_432_5 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_5.x, var_432_5.y, var_432_5.z)

				local var_432_6 = var_432_0.localEulerAngles

				var_432_6.z = 0
				var_432_6.x = 0
				var_432_0.localEulerAngles = var_432_6
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 then
				var_432_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_432_7 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_7.x, var_432_7.y, var_432_7.z)

				local var_432_8 = var_432_0.localEulerAngles

				var_432_8.z = 0
				var_432_8.x = 0
				var_432_0.localEulerAngles = var_432_8
			end

			local var_432_9 = arg_429_1.actors_["1156ui_story"]
			local var_432_10 = 0

			if var_432_10 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect1156ui_story == nil then
				arg_429_1.var_.characterEffect1156ui_story = var_432_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_11 = 0.200000002980232

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_11 and not isNil(var_432_9) then
				local var_432_12 = (arg_429_1.time_ - var_432_10) / var_432_11

				if arg_429_1.var_.characterEffect1156ui_story and not isNil(var_432_9) then
					arg_429_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_10 + var_432_11 and arg_429_1.time_ < var_432_10 + var_432_11 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect1156ui_story then
				arg_429_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_432_13 = 0

			if var_432_13 < arg_429_1.time_ and arg_429_1.time_ <= var_432_13 + arg_432_0 then
				arg_429_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_1")
			end

			local var_432_14 = 0

			if var_432_14 < arg_429_1.time_ and arg_429_1.time_ <= var_432_14 + arg_432_0 then
				arg_429_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_432_15 = 0
			local var_432_16 = 0.975

			if var_432_15 < arg_429_1.time_ and arg_429_1.time_ <= var_432_15 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_17 = arg_429_1:FormatText(StoryNameCfg[605].name)

				arg_429_1.leftNameTxt_.text = var_432_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_18 = arg_429_1:GetWordFromCfg(320251100)
				local var_432_19 = arg_429_1:FormatText(var_432_18.content)

				arg_429_1.text_.text = var_432_19

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_20 = 39
				local var_432_21 = utf8.len(var_432_19)
				local var_432_22 = var_432_20 <= 0 and var_432_16 or var_432_16 * (var_432_21 / var_432_20)

				if var_432_22 > 0 and var_432_16 < var_432_22 then
					arg_429_1.talkMaxDuration = var_432_22

					if var_432_22 + var_432_15 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_22 + var_432_15
					end
				end

				arg_429_1.text_.text = var_432_19
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251100", "story_v_out_320251.awb") ~= 0 then
					local var_432_23 = manager.audio:GetVoiceLength("story_v_out_320251", "320251100", "story_v_out_320251.awb") / 1000

					if var_432_23 + var_432_15 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_23 + var_432_15
					end

					if var_432_18.prefab_name ~= "" and arg_429_1.actors_[var_432_18.prefab_name] ~= nil then
						local var_432_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_18.prefab_name].transform, "story_v_out_320251", "320251100", "story_v_out_320251.awb")

						arg_429_1:RecordAudio("320251100", var_432_24)
						arg_429_1:RecordAudio("320251100", var_432_24)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_320251", "320251100", "story_v_out_320251.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_320251", "320251100", "story_v_out_320251.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_25 = math.max(var_432_16, arg_429_1.talkMaxDuration)

			if var_432_15 <= arg_429_1.time_ and arg_429_1.time_ < var_432_15 + var_432_25 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_15) / var_432_25

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_15 + var_432_25 and arg_429_1.time_ < var_432_15 + var_432_25 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
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

		arg_429_1:InitPlayNodeList()
	end,
	Play320251101 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 320251101
		arg_433_1.duration_ = 3.63

		local var_433_0 = {
			zh = 3,
			ja = 3.633
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play320251102(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1089ui_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos1089ui_story = var_436_0.localPosition
			end

			local var_436_2 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2
				local var_436_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1089ui_story, var_436_4, var_436_3)

				local var_436_5 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_5.x, var_436_5.y, var_436_5.z)

				local var_436_6 = var_436_0.localEulerAngles

				var_436_6.z = 0
				var_436_6.x = 0
				var_436_0.localEulerAngles = var_436_6
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_436_7 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_7.x, var_436_7.y, var_436_7.z)

				local var_436_8 = var_436_0.localEulerAngles

				var_436_8.z = 0
				var_436_8.x = 0
				var_436_0.localEulerAngles = var_436_8
			end

			local var_436_9 = arg_433_1.actors_["1089ui_story"]
			local var_436_10 = 0

			if var_436_10 < arg_433_1.time_ and arg_433_1.time_ <= var_436_10 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect1089ui_story == nil then
				arg_433_1.var_.characterEffect1089ui_story = var_436_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_11 = 0.200000002980232

			if var_436_10 <= arg_433_1.time_ and arg_433_1.time_ < var_436_10 + var_436_11 and not isNil(var_436_9) then
				local var_436_12 = (arg_433_1.time_ - var_436_10) / var_436_11

				if arg_433_1.var_.characterEffect1089ui_story and not isNil(var_436_9) then
					arg_433_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_10 + var_436_11 and arg_433_1.time_ < var_436_10 + var_436_11 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect1089ui_story then
				arg_433_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_436_13 = 0

			if var_436_13 < arg_433_1.time_ and arg_433_1.time_ <= var_436_13 + arg_436_0 then
				arg_433_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_436_14 = 0

			if var_436_14 < arg_433_1.time_ and arg_433_1.time_ <= var_436_14 + arg_436_0 then
				arg_433_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_436_15 = arg_433_1.actors_["1156ui_story"]
			local var_436_16 = 0

			if var_436_16 < arg_433_1.time_ and arg_433_1.time_ <= var_436_16 + arg_436_0 and not isNil(var_436_15) and arg_433_1.var_.characterEffect1156ui_story == nil then
				arg_433_1.var_.characterEffect1156ui_story = var_436_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_17 = 0.200000002980232

			if var_436_16 <= arg_433_1.time_ and arg_433_1.time_ < var_436_16 + var_436_17 and not isNil(var_436_15) then
				local var_436_18 = (arg_433_1.time_ - var_436_16) / var_436_17

				if arg_433_1.var_.characterEffect1156ui_story and not isNil(var_436_15) then
					local var_436_19 = Mathf.Lerp(0, 0.5, var_436_18)

					arg_433_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1156ui_story.fillRatio = var_436_19
				end
			end

			if arg_433_1.time_ >= var_436_16 + var_436_17 and arg_433_1.time_ < var_436_16 + var_436_17 + arg_436_0 and not isNil(var_436_15) and arg_433_1.var_.characterEffect1156ui_story then
				local var_436_20 = 0.5

				arg_433_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1156ui_story.fillRatio = var_436_20
			end

			local var_436_21 = 0
			local var_436_22 = 0.325

			if var_436_21 < arg_433_1.time_ and arg_433_1.time_ <= var_436_21 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_23 = arg_433_1:FormatText(StoryNameCfg[1031].name)

				arg_433_1.leftNameTxt_.text = var_436_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_24 = arg_433_1:GetWordFromCfg(320251101)
				local var_436_25 = arg_433_1:FormatText(var_436_24.content)

				arg_433_1.text_.text = var_436_25

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_26 = 13
				local var_436_27 = utf8.len(var_436_25)
				local var_436_28 = var_436_26 <= 0 and var_436_22 or var_436_22 * (var_436_27 / var_436_26)

				if var_436_28 > 0 and var_436_22 < var_436_28 then
					arg_433_1.talkMaxDuration = var_436_28

					if var_436_28 + var_436_21 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_28 + var_436_21
					end
				end

				arg_433_1.text_.text = var_436_25
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251101", "story_v_out_320251.awb") ~= 0 then
					local var_436_29 = manager.audio:GetVoiceLength("story_v_out_320251", "320251101", "story_v_out_320251.awb") / 1000

					if var_436_29 + var_436_21 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_29 + var_436_21
					end

					if var_436_24.prefab_name ~= "" and arg_433_1.actors_[var_436_24.prefab_name] ~= nil then
						local var_436_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_24.prefab_name].transform, "story_v_out_320251", "320251101", "story_v_out_320251.awb")

						arg_433_1:RecordAudio("320251101", var_436_30)
						arg_433_1:RecordAudio("320251101", var_436_30)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_320251", "320251101", "story_v_out_320251.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_320251", "320251101", "story_v_out_320251.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_31 = math.max(var_436_22, arg_433_1.talkMaxDuration)

			if var_436_21 <= arg_433_1.time_ and arg_433_1.time_ < var_436_21 + var_436_31 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_21) / var_436_31

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_21 + var_436_31 and arg_433_1.time_ < var_436_21 + var_436_31 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
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

		arg_433_1:InitPlayNodeList()
	end,
	Play320251102 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 320251102
		arg_437_1.duration_ = 4.47

		local var_437_0 = {
			zh = 4.466,
			ja = 4.066
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play320251103(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1089ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1089ui_story == nil then
				arg_437_1.var_.characterEffect1089ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect1089ui_story and not isNil(var_440_0) then
					local var_440_4 = Mathf.Lerp(0, 0.5, var_440_3)

					arg_437_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1089ui_story.fillRatio = var_440_4
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1089ui_story then
				local var_440_5 = 0.5

				arg_437_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1089ui_story.fillRatio = var_440_5
			end

			local var_440_6 = arg_437_1.actors_["1156ui_story"]
			local var_440_7 = 0

			if var_440_7 < arg_437_1.time_ and arg_437_1.time_ <= var_440_7 + arg_440_0 and not isNil(var_440_6) and arg_437_1.var_.characterEffect1156ui_story == nil then
				arg_437_1.var_.characterEffect1156ui_story = var_440_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_8 = 0.200000002980232

			if var_440_7 <= arg_437_1.time_ and arg_437_1.time_ < var_440_7 + var_440_8 and not isNil(var_440_6) then
				local var_440_9 = (arg_437_1.time_ - var_440_7) / var_440_8

				if arg_437_1.var_.characterEffect1156ui_story and not isNil(var_440_6) then
					arg_437_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_7 + var_440_8 and arg_437_1.time_ < var_440_7 + var_440_8 + arg_440_0 and not isNil(var_440_6) and arg_437_1.var_.characterEffect1156ui_story then
				arg_437_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_440_10 = 0

			if var_440_10 < arg_437_1.time_ and arg_437_1.time_ <= var_440_10 + arg_440_0 then
				arg_437_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_2")
			end

			local var_440_11 = 0

			if var_440_11 < arg_437_1.time_ and arg_437_1.time_ <= var_440_11 + arg_440_0 then
				arg_437_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_440_12 = 0
			local var_440_13 = 0.55

			if var_440_12 < arg_437_1.time_ and arg_437_1.time_ <= var_440_12 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_14 = arg_437_1:FormatText(StoryNameCfg[605].name)

				arg_437_1.leftNameTxt_.text = var_440_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_15 = arg_437_1:GetWordFromCfg(320251102)
				local var_440_16 = arg_437_1:FormatText(var_440_15.content)

				arg_437_1.text_.text = var_440_16

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_17 = 22
				local var_440_18 = utf8.len(var_440_16)
				local var_440_19 = var_440_17 <= 0 and var_440_13 or var_440_13 * (var_440_18 / var_440_17)

				if var_440_19 > 0 and var_440_13 < var_440_19 then
					arg_437_1.talkMaxDuration = var_440_19

					if var_440_19 + var_440_12 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_19 + var_440_12
					end
				end

				arg_437_1.text_.text = var_440_16
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251102", "story_v_out_320251.awb") ~= 0 then
					local var_440_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251102", "story_v_out_320251.awb") / 1000

					if var_440_20 + var_440_12 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_20 + var_440_12
					end

					if var_440_15.prefab_name ~= "" and arg_437_1.actors_[var_440_15.prefab_name] ~= nil then
						local var_440_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_15.prefab_name].transform, "story_v_out_320251", "320251102", "story_v_out_320251.awb")

						arg_437_1:RecordAudio("320251102", var_440_21)
						arg_437_1:RecordAudio("320251102", var_440_21)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_320251", "320251102", "story_v_out_320251.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_320251", "320251102", "story_v_out_320251.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_22 = math.max(var_440_13, arg_437_1.talkMaxDuration)

			if var_440_12 <= arg_437_1.time_ and arg_437_1.time_ < var_440_12 + var_440_22 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_12) / var_440_22

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_12 + var_440_22 and arg_437_1.time_ < var_440_12 + var_440_22 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play320251103 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 320251103
		arg_441_1.duration_ = 14

		local var_441_0 = {
			zh = 9.066,
			ja = 14
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play320251104(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1089ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1089ui_story == nil then
				arg_441_1.var_.characterEffect1089ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect1089ui_story and not isNil(var_444_0) then
					arg_441_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1089ui_story then
				arg_441_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_444_4 = 0

			if var_444_4 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_1")
			end

			local var_444_5 = arg_441_1.actors_["1156ui_story"]
			local var_444_6 = 0

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 and not isNil(var_444_5) and arg_441_1.var_.characterEffect1156ui_story == nil then
				arg_441_1.var_.characterEffect1156ui_story = var_444_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_7 = 0.200000002980232

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_7 and not isNil(var_444_5) then
				local var_444_8 = (arg_441_1.time_ - var_444_6) / var_444_7

				if arg_441_1.var_.characterEffect1156ui_story and not isNil(var_444_5) then
					local var_444_9 = Mathf.Lerp(0, 0.5, var_444_8)

					arg_441_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1156ui_story.fillRatio = var_444_9
				end
			end

			if arg_441_1.time_ >= var_444_6 + var_444_7 and arg_441_1.time_ < var_444_6 + var_444_7 + arg_444_0 and not isNil(var_444_5) and arg_441_1.var_.characterEffect1156ui_story then
				local var_444_10 = 0.5

				arg_441_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1156ui_story.fillRatio = var_444_10
			end

			local var_444_11 = 0
			local var_444_12 = 1.125

			if var_444_11 < arg_441_1.time_ and arg_441_1.time_ <= var_444_11 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_13 = arg_441_1:FormatText(StoryNameCfg[1031].name)

				arg_441_1.leftNameTxt_.text = var_444_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_14 = arg_441_1:GetWordFromCfg(320251103)
				local var_444_15 = arg_441_1:FormatText(var_444_14.content)

				arg_441_1.text_.text = var_444_15

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_16 = 45
				local var_444_17 = utf8.len(var_444_15)
				local var_444_18 = var_444_16 <= 0 and var_444_12 or var_444_12 * (var_444_17 / var_444_16)

				if var_444_18 > 0 and var_444_12 < var_444_18 then
					arg_441_1.talkMaxDuration = var_444_18

					if var_444_18 + var_444_11 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_18 + var_444_11
					end
				end

				arg_441_1.text_.text = var_444_15
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251103", "story_v_out_320251.awb") ~= 0 then
					local var_444_19 = manager.audio:GetVoiceLength("story_v_out_320251", "320251103", "story_v_out_320251.awb") / 1000

					if var_444_19 + var_444_11 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_19 + var_444_11
					end

					if var_444_14.prefab_name ~= "" and arg_441_1.actors_[var_444_14.prefab_name] ~= nil then
						local var_444_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_14.prefab_name].transform, "story_v_out_320251", "320251103", "story_v_out_320251.awb")

						arg_441_1:RecordAudio("320251103", var_444_20)
						arg_441_1:RecordAudio("320251103", var_444_20)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_320251", "320251103", "story_v_out_320251.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_320251", "320251103", "story_v_out_320251.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_21 = math.max(var_444_12, arg_441_1.talkMaxDuration)

			if var_444_11 <= arg_441_1.time_ and arg_441_1.time_ < var_444_11 + var_444_21 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_11) / var_444_21

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_11 + var_444_21 and arg_441_1.time_ < var_444_11 + var_444_21 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play320251104 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 320251104
		arg_445_1.duration_ = 14.1

		local var_445_0 = {
			zh = 11.133,
			ja = 14.1
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play320251105(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 1.5

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[1031].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:GetWordFromCfg(320251104)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 60
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251104", "story_v_out_320251.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251104", "story_v_out_320251.awb") / 1000

					if var_448_8 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_0
					end

					if var_448_3.prefab_name ~= "" and arg_445_1.actors_[var_448_3.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_3.prefab_name].transform, "story_v_out_320251", "320251104", "story_v_out_320251.awb")

						arg_445_1:RecordAudio("320251104", var_448_9)
						arg_445_1:RecordAudio("320251104", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_320251", "320251104", "story_v_out_320251.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_320251", "320251104", "story_v_out_320251.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_10 and arg_445_1.time_ < var_448_0 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play320251105 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 320251105
		arg_449_1.duration_ = 14.43

		local var_449_0 = {
			zh = 7.966,
			ja = 14.433
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play320251106(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 1.1

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[1031].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_3 = arg_449_1:GetWordFromCfg(320251105)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 44
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251105", "story_v_out_320251.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251105", "story_v_out_320251.awb") / 1000

					if var_452_8 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_0
					end

					if var_452_3.prefab_name ~= "" and arg_449_1.actors_[var_452_3.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_3.prefab_name].transform, "story_v_out_320251", "320251105", "story_v_out_320251.awb")

						arg_449_1:RecordAudio("320251105", var_452_9)
						arg_449_1:RecordAudio("320251105", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_320251", "320251105", "story_v_out_320251.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_320251", "320251105", "story_v_out_320251.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_10 and arg_449_1.time_ < var_452_0 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play320251106 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 320251106
		arg_453_1.duration_ = 12.67

		local var_453_0 = {
			zh = 12.666,
			ja = 8.733
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play320251107(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_2")
			end

			local var_456_1 = 0
			local var_456_2 = 1.375

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_3 = arg_453_1:FormatText(StoryNameCfg[1031].name)

				arg_453_1.leftNameTxt_.text = var_456_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_4 = arg_453_1:GetWordFromCfg(320251106)
				local var_456_5 = arg_453_1:FormatText(var_456_4.content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_6 = 55
				local var_456_7 = utf8.len(var_456_5)
				local var_456_8 = var_456_6 <= 0 and var_456_2 or var_456_2 * (var_456_7 / var_456_6)

				if var_456_8 > 0 and var_456_2 < var_456_8 then
					arg_453_1.talkMaxDuration = var_456_8

					if var_456_8 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251106", "story_v_out_320251.awb") ~= 0 then
					local var_456_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251106", "story_v_out_320251.awb") / 1000

					if var_456_9 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_9 + var_456_1
					end

					if var_456_4.prefab_name ~= "" and arg_453_1.actors_[var_456_4.prefab_name] ~= nil then
						local var_456_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_4.prefab_name].transform, "story_v_out_320251", "320251106", "story_v_out_320251.awb")

						arg_453_1:RecordAudio("320251106", var_456_10)
						arg_453_1:RecordAudio("320251106", var_456_10)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_320251", "320251106", "story_v_out_320251.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_320251", "320251106", "story_v_out_320251.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_11 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_11 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_11

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_11 and arg_453_1.time_ < var_456_1 + var_456_11 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play320251107 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 320251107
		arg_457_1.duration_ = 13.23

		local var_457_0 = {
			zh = 13.233,
			ja = 11.466
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play320251108(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 1.45

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[1031].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_3 = arg_457_1:GetWordFromCfg(320251107)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 58
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251107", "story_v_out_320251.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251107", "story_v_out_320251.awb") / 1000

					if var_460_8 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_0
					end

					if var_460_3.prefab_name ~= "" and arg_457_1.actors_[var_460_3.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_3.prefab_name].transform, "story_v_out_320251", "320251107", "story_v_out_320251.awb")

						arg_457_1:RecordAudio("320251107", var_460_9)
						arg_457_1:RecordAudio("320251107", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_320251", "320251107", "story_v_out_320251.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_320251", "320251107", "story_v_out_320251.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_10 and arg_457_1.time_ < var_460_0 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play320251108 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 320251108
		arg_461_1.duration_ = 10.83

		local var_461_0 = {
			zh = 4.166,
			ja = 10.833
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play320251109(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_464_1 = 0
			local var_464_2 = 0.55

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_3 = arg_461_1:FormatText(StoryNameCfg[1031].name)

				arg_461_1.leftNameTxt_.text = var_464_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_4 = arg_461_1:GetWordFromCfg(320251108)
				local var_464_5 = arg_461_1:FormatText(var_464_4.content)

				arg_461_1.text_.text = var_464_5

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_6 = 22
				local var_464_7 = utf8.len(var_464_5)
				local var_464_8 = var_464_6 <= 0 and var_464_2 or var_464_2 * (var_464_7 / var_464_6)

				if var_464_8 > 0 and var_464_2 < var_464_8 then
					arg_461_1.talkMaxDuration = var_464_8

					if var_464_8 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_5
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251108", "story_v_out_320251.awb") ~= 0 then
					local var_464_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251108", "story_v_out_320251.awb") / 1000

					if var_464_9 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_1
					end

					if var_464_4.prefab_name ~= "" and arg_461_1.actors_[var_464_4.prefab_name] ~= nil then
						local var_464_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_4.prefab_name].transform, "story_v_out_320251", "320251108", "story_v_out_320251.awb")

						arg_461_1:RecordAudio("320251108", var_464_10)
						arg_461_1:RecordAudio("320251108", var_464_10)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_320251", "320251108", "story_v_out_320251.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_320251", "320251108", "story_v_out_320251.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_11 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_11 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_11

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_11 and arg_461_1.time_ < var_464_1 + var_464_11 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play320251109 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 320251109
		arg_465_1.duration_ = 13.17

		local var_465_0 = {
			zh = 10.5,
			ja = 13.166
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play320251110(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 1.2

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[1031].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:GetWordFromCfg(320251109)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 48
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251109", "story_v_out_320251.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251109", "story_v_out_320251.awb") / 1000

					if var_468_8 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_0
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_out_320251", "320251109", "story_v_out_320251.awb")

						arg_465_1:RecordAudio("320251109", var_468_9)
						arg_465_1:RecordAudio("320251109", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_320251", "320251109", "story_v_out_320251.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_320251", "320251109", "story_v_out_320251.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_10 and arg_465_1.time_ < var_468_0 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play320251110 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 320251110
		arg_469_1.duration_ = 4.59

		local var_469_0 = {
			zh = 3.125,
			ja = 4.591
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
				arg_469_0:Play320251111(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1156ui_story"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1156ui_story == nil then
				arg_469_1.var_.characterEffect1156ui_story = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect1156ui_story and not isNil(var_472_0) then
					arg_469_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1156ui_story then
				arg_469_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_472_4 = 0

			if var_472_4 < arg_469_1.time_ and arg_469_1.time_ <= var_472_4 + arg_472_0 then
				arg_469_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			local var_472_5 = 0

			if var_472_5 < arg_469_1.time_ and arg_469_1.time_ <= var_472_5 + arg_472_0 then
				arg_469_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_472_6 = arg_469_1.actors_["1089ui_story"]
			local var_472_7 = 0

			if var_472_7 < arg_469_1.time_ and arg_469_1.time_ <= var_472_7 + arg_472_0 and not isNil(var_472_6) and arg_469_1.var_.characterEffect1089ui_story == nil then
				arg_469_1.var_.characterEffect1089ui_story = var_472_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_8 = 0.200000002980232

			if var_472_7 <= arg_469_1.time_ and arg_469_1.time_ < var_472_7 + var_472_8 and not isNil(var_472_6) then
				local var_472_9 = (arg_469_1.time_ - var_472_7) / var_472_8

				if arg_469_1.var_.characterEffect1089ui_story and not isNil(var_472_6) then
					local var_472_10 = Mathf.Lerp(0, 0.5, var_472_9)

					arg_469_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1089ui_story.fillRatio = var_472_10
				end
			end

			if arg_469_1.time_ >= var_472_7 + var_472_8 and arg_469_1.time_ < var_472_7 + var_472_8 + arg_472_0 and not isNil(var_472_6) and arg_469_1.var_.characterEffect1089ui_story then
				local var_472_11 = 0.5

				arg_469_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1089ui_story.fillRatio = var_472_11
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_12 = 0.725
			local var_472_13 = 0.275

			if var_472_12 < arg_469_1.time_ and arg_469_1.time_ <= var_472_12 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_14 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_14:setOnUpdate(LuaHelper.FloatAction(function(arg_473_0)
					arg_469_1.dialogCg_.alpha = arg_473_0
				end))
				var_472_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_15 = arg_469_1:FormatText(StoryNameCfg[605].name)

				arg_469_1.leftNameTxt_.text = var_472_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_16 = arg_469_1:GetWordFromCfg(320251110)
				local var_472_17 = arg_469_1:FormatText(var_472_16.content)

				arg_469_1.text_.text = var_472_17

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_18 = 11
				local var_472_19 = utf8.len(var_472_17)
				local var_472_20 = var_472_18 <= 0 and var_472_13 or var_472_13 * (var_472_19 / var_472_18)

				if var_472_20 > 0 and var_472_13 < var_472_20 then
					arg_469_1.talkMaxDuration = var_472_20
					var_472_12 = var_472_12 + 0.3

					if var_472_20 + var_472_12 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_20 + var_472_12
					end
				end

				arg_469_1.text_.text = var_472_17
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251110", "story_v_out_320251.awb") ~= 0 then
					local var_472_21 = manager.audio:GetVoiceLength("story_v_out_320251", "320251110", "story_v_out_320251.awb") / 1000

					if var_472_21 + var_472_12 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_21 + var_472_12
					end

					if var_472_16.prefab_name ~= "" and arg_469_1.actors_[var_472_16.prefab_name] ~= nil then
						local var_472_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_16.prefab_name].transform, "story_v_out_320251", "320251110", "story_v_out_320251.awb")

						arg_469_1:RecordAudio("320251110", var_472_22)
						arg_469_1:RecordAudio("320251110", var_472_22)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_320251", "320251110", "story_v_out_320251.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_320251", "320251110", "story_v_out_320251.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_23 = var_472_12 + 0.3
			local var_472_24 = math.max(var_472_13, arg_469_1.talkMaxDuration)

			if var_472_23 <= arg_469_1.time_ and arg_469_1.time_ < var_472_23 + var_472_24 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_23) / var_472_24

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_23 + var_472_24 and arg_469_1.time_ < var_472_23 + var_472_24 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play320251111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 320251111
		arg_475_1.duration_ = 7.73

		local var_475_0 = {
			zh = 7.266,
			ja = 7.733
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play320251112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 0.9

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[605].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_3 = arg_475_1:GetWordFromCfg(320251111)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 36
				local var_478_6 = utf8.len(var_478_4)
				local var_478_7 = var_478_5 <= 0 and var_478_1 or var_478_1 * (var_478_6 / var_478_5)

				if var_478_7 > 0 and var_478_1 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251111", "story_v_out_320251.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251111", "story_v_out_320251.awb") / 1000

					if var_478_8 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_0
					end

					if var_478_3.prefab_name ~= "" and arg_475_1.actors_[var_478_3.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_3.prefab_name].transform, "story_v_out_320251", "320251111", "story_v_out_320251.awb")

						arg_475_1:RecordAudio("320251111", var_478_9)
						arg_475_1:RecordAudio("320251111", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_320251", "320251111", "story_v_out_320251.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_320251", "320251111", "story_v_out_320251.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_10 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_10 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_10

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_10 and arg_475_1.time_ < var_478_0 + var_478_10 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play320251112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 320251112
		arg_479_1.duration_ = 9.6

		local var_479_0 = {
			zh = 7.333,
			ja = 9.6
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play320251113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1089ui_story"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1089ui_story == nil then
				arg_479_1.var_.characterEffect1089ui_story = var_482_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.characterEffect1089ui_story and not isNil(var_482_0) then
					arg_479_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1089ui_story then
				arg_479_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_482_4 = 0

			if var_482_4 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_482_5 = 0

			if var_482_5 < arg_479_1.time_ and arg_479_1.time_ <= var_482_5 + arg_482_0 then
				arg_479_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_482_6 = arg_479_1.actors_["1156ui_story"]
			local var_482_7 = 0

			if var_482_7 < arg_479_1.time_ and arg_479_1.time_ <= var_482_7 + arg_482_0 and not isNil(var_482_6) and arg_479_1.var_.characterEffect1156ui_story == nil then
				arg_479_1.var_.characterEffect1156ui_story = var_482_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_8 = 0.200000002980232

			if var_482_7 <= arg_479_1.time_ and arg_479_1.time_ < var_482_7 + var_482_8 and not isNil(var_482_6) then
				local var_482_9 = (arg_479_1.time_ - var_482_7) / var_482_8

				if arg_479_1.var_.characterEffect1156ui_story and not isNil(var_482_6) then
					local var_482_10 = Mathf.Lerp(0, 0.5, var_482_9)

					arg_479_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1156ui_story.fillRatio = var_482_10
				end
			end

			if arg_479_1.time_ >= var_482_7 + var_482_8 and arg_479_1.time_ < var_482_7 + var_482_8 + arg_482_0 and not isNil(var_482_6) and arg_479_1.var_.characterEffect1156ui_story then
				local var_482_11 = 0.5

				arg_479_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1156ui_story.fillRatio = var_482_11
			end

			local var_482_12 = 0
			local var_482_13 = 0.85

			if var_482_12 < arg_479_1.time_ and arg_479_1.time_ <= var_482_12 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_14 = arg_479_1:FormatText(StoryNameCfg[1031].name)

				arg_479_1.leftNameTxt_.text = var_482_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_15 = arg_479_1:GetWordFromCfg(320251112)
				local var_482_16 = arg_479_1:FormatText(var_482_15.content)

				arg_479_1.text_.text = var_482_16

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_17 = 34
				local var_482_18 = utf8.len(var_482_16)
				local var_482_19 = var_482_17 <= 0 and var_482_13 or var_482_13 * (var_482_18 / var_482_17)

				if var_482_19 > 0 and var_482_13 < var_482_19 then
					arg_479_1.talkMaxDuration = var_482_19

					if var_482_19 + var_482_12 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_19 + var_482_12
					end
				end

				arg_479_1.text_.text = var_482_16
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251112", "story_v_out_320251.awb") ~= 0 then
					local var_482_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251112", "story_v_out_320251.awb") / 1000

					if var_482_20 + var_482_12 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_20 + var_482_12
					end

					if var_482_15.prefab_name ~= "" and arg_479_1.actors_[var_482_15.prefab_name] ~= nil then
						local var_482_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_15.prefab_name].transform, "story_v_out_320251", "320251112", "story_v_out_320251.awb")

						arg_479_1:RecordAudio("320251112", var_482_21)
						arg_479_1:RecordAudio("320251112", var_482_21)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_320251", "320251112", "story_v_out_320251.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_320251", "320251112", "story_v_out_320251.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_22 = math.max(var_482_13, arg_479_1.talkMaxDuration)

			if var_482_12 <= arg_479_1.time_ and arg_479_1.time_ < var_482_12 + var_482_22 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_12) / var_482_22

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_12 + var_482_22 and arg_479_1.time_ < var_482_12 + var_482_22 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play320251113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 320251113
		arg_483_1.duration_ = 6.23

		local var_483_0 = {
			zh = 2.033,
			ja = 6.233
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play320251114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1156ui_story"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1156ui_story == nil then
				arg_483_1.var_.characterEffect1156ui_story = var_486_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 and not isNil(var_486_0) then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.characterEffect1156ui_story and not isNil(var_486_0) then
					arg_483_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and not isNil(var_486_0) and arg_483_1.var_.characterEffect1156ui_story then
				arg_483_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_486_4 = 0

			if var_486_4 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			local var_486_5 = 0

			if var_486_5 < arg_483_1.time_ and arg_483_1.time_ <= var_486_5 + arg_486_0 then
				arg_483_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_486_6 = arg_483_1.actors_["1089ui_story"]
			local var_486_7 = 0

			if var_486_7 < arg_483_1.time_ and arg_483_1.time_ <= var_486_7 + arg_486_0 and not isNil(var_486_6) and arg_483_1.var_.characterEffect1089ui_story == nil then
				arg_483_1.var_.characterEffect1089ui_story = var_486_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_8 = 0.200000002980232

			if var_486_7 <= arg_483_1.time_ and arg_483_1.time_ < var_486_7 + var_486_8 and not isNil(var_486_6) then
				local var_486_9 = (arg_483_1.time_ - var_486_7) / var_486_8

				if arg_483_1.var_.characterEffect1089ui_story and not isNil(var_486_6) then
					local var_486_10 = Mathf.Lerp(0, 0.5, var_486_9)

					arg_483_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1089ui_story.fillRatio = var_486_10
				end
			end

			if arg_483_1.time_ >= var_486_7 + var_486_8 and arg_483_1.time_ < var_486_7 + var_486_8 + arg_486_0 and not isNil(var_486_6) and arg_483_1.var_.characterEffect1089ui_story then
				local var_486_11 = 0.5

				arg_483_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1089ui_story.fillRatio = var_486_11
			end

			local var_486_12 = 0
			local var_486_13 = 0.325

			if var_486_12 < arg_483_1.time_ and arg_483_1.time_ <= var_486_12 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_14 = arg_483_1:FormatText(StoryNameCfg[605].name)

				arg_483_1.leftNameTxt_.text = var_486_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_15 = arg_483_1:GetWordFromCfg(320251113)
				local var_486_16 = arg_483_1:FormatText(var_486_15.content)

				arg_483_1.text_.text = var_486_16

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_17 = 13
				local var_486_18 = utf8.len(var_486_16)
				local var_486_19 = var_486_17 <= 0 and var_486_13 or var_486_13 * (var_486_18 / var_486_17)

				if var_486_19 > 0 and var_486_13 < var_486_19 then
					arg_483_1.talkMaxDuration = var_486_19

					if var_486_19 + var_486_12 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_19 + var_486_12
					end
				end

				arg_483_1.text_.text = var_486_16
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251113", "story_v_out_320251.awb") ~= 0 then
					local var_486_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251113", "story_v_out_320251.awb") / 1000

					if var_486_20 + var_486_12 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_20 + var_486_12
					end

					if var_486_15.prefab_name ~= "" and arg_483_1.actors_[var_486_15.prefab_name] ~= nil then
						local var_486_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_15.prefab_name].transform, "story_v_out_320251", "320251113", "story_v_out_320251.awb")

						arg_483_1:RecordAudio("320251113", var_486_21)
						arg_483_1:RecordAudio("320251113", var_486_21)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_320251", "320251113", "story_v_out_320251.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_320251", "320251113", "story_v_out_320251.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_22 = math.max(var_486_13, arg_483_1.talkMaxDuration)

			if var_486_12 <= arg_483_1.time_ and arg_483_1.time_ < var_486_12 + var_486_22 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_12) / var_486_22

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_12 + var_486_22 and arg_483_1.time_ < var_486_12 + var_486_22 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play320251114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 320251114
		arg_487_1.duration_ = 7.1

		local var_487_0 = {
			zh = 7.1,
			ja = 6.733
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play320251115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["1156ui_story"]
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.characterEffect1156ui_story == nil then
				arg_487_1.var_.characterEffect1156ui_story = var_490_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_2 = 0.200000002980232

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 and not isNil(var_490_0) then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2

				if arg_487_1.var_.characterEffect1156ui_story and not isNil(var_490_0) then
					local var_490_4 = Mathf.Lerp(0, 0.5, var_490_3)

					arg_487_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1156ui_story.fillRatio = var_490_4
				end
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.characterEffect1156ui_story then
				local var_490_5 = 0.5

				arg_487_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1156ui_story.fillRatio = var_490_5
			end

			local var_490_6 = arg_487_1.actors_["1089ui_story"]
			local var_490_7 = 0

			if var_490_7 < arg_487_1.time_ and arg_487_1.time_ <= var_490_7 + arg_490_0 and not isNil(var_490_6) and arg_487_1.var_.characterEffect1089ui_story == nil then
				arg_487_1.var_.characterEffect1089ui_story = var_490_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_8 = 0.200000002980232

			if var_490_7 <= arg_487_1.time_ and arg_487_1.time_ < var_490_7 + var_490_8 and not isNil(var_490_6) then
				local var_490_9 = (arg_487_1.time_ - var_490_7) / var_490_8

				if arg_487_1.var_.characterEffect1089ui_story and not isNil(var_490_6) then
					arg_487_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= var_490_7 + var_490_8 and arg_487_1.time_ < var_490_7 + var_490_8 + arg_490_0 and not isNil(var_490_6) and arg_487_1.var_.characterEffect1089ui_story then
				arg_487_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_490_10 = 0
			local var_490_11 = 0.525

			if var_490_10 < arg_487_1.time_ and arg_487_1.time_ <= var_490_10 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_12 = arg_487_1:FormatText(StoryNameCfg[1031].name)

				arg_487_1.leftNameTxt_.text = var_490_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_13 = arg_487_1:GetWordFromCfg(320251114)
				local var_490_14 = arg_487_1:FormatText(var_490_13.content)

				arg_487_1.text_.text = var_490_14

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_15 = 21
				local var_490_16 = utf8.len(var_490_14)
				local var_490_17 = var_490_15 <= 0 and var_490_11 or var_490_11 * (var_490_16 / var_490_15)

				if var_490_17 > 0 and var_490_11 < var_490_17 then
					arg_487_1.talkMaxDuration = var_490_17

					if var_490_17 + var_490_10 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_17 + var_490_10
					end
				end

				arg_487_1.text_.text = var_490_14
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251114", "story_v_out_320251.awb") ~= 0 then
					local var_490_18 = manager.audio:GetVoiceLength("story_v_out_320251", "320251114", "story_v_out_320251.awb") / 1000

					if var_490_18 + var_490_10 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_18 + var_490_10
					end

					if var_490_13.prefab_name ~= "" and arg_487_1.actors_[var_490_13.prefab_name] ~= nil then
						local var_490_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_13.prefab_name].transform, "story_v_out_320251", "320251114", "story_v_out_320251.awb")

						arg_487_1:RecordAudio("320251114", var_490_19)
						arg_487_1:RecordAudio("320251114", var_490_19)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_320251", "320251114", "story_v_out_320251.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_320251", "320251114", "story_v_out_320251.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_20 = math.max(var_490_11, arg_487_1.talkMaxDuration)

			if var_490_10 <= arg_487_1.time_ and arg_487_1.time_ < var_490_10 + var_490_20 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_10) / var_490_20

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_10 + var_490_20 and arg_487_1.time_ < var_490_10 + var_490_20 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play320251115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 320251115
		arg_491_1.duration_ = 15

		local var_491_0 = {
			zh = 14.4,
			ja = 15
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play320251116(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_494_1 = 0
			local var_494_2 = 1.65

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_3 = arg_491_1:FormatText(StoryNameCfg[1031].name)

				arg_491_1.leftNameTxt_.text = var_494_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_4 = arg_491_1:GetWordFromCfg(320251115)
				local var_494_5 = arg_491_1:FormatText(var_494_4.content)

				arg_491_1.text_.text = var_494_5

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_6 = 66
				local var_494_7 = utf8.len(var_494_5)
				local var_494_8 = var_494_6 <= 0 and var_494_2 or var_494_2 * (var_494_7 / var_494_6)

				if var_494_8 > 0 and var_494_2 < var_494_8 then
					arg_491_1.talkMaxDuration = var_494_8

					if var_494_8 + var_494_1 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_1
					end
				end

				arg_491_1.text_.text = var_494_5
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251115", "story_v_out_320251.awb") ~= 0 then
					local var_494_9 = manager.audio:GetVoiceLength("story_v_out_320251", "320251115", "story_v_out_320251.awb") / 1000

					if var_494_9 + var_494_1 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_9 + var_494_1
					end

					if var_494_4.prefab_name ~= "" and arg_491_1.actors_[var_494_4.prefab_name] ~= nil then
						local var_494_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_4.prefab_name].transform, "story_v_out_320251", "320251115", "story_v_out_320251.awb")

						arg_491_1:RecordAudio("320251115", var_494_10)
						arg_491_1:RecordAudio("320251115", var_494_10)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_320251", "320251115", "story_v_out_320251.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_320251", "320251115", "story_v_out_320251.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_11 = math.max(var_494_2, arg_491_1.talkMaxDuration)

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_11 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_1) / var_494_11

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_1 + var_494_11 and arg_491_1.time_ < var_494_1 + var_494_11 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play320251116 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 320251116
		arg_495_1.duration_ = 13.73

		local var_495_0 = {
			zh = 13.6,
			ja = 13.733
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play320251117(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 1.5

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[1031].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_3 = arg_495_1:GetWordFromCfg(320251116)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 60
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251116", "story_v_out_320251.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251116", "story_v_out_320251.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_320251", "320251116", "story_v_out_320251.awb")

						arg_495_1:RecordAudio("320251116", var_498_9)
						arg_495_1:RecordAudio("320251116", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_320251", "320251116", "story_v_out_320251.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_320251", "320251116", "story_v_out_320251.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_10 and arg_495_1.time_ < var_498_0 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play320251117 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 320251117
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play320251118(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1156ui_story"].transform
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.var_.moveOldPos1156ui_story = var_502_0.localPosition
			end

			local var_502_2 = 0.001

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2
				local var_502_4 = Vector3.New(0, 100, 0)

				var_502_0.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1156ui_story, var_502_4, var_502_3)

				local var_502_5 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_5.x, var_502_5.y, var_502_5.z)

				local var_502_6 = var_502_0.localEulerAngles

				var_502_6.z = 0
				var_502_6.x = 0
				var_502_0.localEulerAngles = var_502_6
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 then
				var_502_0.localPosition = Vector3.New(0, 100, 0)

				local var_502_7 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_7.x, var_502_7.y, var_502_7.z)

				local var_502_8 = var_502_0.localEulerAngles

				var_502_8.z = 0
				var_502_8.x = 0
				var_502_0.localEulerAngles = var_502_8
			end

			local var_502_9 = arg_499_1.actors_["1156ui_story"]
			local var_502_10 = 0

			if var_502_10 < arg_499_1.time_ and arg_499_1.time_ <= var_502_10 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect1156ui_story == nil then
				arg_499_1.var_.characterEffect1156ui_story = var_502_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_11 = 0.200000002980232

			if var_502_10 <= arg_499_1.time_ and arg_499_1.time_ < var_502_10 + var_502_11 and not isNil(var_502_9) then
				local var_502_12 = (arg_499_1.time_ - var_502_10) / var_502_11

				if arg_499_1.var_.characterEffect1156ui_story and not isNil(var_502_9) then
					local var_502_13 = Mathf.Lerp(0, 0.5, var_502_12)

					arg_499_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1156ui_story.fillRatio = var_502_13
				end
			end

			if arg_499_1.time_ >= var_502_10 + var_502_11 and arg_499_1.time_ < var_502_10 + var_502_11 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect1156ui_story then
				local var_502_14 = 0.5

				arg_499_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1156ui_story.fillRatio = var_502_14
			end

			local var_502_15 = arg_499_1.actors_["1089ui_story"].transform
			local var_502_16 = 0

			if var_502_16 < arg_499_1.time_ and arg_499_1.time_ <= var_502_16 + arg_502_0 then
				arg_499_1.var_.moveOldPos1089ui_story = var_502_15.localPosition
			end

			local var_502_17 = 0.001

			if var_502_16 <= arg_499_1.time_ and arg_499_1.time_ < var_502_16 + var_502_17 then
				local var_502_18 = (arg_499_1.time_ - var_502_16) / var_502_17
				local var_502_19 = Vector3.New(0, 100, 0)

				var_502_15.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1089ui_story, var_502_19, var_502_18)

				local var_502_20 = manager.ui.mainCamera.transform.position - var_502_15.position

				var_502_15.forward = Vector3.New(var_502_20.x, var_502_20.y, var_502_20.z)

				local var_502_21 = var_502_15.localEulerAngles

				var_502_21.z = 0
				var_502_21.x = 0
				var_502_15.localEulerAngles = var_502_21
			end

			if arg_499_1.time_ >= var_502_16 + var_502_17 and arg_499_1.time_ < var_502_16 + var_502_17 + arg_502_0 then
				var_502_15.localPosition = Vector3.New(0, 100, 0)

				local var_502_22 = manager.ui.mainCamera.transform.position - var_502_15.position

				var_502_15.forward = Vector3.New(var_502_22.x, var_502_22.y, var_502_22.z)

				local var_502_23 = var_502_15.localEulerAngles

				var_502_23.z = 0
				var_502_23.x = 0
				var_502_15.localEulerAngles = var_502_23
			end

			local var_502_24 = arg_499_1.actors_["1089ui_story"]
			local var_502_25 = 0

			if var_502_25 < arg_499_1.time_ and arg_499_1.time_ <= var_502_25 + arg_502_0 and not isNil(var_502_24) and arg_499_1.var_.characterEffect1089ui_story == nil then
				arg_499_1.var_.characterEffect1089ui_story = var_502_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_26 = 0.200000002980232

			if var_502_25 <= arg_499_1.time_ and arg_499_1.time_ < var_502_25 + var_502_26 and not isNil(var_502_24) then
				local var_502_27 = (arg_499_1.time_ - var_502_25) / var_502_26

				if arg_499_1.var_.characterEffect1089ui_story and not isNil(var_502_24) then
					local var_502_28 = Mathf.Lerp(0, 0.5, var_502_27)

					arg_499_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1089ui_story.fillRatio = var_502_28
				end
			end

			if arg_499_1.time_ >= var_502_25 + var_502_26 and arg_499_1.time_ < var_502_25 + var_502_26 + arg_502_0 and not isNil(var_502_24) and arg_499_1.var_.characterEffect1089ui_story then
				local var_502_29 = 0.5

				arg_499_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1089ui_story.fillRatio = var_502_29
			end

			local var_502_30 = 0
			local var_502_31 = 1.025

			if var_502_30 < arg_499_1.time_ and arg_499_1.time_ <= var_502_30 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_32 = arg_499_1:GetWordFromCfg(320251117)
				local var_502_33 = arg_499_1:FormatText(var_502_32.content)

				arg_499_1.text_.text = var_502_33

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_34 = 41
				local var_502_35 = utf8.len(var_502_33)
				local var_502_36 = var_502_34 <= 0 and var_502_31 or var_502_31 * (var_502_35 / var_502_34)

				if var_502_36 > 0 and var_502_31 < var_502_36 then
					arg_499_1.talkMaxDuration = var_502_36

					if var_502_36 + var_502_30 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_36 + var_502_30
					end
				end

				arg_499_1.text_.text = var_502_33
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_37 = math.max(var_502_31, arg_499_1.talkMaxDuration)

			if var_502_30 <= arg_499_1.time_ and arg_499_1.time_ < var_502_30 + var_502_37 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_30) / var_502_37

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_30 + var_502_37 and arg_499_1.time_ < var_502_30 + var_502_37 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
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
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play320251118 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 320251118
		arg_503_1.duration_ = 4.93

		local var_503_0 = {
			zh = 1.999999999999,
			ja = 4.933
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play320251119(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1156ui_story"].transform
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.var_.moveOldPos1156ui_story = var_506_0.localPosition
			end

			local var_506_2 = 0.001

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2
				local var_506_4 = Vector3.New(0.9, -1.1, -6.18)

				var_506_0.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1156ui_story, var_506_4, var_506_3)

				local var_506_5 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_5.x, var_506_5.y, var_506_5.z)

				local var_506_6 = var_506_0.localEulerAngles

				var_506_6.z = 0
				var_506_6.x = 0
				var_506_0.localEulerAngles = var_506_6
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 then
				var_506_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_506_7 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_7.x, var_506_7.y, var_506_7.z)

				local var_506_8 = var_506_0.localEulerAngles

				var_506_8.z = 0
				var_506_8.x = 0
				var_506_0.localEulerAngles = var_506_8
			end

			local var_506_9 = arg_503_1.actors_["1156ui_story"]
			local var_506_10 = 0

			if var_506_10 < arg_503_1.time_ and arg_503_1.time_ <= var_506_10 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect1156ui_story == nil then
				arg_503_1.var_.characterEffect1156ui_story = var_506_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_11 = 0.200000002980232

			if var_506_10 <= arg_503_1.time_ and arg_503_1.time_ < var_506_10 + var_506_11 and not isNil(var_506_9) then
				local var_506_12 = (arg_503_1.time_ - var_506_10) / var_506_11

				if arg_503_1.var_.characterEffect1156ui_story and not isNil(var_506_9) then
					arg_503_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_10 + var_506_11 and arg_503_1.time_ < var_506_10 + var_506_11 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect1156ui_story then
				arg_503_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_506_13 = 0

			if var_506_13 < arg_503_1.time_ and arg_503_1.time_ <= var_506_13 + arg_506_0 then
				arg_503_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_1")
			end

			local var_506_14 = 0

			if var_506_14 < arg_503_1.time_ and arg_503_1.time_ <= var_506_14 + arg_506_0 then
				arg_503_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_506_15 = 0
			local var_506_16 = 0.25

			if var_506_15 < arg_503_1.time_ and arg_503_1.time_ <= var_506_15 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_17 = arg_503_1:FormatText(StoryNameCfg[605].name)

				arg_503_1.leftNameTxt_.text = var_506_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_18 = arg_503_1:GetWordFromCfg(320251118)
				local var_506_19 = arg_503_1:FormatText(var_506_18.content)

				arg_503_1.text_.text = var_506_19

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_20 = 10
				local var_506_21 = utf8.len(var_506_19)
				local var_506_22 = var_506_20 <= 0 and var_506_16 or var_506_16 * (var_506_21 / var_506_20)

				if var_506_22 > 0 and var_506_16 < var_506_22 then
					arg_503_1.talkMaxDuration = var_506_22

					if var_506_22 + var_506_15 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_22 + var_506_15
					end
				end

				arg_503_1.text_.text = var_506_19
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251118", "story_v_out_320251.awb") ~= 0 then
					local var_506_23 = manager.audio:GetVoiceLength("story_v_out_320251", "320251118", "story_v_out_320251.awb") / 1000

					if var_506_23 + var_506_15 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_23 + var_506_15
					end

					if var_506_18.prefab_name ~= "" and arg_503_1.actors_[var_506_18.prefab_name] ~= nil then
						local var_506_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_18.prefab_name].transform, "story_v_out_320251", "320251118", "story_v_out_320251.awb")

						arg_503_1:RecordAudio("320251118", var_506_24)
						arg_503_1:RecordAudio("320251118", var_506_24)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_320251", "320251118", "story_v_out_320251.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_320251", "320251118", "story_v_out_320251.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_25 = math.max(var_506_16, arg_503_1.talkMaxDuration)

			if var_506_15 <= arg_503_1.time_ and arg_503_1.time_ < var_506_15 + var_506_25 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_15) / var_506_25

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_15 + var_506_25 and arg_503_1.time_ < var_506_15 + var_506_25 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
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

		arg_503_1:InitPlayNodeList()
	end,
	Play320251119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 320251119
		arg_507_1.duration_ = 13.6

		local var_507_0 = {
			zh = 13.6,
			ja = 13.4
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play320251120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1089ui_story"].transform
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.var_.moveOldPos1089ui_story = var_510_0.localPosition
			end

			local var_510_2 = 0.001

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2
				local var_510_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_510_0.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1089ui_story, var_510_4, var_510_3)

				local var_510_5 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_5.x, var_510_5.y, var_510_5.z)

				local var_510_6 = var_510_0.localEulerAngles

				var_510_6.z = 0
				var_510_6.x = 0
				var_510_0.localEulerAngles = var_510_6
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 then
				var_510_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_510_7 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_7.x, var_510_7.y, var_510_7.z)

				local var_510_8 = var_510_0.localEulerAngles

				var_510_8.z = 0
				var_510_8.x = 0
				var_510_0.localEulerAngles = var_510_8
			end

			local var_510_9 = arg_507_1.actors_["1089ui_story"]
			local var_510_10 = 0

			if var_510_10 < arg_507_1.time_ and arg_507_1.time_ <= var_510_10 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect1089ui_story == nil then
				arg_507_1.var_.characterEffect1089ui_story = var_510_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_11 = 0.200000002980232

			if var_510_10 <= arg_507_1.time_ and arg_507_1.time_ < var_510_10 + var_510_11 and not isNil(var_510_9) then
				local var_510_12 = (arg_507_1.time_ - var_510_10) / var_510_11

				if arg_507_1.var_.characterEffect1089ui_story and not isNil(var_510_9) then
					arg_507_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= var_510_10 + var_510_11 and arg_507_1.time_ < var_510_10 + var_510_11 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect1089ui_story then
				arg_507_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_510_13 = 0

			if var_510_13 < arg_507_1.time_ and arg_507_1.time_ <= var_510_13 + arg_510_0 then
				arg_507_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_510_14 = 0

			if var_510_14 < arg_507_1.time_ and arg_507_1.time_ <= var_510_14 + arg_510_0 then
				arg_507_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_510_15 = arg_507_1.actors_["1156ui_story"]
			local var_510_16 = 0

			if var_510_16 < arg_507_1.time_ and arg_507_1.time_ <= var_510_16 + arg_510_0 and not isNil(var_510_15) and arg_507_1.var_.characterEffect1156ui_story == nil then
				arg_507_1.var_.characterEffect1156ui_story = var_510_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_17 = 0.200000002980232

			if var_510_16 <= arg_507_1.time_ and arg_507_1.time_ < var_510_16 + var_510_17 and not isNil(var_510_15) then
				local var_510_18 = (arg_507_1.time_ - var_510_16) / var_510_17

				if arg_507_1.var_.characterEffect1156ui_story and not isNil(var_510_15) then
					local var_510_19 = Mathf.Lerp(0, 0.5, var_510_18)

					arg_507_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1156ui_story.fillRatio = var_510_19
				end
			end

			if arg_507_1.time_ >= var_510_16 + var_510_17 and arg_507_1.time_ < var_510_16 + var_510_17 + arg_510_0 and not isNil(var_510_15) and arg_507_1.var_.characterEffect1156ui_story then
				local var_510_20 = 0.5

				arg_507_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1156ui_story.fillRatio = var_510_20
			end

			local var_510_21 = 0
			local var_510_22 = 1.625

			if var_510_21 < arg_507_1.time_ and arg_507_1.time_ <= var_510_21 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_23 = arg_507_1:FormatText(StoryNameCfg[1031].name)

				arg_507_1.leftNameTxt_.text = var_510_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_24 = arg_507_1:GetWordFromCfg(320251119)
				local var_510_25 = arg_507_1:FormatText(var_510_24.content)

				arg_507_1.text_.text = var_510_25

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_26 = 65
				local var_510_27 = utf8.len(var_510_25)
				local var_510_28 = var_510_26 <= 0 and var_510_22 or var_510_22 * (var_510_27 / var_510_26)

				if var_510_28 > 0 and var_510_22 < var_510_28 then
					arg_507_1.talkMaxDuration = var_510_28

					if var_510_28 + var_510_21 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_28 + var_510_21
					end
				end

				arg_507_1.text_.text = var_510_25
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251119", "story_v_out_320251.awb") ~= 0 then
					local var_510_29 = manager.audio:GetVoiceLength("story_v_out_320251", "320251119", "story_v_out_320251.awb") / 1000

					if var_510_29 + var_510_21 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_29 + var_510_21
					end

					if var_510_24.prefab_name ~= "" and arg_507_1.actors_[var_510_24.prefab_name] ~= nil then
						local var_510_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_24.prefab_name].transform, "story_v_out_320251", "320251119", "story_v_out_320251.awb")

						arg_507_1:RecordAudio("320251119", var_510_30)
						arg_507_1:RecordAudio("320251119", var_510_30)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_320251", "320251119", "story_v_out_320251.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_320251", "320251119", "story_v_out_320251.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_31 = math.max(var_510_22, arg_507_1.talkMaxDuration)

			if var_510_21 <= arg_507_1.time_ and arg_507_1.time_ < var_510_21 + var_510_31 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_21) / var_510_31

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_21 + var_510_31 and arg_507_1.time_ < var_510_21 + var_510_31 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
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

		arg_507_1:InitPlayNodeList()
	end,
	Play320251120 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 320251120
		arg_511_1.duration_ = 10.07

		local var_511_0 = {
			zh = 8.1,
			ja = 10.066
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play320251121(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 0.925

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_2 = arg_511_1:FormatText(StoryNameCfg[1031].name)

				arg_511_1.leftNameTxt_.text = var_514_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:GetWordFromCfg(320251120)
				local var_514_4 = arg_511_1:FormatText(var_514_3.content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 37
				local var_514_6 = utf8.len(var_514_4)
				local var_514_7 = var_514_5 <= 0 and var_514_1 or var_514_1 * (var_514_6 / var_514_5)

				if var_514_7 > 0 and var_514_1 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251120", "story_v_out_320251.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_320251", "320251120", "story_v_out_320251.awb") / 1000

					if var_514_8 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_0
					end

					if var_514_3.prefab_name ~= "" and arg_511_1.actors_[var_514_3.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_3.prefab_name].transform, "story_v_out_320251", "320251120", "story_v_out_320251.awb")

						arg_511_1:RecordAudio("320251120", var_514_9)
						arg_511_1:RecordAudio("320251120", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_320251", "320251120", "story_v_out_320251.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_320251", "320251120", "story_v_out_320251.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_10 and arg_511_1.time_ < var_514_0 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play320251121 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 320251121
		arg_515_1.duration_ = 6.23

		local var_515_0 = {
			zh = 3.6,
			ja = 6.233
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play320251122(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1156ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos1156ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(0.9, -1.1, -6.18)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1156ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = arg_515_1.actors_["1156ui_story"]
			local var_518_10 = 0

			if var_518_10 < arg_515_1.time_ and arg_515_1.time_ <= var_518_10 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1156ui_story == nil then
				arg_515_1.var_.characterEffect1156ui_story = var_518_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_11 = 0.200000002980232

			if var_518_10 <= arg_515_1.time_ and arg_515_1.time_ < var_518_10 + var_518_11 and not isNil(var_518_9) then
				local var_518_12 = (arg_515_1.time_ - var_518_10) / var_518_11

				if arg_515_1.var_.characterEffect1156ui_story and not isNil(var_518_9) then
					arg_515_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= var_518_10 + var_518_11 and arg_515_1.time_ < var_518_10 + var_518_11 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1156ui_story then
				arg_515_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_518_13 = 0

			if var_518_13 < arg_515_1.time_ and arg_515_1.time_ <= var_518_13 + arg_518_0 then
				arg_515_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_2")
			end

			local var_518_14 = 0

			if var_518_14 < arg_515_1.time_ and arg_515_1.time_ <= var_518_14 + arg_518_0 then
				arg_515_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_518_15 = arg_515_1.actors_["1089ui_story"]
			local var_518_16 = 0

			if var_518_16 < arg_515_1.time_ and arg_515_1.time_ <= var_518_16 + arg_518_0 and not isNil(var_518_15) and arg_515_1.var_.characterEffect1089ui_story == nil then
				arg_515_1.var_.characterEffect1089ui_story = var_518_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_17 = 0.200000002980232

			if var_518_16 <= arg_515_1.time_ and arg_515_1.time_ < var_518_16 + var_518_17 and not isNil(var_518_15) then
				local var_518_18 = (arg_515_1.time_ - var_518_16) / var_518_17

				if arg_515_1.var_.characterEffect1089ui_story and not isNil(var_518_15) then
					local var_518_19 = Mathf.Lerp(0, 0.5, var_518_18)

					arg_515_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1089ui_story.fillRatio = var_518_19
				end
			end

			if arg_515_1.time_ >= var_518_16 + var_518_17 and arg_515_1.time_ < var_518_16 + var_518_17 + arg_518_0 and not isNil(var_518_15) and arg_515_1.var_.characterEffect1089ui_story then
				local var_518_20 = 0.5

				arg_515_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1089ui_story.fillRatio = var_518_20
			end

			local var_518_21 = 0
			local var_518_22 = 0.525

			if var_518_21 < arg_515_1.time_ and arg_515_1.time_ <= var_518_21 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_23 = arg_515_1:FormatText(StoryNameCfg[605].name)

				arg_515_1.leftNameTxt_.text = var_518_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_24 = arg_515_1:GetWordFromCfg(320251121)
				local var_518_25 = arg_515_1:FormatText(var_518_24.content)

				arg_515_1.text_.text = var_518_25

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_26 = 21
				local var_518_27 = utf8.len(var_518_25)
				local var_518_28 = var_518_26 <= 0 and var_518_22 or var_518_22 * (var_518_27 / var_518_26)

				if var_518_28 > 0 and var_518_22 < var_518_28 then
					arg_515_1.talkMaxDuration = var_518_28

					if var_518_28 + var_518_21 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_28 + var_518_21
					end
				end

				arg_515_1.text_.text = var_518_25
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251121", "story_v_out_320251.awb") ~= 0 then
					local var_518_29 = manager.audio:GetVoiceLength("story_v_out_320251", "320251121", "story_v_out_320251.awb") / 1000

					if var_518_29 + var_518_21 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_29 + var_518_21
					end

					if var_518_24.prefab_name ~= "" and arg_515_1.actors_[var_518_24.prefab_name] ~= nil then
						local var_518_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_24.prefab_name].transform, "story_v_out_320251", "320251121", "story_v_out_320251.awb")

						arg_515_1:RecordAudio("320251121", var_518_30)
						arg_515_1:RecordAudio("320251121", var_518_30)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_320251", "320251121", "story_v_out_320251.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_320251", "320251121", "story_v_out_320251.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_31 = math.max(var_518_22, arg_515_1.talkMaxDuration)

			if var_518_21 <= arg_515_1.time_ and arg_515_1.time_ < var_518_21 + var_518_31 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_21) / var_518_31

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_21 + var_518_31 and arg_515_1.time_ < var_518_21 + var_518_31 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
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

		arg_515_1:InitPlayNodeList()
	end,
	Play320251122 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 320251122
		arg_519_1.duration_ = 5.4

		local var_519_0 = {
			zh = 5.4,
			ja = 4.6
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play320251123(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["1089ui_story"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1089ui_story == nil then
				arg_519_1.var_.characterEffect1089ui_story = var_522_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 and not isNil(var_522_0) then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.characterEffect1089ui_story and not isNil(var_522_0) then
					arg_519_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and not isNil(var_522_0) and arg_519_1.var_.characterEffect1089ui_story then
				arg_519_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_522_4 = 0

			if var_522_4 < arg_519_1.time_ and arg_519_1.time_ <= var_522_4 + arg_522_0 then
				arg_519_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_522_5 = 0

			if var_522_5 < arg_519_1.time_ and arg_519_1.time_ <= var_522_5 + arg_522_0 then
				arg_519_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_522_6 = arg_519_1.actors_["1156ui_story"]
			local var_522_7 = 0

			if var_522_7 < arg_519_1.time_ and arg_519_1.time_ <= var_522_7 + arg_522_0 and not isNil(var_522_6) and arg_519_1.var_.characterEffect1156ui_story == nil then
				arg_519_1.var_.characterEffect1156ui_story = var_522_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_8 = 0.200000002980232

			if var_522_7 <= arg_519_1.time_ and arg_519_1.time_ < var_522_7 + var_522_8 and not isNil(var_522_6) then
				local var_522_9 = (arg_519_1.time_ - var_522_7) / var_522_8

				if arg_519_1.var_.characterEffect1156ui_story and not isNil(var_522_6) then
					local var_522_10 = Mathf.Lerp(0, 0.5, var_522_9)

					arg_519_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1156ui_story.fillRatio = var_522_10
				end
			end

			if arg_519_1.time_ >= var_522_7 + var_522_8 and arg_519_1.time_ < var_522_7 + var_522_8 + arg_522_0 and not isNil(var_522_6) and arg_519_1.var_.characterEffect1156ui_story then
				local var_522_11 = 0.5

				arg_519_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1156ui_story.fillRatio = var_522_11
			end

			local var_522_12 = 0
			local var_522_13 = 0.5

			if var_522_12 < arg_519_1.time_ and arg_519_1.time_ <= var_522_12 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_14 = arg_519_1:FormatText(StoryNameCfg[1031].name)

				arg_519_1.leftNameTxt_.text = var_522_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_15 = arg_519_1:GetWordFromCfg(320251122)
				local var_522_16 = arg_519_1:FormatText(var_522_15.content)

				arg_519_1.text_.text = var_522_16

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_17 = 20
				local var_522_18 = utf8.len(var_522_16)
				local var_522_19 = var_522_17 <= 0 and var_522_13 or var_522_13 * (var_522_18 / var_522_17)

				if var_522_19 > 0 and var_522_13 < var_522_19 then
					arg_519_1.talkMaxDuration = var_522_19

					if var_522_19 + var_522_12 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_19 + var_522_12
					end
				end

				arg_519_1.text_.text = var_522_16
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251122", "story_v_out_320251.awb") ~= 0 then
					local var_522_20 = manager.audio:GetVoiceLength("story_v_out_320251", "320251122", "story_v_out_320251.awb") / 1000

					if var_522_20 + var_522_12 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_20 + var_522_12
					end

					if var_522_15.prefab_name ~= "" and arg_519_1.actors_[var_522_15.prefab_name] ~= nil then
						local var_522_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_15.prefab_name].transform, "story_v_out_320251", "320251122", "story_v_out_320251.awb")

						arg_519_1:RecordAudio("320251122", var_522_21)
						arg_519_1:RecordAudio("320251122", var_522_21)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_320251", "320251122", "story_v_out_320251.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_320251", "320251122", "story_v_out_320251.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_22 = math.max(var_522_13, arg_519_1.talkMaxDuration)

			if var_522_12 <= arg_519_1.time_ and arg_519_1.time_ < var_522_12 + var_522_22 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_12) / var_522_22

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_12 + var_522_22 and arg_519_1.time_ < var_522_12 + var_522_22 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play320251123 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 320251123
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play320251124(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1089ui_story"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1089ui_story == nil then
				arg_523_1.var_.characterEffect1089ui_story = var_526_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 and not isNil(var_526_0) then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.characterEffect1089ui_story and not isNil(var_526_0) then
					local var_526_4 = Mathf.Lerp(0, 0.5, var_526_3)

					arg_523_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1089ui_story.fillRatio = var_526_4
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1089ui_story then
				local var_526_5 = 0.5

				arg_523_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1089ui_story.fillRatio = var_526_5
			end

			local var_526_6 = 0
			local var_526_7 = 0.9

			if var_526_6 < arg_523_1.time_ and arg_523_1.time_ <= var_526_6 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_8 = arg_523_1:GetWordFromCfg(320251123)
				local var_526_9 = arg_523_1:FormatText(var_526_8.content)

				arg_523_1.text_.text = var_526_9

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_10 = 36
				local var_526_11 = utf8.len(var_526_9)
				local var_526_12 = var_526_10 <= 0 and var_526_7 or var_526_7 * (var_526_11 / var_526_10)

				if var_526_12 > 0 and var_526_7 < var_526_12 then
					arg_523_1.talkMaxDuration = var_526_12

					if var_526_12 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_12 + var_526_6
					end
				end

				arg_523_1.text_.text = var_526_9
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_13 = math.max(var_526_7, arg_523_1.talkMaxDuration)

			if var_526_6 <= arg_523_1.time_ and arg_523_1.time_ < var_526_6 + var_526_13 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_6) / var_526_13

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_6 + var_526_13 and arg_523_1.time_ < var_526_6 + var_526_13 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play320251124 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 320251124
		arg_527_1.duration_ = 12.87

		local var_527_0 = {
			zh = 6.1,
			ja = 12.866
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
			arg_527_1.auto_ = false
		end

		function arg_527_1.playNext_(arg_529_0)
			arg_527_1.onStoryFinished_()
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1089ui_story"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1089ui_story == nil then
				arg_527_1.var_.characterEffect1089ui_story = var_530_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 and not isNil(var_530_0) then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.characterEffect1089ui_story and not isNil(var_530_0) then
					arg_527_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1089ui_story then
				arg_527_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_530_4 = 0

			if var_530_4 < arg_527_1.time_ and arg_527_1.time_ <= var_530_4 + arg_530_0 then
				arg_527_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_530_5 = 0
			local var_530_6 = 0.675

			if var_530_5 < arg_527_1.time_ and arg_527_1.time_ <= var_530_5 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_7 = arg_527_1:FormatText(StoryNameCfg[1031].name)

				arg_527_1.leftNameTxt_.text = var_530_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_8 = arg_527_1:GetWordFromCfg(320251124)
				local var_530_9 = arg_527_1:FormatText(var_530_8.content)

				arg_527_1.text_.text = var_530_9

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_10 = 27
				local var_530_11 = utf8.len(var_530_9)
				local var_530_12 = var_530_10 <= 0 and var_530_6 or var_530_6 * (var_530_11 / var_530_10)

				if var_530_12 > 0 and var_530_6 < var_530_12 then
					arg_527_1.talkMaxDuration = var_530_12

					if var_530_12 + var_530_5 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_12 + var_530_5
					end
				end

				arg_527_1.text_.text = var_530_9
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320251", "320251124", "story_v_out_320251.awb") ~= 0 then
					local var_530_13 = manager.audio:GetVoiceLength("story_v_out_320251", "320251124", "story_v_out_320251.awb") / 1000

					if var_530_13 + var_530_5 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_5
					end

					if var_530_8.prefab_name ~= "" and arg_527_1.actors_[var_530_8.prefab_name] ~= nil then
						local var_530_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_8.prefab_name].transform, "story_v_out_320251", "320251124", "story_v_out_320251.awb")

						arg_527_1:RecordAudio("320251124", var_530_14)
						arg_527_1:RecordAudio("320251124", var_530_14)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_320251", "320251124", "story_v_out_320251.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_320251", "320251124", "story_v_out_320251.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_15 = math.max(var_530_6, arg_527_1.talkMaxDuration)

			if var_530_5 <= arg_527_1.time_ and arg_527_1.time_ < var_530_5 + var_530_15 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_5) / var_530_15

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_5 + var_530_15 and arg_527_1.time_ < var_530_5 + var_530_15 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/L02f"
	},
	voices = {
		"story_v_out_320251.awb"
	}
}
