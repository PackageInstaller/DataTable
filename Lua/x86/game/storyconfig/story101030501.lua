return {
	Play103051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103051001
		arg_1_1.duration_ = 6.33

		local var_1_0 = {
			ja = 6.333,
			ko = 5.333,
			zh = 5.366,
			en = 4.8
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
				arg_1_0:Play103051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = "1019ui_story"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

					var_4_12.name = var_4_10
					var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_10] = var_4_12

					local var_4_13 = var_4_12:GetComponentInChildren(typeof(CharacterEffect))

					var_4_13.enabled = true

					local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_12, typeof(DynamicBoneHelper))

					if var_4_14 then
						var_4_14:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_13.transform, false)

					arg_1_1.var_[var_4_10 .. "Animator"] = var_4_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_10 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_10 .. "LipSync"] = var_4_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_15 = arg_1_1.actors_["1019ui_story"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_19 = "B07b"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.B07b
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueB07b = var_4_23.color.a
					arg_1_1.var_.alphaMatValueB07b = var_4_23
				end

				arg_1_1.var_.alphaOldValueB07b = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB07b, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueB07b then
					local var_4_27 = arg_1_1.var_.alphaMatValueB07b.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueB07b.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueB07b then
				local var_4_28 = arg_1_1.var_.alphaMatValueB07b
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.B07b

				var_4_33.transform.localPosition = var_4_32
				var_4_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_34 = var_4_33:GetComponent("SpriteRenderer")

				if var_4_34 and var_4_34.sprite then
					local var_4_35 = (var_4_33.transform.localPosition - var_4_31).z
					local var_4_36 = manager.ui.mainCameraCom_
					local var_4_37 = 2 * var_4_35 * Mathf.Tan(var_4_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_38 = var_4_37 * var_4_36.aspect
					local var_4_39 = var_4_34.sprite.bounds.size.x
					local var_4_40 = var_4_34.sprite.bounds.size.y
					local var_4_41 = var_4_38 / var_4_39
					local var_4_42 = var_4_37 / var_4_40
					local var_4_43 = var_4_42 < var_4_41 and var_4_41 or var_4_42

					var_4_33.transform.localScale = Vector3.New(var_4_43, var_4_43, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B07b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = 1.5

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_4_45 = arg_1_1.actors_["1019ui_story"].transform
			local var_4_46 = 0

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_45.localPosition
			end

			local var_4_47 = 0.001

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_46) / var_4_47
				local var_4_49 = Vector3.New(-0.2, -1.08, -5.9)

				var_4_45.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, var_4_49, var_4_48)

				local var_4_50 = manager.ui.mainCamera.transform.position - var_4_45.position

				var_4_45.forward = Vector3.New(var_4_50.x, var_4_50.y, var_4_50.z)

				local var_4_51 = var_4_45.localEulerAngles

				var_4_51.z = 0
				var_4_51.x = 0
				var_4_45.localEulerAngles = var_4_51
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				var_4_45.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_4_52 = manager.ui.mainCamera.transform.position - var_4_45.position

				var_4_45.forward = Vector3.New(var_4_52.x, var_4_52.y, var_4_52.z)

				local var_4_53 = var_4_45.localEulerAngles

				var_4_53.z = 0
				var_4_53.x = 0
				var_4_45.localEulerAngles = var_4_53
			end

			local var_4_54 = 0

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_55 = 2

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_56 = 0

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_57 = 2
			local var_4_58 = 0.225

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_59 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_59:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(103051001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 9
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_58 or var_4_58 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_58 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65
					var_4_57 = var_4_57 + 0.3

					if var_4_65 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_57
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051001", "story_v_out_103051.awb") ~= 0 then
					local var_4_66 = manager.audio:GetVoiceLength("story_v_out_103051", "103051001", "story_v_out_103051.awb") / 1000

					if var_4_66 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_57
					end

					if var_4_61.prefab_name ~= "" and arg_1_1.actors_[var_4_61.prefab_name] ~= nil then
						local var_4_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_61.prefab_name].transform, "story_v_out_103051", "103051001", "story_v_out_103051.awb")

						arg_1_1:RecordAudio("103051001", var_4_67)
						arg_1_1:RecordAudio("103051001", var_4_67)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103051", "103051001", "story_v_out_103051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103051", "103051001", "story_v_out_103051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = var_4_57 + 0.3
			local var_4_69 = math.max(var_4_58, arg_1_1.talkMaxDuration)

			if var_4_68 <= arg_1_1.time_ and arg_1_1.time_ < var_4_68 + var_4_69 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_68) / var_4_69

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_68 + var_4_69 and arg_1_1.time_ < var_4_68 + var_4_69 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play103051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103051002
		arg_8_1.duration_ = 8.2

		local var_8_0 = {
			ja = 8.2,
			ko = 5.866,
			zh = 6.433,
			en = 6.866
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_3", "se_story_3_wrongpassword", "")
			end

			local var_11_4 = arg_8_1.actors_["1019ui_story"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.1

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_4) then
					local var_11_8 = Mathf.Lerp(0, 0.5, var_11_7)

					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_8
				end
			end

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.characterEffect1019ui_story then
				local var_11_9 = 0.5

				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_9
			end

			local var_11_10 = 0
			local var_11_11 = 0.525

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_12 = arg_8_1:FormatText(StoryNameCfg[51].name)

				arg_8_1.leftNameTxt_.text = var_11_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_13 = arg_8_1:GetWordFromCfg(103051002)
				local var_11_14 = arg_8_1:FormatText(var_11_13.content)

				arg_8_1.text_.text = var_11_14

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 21
				local var_11_16 = utf8.len(var_11_14)
				local var_11_17 = var_11_15 <= 0 and var_11_11 or var_11_11 * (var_11_16 / var_11_15)

				if var_11_17 > 0 and var_11_11 < var_11_17 then
					arg_8_1.talkMaxDuration = var_11_17

					if var_11_17 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_14
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051002", "story_v_out_103051.awb") ~= 0 then
					local var_11_18 = manager.audio:GetVoiceLength("story_v_out_103051", "103051002", "story_v_out_103051.awb") / 1000

					if var_11_18 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_10
					end

					if var_11_13.prefab_name ~= "" and arg_8_1.actors_[var_11_13.prefab_name] ~= nil then
						local var_11_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_13.prefab_name].transform, "story_v_out_103051", "103051002", "story_v_out_103051.awb")

						arg_8_1:RecordAudio("103051002", var_11_19)
						arg_8_1:RecordAudio("103051002", var_11_19)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103051", "103051002", "story_v_out_103051.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103051", "103051002", "story_v_out_103051.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_20 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_20 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_20

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_20 and arg_8_1.time_ < var_11_10 + var_11_20 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play103051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103051003
		arg_12_1.duration_ = 2

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play103051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1084ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["1019ui_story"].transform
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_9.localPosition
			end

			local var_15_11 = 0.001

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11
				local var_15_13 = Vector3.New(-0.2, -1.08, -5.9)

				var_15_9.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, var_15_13, var_15_12)

				local var_15_14 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_14.x, var_15_14.y, var_15_14.z)

				local var_15_15 = var_15_9.localEulerAngles

				var_15_15.z = 0
				var_15_15.x = 0
				var_15_9.localEulerAngles = var_15_15
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 then
				var_15_9.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_15_16 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_16.x, var_15_16.y, var_15_16.z)

				local var_15_17 = var_15_9.localEulerAngles

				var_15_17.z = 0
				var_15_17.x = 0
				var_15_9.localEulerAngles = var_15_17
			end

			local var_15_18 = arg_12_1.actors_["1019ui_story"].transform
			local var_15_19 = 0.033

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_18.localPosition
			end

			local var_15_20 = 0.5

			if var_15_19 <= arg_12_1.time_ and arg_12_1.time_ < var_15_19 + var_15_20 then
				local var_15_21 = (arg_12_1.time_ - var_15_19) / var_15_20
				local var_15_22 = Vector3.New(-0.7, -1.08, -5.9)

				var_15_18.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, var_15_22, var_15_21)

				local var_15_23 = manager.ui.mainCamera.transform.position - var_15_18.position

				var_15_18.forward = Vector3.New(var_15_23.x, var_15_23.y, var_15_23.z)

				local var_15_24 = var_15_18.localEulerAngles

				var_15_24.z = 0
				var_15_24.x = 0
				var_15_18.localEulerAngles = var_15_24
			end

			if arg_12_1.time_ >= var_15_19 + var_15_20 and arg_12_1.time_ < var_15_19 + var_15_20 + arg_15_0 then
				var_15_18.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_15_25 = manager.ui.mainCamera.transform.position - var_15_18.position

				var_15_18.forward = Vector3.New(var_15_25.x, var_15_25.y, var_15_25.z)

				local var_15_26 = var_15_18.localEulerAngles

				var_15_26.z = 0
				var_15_26.x = 0
				var_15_18.localEulerAngles = var_15_26
			end

			local var_15_27 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_28 = 0

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_27.localPosition
			end

			local var_15_29 = 0.001

			if var_15_28 <= arg_12_1.time_ and arg_12_1.time_ < var_15_28 + var_15_29 then
				local var_15_30 = (arg_12_1.time_ - var_15_28) / var_15_29
				local var_15_31 = Vector3.New(0.7, -0.97, -6)

				var_15_27.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_31, var_15_30)

				local var_15_32 = manager.ui.mainCamera.transform.position - var_15_27.position

				var_15_27.forward = Vector3.New(var_15_32.x, var_15_32.y, var_15_32.z)

				local var_15_33 = var_15_27.localEulerAngles

				var_15_33.z = 0
				var_15_33.x = 0
				var_15_27.localEulerAngles = var_15_33
			end

			if arg_12_1.time_ >= var_15_28 + var_15_29 and arg_12_1.time_ < var_15_28 + var_15_29 + arg_15_0 then
				var_15_27.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_15_34 = manager.ui.mainCamera.transform.position - var_15_27.position

				var_15_27.forward = Vector3.New(var_15_34.x, var_15_34.y, var_15_34.z)

				local var_15_35 = var_15_27.localEulerAngles

				var_15_35.z = 0
				var_15_35.x = 0
				var_15_27.localEulerAngles = var_15_35
			end

			local var_15_36 = 0

			if var_15_36 < arg_12_1.time_ and arg_12_1.time_ <= var_15_36 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_15_37 = 0

			if var_15_37 < arg_12_1.time_ and arg_12_1.time_ <= var_15_37 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_15_38 = 0
			local var_15_39 = 0.075

			if var_15_38 < arg_12_1.time_ and arg_12_1.time_ <= var_15_38 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_40 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_41 = arg_12_1:GetWordFromCfg(103051003)
				local var_15_42 = arg_12_1:FormatText(var_15_41.content)

				arg_12_1.text_.text = var_15_42

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_43 = 3
				local var_15_44 = utf8.len(var_15_42)
				local var_15_45 = var_15_43 <= 0 and var_15_39 or var_15_39 * (var_15_44 / var_15_43)

				if var_15_45 > 0 and var_15_39 < var_15_45 then
					arg_12_1.talkMaxDuration = var_15_45

					if var_15_45 + var_15_38 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_45 + var_15_38
					end
				end

				arg_12_1.text_.text = var_15_42
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051003", "story_v_out_103051.awb") ~= 0 then
					local var_15_46 = manager.audio:GetVoiceLength("story_v_out_103051", "103051003", "story_v_out_103051.awb") / 1000

					if var_15_46 + var_15_38 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_46 + var_15_38
					end

					if var_15_41.prefab_name ~= "" and arg_12_1.actors_[var_15_41.prefab_name] ~= nil then
						local var_15_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_41.prefab_name].transform, "story_v_out_103051", "103051003", "story_v_out_103051.awb")

						arg_12_1:RecordAudio("103051003", var_15_47)
						arg_12_1:RecordAudio("103051003", var_15_47)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103051", "103051003", "story_v_out_103051.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103051", "103051003", "story_v_out_103051.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_48 = math.max(var_15_39, arg_12_1.talkMaxDuration)

			if var_15_38 <= arg_12_1.time_ and arg_12_1.time_ < var_15_38 + var_15_48 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_38) / var_15_48

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_38 + var_15_48 and arg_12_1.time_ < var_15_38 + var_15_48 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play103051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103051004
		arg_16_1.duration_ = 2.73

		local var_16_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play103051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1019ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1084ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.1

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1084ui_story then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = var_19_9
			end

			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.225

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_15 = arg_16_1:GetWordFromCfg(103051004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 9
				local var_19_18 = utf8.len(var_19_16)
				local var_19_19 = var_19_17 <= 0 and var_19_13 or var_19_13 * (var_19_18 / var_19_17)

				if var_19_19 > 0 and var_19_13 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_16
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051004", "story_v_out_103051.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_103051", "103051004", "story_v_out_103051.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_103051", "103051004", "story_v_out_103051.awb")

						arg_16_1:RecordAudio("103051004", var_19_21)
						arg_16_1:RecordAudio("103051004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103051", "103051004", "story_v_out_103051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103051", "103051004", "story_v_out_103051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_22 and arg_16_1.time_ < var_19_12 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play103051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103051005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play103051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1019ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1019ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1019ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.35

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(103051005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 14
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play103051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103051006
		arg_24_1.duration_ = 12.13

		local var_24_0 = {
			ja = 12.133,
			ko = 5.766,
			zh = 7.2,
			en = 6.533
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play103051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.875

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[10].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(103051006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 35
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051006", "story_v_out_103051.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_103051", "103051006", "story_v_out_103051.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_103051", "103051006", "story_v_out_103051.awb")

						arg_24_1:RecordAudio("103051006", var_27_9)
						arg_24_1:RecordAudio("103051006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103051", "103051006", "story_v_out_103051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103051", "103051006", "story_v_out_103051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play103051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103051007
		arg_28_1.duration_ = 2.13

		local var_28_0 = {
			ja = 2.133,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play103051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_6 = 0
			local var_31_7 = 0.2

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_9 = arg_28_1:GetWordFromCfg(103051007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 8
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051007", "story_v_out_103051.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_103051", "103051007", "story_v_out_103051.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_103051", "103051007", "story_v_out_103051.awb")

						arg_28_1:RecordAudio("103051007", var_31_15)
						arg_28_1:RecordAudio("103051007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103051", "103051007", "story_v_out_103051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103051", "103051007", "story_v_out_103051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play103051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103051008
		arg_32_1.duration_ = 2.27

		local var_32_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 2.133,
			en = 1.999999999999
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play103051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1011ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1011ui_story"]
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1011ui_story == nil then
				arg_32_1.var_.characterEffect1011ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.1

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 and not isNil(var_35_5) then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7

				if arg_32_1.var_.characterEffect1011ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1011ui_story then
				arg_32_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_35_9 = arg_32_1.actors_["1019ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.1

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_9) then
					local var_35_13 = Mathf.Lerp(0, 0.5, var_35_12)

					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_13
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1019ui_story then
				local var_35_14 = 0.5

				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_14
			end

			local var_35_15 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_15.localPosition
			end

			local var_35_17 = 0.001

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_17 then
				local var_35_18 = (arg_32_1.time_ - var_35_16) / var_35_17
				local var_35_19 = Vector3.New(0, 100, 0)

				var_35_15.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_19, var_35_18)

				local var_35_20 = manager.ui.mainCamera.transform.position - var_35_15.position

				var_35_15.forward = Vector3.New(var_35_20.x, var_35_20.y, var_35_20.z)

				local var_35_21 = var_35_15.localEulerAngles

				var_35_21.z = 0
				var_35_21.x = 0
				var_35_15.localEulerAngles = var_35_21
			end

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				var_35_15.localPosition = Vector3.New(0, 100, 0)

				local var_35_22 = manager.ui.mainCamera.transform.position - var_35_15.position

				var_35_15.forward = Vector3.New(var_35_22.x, var_35_22.y, var_35_22.z)

				local var_35_23 = var_35_15.localEulerAngles

				var_35_23.z = 0
				var_35_23.x = 0
				var_35_15.localEulerAngles = var_35_23
			end

			local var_35_24 = 0

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_35_25 = arg_32_1.actors_["1011ui_story"].transform
			local var_35_26 = 0

			if var_35_26 < arg_32_1.time_ and arg_32_1.time_ <= var_35_26 + arg_35_0 then
				arg_32_1.var_.moveOldPos1011ui_story = var_35_25.localPosition
			end

			local var_35_27 = 0.001

			if var_35_26 <= arg_32_1.time_ and arg_32_1.time_ < var_35_26 + var_35_27 then
				local var_35_28 = (arg_32_1.time_ - var_35_26) / var_35_27
				local var_35_29 = Vector3.New(0.7, -0.71, -6)

				var_35_25.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1011ui_story, var_35_29, var_35_28)

				local var_35_30 = manager.ui.mainCamera.transform.position - var_35_25.position

				var_35_25.forward = Vector3.New(var_35_30.x, var_35_30.y, var_35_30.z)

				local var_35_31 = var_35_25.localEulerAngles

				var_35_31.z = 0
				var_35_31.x = 0
				var_35_25.localEulerAngles = var_35_31
			end

			if arg_32_1.time_ >= var_35_26 + var_35_27 and arg_32_1.time_ < var_35_26 + var_35_27 + arg_35_0 then
				var_35_25.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_35_32 = manager.ui.mainCamera.transform.position - var_35_25.position

				var_35_25.forward = Vector3.New(var_35_32.x, var_35_32.y, var_35_32.z)

				local var_35_33 = var_35_25.localEulerAngles

				var_35_33.z = 0
				var_35_33.x = 0
				var_35_25.localEulerAngles = var_35_33
			end

			local var_35_34 = 0

			if var_35_34 < arg_32_1.time_ and arg_32_1.time_ <= var_35_34 + arg_35_0 then
				arg_32_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_35_35 = 0
			local var_35_36 = 0.15

			if var_35_35 < arg_32_1.time_ and arg_32_1.time_ <= var_35_35 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_37 = arg_32_1:FormatText(StoryNameCfg[37].name)

				arg_32_1.leftNameTxt_.text = var_35_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_38 = arg_32_1:GetWordFromCfg(103051008)
				local var_35_39 = arg_32_1:FormatText(var_35_38.content)

				arg_32_1.text_.text = var_35_39

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_40 = 6
				local var_35_41 = utf8.len(var_35_39)
				local var_35_42 = var_35_40 <= 0 and var_35_36 or var_35_36 * (var_35_41 / var_35_40)

				if var_35_42 > 0 and var_35_36 < var_35_42 then
					arg_32_1.talkMaxDuration = var_35_42

					if var_35_42 + var_35_35 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_42 + var_35_35
					end
				end

				arg_32_1.text_.text = var_35_39
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051008", "story_v_out_103051.awb") ~= 0 then
					local var_35_43 = manager.audio:GetVoiceLength("story_v_out_103051", "103051008", "story_v_out_103051.awb") / 1000

					if var_35_43 + var_35_35 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_43 + var_35_35
					end

					if var_35_38.prefab_name ~= "" and arg_32_1.actors_[var_35_38.prefab_name] ~= nil then
						local var_35_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_38.prefab_name].transform, "story_v_out_103051", "103051008", "story_v_out_103051.awb")

						arg_32_1:RecordAudio("103051008", var_35_44)
						arg_32_1:RecordAudio("103051008", var_35_44)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_103051", "103051008", "story_v_out_103051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_103051", "103051008", "story_v_out_103051.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_45 = math.max(var_35_36, arg_32_1.talkMaxDuration)

			if var_35_35 <= arg_32_1.time_ and arg_32_1.time_ < var_35_35 + var_35_45 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_35) / var_35_45

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_35 + var_35_45 and arg_32_1.time_ < var_35_35 + var_35_45 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play103051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103051009
		arg_36_1.duration_ = 4.63

		local var_36_0 = {
			ja = 4.1,
			ko = 3.366,
			zh = 4.133,
			en = 4.633
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play103051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "play"
				local var_39_3 = "effect"

				arg_36_1:AudioAction(var_39_2, var_39_3, "se_story_3", "se_story_3_verified", "")
			end

			local var_39_4 = arg_36_1.actors_["1011ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1011ui_story == nil then
				arg_36_1.var_.characterEffect1011ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.1

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1011ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1011ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1011ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1011ui_story.fillRatio = var_39_9
			end

			local var_39_10 = arg_36_1.actors_["1011ui_story"].transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_10.localPosition
			end

			local var_39_12 = 0.001

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_11) / var_39_12
				local var_39_14 = Vector3.New(0, 100, 0)

				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, var_39_14, var_39_13)

				local var_39_15 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_15.x, var_39_15.y, var_39_15.z)

				local var_39_16 = var_39_10.localEulerAngles

				var_39_16.z = 0
				var_39_16.x = 0
				var_39_10.localEulerAngles = var_39_16
			end

			if arg_36_1.time_ >= var_39_11 + var_39_12 and arg_36_1.time_ < var_39_11 + var_39_12 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, 100, 0)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_10.position

				var_39_10.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_10.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_10.localEulerAngles = var_39_18
			end

			local var_39_19 = arg_36_1.actors_["1019ui_story"].transform
			local var_39_20 = 0

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_19.localPosition
			end

			local var_39_21 = 0.001

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_21 then
				local var_39_22 = (arg_36_1.time_ - var_39_20) / var_39_21
				local var_39_23 = Vector3.New(0, 100, 0)

				var_39_19.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, var_39_23, var_39_22)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_19.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_19.localEulerAngles = var_39_25
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				var_39_19.localPosition = Vector3.New(0, 100, 0)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_19.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_19.localEulerAngles = var_39_27
			end

			local var_39_28 = 0
			local var_39_29 = 0.35

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_30 = arg_36_1:FormatText(StoryNameCfg[51].name)

				arg_36_1.leftNameTxt_.text = var_39_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_31 = arg_36_1:GetWordFromCfg(103051009)
				local var_39_32 = arg_36_1:FormatText(var_39_31.content)

				arg_36_1.text_.text = var_39_32

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_33 = 14
				local var_39_34 = utf8.len(var_39_32)
				local var_39_35 = var_39_33 <= 0 and var_39_29 or var_39_29 * (var_39_34 / var_39_33)

				if var_39_35 > 0 and var_39_29 < var_39_35 then
					arg_36_1.talkMaxDuration = var_39_35

					if var_39_35 + var_39_28 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_35 + var_39_28
					end
				end

				arg_36_1.text_.text = var_39_32
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051009", "story_v_out_103051.awb") ~= 0 then
					local var_39_36 = manager.audio:GetVoiceLength("story_v_out_103051", "103051009", "story_v_out_103051.awb") / 1000

					if var_39_36 + var_39_28 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_36 + var_39_28
					end

					if var_39_31.prefab_name ~= "" and arg_36_1.actors_[var_39_31.prefab_name] ~= nil then
						local var_39_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_31.prefab_name].transform, "story_v_out_103051", "103051009", "story_v_out_103051.awb")

						arg_36_1:RecordAudio("103051009", var_39_37)
						arg_36_1:RecordAudio("103051009", var_39_37)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103051", "103051009", "story_v_out_103051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103051", "103051009", "story_v_out_103051.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_38 = math.max(var_39_29, arg_36_1.talkMaxDuration)

			if var_39_28 <= arg_36_1.time_ and arg_36_1.time_ < var_39_28 + var_39_38 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_28) / var_39_38

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_28 + var_39_38 and arg_36_1.time_ < var_39_28 + var_39_38 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play103051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103051010
		arg_40_1.duration_ = 2.57

		local var_40_0 = {
			ja = 2.266,
			ko = 2.566,
			zh = 2.333,
			en = 2.3
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play103051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_4.localPosition
			end

			local var_43_6 = 0.001

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6
				local var_43_8 = Vector3.New(0, -0.97, -6)

				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_8, var_43_7)

				local var_43_9 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_9.x, var_43_9.y, var_43_9.z)

				local var_43_10 = var_43_4.localEulerAngles

				var_43_10.z = 0
				var_43_10.x = 0
				var_43_4.localEulerAngles = var_43_10
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 then
				var_43_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_43_11 = manager.ui.mainCamera.transform.position - var_43_4.position

				var_43_4.forward = Vector3.New(var_43_11.x, var_43_11.y, var_43_11.z)

				local var_43_12 = var_43_4.localEulerAngles

				var_43_12.z = 0
				var_43_12.x = 0
				var_43_4.localEulerAngles = var_43_12
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_43_14 = 0

			if var_43_14 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_43_15 = 0
			local var_43_16 = 0.175

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_17 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(103051010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 7
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051010", "story_v_out_103051.awb") ~= 0 then
					local var_43_23 = manager.audio:GetVoiceLength("story_v_out_103051", "103051010", "story_v_out_103051.awb") / 1000

					if var_43_23 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_23 + var_43_15
					end

					if var_43_18.prefab_name ~= "" and arg_40_1.actors_[var_43_18.prefab_name] ~= nil then
						local var_43_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_18.prefab_name].transform, "story_v_out_103051", "103051010", "story_v_out_103051.awb")

						arg_40_1:RecordAudio("103051010", var_43_24)
						arg_40_1:RecordAudio("103051010", var_43_24)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_103051", "103051010", "story_v_out_103051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_103051", "103051010", "story_v_out_103051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_25 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_25 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_15) / var_43_25

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_15 + var_43_25 and arg_40_1.time_ < var_43_15 + var_43_25 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play103051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103051011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play103051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1084ui_story then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.35

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(103051011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 14
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play103051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103051012
		arg_48_1.duration_ = 3.73

		local var_48_0 = {
			ja = 3.733,
			ko = 2,
			zh = 1.3,
			en = 1.9
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play103051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.15

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[10].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(103051012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 6
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051012", "story_v_out_103051.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_103051", "103051012", "story_v_out_103051.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_103051", "103051012", "story_v_out_103051.awb")

						arg_48_1:RecordAudio("103051012", var_51_9)
						arg_48_1:RecordAudio("103051012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103051", "103051012", "story_v_out_103051.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103051", "103051012", "story_v_out_103051.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play103051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103051013
		arg_52_1.duration_ = 3.7

		local var_52_0 = {
			ja = 3.7,
			ko = 2.233,
			zh = 2.1,
			en = 2.733
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play103051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "1036ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_52_1.stage_.transform)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

					var_55_3.enabled = true

					local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

					if var_55_4 then
						var_55_4:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_3.transform, false)

					arg_52_1.var_[var_55_0 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_0 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_0 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_5 = arg_52_1.actors_["1036ui_story"]
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1036ui_story == nil then
				arg_52_1.var_.characterEffect1036ui_story = var_55_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.1

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 and not isNil(var_55_5) then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7

				if arg_52_1.var_.characterEffect1036ui_story and not isNil(var_55_5) then
					arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 and not isNil(var_55_5) and arg_52_1.var_.characterEffect1036ui_story then
				arg_52_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_55_9 = arg_52_1.actors_["1084ui_story"].transform
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_9.localPosition
			end

			local var_55_11 = 0.001

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11
				local var_55_13 = Vector3.New(0, 100, 0)

				var_55_9.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, var_55_13, var_55_12)

				local var_55_14 = manager.ui.mainCamera.transform.position - var_55_9.position

				var_55_9.forward = Vector3.New(var_55_14.x, var_55_14.y, var_55_14.z)

				local var_55_15 = var_55_9.localEulerAngles

				var_55_15.z = 0
				var_55_15.x = 0
				var_55_9.localEulerAngles = var_55_15
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 then
				var_55_9.localPosition = Vector3.New(0, 100, 0)

				local var_55_16 = manager.ui.mainCamera.transform.position - var_55_9.position

				var_55_9.forward = Vector3.New(var_55_16.x, var_55_16.y, var_55_16.z)

				local var_55_17 = var_55_9.localEulerAngles

				var_55_17.z = 0
				var_55_17.x = 0
				var_55_9.localEulerAngles = var_55_17
			end

			local var_55_18 = 0
			local var_55_19 = 0.225

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_20 = arg_52_1:FormatText(StoryNameCfg[5].name)

				arg_52_1.leftNameTxt_.text = var_55_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_21 = arg_52_1:GetWordFromCfg(103051013)
				local var_55_22 = arg_52_1:FormatText(var_55_21.content)

				arg_52_1.text_.text = var_55_22

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_23 = 9
				local var_55_24 = utf8.len(var_55_22)
				local var_55_25 = var_55_23 <= 0 and var_55_19 or var_55_19 * (var_55_24 / var_55_23)

				if var_55_25 > 0 and var_55_19 < var_55_25 then
					arg_52_1.talkMaxDuration = var_55_25

					if var_55_25 + var_55_18 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_18
					end
				end

				arg_52_1.text_.text = var_55_22
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051013", "story_v_out_103051.awb") ~= 0 then
					local var_55_26 = manager.audio:GetVoiceLength("story_v_out_103051", "103051013", "story_v_out_103051.awb") / 1000

					if var_55_26 + var_55_18 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_26 + var_55_18
					end

					if var_55_21.prefab_name ~= "" and arg_52_1.actors_[var_55_21.prefab_name] ~= nil then
						local var_55_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_21.prefab_name].transform, "story_v_out_103051", "103051013", "story_v_out_103051.awb")

						arg_52_1:RecordAudio("103051013", var_55_27)
						arg_52_1:RecordAudio("103051013", var_55_27)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103051", "103051013", "story_v_out_103051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103051", "103051013", "story_v_out_103051.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_28 = math.max(var_55_19, arg_52_1.talkMaxDuration)

			if var_55_18 <= arg_52_1.time_ and arg_52_1.time_ < var_55_18 + var_55_28 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_18) / var_55_28

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_18 + var_55_28 and arg_52_1.time_ < var_55_18 + var_55_28 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play103051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103051014
		arg_56_1.duration_ = 1.33

		local var_56_0 = {
			ja = 1.333,
			ko = 1.266,
			zh = 1.3,
			en = 1.2
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play103051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1019ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1019ui_story then
				arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1036ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1036ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1036ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1036ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1036ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0
			local var_59_11 = 0.1

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_12 = arg_56_1:FormatText(StoryNameCfg[13].name)

				arg_56_1.leftNameTxt_.text = var_59_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_13 = arg_56_1:GetWordFromCfg(103051014)
				local var_59_14 = arg_56_1:FormatText(var_59_13.content)

				arg_56_1.text_.text = var_59_14

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 4
				local var_59_16 = utf8.len(var_59_14)
				local var_59_17 = var_59_15 <= 0 and var_59_11 or var_59_11 * (var_59_16 / var_59_15)

				if var_59_17 > 0 and var_59_11 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_14
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051014", "story_v_out_103051.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_103051", "103051014", "story_v_out_103051.awb") / 1000

					if var_59_18 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_10
					end

					if var_59_13.prefab_name ~= "" and arg_56_1.actors_[var_59_13.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_13.prefab_name].transform, "story_v_out_103051", "103051014", "story_v_out_103051.awb")

						arg_56_1:RecordAudio("103051014", var_59_19)
						arg_56_1:RecordAudio("103051014", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_103051", "103051014", "story_v_out_103051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_103051", "103051014", "story_v_out_103051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_20 and arg_56_1.time_ < var_59_10 + var_59_20 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play103051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 103051015
		arg_60_1.duration_ = 7.77

		local var_60_0 = {
			ja = 7.766,
			ko = 7,
			zh = 6,
			en = 6.3
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
				arg_60_0:Play103051016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1036ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1036ui_story == nil then
				arg_60_1.var_.characterEffect1036ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1036ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1036ui_story then
				arg_60_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_63_4 = 0
			local var_63_5 = 0.85

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_6 = arg_60_1:FormatText(StoryNameCfg[5].name)

				arg_60_1.leftNameTxt_.text = var_63_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_7 = arg_60_1:GetWordFromCfg(103051015)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 34
				local var_63_10 = utf8.len(var_63_8)
				local var_63_11 = var_63_9 <= 0 and var_63_5 or var_63_5 * (var_63_10 / var_63_9)

				if var_63_11 > 0 and var_63_5 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051015", "story_v_out_103051.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_103051", "103051015", "story_v_out_103051.awb") / 1000

					if var_63_12 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_4
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_103051", "103051015", "story_v_out_103051.awb")

						arg_60_1:RecordAudio("103051015", var_63_13)
						arg_60_1:RecordAudio("103051015", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_103051", "103051015", "story_v_out_103051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_103051", "103051015", "story_v_out_103051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_14 and arg_60_1.time_ < var_63_4 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play103051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 103051016
		arg_64_1.duration_ = 0.1

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"

			SetActive(arg_64_1.choicesGo_, true)

			for iter_65_0, iter_65_1 in ipairs(arg_64_1.choices_) do
				local var_65_0 = iter_65_0 <= 2

				SetActive(iter_65_1.go, var_65_0)
			end

			arg_64_1.choices_[1].txt.text = arg_64_1:FormatText(StoryChoiceCfg[18].name)
			arg_64_1.choices_[2].txt.text = arg_64_1:FormatText(StoryChoiceCfg[19].name)
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play103051017(arg_64_1)
			end

			if arg_66_0 == 2 then
				arg_64_0:Play103051018(arg_64_1)
			end

			arg_64_1:RecordChoiceLog(103051016, 18, 19)
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1036ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1036ui_story == nil then
				arg_64_1.var_.characterEffect1036ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1036ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1036ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1036ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1036ui_story.fillRatio = var_67_5
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play103051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 103051017
		arg_68_1.duration_ = 7.9

		local var_68_0 = {
			ja = 7.9,
			ko = 7.466,
			zh = 5.533,
			en = 7.2
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play103051019(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1036ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1036ui_story == nil then
				arg_68_1.var_.characterEffect1036ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1036ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1036ui_story then
				arg_68_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_71_4 = 0
			local var_71_5 = 0.775

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_6 = arg_68_1:FormatText(StoryNameCfg[5].name)

				arg_68_1.leftNameTxt_.text = var_71_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_7 = arg_68_1:GetWordFromCfg(103051017)
				local var_71_8 = arg_68_1:FormatText(var_71_7.content)

				arg_68_1.text_.text = var_71_8

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 31
				local var_71_10 = utf8.len(var_71_8)
				local var_71_11 = var_71_9 <= 0 and var_71_5 or var_71_5 * (var_71_10 / var_71_9)

				if var_71_11 > 0 and var_71_5 < var_71_11 then
					arg_68_1.talkMaxDuration = var_71_11

					if var_71_11 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_8
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051017", "story_v_out_103051.awb") ~= 0 then
					local var_71_12 = manager.audio:GetVoiceLength("story_v_out_103051", "103051017", "story_v_out_103051.awb") / 1000

					if var_71_12 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_4
					end

					if var_71_7.prefab_name ~= "" and arg_68_1.actors_[var_71_7.prefab_name] ~= nil then
						local var_71_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_7.prefab_name].transform, "story_v_out_103051", "103051017", "story_v_out_103051.awb")

						arg_68_1:RecordAudio("103051017", var_71_13)
						arg_68_1:RecordAudio("103051017", var_71_13)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_103051", "103051017", "story_v_out_103051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_103051", "103051017", "story_v_out_103051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_14 and arg_68_1.time_ < var_71_4 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play103051019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 103051019
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play103051020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1036ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1036ui_story == nil then
				arg_72_1.var_.characterEffect1036ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1036ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1036ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1036ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1036ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.35

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(103051019)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 14
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play103051020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 103051020
		arg_76_1.duration_ = 7.77

		local var_76_0 = {
			ja = 5.533,
			ko = 6.966,
			zh = 6.233,
			en = 7.766
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
			arg_76_1.auto_ = false
		end

		function arg_76_1.playNext_(arg_78_0)
			arg_76_1.onStoryFinished_()
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1036ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1036ui_story == nil then
				arg_76_1.var_.characterEffect1036ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1036ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1036ui_story then
				arg_76_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_79_4 = 0
			local var_79_5 = 0.825

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_6 = arg_76_1:FormatText(StoryNameCfg[5].name)

				arg_76_1.leftNameTxt_.text = var_79_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_7 = arg_76_1:GetWordFromCfg(103051020)
				local var_79_8 = arg_76_1:FormatText(var_79_7.content)

				arg_76_1.text_.text = var_79_8

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 33
				local var_79_10 = utf8.len(var_79_8)
				local var_79_11 = var_79_9 <= 0 and var_79_5 or var_79_5 * (var_79_10 / var_79_9)

				if var_79_11 > 0 and var_79_5 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_8
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051020", "story_v_out_103051.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_103051", "103051020", "story_v_out_103051.awb") / 1000

					if var_79_12 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_4
					end

					if var_79_7.prefab_name ~= "" and arg_76_1.actors_[var_79_7.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_7.prefab_name].transform, "story_v_out_103051", "103051020", "story_v_out_103051.awb")

						arg_76_1:RecordAudio("103051020", var_79_13)
						arg_76_1:RecordAudio("103051020", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_103051", "103051020", "story_v_out_103051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_103051", "103051020", "story_v_out_103051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_14 and arg_76_1.time_ < var_79_4 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play103051018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 103051018
		arg_80_1.duration_ = 7.23

		local var_80_0 = {
			ja = 7.233,
			ko = 6.7,
			zh = 4.7,
			en = 6.433
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play103051019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.675

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[5].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(103051018)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 27
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103051", "103051018", "story_v_out_103051.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_103051", "103051018", "story_v_out_103051.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_103051", "103051018", "story_v_out_103051.awb")

						arg_80_1:RecordAudio("103051018", var_83_9)
						arg_80_1:RecordAudio("103051018", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_103051", "103051018", "story_v_out_103051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_103051", "103051018", "story_v_out_103051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B07b"
	},
	voices = {
		"story_v_out_103051.awb"
	}
}
