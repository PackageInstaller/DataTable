return {
	Play320252001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320252001
		arg_1_1.duration_ = 8.13

		local var_1_0 = {
			zh = 6.032999999999,
			ja = 8.132999999999
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
				arg_1_0:Play320252002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L07f"

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
				local var_4_5 = arg_1_1.bgs_.L07f

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
					if iter_4_0 ~= "L07f" then
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
			local var_4_30 = 1.9

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
			local var_4_39 = 1.9

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

			local var_4_42 = 1.9

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_4_43 = 1.9

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
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

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry")

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

			local var_4_56 = 1.999999999999
			local var_4_57 = 0.45

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

				local var_4_60 = arg_1_1:GetWordFromCfg(320252001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252001", "story_v_out_320252.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_320252", "320252001", "story_v_out_320252.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_320252", "320252001", "story_v_out_320252.awb")

						arg_1_1:RecordAudio("320252001", var_4_66)
						arg_1_1:RecordAudio("320252001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_320252", "320252001", "story_v_out_320252.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_320252", "320252001", "story_v_out_320252.awb")
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
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play320252002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320252002
		arg_9_1.duration_ = 11.7

		local var_9_0 = {
			zh = 9.533,
			ja = 11.7
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
				arg_9_0:Play320252003(arg_9_1)
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

			local var_12_6 = 0
			local var_12_7 = 1.025

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[1036].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(320252002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252002", "story_v_out_320252.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_320252", "320252002", "story_v_out_320252.awb") / 1000

					if var_12_14 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_6
					end

					if var_12_9.prefab_name ~= "" and arg_9_1.actors_[var_12_9.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_9.prefab_name].transform, "story_v_out_320252", "320252002", "story_v_out_320252.awb")

						arg_9_1:RecordAudio("320252002", var_12_15)
						arg_9_1:RecordAudio("320252002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320252", "320252002", "story_v_out_320252.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320252", "320252002", "story_v_out_320252.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_16 and arg_9_1.time_ < var_12_6 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play320252003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320252003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320252004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1089ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1089ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1089ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1089ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1089ui_story == nil then
				arg_13_1.var_.characterEffect1089ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1089ui_story and not isNil(var_16_9) then
					local var_16_13 = Mathf.Lerp(0, 0.5, var_16_12)

					arg_13_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1089ui_story.fillRatio = var_16_13
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1089ui_story then
				local var_16_14 = 0.5

				arg_13_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1089ui_story.fillRatio = var_16_14
			end

			local var_16_15 = 0
			local var_16_16 = 1.175

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(320252003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 47
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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
	Play320252004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320252004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320252005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.125

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(320252004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 44
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play320252005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320252005
		arg_21_1.duration_ = 6.33

		local var_21_0 = {
			zh = 6.3,
			ja = 6.333
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
				arg_21_0:Play320252006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1089ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1089ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.1, -6.17)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1089ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1089ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1089ui_story == nil then
				arg_21_1.var_.characterEffect1089ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1089ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1089ui_story then
				arg_21_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			local var_24_14 = 0
			local var_24_15 = 0.75

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_16 = arg_21_1:FormatText(StoryNameCfg[1031].name)

				arg_21_1.leftNameTxt_.text = var_24_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_17 = arg_21_1:GetWordFromCfg(320252005)
				local var_24_18 = arg_21_1:FormatText(var_24_17.content)

				arg_21_1.text_.text = var_24_18

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 30
				local var_24_20 = utf8.len(var_24_18)
				local var_24_21 = var_24_19 <= 0 and var_24_15 or var_24_15 * (var_24_20 / var_24_19)

				if var_24_21 > 0 and var_24_15 < var_24_21 then
					arg_21_1.talkMaxDuration = var_24_21

					if var_24_21 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_21 + var_24_14
					end
				end

				arg_21_1.text_.text = var_24_18
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252005", "story_v_out_320252.awb") ~= 0 then
					local var_24_22 = manager.audio:GetVoiceLength("story_v_out_320252", "320252005", "story_v_out_320252.awb") / 1000

					if var_24_22 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_14
					end

					if var_24_17.prefab_name ~= "" and arg_21_1.actors_[var_24_17.prefab_name] ~= nil then
						local var_24_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_17.prefab_name].transform, "story_v_out_320252", "320252005", "story_v_out_320252.awb")

						arg_21_1:RecordAudio("320252005", var_24_23)
						arg_21_1:RecordAudio("320252005", var_24_23)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320252", "320252005", "story_v_out_320252.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320252", "320252005", "story_v_out_320252.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_24 = math.max(var_24_15, arg_21_1.talkMaxDuration)

			if var_24_14 <= arg_21_1.time_ and arg_21_1.time_ < var_24_14 + var_24_24 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_14) / var_24_24

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_14 + var_24_24 and arg_21_1.time_ < var_24_14 + var_24_24 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play320252006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320252006
		arg_25_1.duration_ = 10.63

		local var_25_0 = {
			zh = 10.633,
			ja = 9.333
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
				arg_25_0:Play320252007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1089ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1089ui_story == nil then
				arg_25_1.var_.characterEffect1089ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1089ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1089ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1089ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1089ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.35

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[1036].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(320252006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 54
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252006", "story_v_out_320252.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_320252", "320252006", "story_v_out_320252.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_320252", "320252006", "story_v_out_320252.awb")

						arg_25_1:RecordAudio("320252006", var_28_15)
						arg_25_1:RecordAudio("320252006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320252", "320252006", "story_v_out_320252.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320252", "320252006", "story_v_out_320252.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320252007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320252007
		arg_29_1.duration_ = 15.5

		local var_29_0 = {
			zh = 13.1,
			ja = 15.5
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
				arg_29_0:Play320252008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.25

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1036].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(320252007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252007", "story_v_out_320252.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252007", "story_v_out_320252.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_320252", "320252007", "story_v_out_320252.awb")

						arg_29_1:RecordAudio("320252007", var_32_9)
						arg_29_1:RecordAudio("320252007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320252", "320252007", "story_v_out_320252.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320252", "320252007", "story_v_out_320252.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320252008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320252008
		arg_33_1.duration_ = 4.8

		local var_33_0 = {
			zh = 3.833,
			ja = 4.8
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
				arg_33_0:Play320252009(arg_33_1)
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
				local var_36_4 = Vector3.New(0, -1.1, -6.17)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1089ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -1.1, -6.17)

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
				arg_33_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_36_14 = 0
			local var_36_15 = 0.375

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_16 = arg_33_1:FormatText(StoryNameCfg[1031].name)

				arg_33_1.leftNameTxt_.text = var_36_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_17 = arg_33_1:GetWordFromCfg(320252008)
				local var_36_18 = arg_33_1:FormatText(var_36_17.content)

				arg_33_1.text_.text = var_36_18

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 15
				local var_36_20 = utf8.len(var_36_18)
				local var_36_21 = var_36_19 <= 0 and var_36_15 or var_36_15 * (var_36_20 / var_36_19)

				if var_36_21 > 0 and var_36_15 < var_36_21 then
					arg_33_1.talkMaxDuration = var_36_21

					if var_36_21 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_21 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_18
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252008", "story_v_out_320252.awb") ~= 0 then
					local var_36_22 = manager.audio:GetVoiceLength("story_v_out_320252", "320252008", "story_v_out_320252.awb") / 1000

					if var_36_22 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_14
					end

					if var_36_17.prefab_name ~= "" and arg_33_1.actors_[var_36_17.prefab_name] ~= nil then
						local var_36_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_17.prefab_name].transform, "story_v_out_320252", "320252008", "story_v_out_320252.awb")

						arg_33_1:RecordAudio("320252008", var_36_23)
						arg_33_1:RecordAudio("320252008", var_36_23)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320252", "320252008", "story_v_out_320252.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320252", "320252008", "story_v_out_320252.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_24 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_24 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_24

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_24 and arg_33_1.time_ < var_36_14 + var_36_24 + arg_36_0 then
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
	Play320252009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320252009
		arg_37_1.duration_ = 10.9

		local var_37_0 = {
			zh = 10.9,
			ja = 8.166
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
				arg_37_0:Play320252010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1089ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1089ui_story == nil then
				arg_37_1.var_.characterEffect1089ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1089ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1089ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1089ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1089ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 1.175

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[1036].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(320252009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 47
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252009", "story_v_out_320252.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_320252", "320252009", "story_v_out_320252.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_320252", "320252009", "story_v_out_320252.awb")

						arg_37_1:RecordAudio("320252009", var_40_15)
						arg_37_1:RecordAudio("320252009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320252", "320252009", "story_v_out_320252.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320252", "320252009", "story_v_out_320252.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320252010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320252010
		arg_41_1.duration_ = 12.7

		local var_41_0 = {
			zh = 11.666,
			ja = 12.7
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
				arg_41_0:Play320252011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.275

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1036].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(320252010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 51
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252010", "story_v_out_320252.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252010", "story_v_out_320252.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_320252", "320252010", "story_v_out_320252.awb")

						arg_41_1:RecordAudio("320252010", var_44_9)
						arg_41_1:RecordAudio("320252010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320252", "320252010", "story_v_out_320252.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320252", "320252010", "story_v_out_320252.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play320252011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320252011
		arg_45_1.duration_ = 8.13

		local var_45_0 = {
			zh = 7.366,
			ja = 8.133
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
				arg_45_0:Play320252012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1089ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1089ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, -1.1, -6.17)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1089ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1089ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1089ui_story == nil then
				arg_45_1.var_.characterEffect1089ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1089ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1089ui_story then
				arg_45_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action452")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_48_15 = 0
			local var_48_16 = 0.75

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[1031].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(320252011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 30
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252011", "story_v_out_320252.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_320252", "320252011", "story_v_out_320252.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_320252", "320252011", "story_v_out_320252.awb")

						arg_45_1:RecordAudio("320252011", var_48_24)
						arg_45_1:RecordAudio("320252011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320252", "320252011", "story_v_out_320252.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320252", "320252011", "story_v_out_320252.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play320252012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320252012
		arg_49_1.duration_ = 5.37

		local var_49_0 = {
			zh = 4.433,
			ja = 5.366
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
				arg_49_0:Play320252013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1089ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1089ui_story == nil then
				arg_49_1.var_.characterEffect1089ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1089ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1089ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1089ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1089ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.35

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[1036].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(320252012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 14
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252012", "story_v_out_320252.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_320252", "320252012", "story_v_out_320252.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_320252", "320252012", "story_v_out_320252.awb")

						arg_49_1:RecordAudio("320252012", var_52_15)
						arg_49_1:RecordAudio("320252012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320252", "320252012", "story_v_out_320252.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320252", "320252012", "story_v_out_320252.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play320252013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320252013
		arg_53_1.duration_ = 3.4

		local var_53_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_53_0:Play320252014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1089ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1089ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -1.1, -6.17)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1089ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1089ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1089ui_story == nil then
				arg_53_1.var_.characterEffect1089ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect1089ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1089ui_story then
				arg_53_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action427")
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_56_15 = 0
			local var_56_16 = 0.3

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[1031].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(320252013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 12
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252013", "story_v_out_320252.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_320252", "320252013", "story_v_out_320252.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_320252", "320252013", "story_v_out_320252.awb")

						arg_53_1:RecordAudio("320252013", var_56_24)
						arg_53_1:RecordAudio("320252013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320252", "320252013", "story_v_out_320252.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320252", "320252013", "story_v_out_320252.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play320252014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320252014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play320252015(arg_57_1)
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
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1089ui_story, var_60_4, var_60_3)

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

			local var_60_9 = 0
			local var_60_10 = 1.25

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(320252014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 50
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_10 or var_60_10 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_10 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_9 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_9
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_10, arg_57_1.talkMaxDuration)

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_9) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_9 + var_60_16 and arg_57_1.time_ < var_60_9 + var_60_16 + arg_60_0 then
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
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play320252015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320252015
		arg_61_1.duration_ = 13.2

		local var_61_0 = {
			zh = 9.6,
			ja = 13.2
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
				arg_61_0:Play320252016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.85

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[1036].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(320252015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252015", "story_v_out_320252.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252015", "story_v_out_320252.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_320252", "320252015", "story_v_out_320252.awb")

						arg_61_1:RecordAudio("320252015", var_64_9)
						arg_61_1:RecordAudio("320252015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320252", "320252015", "story_v_out_320252.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320252", "320252015", "story_v_out_320252.awb")
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
	Play320252016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320252016
		arg_65_1.duration_ = 3.33

		local var_65_0 = {
			zh = 2.533,
			ja = 3.333
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
				arg_65_0:Play320252017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1089ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1089ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -1.1, -6.17)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1089ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1089ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1089ui_story == nil then
				arg_65_1.var_.characterEffect1089ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1089ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1089ui_story then
				arg_65_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_68_15 = 0
			local var_68_16 = 0.3

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[1031].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(320252016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 12
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252016", "story_v_out_320252.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_320252", "320252016", "story_v_out_320252.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_320252", "320252016", "story_v_out_320252.awb")

						arg_65_1:RecordAudio("320252016", var_68_24)
						arg_65_1:RecordAudio("320252016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320252", "320252016", "story_v_out_320252.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320252", "320252016", "story_v_out_320252.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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
	Play320252017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320252017
		arg_69_1.duration_ = 10.2

		local var_69_0 = {
			zh = 10.2,
			ja = 7.933
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
				arg_69_0:Play320252018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1089ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1089ui_story == nil then
				arg_69_1.var_.characterEffect1089ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1089ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1089ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1089ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1089ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 1.1

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[1036].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(320252017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252017", "story_v_out_320252.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_320252", "320252017", "story_v_out_320252.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_320252", "320252017", "story_v_out_320252.awb")

						arg_69_1:RecordAudio("320252017", var_72_15)
						arg_69_1:RecordAudio("320252017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_320252", "320252017", "story_v_out_320252.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_320252", "320252017", "story_v_out_320252.awb")
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
	Play320252018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320252018
		arg_73_1.duration_ = 12.1

		local var_73_0 = {
			zh = 6.1,
			ja = 12.1
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
				arg_73_0:Play320252019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.65

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[1036].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(320252018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252018", "story_v_out_320252.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252018", "story_v_out_320252.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_320252", "320252018", "story_v_out_320252.awb")

						arg_73_1:RecordAudio("320252018", var_76_9)
						arg_73_1:RecordAudio("320252018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320252", "320252018", "story_v_out_320252.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320252", "320252018", "story_v_out_320252.awb")
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
	Play320252019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320252019
		arg_77_1.duration_ = 4.8

		local var_77_0 = {
			zh = 4.433,
			ja = 4.8
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
				arg_77_0:Play320252020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.65

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1066].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(320252019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252019", "story_v_out_320252.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252019", "story_v_out_320252.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_320252", "320252019", "story_v_out_320252.awb")

						arg_77_1:RecordAudio("320252019", var_80_9)
						arg_77_1:RecordAudio("320252019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_320252", "320252019", "story_v_out_320252.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_320252", "320252019", "story_v_out_320252.awb")
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
	Play320252020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320252020
		arg_81_1.duration_ = 9.23

		local var_81_0 = {
			zh = 5.866,
			ja = 9.233
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
				arg_81_0:Play320252021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.725

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1044].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badgirl")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(320252020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252020", "story_v_out_320252.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252020", "story_v_out_320252.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_320252", "320252020", "story_v_out_320252.awb")

						arg_81_1:RecordAudio("320252020", var_84_9)
						arg_81_1:RecordAudio("320252020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_320252", "320252020", "story_v_out_320252.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_320252", "320252020", "story_v_out_320252.awb")
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
	Play320252021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320252021
		arg_85_1.duration_ = 9.07

		local var_85_0 = {
			zh = 4.633,
			ja = 9.066
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
				arg_85_0:Play320252022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.525

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[1036].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(320252021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252021", "story_v_out_320252.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252021", "story_v_out_320252.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_320252", "320252021", "story_v_out_320252.awb")

						arg_85_1:RecordAudio("320252021", var_88_9)
						arg_85_1:RecordAudio("320252021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_320252", "320252021", "story_v_out_320252.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_320252", "320252021", "story_v_out_320252.awb")
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
	Play320252022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320252022
		arg_89_1.duration_ = 14.03

		local var_89_0 = {
			zh = 14.033,
			ja = 13.766
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
				arg_89_0:Play320252023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.375

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[1036].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(320252022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 55
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252022", "story_v_out_320252.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252022", "story_v_out_320252.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_320252", "320252022", "story_v_out_320252.awb")

						arg_89_1:RecordAudio("320252022", var_92_9)
						arg_89_1:RecordAudio("320252022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_320252", "320252022", "story_v_out_320252.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_320252", "320252022", "story_v_out_320252.awb")
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
	Play320252023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320252023
		arg_93_1.duration_ = 7.43

		local var_93_0 = {
			zh = 6.033,
			ja = 7.433
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
				arg_93_0:Play320252024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1089ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1089ui_story == nil then
				arg_93_1.var_.characterEffect1089ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1089ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1089ui_story then
				arg_93_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_96_5 = 0
			local var_96_6 = 0.65

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_7 = arg_93_1:FormatText(StoryNameCfg[1031].name)

				arg_93_1.leftNameTxt_.text = var_96_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(320252023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 26
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_6 or var_96_6 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_6 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252023", "story_v_out_320252.awb") ~= 0 then
					local var_96_13 = manager.audio:GetVoiceLength("story_v_out_320252", "320252023", "story_v_out_320252.awb") / 1000

					if var_96_13 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_5
					end

					if var_96_8.prefab_name ~= "" and arg_93_1.actors_[var_96_8.prefab_name] ~= nil then
						local var_96_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_8.prefab_name].transform, "story_v_out_320252", "320252023", "story_v_out_320252.awb")

						arg_93_1:RecordAudio("320252023", var_96_14)
						arg_93_1:RecordAudio("320252023", var_96_14)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320252", "320252023", "story_v_out_320252.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320252", "320252023", "story_v_out_320252.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_15 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_15 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_15

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_15 and arg_93_1.time_ < var_96_5 + var_96_15 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play320252024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320252024
		arg_97_1.duration_ = 3.9

		local var_97_0 = {
			zh = 3.366,
			ja = 3.9
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
				arg_97_0:Play320252025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1089ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1089ui_story == nil then
				arg_97_1.var_.characterEffect1089ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1089ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1089ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1089ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1089ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.425

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[1036].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(320252024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 17
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252024", "story_v_out_320252.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_320252", "320252024", "story_v_out_320252.awb") / 1000

					if var_100_14 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_6
					end

					if var_100_9.prefab_name ~= "" and arg_97_1.actors_[var_100_9.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_9.prefab_name].transform, "story_v_out_320252", "320252024", "story_v_out_320252.awb")

						arg_97_1:RecordAudio("320252024", var_100_15)
						arg_97_1:RecordAudio("320252024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320252", "320252024", "story_v_out_320252.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320252", "320252024", "story_v_out_320252.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_16 and arg_97_1.time_ < var_100_6 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320252025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320252025
		arg_101_1.duration_ = 5.73

		local var_101_0 = {
			zh = 2.8,
			ja = 5.733
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
				arg_101_0:Play320252026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1089ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1089ui_story == nil then
				arg_101_1.var_.characterEffect1089ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1089ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1089ui_story then
				arg_101_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_104_4 = 0
			local var_104_5 = 0.35

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_6 = arg_101_1:FormatText(StoryNameCfg[1031].name)

				arg_101_1.leftNameTxt_.text = var_104_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(320252025)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 14
				local var_104_10 = utf8.len(var_104_8)
				local var_104_11 = var_104_9 <= 0 and var_104_5 or var_104_5 * (var_104_10 / var_104_9)

				if var_104_11 > 0 and var_104_5 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252025", "story_v_out_320252.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_320252", "320252025", "story_v_out_320252.awb") / 1000

					if var_104_12 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_4
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_320252", "320252025", "story_v_out_320252.awb")

						arg_101_1:RecordAudio("320252025", var_104_13)
						arg_101_1:RecordAudio("320252025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_320252", "320252025", "story_v_out_320252.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_320252", "320252025", "story_v_out_320252.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_14 and arg_101_1.time_ < var_104_4 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play320252026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320252026
		arg_105_1.duration_ = 9.53

		local var_105_0 = {
			zh = 8.2,
			ja = 9.533
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
				arg_105_0:Play320252027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1089ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1089ui_story == nil then
				arg_105_1.var_.characterEffect1089ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1089ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1089ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1089ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1089ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.75

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[1036].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_9 = arg_105_1:GetWordFromCfg(320252026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 30
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252026", "story_v_out_320252.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_320252", "320252026", "story_v_out_320252.awb") / 1000

					if var_108_14 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_6
					end

					if var_108_9.prefab_name ~= "" and arg_105_1.actors_[var_108_9.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_9.prefab_name].transform, "story_v_out_320252", "320252026", "story_v_out_320252.awb")

						arg_105_1:RecordAudio("320252026", var_108_15)
						arg_105_1:RecordAudio("320252026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320252", "320252026", "story_v_out_320252.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320252", "320252026", "story_v_out_320252.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_16 and arg_105_1.time_ < var_108_6 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320252027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320252027
		arg_109_1.duration_ = 3.3

		local var_109_0 = {
			zh = 2.933,
			ja = 3.3
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
				arg_109_0:Play320252028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.25

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[1036].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(320252027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 10
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252027", "story_v_out_320252.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252027", "story_v_out_320252.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_320252", "320252027", "story_v_out_320252.awb")

						arg_109_1:RecordAudio("320252027", var_112_9)
						arg_109_1:RecordAudio("320252027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_320252", "320252027", "story_v_out_320252.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_320252", "320252027", "story_v_out_320252.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320252028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320252028
		arg_113_1.duration_ = 8.53

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play320252029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "L07i"

			if arg_113_1.bgs_[var_116_0] == nil then
				local var_116_1 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_0)
				var_116_1.name = var_116_0
				var_116_1.transform.parent = arg_113_1.stage_.transform
				var_116_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_0] = var_116_1
			end

			local var_116_2 = 1.86666666666667

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				local var_116_3 = manager.ui.mainCamera.transform.localPosition
				local var_116_4 = Vector3.New(0, 0, 10) + Vector3.New(var_116_3.x, var_116_3.y, 0)
				local var_116_5 = arg_113_1.bgs_.L07i

				var_116_5.transform.localPosition = var_116_4
				var_116_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_6 = var_116_5:GetComponent("SpriteRenderer")

				if var_116_6 and var_116_6.sprite then
					local var_116_7 = (var_116_5.transform.localPosition - var_116_3).z
					local var_116_8 = manager.ui.mainCameraCom_
					local var_116_9 = 2 * var_116_7 * Mathf.Tan(var_116_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_10 = var_116_9 * var_116_8.aspect
					local var_116_11 = var_116_6.sprite.bounds.size.x
					local var_116_12 = var_116_6.sprite.bounds.size.y
					local var_116_13 = var_116_10 / var_116_11
					local var_116_14 = var_116_9 / var_116_12
					local var_116_15 = var_116_14 < var_116_13 and var_116_13 or var_116_14

					var_116_5.transform.localScale = Vector3.New(var_116_15, var_116_15, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "L07i" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_17 = 1.86666666666667

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17
				local var_116_19 = Color.New(0, 0, 0)

				var_116_19.a = Mathf.Lerp(0, 1, var_116_18)
				arg_113_1.mask_.color = var_116_19
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				local var_116_20 = Color.New(0, 0, 0)

				var_116_20.a = 1
				arg_113_1.mask_.color = var_116_20
			end

			local var_116_21 = 1.86666666666667

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_22 = 2

			if var_116_21 <= arg_113_1.time_ and arg_113_1.time_ < var_116_21 + var_116_22 then
				local var_116_23 = (arg_113_1.time_ - var_116_21) / var_116_22
				local var_116_24 = Color.New(0, 0, 0)

				var_116_24.a = Mathf.Lerp(1, 0, var_116_23)
				arg_113_1.mask_.color = var_116_24
			end

			if arg_113_1.time_ >= var_116_21 + var_116_22 and arg_113_1.time_ < var_116_21 + var_116_22 + arg_116_0 then
				local var_116_25 = Color.New(0, 0, 0)
				local var_116_26 = 0

				arg_113_1.mask_.enabled = false
				var_116_25.a = var_116_26
				arg_113_1.mask_.color = var_116_25
			end

			local var_116_27 = arg_113_1.actors_["1089ui_story"].transform
			local var_116_28 = 1.83333333333333

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1.var_.moveOldPos1089ui_story = var_116_27.localPosition
			end

			local var_116_29 = 0.001

			if var_116_28 <= arg_113_1.time_ and arg_113_1.time_ < var_116_28 + var_116_29 then
				local var_116_30 = (arg_113_1.time_ - var_116_28) / var_116_29
				local var_116_31 = Vector3.New(0, 100, 0)

				var_116_27.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1089ui_story, var_116_31, var_116_30)

				local var_116_32 = manager.ui.mainCamera.transform.position - var_116_27.position

				var_116_27.forward = Vector3.New(var_116_32.x, var_116_32.y, var_116_32.z)

				local var_116_33 = var_116_27.localEulerAngles

				var_116_33.z = 0
				var_116_33.x = 0
				var_116_27.localEulerAngles = var_116_33
			end

			if arg_113_1.time_ >= var_116_28 + var_116_29 and arg_113_1.time_ < var_116_28 + var_116_29 + arg_116_0 then
				var_116_27.localPosition = Vector3.New(0, 100, 0)

				local var_116_34 = manager.ui.mainCamera.transform.position - var_116_27.position

				var_116_27.forward = Vector3.New(var_116_34.x, var_116_34.y, var_116_34.z)

				local var_116_35 = var_116_27.localEulerAngles

				var_116_35.z = 0
				var_116_35.x = 0
				var_116_27.localEulerAngles = var_116_35
			end

			local var_116_36 = arg_113_1.actors_["1089ui_story"]
			local var_116_37 = 1.83333333333333

			if var_116_37 < arg_113_1.time_ and arg_113_1.time_ <= var_116_37 + arg_116_0 and not isNil(var_116_36) and arg_113_1.var_.characterEffect1089ui_story == nil then
				arg_113_1.var_.characterEffect1089ui_story = var_116_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_38 = 0.200000002980232

			if var_116_37 <= arg_113_1.time_ and arg_113_1.time_ < var_116_37 + var_116_38 and not isNil(var_116_36) then
				local var_116_39 = (arg_113_1.time_ - var_116_37) / var_116_38

				if arg_113_1.var_.characterEffect1089ui_story and not isNil(var_116_36) then
					local var_116_40 = Mathf.Lerp(0, 0.5, var_116_39)

					arg_113_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1089ui_story.fillRatio = var_116_40
				end
			end

			if arg_113_1.time_ >= var_116_37 + var_116_38 and arg_113_1.time_ < var_116_37 + var_116_38 + arg_116_0 and not isNil(var_116_36) and arg_113_1.var_.characterEffect1089ui_story then
				local var_116_41 = 0.5

				arg_113_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1089ui_story.fillRatio = var_116_41
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_42 = 3.53333333333333
			local var_116_43 = 0.75

			if var_116_42 < arg_113_1.time_ and arg_113_1.time_ <= var_116_42 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_44 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_44:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_45 = arg_113_1:GetWordFromCfg(320252028)
				local var_116_46 = arg_113_1:FormatText(var_116_45.content)

				arg_113_1.text_.text = var_116_46

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_47 = 30
				local var_116_48 = utf8.len(var_116_46)
				local var_116_49 = var_116_47 <= 0 and var_116_43 or var_116_43 * (var_116_48 / var_116_47)

				if var_116_49 > 0 and var_116_43 < var_116_49 then
					arg_113_1.talkMaxDuration = var_116_49
					var_116_42 = var_116_42 + 0.3

					if var_116_49 + var_116_42 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_49 + var_116_42
					end
				end

				arg_113_1.text_.text = var_116_46
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_50 = var_116_42 + 0.3
			local var_116_51 = math.max(var_116_43, arg_113_1.talkMaxDuration)

			if var_116_50 <= arg_113_1.time_ and arg_113_1.time_ < var_116_50 + var_116_51 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_50) / var_116_51

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_50 + var_116_51 and arg_113_1.time_ < var_116_50 + var_116_51 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play320252029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 320252029
		arg_119_1.duration_ = 10.03

		local var_119_0 = {
			zh = 8.366,
			ja = 10.033
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play320252030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.925

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[1028].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(320252029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 37
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252029", "story_v_out_320252.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252029", "story_v_out_320252.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_320252", "320252029", "story_v_out_320252.awb")

						arg_119_1:RecordAudio("320252029", var_122_9)
						arg_119_1:RecordAudio("320252029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_320252", "320252029", "story_v_out_320252.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_320252", "320252029", "story_v_out_320252.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play320252030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 320252030
		arg_123_1.duration_ = 9.63

		local var_123_0 = {
			zh = 9.033,
			ja = 9.633
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play320252031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.05

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[1028].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(320252030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252030", "story_v_out_320252.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252030", "story_v_out_320252.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_320252", "320252030", "story_v_out_320252.awb")

						arg_123_1:RecordAudio("320252030", var_126_9)
						arg_123_1:RecordAudio("320252030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_320252", "320252030", "story_v_out_320252.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_320252", "320252030", "story_v_out_320252.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play320252031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 320252031
		arg_127_1.duration_ = 2.13

		local var_127_0 = {
			zh = 2.133,
			ja = 1.566
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
				arg_127_0:Play320252032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.15

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[1028].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(320252031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 6
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252031", "story_v_out_320252.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252031", "story_v_out_320252.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_320252", "320252031", "story_v_out_320252.awb")

						arg_127_1:RecordAudio("320252031", var_130_9)
						arg_127_1:RecordAudio("320252031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_320252", "320252031", "story_v_out_320252.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_320252", "320252031", "story_v_out_320252.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play320252032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 320252032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play320252033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 1.1

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(320252032)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 44
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play320252033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 320252033
		arg_135_1.duration_ = 8.3

		local var_135_0 = {
			zh = 8.3,
			ja = 6.7
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
				arg_135_0:Play320252034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.5

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[1036].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(320252033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 20
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252033", "story_v_out_320252.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252033", "story_v_out_320252.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_320252", "320252033", "story_v_out_320252.awb")

						arg_135_1:RecordAudio("320252033", var_138_9)
						arg_135_1:RecordAudio("320252033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_320252", "320252033", "story_v_out_320252.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_320252", "320252033", "story_v_out_320252.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play320252034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 320252034
		arg_139_1.duration_ = 9.7

		local var_139_0 = {
			zh = 9.7,
			ja = 5.566
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play320252035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.1

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[1028].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(320252034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 44
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252034", "story_v_out_320252.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252034", "story_v_out_320252.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_320252", "320252034", "story_v_out_320252.awb")

						arg_139_1:RecordAudio("320252034", var_142_9)
						arg_139_1:RecordAudio("320252034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_320252", "320252034", "story_v_out_320252.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_320252", "320252034", "story_v_out_320252.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play320252035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 320252035
		arg_143_1.duration_ = 7.8

		local var_143_0 = {
			zh = 5.966,
			ja = 7.8
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
				arg_143_0:Play320252036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.525

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[1036].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(320252035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 21
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252035", "story_v_out_320252.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252035", "story_v_out_320252.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_320252", "320252035", "story_v_out_320252.awb")

						arg_143_1:RecordAudio("320252035", var_146_9)
						arg_143_1:RecordAudio("320252035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_320252", "320252035", "story_v_out_320252.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_320252", "320252035", "story_v_out_320252.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play320252036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 320252036
		arg_147_1.duration_ = 13.6

		local var_147_0 = {
			zh = 8.733,
			ja = 13.6
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
				arg_147_0:Play320252037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.55

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[1036].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(320252036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 22
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252036", "story_v_out_320252.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252036", "story_v_out_320252.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_320252", "320252036", "story_v_out_320252.awb")

						arg_147_1:RecordAudio("320252036", var_150_9)
						arg_147_1:RecordAudio("320252036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_320252", "320252036", "story_v_out_320252.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_320252", "320252036", "story_v_out_320252.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play320252037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 320252037
		arg_151_1.duration_ = 9

		local var_151_0 = {
			zh = 6.533,
			ja = 9
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
				arg_151_0:Play320252038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.675

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[1028].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowboffinm")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(320252037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 27
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252037", "story_v_out_320252.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252037", "story_v_out_320252.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_320252", "320252037", "story_v_out_320252.awb")

						arg_151_1:RecordAudio("320252037", var_154_9)
						arg_151_1:RecordAudio("320252037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_320252", "320252037", "story_v_out_320252.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_320252", "320252037", "story_v_out_320252.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play320252038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 320252038
		arg_155_1.duration_ = 10.13

		local var_155_0 = {
			zh = 10.133,
			ja = 8.533
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
				arg_155_0:Play320252039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.4

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[1036].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(320252038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 16
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252038", "story_v_out_320252.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252038", "story_v_out_320252.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_320252", "320252038", "story_v_out_320252.awb")

						arg_155_1:RecordAudio("320252038", var_158_9)
						arg_155_1:RecordAudio("320252038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_320252", "320252038", "story_v_out_320252.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_320252", "320252038", "story_v_out_320252.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play320252039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 320252039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play320252040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.775

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(320252039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 31
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play320252040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 320252040
		arg_163_1.duration_ = 4.87

		local var_163_0 = {
			zh = 4.666,
			ja = 4.866
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
				arg_163_0:Play320252041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = "L07m"

			if arg_163_1.bgs_[var_166_0] == nil then
				local var_166_1 = Object.Instantiate(arg_163_1.paintGo_)

				var_166_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_166_0)
				var_166_1.name = var_166_0
				var_166_1.transform.parent = arg_163_1.stage_.transform
				var_166_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.bgs_[var_166_0] = var_166_1
			end

			local var_166_2 = 1.1

			if var_166_2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				local var_166_3 = manager.ui.mainCamera.transform.localPosition
				local var_166_4 = Vector3.New(0, 0, 10) + Vector3.New(var_166_3.x, var_166_3.y, 0)
				local var_166_5 = arg_163_1.bgs_.L07m

				var_166_5.transform.localPosition = var_166_4
				var_166_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_6 = var_166_5:GetComponent("SpriteRenderer")

				if var_166_6 and var_166_6.sprite then
					local var_166_7 = (var_166_5.transform.localPosition - var_166_3).z
					local var_166_8 = manager.ui.mainCameraCom_
					local var_166_9 = 2 * var_166_7 * Mathf.Tan(var_166_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_166_10 = var_166_9 * var_166_8.aspect
					local var_166_11 = var_166_6.sprite.bounds.size.x
					local var_166_12 = var_166_6.sprite.bounds.size.y
					local var_166_13 = var_166_10 / var_166_11
					local var_166_14 = var_166_9 / var_166_12
					local var_166_15 = var_166_14 < var_166_13 and var_166_13 or var_166_14

					var_166_5.transform.localScale = Vector3.New(var_166_15, var_166_15, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "L07m" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			local var_166_17 = 0.3

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_18 = 0

			if var_166_18 < arg_163_1.time_ and arg_163_1.time_ <= var_166_18 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_19 = 1.1

			if var_166_18 <= arg_163_1.time_ and arg_163_1.time_ < var_166_18 + var_166_19 then
				local var_166_20 = (arg_163_1.time_ - var_166_18) / var_166_19
				local var_166_21 = Color.New(0, 0, 0)

				var_166_21.a = Mathf.Lerp(0, 1, var_166_20)
				arg_163_1.mask_.color = var_166_21
			end

			if arg_163_1.time_ >= var_166_18 + var_166_19 and arg_163_1.time_ < var_166_18 + var_166_19 + arg_166_0 then
				local var_166_22 = Color.New(0, 0, 0)

				var_166_22.a = 1
				arg_163_1.mask_.color = var_166_22
			end

			local var_166_23 = 1.1

			if var_166_23 < arg_163_1.time_ and arg_163_1.time_ <= var_166_23 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_24 = 1.1

			if var_166_23 <= arg_163_1.time_ and arg_163_1.time_ < var_166_23 + var_166_24 then
				local var_166_25 = (arg_163_1.time_ - var_166_23) / var_166_24
				local var_166_26 = Color.New(0, 0, 0)

				var_166_26.a = Mathf.Lerp(1, 0, var_166_25)
				arg_163_1.mask_.color = var_166_26
			end

			if arg_163_1.time_ >= var_166_23 + var_166_24 and arg_163_1.time_ < var_166_23 + var_166_24 + arg_166_0 then
				local var_166_27 = Color.New(0, 0, 0)
				local var_166_28 = 0

				arg_163_1.mask_.enabled = false
				var_166_27.a = var_166_28
				arg_163_1.mask_.color = var_166_27
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_29 = 2.2
			local var_166_30 = 0.25

			if var_166_29 < arg_163_1.time_ and arg_163_1.time_ <= var_166_29 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_31 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_31:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_163_1.dialogCg_.alpha = arg_167_0
				end))
				var_166_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_32 = arg_163_1:FormatText(StoryNameCfg[1040].name)

				arg_163_1.leftNameTxt_.text = var_166_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_33 = arg_163_1:GetWordFromCfg(320252040)
				local var_166_34 = arg_163_1:FormatText(var_166_33.content)

				arg_163_1.text_.text = var_166_34

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_35 = 10
				local var_166_36 = utf8.len(var_166_34)
				local var_166_37 = var_166_35 <= 0 and var_166_30 or var_166_30 * (var_166_36 / var_166_35)

				if var_166_37 > 0 and var_166_30 < var_166_37 then
					arg_163_1.talkMaxDuration = var_166_37
					var_166_29 = var_166_29 + 0.3

					if var_166_37 + var_166_29 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_37 + var_166_29
					end
				end

				arg_163_1.text_.text = var_166_34
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252040", "story_v_out_320252.awb") ~= 0 then
					local var_166_38 = manager.audio:GetVoiceLength("story_v_out_320252", "320252040", "story_v_out_320252.awb") / 1000

					if var_166_38 + var_166_29 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_38 + var_166_29
					end

					if var_166_33.prefab_name ~= "" and arg_163_1.actors_[var_166_33.prefab_name] ~= nil then
						local var_166_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_33.prefab_name].transform, "story_v_out_320252", "320252040", "story_v_out_320252.awb")

						arg_163_1:RecordAudio("320252040", var_166_39)
						arg_163_1:RecordAudio("320252040", var_166_39)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_320252", "320252040", "story_v_out_320252.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_320252", "320252040", "story_v_out_320252.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_40 = var_166_29 + 0.3
			local var_166_41 = math.max(var_166_30, arg_163_1.talkMaxDuration)

			if var_166_40 <= arg_163_1.time_ and arg_163_1.time_ < var_166_40 + var_166_41 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_40) / var_166_41

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_40 + var_166_41 and arg_163_1.time_ < var_166_40 + var_166_41 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play320252041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320252041
		arg_169_1.duration_ = 3.97

		local var_169_0 = {
			zh = 3.966,
			ja = 3.5
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
				arg_169_0:Play320252042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.4

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[1036].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(320252041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252041", "story_v_out_320252.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252041", "story_v_out_320252.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_320252", "320252041", "story_v_out_320252.awb")

						arg_169_1:RecordAudio("320252041", var_172_9)
						arg_169_1:RecordAudio("320252041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_320252", "320252041", "story_v_out_320252.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_320252", "320252041", "story_v_out_320252.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play320252042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320252042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play320252043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.75

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(320252042)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 30
				local var_176_5 = utf8.len(var_176_3)
				local var_176_6 = var_176_4 <= 0 and var_176_1 or var_176_1 * (var_176_5 / var_176_4)

				if var_176_6 > 0 and var_176_1 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_7 and arg_173_1.time_ < var_176_0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play320252043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320252043
		arg_177_1.duration_ = 2.9

		local var_177_0 = {
			zh = 2.266,
			ja = 2.9
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
				arg_177_0:Play320252044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.25

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[1040].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(320252043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 10
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252043", "story_v_out_320252.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252043", "story_v_out_320252.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_320252", "320252043", "story_v_out_320252.awb")

						arg_177_1:RecordAudio("320252043", var_180_9)
						arg_177_1:RecordAudio("320252043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320252", "320252043", "story_v_out_320252.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320252", "320252043", "story_v_out_320252.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320252044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320252044
		arg_181_1.duration_ = 8

		local var_181_0 = {
			zh = 5.9,
			ja = 8
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
				arg_181_0:Play320252045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.65

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[1036].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(320252044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252044", "story_v_out_320252.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252044", "story_v_out_320252.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_320252", "320252044", "story_v_out_320252.awb")

						arg_181_1:RecordAudio("320252044", var_184_9)
						arg_181_1:RecordAudio("320252044", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320252", "320252044", "story_v_out_320252.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320252", "320252044", "story_v_out_320252.awb")
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
	Play320252045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320252045
		arg_185_1.duration_ = 3.73

		local var_185_0 = {
			zh = 3.733,
			ja = 3.4
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
				arg_185_0:Play320252046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.425

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[1040].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(320252045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 17
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252045", "story_v_out_320252.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252045", "story_v_out_320252.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_320252", "320252045", "story_v_out_320252.awb")

						arg_185_1:RecordAudio("320252045", var_188_9)
						arg_185_1:RecordAudio("320252045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320252", "320252045", "story_v_out_320252.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320252", "320252045", "story_v_out_320252.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play320252046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320252046
		arg_189_1.duration_ = 5.1

		local var_189_0 = {
			zh = 4.833,
			ja = 5.1
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
				arg_189_0:Play320252047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.425

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[1036].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(320252046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252046", "story_v_out_320252.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252046", "story_v_out_320252.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_320252", "320252046", "story_v_out_320252.awb")

						arg_189_1:RecordAudio("320252046", var_192_9)
						arg_189_1:RecordAudio("320252046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320252", "320252046", "story_v_out_320252.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320252", "320252046", "story_v_out_320252.awb")
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
	Play320252047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320252047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play320252048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.333333333333333
			local var_196_1 = 1

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				local var_196_2 = "play"
				local var_196_3 = "effect"

				arg_193_1:AudioAction(var_196_2, var_196_3, "se_story_side_1094", "se_story_1094_gun", "")
			end

			local var_196_4 = 0
			local var_196_5 = 1.375

			if var_196_4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(320252047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_8 = 55
				local var_196_9 = utf8.len(var_196_7)
				local var_196_10 = var_196_8 <= 0 and var_196_5 or var_196_5 * (var_196_9 / var_196_8)

				if var_196_10 > 0 and var_196_5 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_11 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_11 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_11

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_11 and arg_193_1.time_ < var_196_4 + var_196_11 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play320252048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320252048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play320252049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.333333333333333
			local var_200_1 = 1

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				local var_200_2 = "play"
				local var_200_3 = "effect"

				arg_197_1:AudioAction(var_200_2, var_200_3, "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_200_4 = 0
			local var_200_5 = 1.225

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(320252048)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_8 = 49
				local var_200_9 = utf8.len(var_200_7)
				local var_200_10 = var_200_8 <= 0 and var_200_5 or var_200_5 * (var_200_9 / var_200_8)

				if var_200_10 > 0 and var_200_5 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_11 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_11 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_11

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_11 and arg_197_1.time_ < var_200_4 + var_200_11 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play320252049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320252049
		arg_201_1.duration_ = 6.47

		local var_201_0 = {
			zh = 5.466,
			ja = 6.466
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
				arg_201_0:Play320252050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.55

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[1025].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(320252049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252049", "story_v_out_320252.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252049", "story_v_out_320252.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_320252", "320252049", "story_v_out_320252.awb")

						arg_201_1:RecordAudio("320252049", var_204_9)
						arg_201_1:RecordAudio("320252049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_320252", "320252049", "story_v_out_320252.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_320252", "320252049", "story_v_out_320252.awb")
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
	Play320252050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320252050
		arg_205_1.duration_ = 1.73

		local var_205_0 = {
			zh = 1.3,
			ja = 1.733
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
				arg_205_0:Play320252051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.15

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[1040].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(320252050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252050", "story_v_out_320252.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252050", "story_v_out_320252.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_320252", "320252050", "story_v_out_320252.awb")

						arg_205_1:RecordAudio("320252050", var_208_9)
						arg_205_1:RecordAudio("320252050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_320252", "320252050", "story_v_out_320252.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_320252", "320252050", "story_v_out_320252.awb")
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
	Play320252051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320252051
		arg_209_1.duration_ = 7.33

		local var_209_0 = {
			zh = 6.733,
			ja = 7.333
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
				arg_209_0:Play320252052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.7

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[1025].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(320252051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252051", "story_v_out_320252.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252051", "story_v_out_320252.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_320252", "320252051", "story_v_out_320252.awb")

						arg_209_1:RecordAudio("320252051", var_212_9)
						arg_209_1:RecordAudio("320252051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_320252", "320252051", "story_v_out_320252.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_320252", "320252051", "story_v_out_320252.awb")
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
	Play320252052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320252052
		arg_213_1.duration_ = 8.77

		local var_213_0 = {
			zh = 7.966,
			ja = 8.766
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
				arg_213_0:Play320252053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.85

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[1025].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(320252052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252052", "story_v_out_320252.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252052", "story_v_out_320252.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_320252", "320252052", "story_v_out_320252.awb")

						arg_213_1:RecordAudio("320252052", var_216_9)
						arg_213_1:RecordAudio("320252052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320252", "320252052", "story_v_out_320252.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320252", "320252052", "story_v_out_320252.awb")
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
	Play320252053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320252053
		arg_217_1.duration_ = 8.17

		local var_217_0 = {
			zh = 5.9,
			ja = 8.166
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
				arg_217_0:Play320252054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.575

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[1036].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(320252053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252053", "story_v_out_320252.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252053", "story_v_out_320252.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_320252", "320252053", "story_v_out_320252.awb")

						arg_217_1:RecordAudio("320252053", var_220_9)
						arg_217_1:RecordAudio("320252053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_320252", "320252053", "story_v_out_320252.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_320252", "320252053", "story_v_out_320252.awb")
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
	Play320252054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320252054
		arg_221_1.duration_ = 10.9

		local var_221_0 = {
			zh = 7.3,
			ja = 10.9
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
				arg_221_0:Play320252055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.775

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[1025].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(320252054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 31
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252054", "story_v_out_320252.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252054", "story_v_out_320252.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_320252", "320252054", "story_v_out_320252.awb")

						arg_221_1:RecordAudio("320252054", var_224_9)
						arg_221_1:RecordAudio("320252054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320252", "320252054", "story_v_out_320252.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320252", "320252054", "story_v_out_320252.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play320252055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320252055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play320252056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.95

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(320252055)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 38
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play320252056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320252056
		arg_229_1.duration_ = 14.23

		local var_229_0 = {
			zh = 11.433,
			ja = 14.233
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
				arg_229_0:Play320252057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.1

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[1036].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(320252056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 44
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252056", "story_v_out_320252.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252056", "story_v_out_320252.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_320252", "320252056", "story_v_out_320252.awb")

						arg_229_1:RecordAudio("320252056", var_232_9)
						arg_229_1:RecordAudio("320252056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_320252", "320252056", "story_v_out_320252.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_320252", "320252056", "story_v_out_320252.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play320252057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320252057
		arg_233_1.duration_ = 12.73

		local var_233_0 = {
			zh = 10.333,
			ja = 12.733
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
				arg_233_0:Play320252058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.175

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[1025].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(320252057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 47
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252057", "story_v_out_320252.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252057", "story_v_out_320252.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_320252", "320252057", "story_v_out_320252.awb")

						arg_233_1:RecordAudio("320252057", var_236_9)
						arg_233_1:RecordAudio("320252057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_320252", "320252057", "story_v_out_320252.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_320252", "320252057", "story_v_out_320252.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play320252058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320252058
		arg_237_1.duration_ = 14.9

		local var_237_0 = {
			zh = 11.033,
			ja = 14.9
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
				arg_237_0:Play320252059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1.175

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[1025].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(320252058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 47
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252058", "story_v_out_320252.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252058", "story_v_out_320252.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_320252", "320252058", "story_v_out_320252.awb")

						arg_237_1:RecordAudio("320252058", var_240_9)
						arg_237_1:RecordAudio("320252058", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320252", "320252058", "story_v_out_320252.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320252", "320252058", "story_v_out_320252.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320252059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320252059
		arg_241_1.duration_ = 12.8

		local var_241_0 = {
			zh = 12.6,
			ja = 12.8
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
				arg_241_0:Play320252060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 1.125

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[1025].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(320252059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 45
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252059", "story_v_out_320252.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252059", "story_v_out_320252.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_320252", "320252059", "story_v_out_320252.awb")

						arg_241_1:RecordAudio("320252059", var_244_9)
						arg_241_1:RecordAudio("320252059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_320252", "320252059", "story_v_out_320252.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_320252", "320252059", "story_v_out_320252.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play320252060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320252060
		arg_245_1.duration_ = 12.6

		local var_245_0 = {
			zh = 7.766,
			ja = 12.6
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
				arg_245_0:Play320252061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.825

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[1036].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(320252060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 33
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252060", "story_v_out_320252.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252060", "story_v_out_320252.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_320252", "320252060", "story_v_out_320252.awb")

						arg_245_1:RecordAudio("320252060", var_248_9)
						arg_245_1:RecordAudio("320252060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_320252", "320252060", "story_v_out_320252.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_320252", "320252060", "story_v_out_320252.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320252061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320252061
		arg_249_1.duration_ = 12

		local var_249_0 = {
			zh = 8.833,
			ja = 12
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
				arg_249_0:Play320252062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.9

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[1036].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(320252061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 35
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252061", "story_v_out_320252.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252061", "story_v_out_320252.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_320252", "320252061", "story_v_out_320252.awb")

						arg_249_1:RecordAudio("320252061", var_252_9)
						arg_249_1:RecordAudio("320252061", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320252", "320252061", "story_v_out_320252.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320252", "320252061", "story_v_out_320252.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play320252062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320252062
		arg_253_1.duration_ = 12.77

		local var_253_0 = {
			zh = 10.4,
			ja = 12.766
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
				arg_253_0:Play320252063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.15

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[1025].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(320252062)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 46
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252062", "story_v_out_320252.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252062", "story_v_out_320252.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_320252", "320252062", "story_v_out_320252.awb")

						arg_253_1:RecordAudio("320252062", var_256_9)
						arg_253_1:RecordAudio("320252062", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_320252", "320252062", "story_v_out_320252.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_320252", "320252062", "story_v_out_320252.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play320252063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320252063
		arg_257_1.duration_ = 2.17

		local var_257_0 = {
			zh = 1.033,
			ja = 2.166
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
				arg_257_0:Play320252064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.05

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[1036].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(320252063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252063", "story_v_out_320252.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252063", "story_v_out_320252.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_320252", "320252063", "story_v_out_320252.awb")

						arg_257_1:RecordAudio("320252063", var_260_9)
						arg_257_1:RecordAudio("320252063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320252", "320252063", "story_v_out_320252.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320252", "320252063", "story_v_out_320252.awb")
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
	Play320252064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320252064
		arg_261_1.duration_ = 17.73

		local var_261_0 = {
			zh = 14.6,
			ja = 17.733
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
				arg_261_0:Play320252065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 1.35

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[1025].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(320252064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252064", "story_v_out_320252.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252064", "story_v_out_320252.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_320252", "320252064", "story_v_out_320252.awb")

						arg_261_1:RecordAudio("320252064", var_264_9)
						arg_261_1:RecordAudio("320252064", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_320252", "320252064", "story_v_out_320252.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_320252", "320252064", "story_v_out_320252.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play320252065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320252065
		arg_265_1.duration_ = 13.7

		local var_265_0 = {
			zh = 9.2,
			ja = 13.7
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
				arg_265_0:Play320252066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.95

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[1025].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(320252065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252065", "story_v_out_320252.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252065", "story_v_out_320252.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_320252", "320252065", "story_v_out_320252.awb")

						arg_265_1:RecordAudio("320252065", var_268_9)
						arg_265_1:RecordAudio("320252065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_320252", "320252065", "story_v_out_320252.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_320252", "320252065", "story_v_out_320252.awb")
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
	Play320252066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320252066
		arg_269_1.duration_ = 15.73

		local var_269_0 = {
			zh = 15.733,
			ja = 13.366
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
				arg_269_0:Play320252067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 1.35

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[1025].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(320252066)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252066", "story_v_out_320252.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252066", "story_v_out_320252.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_320252", "320252066", "story_v_out_320252.awb")

						arg_269_1:RecordAudio("320252066", var_272_9)
						arg_269_1:RecordAudio("320252066", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_320252", "320252066", "story_v_out_320252.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_320252", "320252066", "story_v_out_320252.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play320252067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320252067
		arg_273_1.duration_ = 5.3

		local var_273_0 = {
			zh = 5.1,
			ja = 5.3
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
				arg_273_0:Play320252068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.425

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[1025].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(320252067)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252067", "story_v_out_320252.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252067", "story_v_out_320252.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_320252", "320252067", "story_v_out_320252.awb")

						arg_273_1:RecordAudio("320252067", var_276_9)
						arg_273_1:RecordAudio("320252067", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_320252", "320252067", "story_v_out_320252.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_320252", "320252067", "story_v_out_320252.awb")
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
	Play320252068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320252068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play320252069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.85

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(320252068)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 34
				local var_280_5 = utf8.len(var_280_3)
				local var_280_6 = var_280_4 <= 0 and var_280_1 or var_280_1 * (var_280_5 / var_280_4)

				if var_280_6 > 0 and var_280_1 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_7 and arg_277_1.time_ < var_280_0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play320252069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320252069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320252070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.725

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(320252069)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 29
				local var_284_5 = utf8.len(var_284_3)
				local var_284_6 = var_284_4 <= 0 and var_284_1 or var_284_1 * (var_284_5 / var_284_4)

				if var_284_6 > 0 and var_284_1 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_7 and arg_281_1.time_ < var_284_0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320252070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320252070
		arg_285_1.duration_ = 5.87

		local var_285_0 = {
			zh = 5.866,
			ja = 5.733
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
			arg_285_1.auto_ = false
		end

		function arg_285_1.playNext_(arg_287_0)
			arg_285_1.onStoryFinished_()
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.425

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[1036].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:GetWordFromCfg(320252070)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 17
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320252", "320252070", "story_v_out_320252.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_320252", "320252070", "story_v_out_320252.awb") / 1000

					if var_288_8 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_0
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_320252", "320252070", "story_v_out_320252.awb")

						arg_285_1:RecordAudio("320252070", var_288_9)
						arg_285_1:RecordAudio("320252070", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_320252", "320252070", "story_v_out_320252.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_320252", "320252070", "story_v_out_320252.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_10 and arg_285_1.time_ < var_288_0 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L07f",
		"TextureConfig/Background/L07i",
		"TextureConfig/Background/L07m"
	},
	voices = {
		"story_v_out_320252.awb"
	}
}
