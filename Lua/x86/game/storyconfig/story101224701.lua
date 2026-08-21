return {
	Play122471001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122471001
		arg_1_1.duration_ = 6.17

		local var_1_0 = {
			ja = 6.166,
			ko = 4.366666666666,
			zh = 4.366666666666
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
				arg_1_0:Play122471002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST42"

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
				local var_4_5 = arg_1_1.bgs_.ST42

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
					if iter_4_0 ~= "ST42" then
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

			local var_4_22 = "1076ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1076ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["1076ui_story"].transform
			local var_4_28 = 2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1076ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.06, -6.2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1076ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1076ui_story"]
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1076ui_story == nil then
				arg_1_1.var_.characterEffect1076ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1076ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1076ui_story then
				arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_4_41 = 2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_42 = 2
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "effect"

				arg_1_1:AudioAction(var_4_44, var_4_45, "se_story_122_03", "se_story_122_03_chess", "")
			end

			local var_4_46 = 0
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 1.5
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "bgm_activity_2_2_story_ygx", "bgm_activity_2_2_story_ygx", "bgm_activity_2_2_story_ygx.awb")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("bgm_activity_2_2_story_ygx", "bgm_activity_2_2_story_ygx")

				if var_4_57 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_57 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_57

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_57
						arg_1_1.bgmTxt2_.text = var_4_57
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

			local var_4_58 = 2
			local var_4_59 = 0.175

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[389].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(122471001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 7
				local var_4_65 = utf8.len(var_4_63)
				local var_4_66 = var_4_64 <= 0 and var_4_59 or var_4_59 * (var_4_65 / var_4_64)

				if var_4_66 > 0 and var_4_59 < var_4_66 then
					arg_1_1.talkMaxDuration = var_4_66
					var_4_58 = var_4_58 + 0.3

					if var_4_66 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_58
					end
				end

				arg_1_1.text_.text = var_4_63
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471001", "story_v_out_122471.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_122471", "122471001", "story_v_out_122471.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_122471", "122471001", "story_v_out_122471.awb")

						arg_1_1:RecordAudio("122471001", var_4_68)
						arg_1_1:RecordAudio("122471001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122471", "122471001", "story_v_out_122471.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122471", "122471001", "story_v_out_122471.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = var_4_58 + 0.3
			local var_4_70 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_69 <= arg_1_1.time_ and arg_1_1.time_ < var_4_69 + var_4_70 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_69) / var_4_70

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_69 + var_4_70 and arg_1_1.time_ < var_4_69 + var_4_70 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play122471002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122471002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122471003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1076ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1076ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1076ui_story, var_12_4, var_12_3)

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

			local var_12_9 = 0
			local var_12_10 = 1.3

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_11 = arg_9_1:GetWordFromCfg(122471002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 52
				local var_12_14 = utf8.len(var_12_12)
				local var_12_15 = var_12_13 <= 0 and var_12_10 or var_12_10 * (var_12_14 / var_12_13)

				if var_12_15 > 0 and var_12_10 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_9 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_9
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_10, arg_9_1.talkMaxDuration)

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_9) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_9 + var_12_16 and arg_9_1.time_ < var_12_9 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play122471003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122471003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play122471004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.6

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(122471003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 64
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play122471004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122471004
		arg_17_1.duration_ = 11.53

		local var_17_0 = {
			ja = 11.533,
			ko = 10.566,
			zh = 10.566
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
				arg_17_0:Play122471005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.7

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[472].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10039")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(122471004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471004", "story_v_out_122471.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471004", "story_v_out_122471.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_122471", "122471004", "story_v_out_122471.awb")

						arg_17_1:RecordAudio("122471004", var_20_9)
						arg_17_1:RecordAudio("122471004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_122471", "122471004", "story_v_out_122471.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_122471", "122471004", "story_v_out_122471.awb")
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
	Play122471005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122471005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play122471006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.3

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(122471005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 52
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play122471006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122471006
		arg_25_1.duration_ = 2.23

		local var_25_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_25_0:Play122471007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1076ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1076ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1076ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1076ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1076ui_story == nil then
				arg_25_1.var_.characterEffect1076ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1076ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1076ui_story then
				arg_25_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_15 = "10039ui_story"

			if arg_25_1.actors_[var_28_15] == nil then
				local var_28_16 = Asset.Load("Char/" .. "10039ui_story")

				if not isNil(var_28_16) then
					local var_28_17 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_25_1.stage_.transform)

					var_28_17.name = var_28_15
					var_28_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_15] = var_28_17

					local var_28_18 = var_28_17:GetComponentInChildren(typeof(CharacterEffect))

					var_28_18.enabled = true

					local var_28_19 = GameObjectTools.GetOrAddComponent(var_28_17, typeof(DynamicBoneHelper))

					if var_28_19 then
						var_28_19:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_18.transform, false)

					arg_25_1.var_[var_28_15 .. "Animator"] = var_28_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_15 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_15 .. "LipSync"] = var_28_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_20 = arg_25_1.actors_["10039ui_story"].transform
			local var_28_21 = 0

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.var_.moveOldPos10039ui_story = var_28_20.localPosition
			end

			local var_28_22 = 0.001

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_22 then
				local var_28_23 = (arg_25_1.time_ - var_28_21) / var_28_22
				local var_28_24 = Vector3.New(0.7, -0.8, -6.2)

				var_28_20.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10039ui_story, var_28_24, var_28_23)

				local var_28_25 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_25.x, var_28_25.y, var_28_25.z)

				local var_28_26 = var_28_20.localEulerAngles

				var_28_26.z = 0
				var_28_26.x = 0
				var_28_20.localEulerAngles = var_28_26
			end

			if arg_25_1.time_ >= var_28_21 + var_28_22 and arg_25_1.time_ < var_28_21 + var_28_22 + arg_28_0 then
				var_28_20.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_28_27 = manager.ui.mainCamera.transform.position - var_28_20.position

				var_28_20.forward = Vector3.New(var_28_27.x, var_28_27.y, var_28_27.z)

				local var_28_28 = var_28_20.localEulerAngles

				var_28_28.z = 0
				var_28_28.x = 0
				var_28_20.localEulerAngles = var_28_28
			end

			local var_28_29 = arg_25_1.actors_["10039ui_story"]
			local var_28_30 = 0

			if var_28_30 < arg_25_1.time_ and arg_25_1.time_ <= var_28_30 + arg_28_0 and not isNil(var_28_29) and arg_25_1.var_.characterEffect10039ui_story == nil then
				arg_25_1.var_.characterEffect10039ui_story = var_28_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_31 = 0.200000002980232

			if var_28_30 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_31 and not isNil(var_28_29) then
				local var_28_32 = (arg_25_1.time_ - var_28_30) / var_28_31

				if arg_25_1.var_.characterEffect10039ui_story and not isNil(var_28_29) then
					local var_28_33 = Mathf.Lerp(0, 0.5, var_28_32)

					arg_25_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10039ui_story.fillRatio = var_28_33
				end
			end

			if arg_25_1.time_ >= var_28_30 + var_28_31 and arg_25_1.time_ < var_28_30 + var_28_31 + arg_28_0 and not isNil(var_28_29) and arg_25_1.var_.characterEffect10039ui_story then
				local var_28_34 = 0.5

				arg_25_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10039ui_story.fillRatio = var_28_34
			end

			local var_28_35 = 0

			if var_28_35 < arg_25_1.time_ and arg_25_1.time_ <= var_28_35 + arg_28_0 then
				arg_25_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_28_36 = 0
			local var_28_37 = 0.1

			if var_28_36 < arg_25_1.time_ and arg_25_1.time_ <= var_28_36 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_38 = arg_25_1:FormatText(StoryNameCfg[389].name)

				arg_25_1.leftNameTxt_.text = var_28_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_39 = arg_25_1:GetWordFromCfg(122471006)
				local var_28_40 = arg_25_1:FormatText(var_28_39.content)

				arg_25_1.text_.text = var_28_40

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_41 = 4
				local var_28_42 = utf8.len(var_28_40)
				local var_28_43 = var_28_41 <= 0 and var_28_37 or var_28_37 * (var_28_42 / var_28_41)

				if var_28_43 > 0 and var_28_37 < var_28_43 then
					arg_25_1.talkMaxDuration = var_28_43

					if var_28_43 + var_28_36 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_43 + var_28_36
					end
				end

				arg_25_1.text_.text = var_28_40
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471006", "story_v_out_122471.awb") ~= 0 then
					local var_28_44 = manager.audio:GetVoiceLength("story_v_out_122471", "122471006", "story_v_out_122471.awb") / 1000

					if var_28_44 + var_28_36 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_44 + var_28_36
					end

					if var_28_39.prefab_name ~= "" and arg_25_1.actors_[var_28_39.prefab_name] ~= nil then
						local var_28_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_39.prefab_name].transform, "story_v_out_122471", "122471006", "story_v_out_122471.awb")

						arg_25_1:RecordAudio("122471006", var_28_45)
						arg_25_1:RecordAudio("122471006", var_28_45)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122471", "122471006", "story_v_out_122471.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122471", "122471006", "story_v_out_122471.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_46 = math.max(var_28_37, arg_25_1.talkMaxDuration)

			if var_28_36 <= arg_25_1.time_ and arg_25_1.time_ < var_28_36 + var_28_46 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_36) / var_28_46

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_36 + var_28_46 and arg_25_1.time_ < var_28_36 + var_28_46 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play122471007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122471007
		arg_29_1.duration_ = 5.2

		local var_29_0 = {
			ja = 5.2,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_29_0:Play122471008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10039ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10039ui_story == nil then
				arg_29_1.var_.characterEffect10039ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10039ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10039ui_story then
				arg_29_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_32_6 = arg_29_1.actors_["1076ui_story"]
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1076ui_story == nil then
				arg_29_1.var_.characterEffect1076ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 and not isNil(var_32_6) then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8

				if arg_29_1.var_.characterEffect1076ui_story and not isNil(var_32_6) then
					local var_32_10 = Mathf.Lerp(0, 0.5, var_32_9)

					arg_29_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1076ui_story.fillRatio = var_32_10
				end
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1076ui_story then
				local var_32_11 = 0.5

				arg_29_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1076ui_story.fillRatio = var_32_11
			end

			local var_32_12 = 0
			local var_32_13 = 0.125

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[472].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(122471007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471007", "story_v_out_122471.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471007", "story_v_out_122471.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_122471", "122471007", "story_v_out_122471.awb")

						arg_29_1:RecordAudio("122471007", var_32_21)
						arg_29_1:RecordAudio("122471007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_122471", "122471007", "story_v_out_122471.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_122471", "122471007", "story_v_out_122471.awb")
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
	Play122471008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122471008
		arg_33_1.duration_ = 2.4

		local var_33_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_33_0:Play122471009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1076ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1076ui_story == nil then
				arg_33_1.var_.characterEffect1076ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1076ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1076ui_story then
				arg_33_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_6 = arg_33_1.actors_["10039ui_story"]
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10039ui_story == nil then
				arg_33_1.var_.characterEffect10039ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 and not isNil(var_36_6) then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8

				if arg_33_1.var_.characterEffect10039ui_story and not isNil(var_36_6) then
					local var_36_10 = Mathf.Lerp(0, 0.5, var_36_9)

					arg_33_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10039ui_story.fillRatio = var_36_10
				end
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10039ui_story then
				local var_36_11 = 0.5

				arg_33_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10039ui_story.fillRatio = var_36_11
			end

			local var_36_12 = 0
			local var_36_13 = 0.125

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_14 = arg_33_1:FormatText(StoryNameCfg[389].name)

				arg_33_1.leftNameTxt_.text = var_36_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_15 = arg_33_1:GetWordFromCfg(122471008)
				local var_36_16 = arg_33_1:FormatText(var_36_15.content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471008", "story_v_out_122471.awb") ~= 0 then
					local var_36_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471008", "story_v_out_122471.awb") / 1000

					if var_36_20 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_12
					end

					if var_36_15.prefab_name ~= "" and arg_33_1.actors_[var_36_15.prefab_name] ~= nil then
						local var_36_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_15.prefab_name].transform, "story_v_out_122471", "122471008", "story_v_out_122471.awb")

						arg_33_1:RecordAudio("122471008", var_36_21)
						arg_33_1:RecordAudio("122471008", var_36_21)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_122471", "122471008", "story_v_out_122471.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_122471", "122471008", "story_v_out_122471.awb")
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
	Play122471009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122471009
		arg_37_1.duration_ = 15.03

		local var_37_0 = {
			ja = 15.033,
			ko = 14.333,
			zh = 14.333
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
				arg_37_0:Play122471010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10039ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10039ui_story == nil then
				arg_37_1.var_.characterEffect10039ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10039ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10039ui_story then
				arg_37_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_40_5 = arg_37_1.actors_["1076ui_story"]
			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1076ui_story == nil then
				arg_37_1.var_.characterEffect1076ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.200000002980232

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_7 and not isNil(var_40_5) then
				local var_40_8 = (arg_37_1.time_ - var_40_6) / var_40_7

				if arg_37_1.var_.characterEffect1076ui_story and not isNil(var_40_5) then
					local var_40_9 = Mathf.Lerp(0, 0.5, var_40_8)

					arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1076ui_story.fillRatio = var_40_9
				end
			end

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1076ui_story then
				local var_40_10 = 0.5

				arg_37_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1076ui_story.fillRatio = var_40_10
			end

			local var_40_11 = 0
			local var_40_12 = 1.125

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[472].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(122471009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471009", "story_v_out_122471.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_122471", "122471009", "story_v_out_122471.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_122471", "122471009", "story_v_out_122471.awb")

						arg_37_1:RecordAudio("122471009", var_40_20)
						arg_37_1:RecordAudio("122471009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_122471", "122471009", "story_v_out_122471.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_122471", "122471009", "story_v_out_122471.awb")
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
	Play122471010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122471010
		arg_41_1.duration_ = 14.27

		local var_41_0 = {
			ja = 14.266,
			ko = 6.8,
			zh = 6.8
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
				arg_41_0:Play122471011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1076ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1076ui_story == nil then
				arg_41_1.var_.characterEffect1076ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1076ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1076ui_story then
				arg_41_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_6 = arg_41_1.actors_["10039ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect10039ui_story == nil then
				arg_41_1.var_.characterEffect10039ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect10039ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10039ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect10039ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10039ui_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 0.725

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[389].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(122471010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471010", "story_v_out_122471.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471010", "story_v_out_122471.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_122471", "122471010", "story_v_out_122471.awb")

						arg_41_1:RecordAudio("122471010", var_44_21)
						arg_41_1:RecordAudio("122471010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_122471", "122471010", "story_v_out_122471.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_122471", "122471010", "story_v_out_122471.awb")
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
	Play122471011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122471011
		arg_45_1.duration_ = 13.93

		local var_45_0 = {
			ja = 13.933,
			ko = 7.133,
			zh = 7.133
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
				arg_45_0:Play122471012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10039ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10039ui_story == nil then
				arg_45_1.var_.characterEffect10039ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10039ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10039ui_story then
				arg_45_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_48_5 = arg_45_1.actors_["1076ui_story"]
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1076ui_story == nil then
				arg_45_1.var_.characterEffect1076ui_story = var_48_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.200000002980232

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 and not isNil(var_48_5) then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7

				if arg_45_1.var_.characterEffect1076ui_story and not isNil(var_48_5) then
					local var_48_9 = Mathf.Lerp(0, 0.5, var_48_8)

					arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1076ui_story.fillRatio = var_48_9
				end
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.characterEffect1076ui_story then
				local var_48_10 = 0.5

				arg_45_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1076ui_story.fillRatio = var_48_10
			end

			local var_48_11 = 0
			local var_48_12 = 0.65

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[472].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(122471011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 26
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_12 or var_48_12 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_12 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471011", "story_v_out_122471.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_122471", "122471011", "story_v_out_122471.awb") / 1000

					if var_48_19 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_11
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_122471", "122471011", "story_v_out_122471.awb")

						arg_45_1:RecordAudio("122471011", var_48_20)
						arg_45_1:RecordAudio("122471011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122471", "122471011", "story_v_out_122471.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122471", "122471011", "story_v_out_122471.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_21 and arg_45_1.time_ < var_48_11 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play122471012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122471012
		arg_49_1.duration_ = 12.23

		local var_49_0 = {
			ja = 12.233,
			ko = 5.9,
			zh = 5.9
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
				arg_49_0:Play122471013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_2")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.425

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_4 = arg_49_1:FormatText(StoryNameCfg[472].name)

				arg_49_1.leftNameTxt_.text = var_52_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(122471012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 17
				local var_52_8 = utf8.len(var_52_6)
				local var_52_9 = var_52_7 <= 0 and var_52_3 or var_52_3 * (var_52_8 / var_52_7)

				if var_52_9 > 0 and var_52_3 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471012", "story_v_out_122471.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_122471", "122471012", "story_v_out_122471.awb") / 1000

					if var_52_10 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_2
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_122471", "122471012", "story_v_out_122471.awb")

						arg_49_1:RecordAudio("122471012", var_52_11)
						arg_49_1:RecordAudio("122471012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122471", "122471012", "story_v_out_122471.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122471", "122471012", "story_v_out_122471.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_12 and arg_49_1.time_ < var_52_2 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122471013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122471013
		arg_53_1.duration_ = 19.87

		local var_53_0 = {
			ja = 19.866,
			ko = 8.866,
			zh = 8.866
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
				arg_53_0:Play122471014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1076ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1076ui_story == nil then
				arg_53_1.var_.characterEffect1076ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1076ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1076ui_story then
				arg_53_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_6 = arg_53_1.actors_["10039ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect10039ui_story == nil then
				arg_53_1.var_.characterEffect10039ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.200000002980232

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect10039ui_story and not isNil(var_56_6) then
					local var_56_10 = Mathf.Lerp(0, 0.5, var_56_9)

					arg_53_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10039ui_story.fillRatio = var_56_10
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect10039ui_story then
				local var_56_11 = 0.5

				arg_53_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10039ui_story.fillRatio = var_56_11
			end

			local var_56_12 = 0
			local var_56_13 = 0.85

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_14 = arg_53_1:FormatText(StoryNameCfg[389].name)

				arg_53_1.leftNameTxt_.text = var_56_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(122471013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 34
				local var_56_18 = utf8.len(var_56_16)
				local var_56_19 = var_56_17 <= 0 and var_56_13 or var_56_13 * (var_56_18 / var_56_17)

				if var_56_19 > 0 and var_56_13 < var_56_19 then
					arg_53_1.talkMaxDuration = var_56_19

					if var_56_19 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471013", "story_v_out_122471.awb") ~= 0 then
					local var_56_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471013", "story_v_out_122471.awb") / 1000

					if var_56_20 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_12
					end

					if var_56_15.prefab_name ~= "" and arg_53_1.actors_[var_56_15.prefab_name] ~= nil then
						local var_56_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_15.prefab_name].transform, "story_v_out_122471", "122471013", "story_v_out_122471.awb")

						arg_53_1:RecordAudio("122471013", var_56_21)
						arg_53_1:RecordAudio("122471013", var_56_21)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122471", "122471013", "story_v_out_122471.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122471", "122471013", "story_v_out_122471.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_22 and arg_53_1.time_ < var_56_12 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play122471014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122471014
		arg_57_1.duration_ = 11.93

		local var_57_0 = {
			ja = 11.133,
			ko = 11.933,
			zh = 11.933
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
				arg_57_0:Play122471015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.175

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[389].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(122471014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471014", "story_v_out_122471.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471014", "story_v_out_122471.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_122471", "122471014", "story_v_out_122471.awb")

						arg_57_1:RecordAudio("122471014", var_60_9)
						arg_57_1:RecordAudio("122471014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122471", "122471014", "story_v_out_122471.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122471", "122471014", "story_v_out_122471.awb")
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
	Play122471015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122471015
		arg_61_1.duration_ = 17.77

		local var_61_0 = {
			ja = 17.766,
			ko = 7.566,
			zh = 7.566
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
				arg_61_0:Play122471016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10039ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10039ui_story == nil then
				arg_61_1.var_.characterEffect10039ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect10039ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect10039ui_story then
				arg_61_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_64_6 = arg_61_1.actors_["1076ui_story"]
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1076ui_story == nil then
				arg_61_1.var_.characterEffect1076ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_8 = 0.200000002980232

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 and not isNil(var_64_6) then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8

				if arg_61_1.var_.characterEffect1076ui_story and not isNil(var_64_6) then
					local var_64_10 = Mathf.Lerp(0, 0.5, var_64_9)

					arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1076ui_story.fillRatio = var_64_10
				end
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1076ui_story then
				local var_64_11 = 0.5

				arg_61_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1076ui_story.fillRatio = var_64_11
			end

			local var_64_12 = 0
			local var_64_13 = 0.7

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[472].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(122471015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 28
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471015", "story_v_out_122471.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471015", "story_v_out_122471.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_122471", "122471015", "story_v_out_122471.awb")

						arg_61_1:RecordAudio("122471015", var_64_21)
						arg_61_1:RecordAudio("122471015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122471", "122471015", "story_v_out_122471.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122471", "122471015", "story_v_out_122471.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_22 and arg_61_1.time_ < var_64_12 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122471016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122471016
		arg_65_1.duration_ = 17.6

		local var_65_0 = {
			ja = 17.6,
			ko = 9.3,
			zh = 9.3
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
				arg_65_0:Play122471017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1076ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1076ui_story == nil then
				arg_65_1.var_.characterEffect1076ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1076ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1076ui_story then
				arg_65_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_6 = arg_65_1.actors_["10039ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect10039ui_story == nil then
				arg_65_1.var_.characterEffect10039ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect10039ui_story and not isNil(var_68_6) then
					local var_68_10 = Mathf.Lerp(0, 0.5, var_68_9)

					arg_65_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10039ui_story.fillRatio = var_68_10
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect10039ui_story then
				local var_68_11 = 0.5

				arg_65_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10039ui_story.fillRatio = var_68_11
			end

			local var_68_12 = 0
			local var_68_13 = 0.875

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[389].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(122471016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 35
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471016", "story_v_out_122471.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471016", "story_v_out_122471.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_122471", "122471016", "story_v_out_122471.awb")

						arg_65_1:RecordAudio("122471016", var_68_21)
						arg_65_1:RecordAudio("122471016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122471", "122471016", "story_v_out_122471.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122471", "122471016", "story_v_out_122471.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play122471017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122471017
		arg_69_1.duration_ = 20.03

		local var_69_0 = {
			ja = 20.033,
			ko = 10.6,
			zh = 10.6
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
				arg_69_0:Play122471018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			local var_72_1 = 0
			local var_72_2 = 1.15

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[389].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(122471017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 46
				local var_72_7 = utf8.len(var_72_5)
				local var_72_8 = var_72_6 <= 0 and var_72_2 or var_72_2 * (var_72_7 / var_72_6)

				if var_72_8 > 0 and var_72_2 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471017", "story_v_out_122471.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_122471", "122471017", "story_v_out_122471.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_122471", "122471017", "story_v_out_122471.awb")

						arg_69_1:RecordAudio("122471017", var_72_10)
						arg_69_1:RecordAudio("122471017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122471", "122471017", "story_v_out_122471.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122471", "122471017", "story_v_out_122471.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_11 and arg_69_1.time_ < var_72_1 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122471018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122471018
		arg_73_1.duration_ = 8.57

		local var_73_0 = {
			ja = 8.566,
			ko = 4.5,
			zh = 4.5
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
				arg_73_0:Play122471019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.525

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[389].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(122471018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471018", "story_v_out_122471.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471018", "story_v_out_122471.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_122471", "122471018", "story_v_out_122471.awb")

						arg_73_1:RecordAudio("122471018", var_76_9)
						arg_73_1:RecordAudio("122471018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122471", "122471018", "story_v_out_122471.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122471", "122471018", "story_v_out_122471.awb")
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
	Play122471019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122471019
		arg_77_1.duration_ = 11.43

		local var_77_0 = {
			ja = 11.433,
			ko = 8.666,
			zh = 8.666
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
				arg_77_0:Play122471020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.95

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[389].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(122471019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471019", "story_v_out_122471.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471019", "story_v_out_122471.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_122471", "122471019", "story_v_out_122471.awb")

						arg_77_1:RecordAudio("122471019", var_80_9)
						arg_77_1:RecordAudio("122471019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122471", "122471019", "story_v_out_122471.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122471", "122471019", "story_v_out_122471.awb")
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
	Play122471020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122471020
		arg_81_1.duration_ = 2.7

		local var_81_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_81_0:Play122471021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10039ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10039ui_story == nil then
				arg_81_1.var_.characterEffect10039ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10039ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10039ui_story then
				arg_81_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_84_6 = arg_81_1.actors_["1076ui_story"]
			local var_84_7 = 0

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1076ui_story == nil then
				arg_81_1.var_.characterEffect1076ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_8 = 0.200000002980232

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 and not isNil(var_84_6) then
				local var_84_9 = (arg_81_1.time_ - var_84_7) / var_84_8

				if arg_81_1.var_.characterEffect1076ui_story and not isNil(var_84_6) then
					local var_84_10 = Mathf.Lerp(0, 0.5, var_84_9)

					arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1076ui_story.fillRatio = var_84_10
				end
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1076ui_story then
				local var_84_11 = 0.5

				arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1076ui_story.fillRatio = var_84_11
			end

			local var_84_12 = 0
			local var_84_13 = 0.125

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_14 = arg_81_1:FormatText(StoryNameCfg[472].name)

				arg_81_1.leftNameTxt_.text = var_84_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_15 = arg_81_1:GetWordFromCfg(122471020)
				local var_84_16 = arg_81_1:FormatText(var_84_15.content)

				arg_81_1.text_.text = var_84_16

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_17 = 5
				local var_84_18 = utf8.len(var_84_16)
				local var_84_19 = var_84_17 <= 0 and var_84_13 or var_84_13 * (var_84_18 / var_84_17)

				if var_84_19 > 0 and var_84_13 < var_84_19 then
					arg_81_1.talkMaxDuration = var_84_19

					if var_84_19 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_16
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471020", "story_v_out_122471.awb") ~= 0 then
					local var_84_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471020", "story_v_out_122471.awb") / 1000

					if var_84_20 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_20 + var_84_12
					end

					if var_84_15.prefab_name ~= "" and arg_81_1.actors_[var_84_15.prefab_name] ~= nil then
						local var_84_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_15.prefab_name].transform, "story_v_out_122471", "122471020", "story_v_out_122471.awb")

						arg_81_1:RecordAudio("122471020", var_84_21)
						arg_81_1:RecordAudio("122471020", var_84_21)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_122471", "122471020", "story_v_out_122471.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_122471", "122471020", "story_v_out_122471.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_12) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_12 + var_84_22 and arg_81_1.time_ < var_84_12 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play122471021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122471021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play122471022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1076ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1076ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1076ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, 100, 0)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["10039ui_story"].transform
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.var_.moveOldPos10039ui_story = var_88_9.localPosition
			end

			local var_88_11 = 0.001

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11
				local var_88_13 = Vector3.New(0, 100, 0)

				var_88_9.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10039ui_story, var_88_13, var_88_12)

				local var_88_14 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_14.x, var_88_14.y, var_88_14.z)

				local var_88_15 = var_88_9.localEulerAngles

				var_88_15.z = 0
				var_88_15.x = 0
				var_88_9.localEulerAngles = var_88_15
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 then
				var_88_9.localPosition = Vector3.New(0, 100, 0)

				local var_88_16 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_16.x, var_88_16.y, var_88_16.z)

				local var_88_17 = var_88_9.localEulerAngles

				var_88_17.z = 0
				var_88_17.x = 0
				var_88_9.localEulerAngles = var_88_17
			end

			local var_88_18 = 0
			local var_88_19 = 1

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_20 = arg_85_1:GetWordFromCfg(122471021)
				local var_88_21 = arg_85_1:FormatText(var_88_20.content)

				arg_85_1.text_.text = var_88_21

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_22 = 40
				local var_88_23 = utf8.len(var_88_21)
				local var_88_24 = var_88_22 <= 0 and var_88_19 or var_88_19 * (var_88_23 / var_88_22)

				if var_88_24 > 0 and var_88_19 < var_88_24 then
					arg_85_1.talkMaxDuration = var_88_24

					if var_88_24 + var_88_18 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_18
					end
				end

				arg_85_1.text_.text = var_88_21
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_19, arg_85_1.talkMaxDuration)

			if var_88_18 <= arg_85_1.time_ and arg_85_1.time_ < var_88_18 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_18) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_18 + var_88_25 and arg_85_1.time_ < var_88_18 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play122471022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 122471022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play122471023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.825

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

				local var_92_2 = arg_89_1:GetWordFromCfg(122471022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 33
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
	Play122471023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 122471023
		arg_93_1.duration_ = 14.97

		local var_93_0 = {
			ja = 14.966,
			ko = 8.7,
			zh = 8.7
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
				arg_93_0:Play122471024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1076ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1076ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1076ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1076ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1076ui_story == nil then
				arg_93_1.var_.characterEffect1076ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1076ui_story and not isNil(var_96_9) then
					local var_96_13 = Mathf.Lerp(0, 0.5, var_96_12)

					arg_93_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1076ui_story.fillRatio = var_96_13
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1076ui_story then
				local var_96_14 = 0.5

				arg_93_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1076ui_story.fillRatio = var_96_14
			end

			local var_96_15 = arg_93_1.actors_["10039ui_story"].transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.var_.moveOldPos10039ui_story = var_96_15.localPosition
			end

			local var_96_17 = 0.001

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Vector3.New(0.7, -0.8, -6.2)

				var_96_15.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10039ui_story, var_96_19, var_96_18)

				local var_96_20 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_20.x, var_96_20.y, var_96_20.z)

				local var_96_21 = var_96_15.localEulerAngles

				var_96_21.z = 0
				var_96_21.x = 0
				var_96_15.localEulerAngles = var_96_21
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				var_96_15.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_96_22 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_22.x, var_96_22.y, var_96_22.z)

				local var_96_23 = var_96_15.localEulerAngles

				var_96_23.z = 0
				var_96_23.x = 0
				var_96_15.localEulerAngles = var_96_23
			end

			local var_96_24 = arg_93_1.actors_["10039ui_story"]
			local var_96_25 = 0

			if var_96_25 < arg_93_1.time_ and arg_93_1.time_ <= var_96_25 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect10039ui_story == nil then
				arg_93_1.var_.characterEffect10039ui_story = var_96_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_26 = 0.200000002980232

			if var_96_25 <= arg_93_1.time_ and arg_93_1.time_ < var_96_25 + var_96_26 and not isNil(var_96_24) then
				local var_96_27 = (arg_93_1.time_ - var_96_25) / var_96_26

				if arg_93_1.var_.characterEffect10039ui_story and not isNil(var_96_24) then
					arg_93_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_25 + var_96_26 and arg_93_1.time_ < var_96_25 + var_96_26 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect10039ui_story then
				arg_93_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_96_28 = 0

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 then
				arg_93_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_96_29 = 0

			if var_96_29 < arg_93_1.time_ and arg_93_1.time_ <= var_96_29 + arg_96_0 then
				arg_93_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_30 = 0
			local var_96_31 = 0.725

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[472].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(122471023)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 29
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471023", "story_v_out_122471.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_122471", "122471023", "story_v_out_122471.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_122471", "122471023", "story_v_out_122471.awb")

						arg_93_1:RecordAudio("122471023", var_96_39)
						arg_93_1:RecordAudio("122471023", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_122471", "122471023", "story_v_out_122471.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_122471", "122471023", "story_v_out_122471.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play122471024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 122471024
		arg_97_1.duration_ = 8.1

		local var_97_0 = {
			ja = 8.1,
			ko = 3.966,
			zh = 3.966
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
				arg_97_0:Play122471025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1076ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1076ui_story == nil then
				arg_97_1.var_.characterEffect1076ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1076ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1076ui_story then
				arg_97_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_6 = arg_97_1.actors_["10039ui_story"]
			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10039ui_story == nil then
				arg_97_1.var_.characterEffect10039ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_8 = 0.200000002980232

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_8 and not isNil(var_100_6) then
				local var_100_9 = (arg_97_1.time_ - var_100_7) / var_100_8

				if arg_97_1.var_.characterEffect10039ui_story and not isNil(var_100_6) then
					local var_100_10 = Mathf.Lerp(0, 0.5, var_100_9)

					arg_97_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10039ui_story.fillRatio = var_100_10
				end
			end

			if arg_97_1.time_ >= var_100_7 + var_100_8 and arg_97_1.time_ < var_100_7 + var_100_8 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10039ui_story then
				local var_100_11 = 0.5

				arg_97_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10039ui_story.fillRatio = var_100_11
			end

			local var_100_12 = 0
			local var_100_13 = 0.45

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_14 = arg_97_1:FormatText(StoryNameCfg[389].name)

				arg_97_1.leftNameTxt_.text = var_100_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_15 = arg_97_1:GetWordFromCfg(122471024)
				local var_100_16 = arg_97_1:FormatText(var_100_15.content)

				arg_97_1.text_.text = var_100_16

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_17 = 18
				local var_100_18 = utf8.len(var_100_16)
				local var_100_19 = var_100_17 <= 0 and var_100_13 or var_100_13 * (var_100_18 / var_100_17)

				if var_100_19 > 0 and var_100_13 < var_100_19 then
					arg_97_1.talkMaxDuration = var_100_19

					if var_100_19 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_19 + var_100_12
					end
				end

				arg_97_1.text_.text = var_100_16
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471024", "story_v_out_122471.awb") ~= 0 then
					local var_100_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471024", "story_v_out_122471.awb") / 1000

					if var_100_20 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_20 + var_100_12
					end

					if var_100_15.prefab_name ~= "" and arg_97_1.actors_[var_100_15.prefab_name] ~= nil then
						local var_100_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_15.prefab_name].transform, "story_v_out_122471", "122471024", "story_v_out_122471.awb")

						arg_97_1:RecordAudio("122471024", var_100_21)
						arg_97_1:RecordAudio("122471024", var_100_21)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_122471", "122471024", "story_v_out_122471.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_122471", "122471024", "story_v_out_122471.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_22 = math.max(var_100_13, arg_97_1.talkMaxDuration)

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_22 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_12) / var_100_22

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_12 + var_100_22 and arg_97_1.time_ < var_100_12 + var_100_22 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play122471025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 122471025
		arg_101_1.duration_ = 7.13

		local var_101_0 = {
			ja = 7.133,
			ko = 3.3,
			zh = 3.3
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
				arg_101_0:Play122471026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10039ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10039ui_story == nil then
				arg_101_1.var_.characterEffect10039ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10039ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10039ui_story then
				arg_101_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_5 = arg_101_1.actors_["1076ui_story"]
			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1076ui_story == nil then
				arg_101_1.var_.characterEffect1076ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_7 and not isNil(var_104_5) then
				local var_104_8 = (arg_101_1.time_ - var_104_6) / var_104_7

				if arg_101_1.var_.characterEffect1076ui_story and not isNil(var_104_5) then
					local var_104_9 = Mathf.Lerp(0, 0.5, var_104_8)

					arg_101_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1076ui_story.fillRatio = var_104_9
				end
			end

			if arg_101_1.time_ >= var_104_6 + var_104_7 and arg_101_1.time_ < var_104_6 + var_104_7 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1076ui_story then
				local var_104_10 = 0.5

				arg_101_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1076ui_story.fillRatio = var_104_10
			end

			local var_104_11 = 0
			local var_104_12 = 0.275

			if var_104_11 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_13 = arg_101_1:FormatText(StoryNameCfg[472].name)

				arg_101_1.leftNameTxt_.text = var_104_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_14 = arg_101_1:GetWordFromCfg(122471025)
				local var_104_15 = arg_101_1:FormatText(var_104_14.content)

				arg_101_1.text_.text = var_104_15

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_16 = 11
				local var_104_17 = utf8.len(var_104_15)
				local var_104_18 = var_104_16 <= 0 and var_104_12 or var_104_12 * (var_104_17 / var_104_16)

				if var_104_18 > 0 and var_104_12 < var_104_18 then
					arg_101_1.talkMaxDuration = var_104_18

					if var_104_18 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_11
					end
				end

				arg_101_1.text_.text = var_104_15
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471025", "story_v_out_122471.awb") ~= 0 then
					local var_104_19 = manager.audio:GetVoiceLength("story_v_out_122471", "122471025", "story_v_out_122471.awb") / 1000

					if var_104_19 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_11
					end

					if var_104_14.prefab_name ~= "" and arg_101_1.actors_[var_104_14.prefab_name] ~= nil then
						local var_104_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_14.prefab_name].transform, "story_v_out_122471", "122471025", "story_v_out_122471.awb")

						arg_101_1:RecordAudio("122471025", var_104_20)
						arg_101_1:RecordAudio("122471025", var_104_20)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_122471", "122471025", "story_v_out_122471.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_122471", "122471025", "story_v_out_122471.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_21 = math.max(var_104_12, arg_101_1.talkMaxDuration)

			if var_104_11 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_21 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_11) / var_104_21

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_11 + var_104_21 and arg_101_1.time_ < var_104_11 + var_104_21 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play122471026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122471026
		arg_105_1.duration_ = 8.13

		local var_105_0 = {
			ja = 6.5,
			ko = 8.133,
			zh = 8.133
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
				arg_105_0:Play122471027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1076ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1076ui_story == nil then
				arg_105_1.var_.characterEffect1076ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1076ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1076ui_story then
				arg_105_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_108_4 = 0

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_6 = arg_105_1.actors_["10039ui_story"]
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect10039ui_story == nil then
				arg_105_1.var_.characterEffect10039ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_8 = 0.200000002980232

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_8 and not isNil(var_108_6) then
				local var_108_9 = (arg_105_1.time_ - var_108_7) / var_108_8

				if arg_105_1.var_.characterEffect10039ui_story and not isNil(var_108_6) then
					local var_108_10 = Mathf.Lerp(0, 0.5, var_108_9)

					arg_105_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10039ui_story.fillRatio = var_108_10
				end
			end

			if arg_105_1.time_ >= var_108_7 + var_108_8 and arg_105_1.time_ < var_108_7 + var_108_8 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect10039ui_story then
				local var_108_11 = 0.5

				arg_105_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10039ui_story.fillRatio = var_108_11
			end

			local var_108_12 = 0
			local var_108_13 = 0.575

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[389].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:GetWordFromCfg(122471026)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 23
				local var_108_18 = utf8.len(var_108_16)
				local var_108_19 = var_108_17 <= 0 and var_108_13 or var_108_13 * (var_108_18 / var_108_17)

				if var_108_19 > 0 and var_108_13 < var_108_19 then
					arg_105_1.talkMaxDuration = var_108_19

					if var_108_19 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_16
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471026", "story_v_out_122471.awb") ~= 0 then
					local var_108_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471026", "story_v_out_122471.awb") / 1000

					if var_108_20 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_12
					end

					if var_108_15.prefab_name ~= "" and arg_105_1.actors_[var_108_15.prefab_name] ~= nil then
						local var_108_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_15.prefab_name].transform, "story_v_out_122471", "122471026", "story_v_out_122471.awb")

						arg_105_1:RecordAudio("122471026", var_108_21)
						arg_105_1:RecordAudio("122471026", var_108_21)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_122471", "122471026", "story_v_out_122471.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_122471", "122471026", "story_v_out_122471.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_22 and arg_105_1.time_ < var_108_12 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play122471027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 122471027
		arg_109_1.duration_ = 12.17

		local var_109_0 = {
			ja = 12.166,
			ko = 6.4,
			zh = 6.4
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
				arg_109_0:Play122471028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1076ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1076ui_story == nil then
				arg_109_1.var_.characterEffect1076ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1076ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1076ui_story then
				arg_109_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_112_4 = 0

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_6 = 0
			local var_112_7 = 0.7

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[389].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(122471027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471027", "story_v_out_122471.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_122471", "122471027", "story_v_out_122471.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_out_122471", "122471027", "story_v_out_122471.awb")

						arg_109_1:RecordAudio("122471027", var_112_15)
						arg_109_1:RecordAudio("122471027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_122471", "122471027", "story_v_out_122471.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_122471", "122471027", "story_v_out_122471.awb")
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
	Play122471028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 122471028
		arg_113_1.duration_ = 14.67

		local var_113_0 = {
			ja = 14.666,
			ko = 9.6,
			zh = 9.6
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
				arg_113_0:Play122471029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10039ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10039ui_story == nil then
				arg_113_1.var_.characterEffect10039ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect10039ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10039ui_story then
				arg_113_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_6 = arg_113_1.actors_["1076ui_story"]
			local var_116_7 = 0

			if var_116_7 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1076ui_story == nil then
				arg_113_1.var_.characterEffect1076ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_8 and not isNil(var_116_6) then
				local var_116_9 = (arg_113_1.time_ - var_116_7) / var_116_8

				if arg_113_1.var_.characterEffect1076ui_story and not isNil(var_116_6) then
					local var_116_10 = Mathf.Lerp(0, 0.5, var_116_9)

					arg_113_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1076ui_story.fillRatio = var_116_10
				end
			end

			if arg_113_1.time_ >= var_116_7 + var_116_8 and arg_113_1.time_ < var_116_7 + var_116_8 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1076ui_story then
				local var_116_11 = 0.5

				arg_113_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1076ui_story.fillRatio = var_116_11
			end

			local var_116_12 = 0
			local var_116_13 = 0.85

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_14 = arg_113_1:FormatText(StoryNameCfg[472].name)

				arg_113_1.leftNameTxt_.text = var_116_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_15 = arg_113_1:GetWordFromCfg(122471028)
				local var_116_16 = arg_113_1:FormatText(var_116_15.content)

				arg_113_1.text_.text = var_116_16

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 34
				local var_116_18 = utf8.len(var_116_16)
				local var_116_19 = var_116_17 <= 0 and var_116_13 or var_116_13 * (var_116_18 / var_116_17)

				if var_116_19 > 0 and var_116_13 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_16
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471028", "story_v_out_122471.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471028", "story_v_out_122471.awb") / 1000

					if var_116_20 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_12
					end

					if var_116_15.prefab_name ~= "" and arg_113_1.actors_[var_116_15.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_15.prefab_name].transform, "story_v_out_122471", "122471028", "story_v_out_122471.awb")

						arg_113_1:RecordAudio("122471028", var_116_21)
						arg_113_1:RecordAudio("122471028", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_122471", "122471028", "story_v_out_122471.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_122471", "122471028", "story_v_out_122471.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_22 and arg_113_1.time_ < var_116_12 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play122471029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 122471029
		arg_117_1.duration_ = 16.57

		local var_117_0 = {
			ja = 16.566,
			ko = 12.433,
			zh = 12.433
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
				arg_117_0:Play122471030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1.225

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[472].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(122471029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 49
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471029", "story_v_out_122471.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471029", "story_v_out_122471.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_122471", "122471029", "story_v_out_122471.awb")

						arg_117_1:RecordAudio("122471029", var_120_9)
						arg_117_1:RecordAudio("122471029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_122471", "122471029", "story_v_out_122471.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_122471", "122471029", "story_v_out_122471.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play122471030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 122471030
		arg_121_1.duration_ = 6.77

		local var_121_0 = {
			ja = 6.766,
			ko = 4.9,
			zh = 4.9
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
				arg_121_0:Play122471031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_2")
			end

			local var_124_1 = 0
			local var_124_2 = 0.55

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_3 = arg_121_1:FormatText(StoryNameCfg[472].name)

				arg_121_1.leftNameTxt_.text = var_124_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(122471030)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 22
				local var_124_7 = utf8.len(var_124_5)
				local var_124_8 = var_124_6 <= 0 and var_124_2 or var_124_2 * (var_124_7 / var_124_6)

				if var_124_8 > 0 and var_124_2 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471030", "story_v_out_122471.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_out_122471", "122471030", "story_v_out_122471.awb") / 1000

					if var_124_9 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_1
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_out_122471", "122471030", "story_v_out_122471.awb")

						arg_121_1:RecordAudio("122471030", var_124_10)
						arg_121_1:RecordAudio("122471030", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_122471", "122471030", "story_v_out_122471.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_122471", "122471030", "story_v_out_122471.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_11 and arg_121_1.time_ < var_124_1 + var_124_11 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play122471031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 122471031
		arg_125_1.duration_ = 4.07

		local var_125_0 = {
			ja = 4.066,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_125_0:Play122471032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1076ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1076ui_story == nil then
				arg_125_1.var_.characterEffect1076ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1076ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1076ui_story then
				arg_125_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_128_4 = 0

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076actionlink/1076action454")
			end

			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_6 = arg_125_1.actors_["10039ui_story"]
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10039ui_story == nil then
				arg_125_1.var_.characterEffect10039ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_8 = 0.200000002980232

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 and not isNil(var_128_6) then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8

				if arg_125_1.var_.characterEffect10039ui_story and not isNil(var_128_6) then
					local var_128_10 = Mathf.Lerp(0, 0.5, var_128_9)

					arg_125_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10039ui_story.fillRatio = var_128_10
				end
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect10039ui_story then
				local var_128_11 = 0.5

				arg_125_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10039ui_story.fillRatio = var_128_11
			end

			local var_128_12 = 0
			local var_128_13 = 0.175

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[389].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(122471031)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 7
				local var_128_18 = utf8.len(var_128_16)
				local var_128_19 = var_128_17 <= 0 and var_128_13 or var_128_13 * (var_128_18 / var_128_17)

				if var_128_19 > 0 and var_128_13 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19

					if var_128_19 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471031", "story_v_out_122471.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471031", "story_v_out_122471.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_out_122471", "122471031", "story_v_out_122471.awb")

						arg_125_1:RecordAudio("122471031", var_128_21)
						arg_125_1:RecordAudio("122471031", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_122471", "122471031", "story_v_out_122471.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_122471", "122471031", "story_v_out_122471.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_22 and arg_125_1.time_ < var_128_12 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play122471032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 122471032
		arg_129_1.duration_ = 14.6

		local var_129_0 = {
			ja = 14.6,
			ko = 10.633,
			zh = 10.633
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
				arg_129_0:Play122471033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10039ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10039ui_story == nil then
				arg_129_1.var_.characterEffect10039ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10039ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10039ui_story then
				arg_129_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_5 = arg_129_1.actors_["1076ui_story"]
			local var_132_6 = 0

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1076ui_story == nil then
				arg_129_1.var_.characterEffect1076ui_story = var_132_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_7 = 0.200000002980232

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_7 and not isNil(var_132_5) then
				local var_132_8 = (arg_129_1.time_ - var_132_6) / var_132_7

				if arg_129_1.var_.characterEffect1076ui_story and not isNil(var_132_5) then
					local var_132_9 = Mathf.Lerp(0, 0.5, var_132_8)

					arg_129_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1076ui_story.fillRatio = var_132_9
				end
			end

			if arg_129_1.time_ >= var_132_6 + var_132_7 and arg_129_1.time_ < var_132_6 + var_132_7 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.characterEffect1076ui_story then
				local var_132_10 = 0.5

				arg_129_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1076ui_story.fillRatio = var_132_10
			end

			local var_132_11 = 0
			local var_132_12 = 1

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_13 = arg_129_1:FormatText(StoryNameCfg[472].name)

				arg_129_1.leftNameTxt_.text = var_132_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(122471032)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 40
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_12 or var_132_12 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_12 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471032", "story_v_out_122471.awb") ~= 0 then
					local var_132_19 = manager.audio:GetVoiceLength("story_v_out_122471", "122471032", "story_v_out_122471.awb") / 1000

					if var_132_19 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_11
					end

					if var_132_14.prefab_name ~= "" and arg_129_1.actors_[var_132_14.prefab_name] ~= nil then
						local var_132_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_14.prefab_name].transform, "story_v_out_122471", "122471032", "story_v_out_122471.awb")

						arg_129_1:RecordAudio("122471032", var_132_20)
						arg_129_1:RecordAudio("122471032", var_132_20)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_122471", "122471032", "story_v_out_122471.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_122471", "122471032", "story_v_out_122471.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_21 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_21 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_21

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_21 and arg_129_1.time_ < var_132_11 + var_132_21 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play122471033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 122471033
		arg_133_1.duration_ = 12.9

		local var_133_0 = {
			ja = 11.433,
			ko = 12.9,
			zh = 12.9
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
				arg_133_0:Play122471034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.15

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[472].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(122471033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 46
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471033", "story_v_out_122471.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471033", "story_v_out_122471.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_122471", "122471033", "story_v_out_122471.awb")

						arg_133_1:RecordAudio("122471033", var_136_9)
						arg_133_1:RecordAudio("122471033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_122471", "122471033", "story_v_out_122471.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_122471", "122471033", "story_v_out_122471.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play122471034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 122471034
		arg_137_1.duration_ = 19.93

		local var_137_0 = {
			ja = 19.933,
			ko = 11.466,
			zh = 11.466
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
				arg_137_0:Play122471035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1076ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1076ui_story == nil then
				arg_137_1.var_.characterEffect1076ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1076ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1076ui_story then
				arg_137_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_2")
			end

			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_6 = arg_137_1.actors_["10039ui_story"]
			local var_140_7 = 0

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10039ui_story == nil then
				arg_137_1.var_.characterEffect10039ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_8 = 0.200000002980232

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_8 and not isNil(var_140_6) then
				local var_140_9 = (arg_137_1.time_ - var_140_7) / var_140_8

				if arg_137_1.var_.characterEffect10039ui_story and not isNil(var_140_6) then
					local var_140_10 = Mathf.Lerp(0, 0.5, var_140_9)

					arg_137_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10039ui_story.fillRatio = var_140_10
				end
			end

			if arg_137_1.time_ >= var_140_7 + var_140_8 and arg_137_1.time_ < var_140_7 + var_140_8 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect10039ui_story then
				local var_140_11 = 0.5

				arg_137_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10039ui_story.fillRatio = var_140_11
			end

			local var_140_12 = 0
			local var_140_13 = 1.1

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[389].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(122471034)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 44
				local var_140_18 = utf8.len(var_140_16)
				local var_140_19 = var_140_17 <= 0 and var_140_13 or var_140_13 * (var_140_18 / var_140_17)

				if var_140_19 > 0 and var_140_13 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_12
					end
				end

				arg_137_1.text_.text = var_140_16
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471034", "story_v_out_122471.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471034", "story_v_out_122471.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_out_122471", "122471034", "story_v_out_122471.awb")

						arg_137_1:RecordAudio("122471034", var_140_21)
						arg_137_1:RecordAudio("122471034", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_122471", "122471034", "story_v_out_122471.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_122471", "122471034", "story_v_out_122471.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_13, arg_137_1.talkMaxDuration)

			if var_140_12 <= arg_137_1.time_ and arg_137_1.time_ < var_140_12 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_12) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_12 + var_140_22 and arg_137_1.time_ < var_140_12 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play122471035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 122471035
		arg_141_1.duration_ = 14.87

		local var_141_0 = {
			ja = 14.866,
			ko = 8,
			zh = 8
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
				arg_141_0:Play122471036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_144_2 = 0
			local var_144_3 = 0.725

			if var_144_2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_4 = arg_141_1:FormatText(StoryNameCfg[389].name)

				arg_141_1.leftNameTxt_.text = var_144_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_5 = arg_141_1:GetWordFromCfg(122471035)
				local var_144_6 = arg_141_1:FormatText(var_144_5.content)

				arg_141_1.text_.text = var_144_6

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 29
				local var_144_8 = utf8.len(var_144_6)
				local var_144_9 = var_144_7 <= 0 and var_144_3 or var_144_3 * (var_144_8 / var_144_7)

				if var_144_9 > 0 and var_144_3 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_6
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471035", "story_v_out_122471.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_122471", "122471035", "story_v_out_122471.awb") / 1000

					if var_144_10 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_2
					end

					if var_144_5.prefab_name ~= "" and arg_141_1.actors_[var_144_5.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_5.prefab_name].transform, "story_v_out_122471", "122471035", "story_v_out_122471.awb")

						arg_141_1:RecordAudio("122471035", var_144_11)
						arg_141_1:RecordAudio("122471035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_122471", "122471035", "story_v_out_122471.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_122471", "122471035", "story_v_out_122471.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_12 and arg_141_1.time_ < var_144_2 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play122471036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122471036
		arg_145_1.duration_ = 9.67

		local var_145_0 = {
			ja = 9.666,
			ko = 4.5,
			zh = 4.5
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play122471037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10039ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10039ui_story == nil then
				arg_145_1.var_.characterEffect10039ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect10039ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10039ui_story then
				arg_145_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_148_4 = 0

			if var_148_4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_148_6 = arg_145_1.actors_["1076ui_story"]
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1076ui_story == nil then
				arg_145_1.var_.characterEffect1076ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.200000002980232

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 and not isNil(var_148_6) then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8

				if arg_145_1.var_.characterEffect1076ui_story and not isNil(var_148_6) then
					local var_148_10 = Mathf.Lerp(0, 0.5, var_148_9)

					arg_145_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1076ui_story.fillRatio = var_148_10
				end
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1076ui_story then
				local var_148_11 = 0.5

				arg_145_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1076ui_story.fillRatio = var_148_11
			end

			local var_148_12 = 0
			local var_148_13 = 0.375

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_14 = arg_145_1:FormatText(StoryNameCfg[472].name)

				arg_145_1.leftNameTxt_.text = var_148_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:GetWordFromCfg(122471036)
				local var_148_16 = arg_145_1:FormatText(var_148_15.content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 15
				local var_148_18 = utf8.len(var_148_16)
				local var_148_19 = var_148_17 <= 0 and var_148_13 or var_148_13 * (var_148_18 / var_148_17)

				if var_148_19 > 0 and var_148_13 < var_148_19 then
					arg_145_1.talkMaxDuration = var_148_19

					if var_148_19 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_19 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_16
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471036", "story_v_out_122471.awb") ~= 0 then
					local var_148_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471036", "story_v_out_122471.awb") / 1000

					if var_148_20 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_12
					end

					if var_148_15.prefab_name ~= "" and arg_145_1.actors_[var_148_15.prefab_name] ~= nil then
						local var_148_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_15.prefab_name].transform, "story_v_out_122471", "122471036", "story_v_out_122471.awb")

						arg_145_1:RecordAudio("122471036", var_148_21)
						arg_145_1:RecordAudio("122471036", var_148_21)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_122471", "122471036", "story_v_out_122471.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_122471", "122471036", "story_v_out_122471.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_22 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_22 and arg_145_1.time_ < var_148_12 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play122471037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122471037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play122471038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1076ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1076ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0, 100, 0)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1076ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, 100, 0)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["10039ui_story"].transform
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.var_.moveOldPos10039ui_story = var_152_9.localPosition
			end

			local var_152_11 = 0.001

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11
				local var_152_13 = Vector3.New(0, 100, 0)

				var_152_9.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10039ui_story, var_152_13, var_152_12)

				local var_152_14 = manager.ui.mainCamera.transform.position - var_152_9.position

				var_152_9.forward = Vector3.New(var_152_14.x, var_152_14.y, var_152_14.z)

				local var_152_15 = var_152_9.localEulerAngles

				var_152_15.z = 0
				var_152_15.x = 0
				var_152_9.localEulerAngles = var_152_15
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 then
				var_152_9.localPosition = Vector3.New(0, 100, 0)

				local var_152_16 = manager.ui.mainCamera.transform.position - var_152_9.position

				var_152_9.forward = Vector3.New(var_152_16.x, var_152_16.y, var_152_16.z)

				local var_152_17 = var_152_9.localEulerAngles

				var_152_17.z = 0
				var_152_17.x = 0
				var_152_9.localEulerAngles = var_152_17
			end

			local var_152_18 = 0
			local var_152_19 = 1

			if var_152_18 < arg_149_1.time_ and arg_149_1.time_ <= var_152_18 + arg_152_0 then
				local var_152_20 = "play"
				local var_152_21 = "effect"

				arg_149_1:AudioAction(var_152_20, var_152_21, "se_story_122_03", "se_story_122_03_camera", "")
			end

			local var_152_22 = 0
			local var_152_23 = 0.875

			if var_152_22 < arg_149_1.time_ and arg_149_1.time_ <= var_152_22 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_24 = arg_149_1:GetWordFromCfg(122471037)
				local var_152_25 = arg_149_1:FormatText(var_152_24.content)

				arg_149_1.text_.text = var_152_25

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_26 = 35
				local var_152_27 = utf8.len(var_152_25)
				local var_152_28 = var_152_26 <= 0 and var_152_23 or var_152_23 * (var_152_27 / var_152_26)

				if var_152_28 > 0 and var_152_23 < var_152_28 then
					arg_149_1.talkMaxDuration = var_152_28

					if var_152_28 + var_152_22 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_28 + var_152_22
					end
				end

				arg_149_1.text_.text = var_152_25
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_29 = math.max(var_152_23, arg_149_1.talkMaxDuration)

			if var_152_22 <= arg_149_1.time_ and arg_149_1.time_ < var_152_22 + var_152_29 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_22) / var_152_29

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_22 + var_152_29 and arg_149_1.time_ < var_152_22 + var_152_29 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play122471038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122471038
		arg_153_1.duration_ = 10.73

		local var_153_0 = {
			ja = 10.733,
			ko = 6.4,
			zh = 6.4
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
				arg_153_0:Play122471039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1076ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1076ui_story == nil then
				arg_153_1.var_.characterEffect1076ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1076ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1076ui_story then
				arg_153_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_6 = arg_153_1.actors_["10039ui_story"]
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect10039ui_story == nil then
				arg_153_1.var_.characterEffect10039ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_8 = 0.200000002980232

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 and not isNil(var_156_6) then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8

				if arg_153_1.var_.characterEffect10039ui_story and not isNil(var_156_6) then
					local var_156_10 = Mathf.Lerp(0, 0.5, var_156_9)

					arg_153_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10039ui_story.fillRatio = var_156_10
				end
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect10039ui_story then
				local var_156_11 = 0.5

				arg_153_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10039ui_story.fillRatio = var_156_11
			end

			local var_156_12 = 0

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_156_14 = arg_153_1.actors_["1076ui_story"].transform
			local var_156_15 = 0

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.var_.moveOldPos1076ui_story = var_156_14.localPosition
			end

			local var_156_16 = 0.001

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_16 then
				local var_156_17 = (arg_153_1.time_ - var_156_15) / var_156_16
				local var_156_18 = Vector3.New(-0.7, -1.06, -6.2)

				var_156_14.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1076ui_story, var_156_18, var_156_17)

				local var_156_19 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_19.x, var_156_19.y, var_156_19.z)

				local var_156_20 = var_156_14.localEulerAngles

				var_156_20.z = 0
				var_156_20.x = 0
				var_156_14.localEulerAngles = var_156_20
			end

			if arg_153_1.time_ >= var_156_15 + var_156_16 and arg_153_1.time_ < var_156_15 + var_156_16 + arg_156_0 then
				var_156_14.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_156_21 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_21.x, var_156_21.y, var_156_21.z)

				local var_156_22 = var_156_14.localEulerAngles

				var_156_22.z = 0
				var_156_22.x = 0
				var_156_14.localEulerAngles = var_156_22
			end

			local var_156_23 = arg_153_1.actors_["10039ui_story"].transform
			local var_156_24 = 0

			if var_156_24 < arg_153_1.time_ and arg_153_1.time_ <= var_156_24 + arg_156_0 then
				arg_153_1.var_.moveOldPos10039ui_story = var_156_23.localPosition
			end

			local var_156_25 = 0.001

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_25 then
				local var_156_26 = (arg_153_1.time_ - var_156_24) / var_156_25
				local var_156_27 = Vector3.New(0.7, -0.8, -6.2)

				var_156_23.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10039ui_story, var_156_27, var_156_26)

				local var_156_28 = manager.ui.mainCamera.transform.position - var_156_23.position

				var_156_23.forward = Vector3.New(var_156_28.x, var_156_28.y, var_156_28.z)

				local var_156_29 = var_156_23.localEulerAngles

				var_156_29.z = 0
				var_156_29.x = 0
				var_156_23.localEulerAngles = var_156_29
			end

			if arg_153_1.time_ >= var_156_24 + var_156_25 and arg_153_1.time_ < var_156_24 + var_156_25 + arg_156_0 then
				var_156_23.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_156_30 = manager.ui.mainCamera.transform.position - var_156_23.position

				var_156_23.forward = Vector3.New(var_156_30.x, var_156_30.y, var_156_30.z)

				local var_156_31 = var_156_23.localEulerAngles

				var_156_31.z = 0
				var_156_31.x = 0
				var_156_23.localEulerAngles = var_156_31
			end

			local var_156_32 = 0
			local var_156_33 = 0.6

			if var_156_32 < arg_153_1.time_ and arg_153_1.time_ <= var_156_32 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_34 = arg_153_1:FormatText(StoryNameCfg[389].name)

				arg_153_1.leftNameTxt_.text = var_156_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_35 = arg_153_1:GetWordFromCfg(122471038)
				local var_156_36 = arg_153_1:FormatText(var_156_35.content)

				arg_153_1.text_.text = var_156_36

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_37 = 24
				local var_156_38 = utf8.len(var_156_36)
				local var_156_39 = var_156_37 <= 0 and var_156_33 or var_156_33 * (var_156_38 / var_156_37)

				if var_156_39 > 0 and var_156_33 < var_156_39 then
					arg_153_1.talkMaxDuration = var_156_39

					if var_156_39 + var_156_32 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_39 + var_156_32
					end
				end

				arg_153_1.text_.text = var_156_36
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471038", "story_v_out_122471.awb") ~= 0 then
					local var_156_40 = manager.audio:GetVoiceLength("story_v_out_122471", "122471038", "story_v_out_122471.awb") / 1000

					if var_156_40 + var_156_32 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_40 + var_156_32
					end

					if var_156_35.prefab_name ~= "" and arg_153_1.actors_[var_156_35.prefab_name] ~= nil then
						local var_156_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_35.prefab_name].transform, "story_v_out_122471", "122471038", "story_v_out_122471.awb")

						arg_153_1:RecordAudio("122471038", var_156_41)
						arg_153_1:RecordAudio("122471038", var_156_41)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_122471", "122471038", "story_v_out_122471.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_122471", "122471038", "story_v_out_122471.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_42 = math.max(var_156_33, arg_153_1.talkMaxDuration)

			if var_156_32 <= arg_153_1.time_ and arg_153_1.time_ < var_156_32 + var_156_42 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_32) / var_156_42

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_32 + var_156_42 and arg_153_1.time_ < var_156_32 + var_156_42 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play122471039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122471039
		arg_157_1.duration_ = 16.13

		local var_157_0 = {
			ja = 16.133,
			ko = 7.933,
			zh = 7.933
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
				arg_157_0:Play122471040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10039ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10039ui_story == nil then
				arg_157_1.var_.characterEffect10039ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect10039ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10039ui_story then
				arg_157_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_160_4 = 0

			if var_160_4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action3_1")
			end

			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_160_6 = arg_157_1.actors_["1076ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1076ui_story == nil then
				arg_157_1.var_.characterEffect1076ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect1076ui_story and not isNil(var_160_6) then
					local var_160_10 = Mathf.Lerp(0, 0.5, var_160_9)

					arg_157_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1076ui_story.fillRatio = var_160_10
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1076ui_story then
				local var_160_11 = 0.5

				arg_157_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1076ui_story.fillRatio = var_160_11
			end

			local var_160_12 = 0
			local var_160_13 = 0.85

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_14 = arg_157_1:FormatText(StoryNameCfg[472].name)

				arg_157_1.leftNameTxt_.text = var_160_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:GetWordFromCfg(122471039)
				local var_160_16 = arg_157_1:FormatText(var_160_15.content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 34
				local var_160_18 = utf8.len(var_160_16)
				local var_160_19 = var_160_17 <= 0 and var_160_13 or var_160_13 * (var_160_18 / var_160_17)

				if var_160_19 > 0 and var_160_13 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471039", "story_v_out_122471.awb") ~= 0 then
					local var_160_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471039", "story_v_out_122471.awb") / 1000

					if var_160_20 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_12
					end

					if var_160_15.prefab_name ~= "" and arg_157_1.actors_[var_160_15.prefab_name] ~= nil then
						local var_160_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_15.prefab_name].transform, "story_v_out_122471", "122471039", "story_v_out_122471.awb")

						arg_157_1:RecordAudio("122471039", var_160_21)
						arg_157_1:RecordAudio("122471039", var_160_21)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_122471", "122471039", "story_v_out_122471.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_122471", "122471039", "story_v_out_122471.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_22 and arg_157_1.time_ < var_160_12 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play122471040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122471040
		arg_161_1.duration_ = 2.8

		local var_161_0 = {
			ja = 2.8,
			ko = 2.2,
			zh = 2.2
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
				arg_161_0:Play122471041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1076ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1076ui_story == nil then
				arg_161_1.var_.characterEffect1076ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1076ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1076ui_story then
				arg_161_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_164_4 = 0

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_164_6 = arg_161_1.actors_["10039ui_story"]
			local var_164_7 = 0

			if var_164_7 < arg_161_1.time_ and arg_161_1.time_ <= var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10039ui_story == nil then
				arg_161_1.var_.characterEffect10039ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_8 = 0.200000002980232

			if var_164_7 <= arg_161_1.time_ and arg_161_1.time_ < var_164_7 + var_164_8 and not isNil(var_164_6) then
				local var_164_9 = (arg_161_1.time_ - var_164_7) / var_164_8

				if arg_161_1.var_.characterEffect10039ui_story and not isNil(var_164_6) then
					local var_164_10 = Mathf.Lerp(0, 0.5, var_164_9)

					arg_161_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10039ui_story.fillRatio = var_164_10
				end
			end

			if arg_161_1.time_ >= var_164_7 + var_164_8 and arg_161_1.time_ < var_164_7 + var_164_8 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10039ui_story then
				local var_164_11 = 0.5

				arg_161_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10039ui_story.fillRatio = var_164_11
			end

			local var_164_12 = 0
			local var_164_13 = 0.275

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_14 = arg_161_1:FormatText(StoryNameCfg[389].name)

				arg_161_1.leftNameTxt_.text = var_164_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_15 = arg_161_1:GetWordFromCfg(122471040)
				local var_164_16 = arg_161_1:FormatText(var_164_15.content)

				arg_161_1.text_.text = var_164_16

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_17 = 11
				local var_164_18 = utf8.len(var_164_16)
				local var_164_19 = var_164_17 <= 0 and var_164_13 or var_164_13 * (var_164_18 / var_164_17)

				if var_164_19 > 0 and var_164_13 < var_164_19 then
					arg_161_1.talkMaxDuration = var_164_19

					if var_164_19 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_19 + var_164_12
					end
				end

				arg_161_1.text_.text = var_164_16
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471040", "story_v_out_122471.awb") ~= 0 then
					local var_164_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471040", "story_v_out_122471.awb") / 1000

					if var_164_20 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_20 + var_164_12
					end

					if var_164_15.prefab_name ~= "" and arg_161_1.actors_[var_164_15.prefab_name] ~= nil then
						local var_164_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_15.prefab_name].transform, "story_v_out_122471", "122471040", "story_v_out_122471.awb")

						arg_161_1:RecordAudio("122471040", var_164_21)
						arg_161_1:RecordAudio("122471040", var_164_21)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_122471", "122471040", "story_v_out_122471.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_122471", "122471040", "story_v_out_122471.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_22 = math.max(var_164_13, arg_161_1.talkMaxDuration)

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_22 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_12) / var_164_22

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_12 + var_164_22 and arg_161_1.time_ < var_164_12 + var_164_22 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play122471041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122471041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play122471042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1076ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1076ui_story == nil then
				arg_165_1.var_.characterEffect1076ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1076ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1076ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1076ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1076ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.775

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(122471041)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 31
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_7 or var_168_7 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_7 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_13 and arg_165_1.time_ < var_168_6 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play122471042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122471042
		arg_169_1.duration_ = 13.7

		local var_169_0 = {
			ja = 13.7,
			ko = 8.766,
			zh = 8.766
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
				arg_169_0:Play122471043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10039ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10039ui_story == nil then
				arg_169_1.var_.characterEffect10039ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect10039ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10039ui_story then
				arg_169_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_172_4 = 0

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action435")
			end

			local var_172_5 = 0

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_172_6 = 0
			local var_172_7 = 0.7

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[472].name)

				arg_169_1.leftNameTxt_.text = var_172_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_9 = arg_169_1:GetWordFromCfg(122471042)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 28
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471042", "story_v_out_122471.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_out_122471", "122471042", "story_v_out_122471.awb") / 1000

					if var_172_14 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_6
					end

					if var_172_9.prefab_name ~= "" and arg_169_1.actors_[var_172_9.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_9.prefab_name].transform, "story_v_out_122471", "122471042", "story_v_out_122471.awb")

						arg_169_1:RecordAudio("122471042", var_172_15)
						arg_169_1:RecordAudio("122471042", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_122471", "122471042", "story_v_out_122471.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_122471", "122471042", "story_v_out_122471.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_16 and arg_169_1.time_ < var_172_6 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play122471043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122471043
		arg_173_1.duration_ = 12.2

		local var_173_0 = {
			ja = 12.2,
			ko = 8.1,
			zh = 8.1
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
				arg_173_0:Play122471044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1076ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1076ui_story == nil then
				arg_173_1.var_.characterEffect1076ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1076ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1076ui_story then
				arg_173_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_176_4 = 0

			if var_176_4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_1")
			end

			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_6 = arg_173_1.actors_["10039ui_story"]
			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10039ui_story == nil then
				arg_173_1.var_.characterEffect10039ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 and not isNil(var_176_6) then
				local var_176_9 = (arg_173_1.time_ - var_176_7) / var_176_8

				if arg_173_1.var_.characterEffect10039ui_story and not isNil(var_176_6) then
					local var_176_10 = Mathf.Lerp(0, 0.5, var_176_9)

					arg_173_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10039ui_story.fillRatio = var_176_10
				end
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10039ui_story then
				local var_176_11 = 0.5

				arg_173_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10039ui_story.fillRatio = var_176_11
			end

			local var_176_12 = 0
			local var_176_13 = 0.725

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_14 = arg_173_1:FormatText(StoryNameCfg[389].name)

				arg_173_1.leftNameTxt_.text = var_176_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_15 = arg_173_1:GetWordFromCfg(122471043)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 29
				local var_176_18 = utf8.len(var_176_16)
				local var_176_19 = var_176_17 <= 0 and var_176_13 or var_176_13 * (var_176_18 / var_176_17)

				if var_176_19 > 0 and var_176_13 < var_176_19 then
					arg_173_1.talkMaxDuration = var_176_19

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471043", "story_v_out_122471.awb") ~= 0 then
					local var_176_20 = manager.audio:GetVoiceLength("story_v_out_122471", "122471043", "story_v_out_122471.awb") / 1000

					if var_176_20 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_122471", "122471043", "story_v_out_122471.awb")

						arg_173_1:RecordAudio("122471043", var_176_21)
						arg_173_1:RecordAudio("122471043", var_176_21)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_122471", "122471043", "story_v_out_122471.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_122471", "122471043", "story_v_out_122471.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_22 and arg_173_1.time_ < var_176_12 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play122471044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122471044
		arg_177_1.duration_ = 19.5

		local var_177_0 = {
			ja = 19.5,
			ko = 10.266,
			zh = 10.266
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
				arg_177_0:Play122471045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action4_2")
			end

			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_2 = 0
			local var_180_3 = 1

			if var_180_2 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_4 = arg_177_1:FormatText(StoryNameCfg[389].name)

				arg_177_1.leftNameTxt_.text = var_180_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_5 = arg_177_1:GetWordFromCfg(122471044)
				local var_180_6 = arg_177_1:FormatText(var_180_5.content)

				arg_177_1.text_.text = var_180_6

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 40
				local var_180_8 = utf8.len(var_180_6)
				local var_180_9 = var_180_7 <= 0 and var_180_3 or var_180_3 * (var_180_8 / var_180_7)

				if var_180_9 > 0 and var_180_3 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_6
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471044", "story_v_out_122471.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_122471", "122471044", "story_v_out_122471.awb") / 1000

					if var_180_10 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_2
					end

					if var_180_5.prefab_name ~= "" and arg_177_1.actors_[var_180_5.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_5.prefab_name].transform, "story_v_out_122471", "122471044", "story_v_out_122471.awb")

						arg_177_1:RecordAudio("122471044", var_180_11)
						arg_177_1:RecordAudio("122471044", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_122471", "122471044", "story_v_out_122471.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_122471", "122471044", "story_v_out_122471.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_12 and arg_177_1.time_ < var_180_2 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play122471045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122471045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122471046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1076ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1076ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1076ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["10039ui_story"].transform
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.var_.moveOldPos10039ui_story = var_184_9.localPosition
			end

			local var_184_11 = 0.001

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11
				local var_184_13 = Vector3.New(0, 100, 0)

				var_184_9.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10039ui_story, var_184_13, var_184_12)

				local var_184_14 = manager.ui.mainCamera.transform.position - var_184_9.position

				var_184_9.forward = Vector3.New(var_184_14.x, var_184_14.y, var_184_14.z)

				local var_184_15 = var_184_9.localEulerAngles

				var_184_15.z = 0
				var_184_15.x = 0
				var_184_9.localEulerAngles = var_184_15
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 then
				var_184_9.localPosition = Vector3.New(0, 100, 0)

				local var_184_16 = manager.ui.mainCamera.transform.position - var_184_9.position

				var_184_9.forward = Vector3.New(var_184_16.x, var_184_16.y, var_184_16.z)

				local var_184_17 = var_184_9.localEulerAngles

				var_184_17.z = 0
				var_184_17.x = 0
				var_184_9.localEulerAngles = var_184_17
			end

			local var_184_18 = 0
			local var_184_19 = 0.3

			if var_184_18 < arg_181_1.time_ and arg_181_1.time_ <= var_184_18 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_20 = arg_181_1:GetWordFromCfg(122471045)
				local var_184_21 = arg_181_1:FormatText(var_184_20.content)

				arg_181_1.text_.text = var_184_21

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_22 = 12
				local var_184_23 = utf8.len(var_184_21)
				local var_184_24 = var_184_22 <= 0 and var_184_19 or var_184_19 * (var_184_23 / var_184_22)

				if var_184_24 > 0 and var_184_19 < var_184_24 then
					arg_181_1.talkMaxDuration = var_184_24

					if var_184_24 + var_184_18 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_24 + var_184_18
					end
				end

				arg_181_1.text_.text = var_184_21
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_25 = math.max(var_184_19, arg_181_1.talkMaxDuration)

			if var_184_18 <= arg_181_1.time_ and arg_181_1.time_ < var_184_18 + var_184_25 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_18) / var_184_25

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_18 + var_184_25 and arg_181_1.time_ < var_184_18 + var_184_25 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play122471046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122471046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play122471047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_2 = "play"
				local var_188_3 = "effect"

				arg_185_1:AudioAction(var_188_2, var_188_3, "se_story_122_03", "se_story_122_03_wind", "")
			end

			local var_188_4 = 0
			local var_188_5 = 0.575

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(122471046)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 23
				local var_188_9 = utf8.len(var_188_7)
				local var_188_10 = var_188_8 <= 0 and var_188_5 or var_188_5 * (var_188_9 / var_188_8)

				if var_188_10 > 0 and var_188_5 < var_188_10 then
					arg_185_1.talkMaxDuration = var_188_10

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_11 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_11 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_11

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_11 and arg_185_1.time_ < var_188_4 + var_188_11 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play122471047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122471047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play122471048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.525

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(122471047)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 21
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play122471048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122471048
		arg_193_1.duration_ = 8.4

		local var_193_0 = {
			ja = 7.5,
			ko = 8.4,
			zh = 8.4
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
				arg_193_0:Play122471049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "J08h"

			if arg_193_1.bgs_[var_196_0] == nil then
				local var_196_1 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_0)
				var_196_1.name = var_196_0
				var_196_1.transform.parent = arg_193_1.stage_.transform
				var_196_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_0] = var_196_1
			end

			local var_196_2 = 2

			if var_196_2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				local var_196_3 = manager.ui.mainCamera.transform.localPosition
				local var_196_4 = Vector3.New(0, 0, 10) + Vector3.New(var_196_3.x, var_196_3.y, 0)
				local var_196_5 = arg_193_1.bgs_.J08h

				var_196_5.transform.localPosition = var_196_4
				var_196_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_6 = var_196_5:GetComponent("SpriteRenderer")

				if var_196_6 and var_196_6.sprite then
					local var_196_7 = (var_196_5.transform.localPosition - var_196_3).z
					local var_196_8 = manager.ui.mainCameraCom_
					local var_196_9 = 2 * var_196_7 * Mathf.Tan(var_196_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_10 = var_196_9 * var_196_8.aspect
					local var_196_11 = var_196_6.sprite.bounds.size.x
					local var_196_12 = var_196_6.sprite.bounds.size.y
					local var_196_13 = var_196_10 / var_196_11
					local var_196_14 = var_196_9 / var_196_12
					local var_196_15 = var_196_14 < var_196_13 and var_196_13 or var_196_14

					var_196_5.transform.localScale = Vector3.New(var_196_15, var_196_15, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "J08h" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_17 = 2

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17
				local var_196_19 = Color.New(0, 0, 0)

				var_196_19.a = Mathf.Lerp(0, 1, var_196_18)
				arg_193_1.mask_.color = var_196_19
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				local var_196_20 = Color.New(0, 0, 0)

				var_196_20.a = 1
				arg_193_1.mask_.color = var_196_20
			end

			local var_196_21 = 2

			if var_196_21 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_22 = 2

			if var_196_21 <= arg_193_1.time_ and arg_193_1.time_ < var_196_21 + var_196_22 then
				local var_196_23 = (arg_193_1.time_ - var_196_21) / var_196_22
				local var_196_24 = Color.New(0, 0, 0)

				var_196_24.a = Mathf.Lerp(1, 0, var_196_23)
				arg_193_1.mask_.color = var_196_24
			end

			if arg_193_1.time_ >= var_196_21 + var_196_22 and arg_193_1.time_ < var_196_21 + var_196_22 + arg_196_0 then
				local var_196_25 = Color.New(0, 0, 0)
				local var_196_26 = 0

				arg_193_1.mask_.enabled = false
				var_196_25.a = var_196_26
				arg_193_1.mask_.color = var_196_25
			end

			local var_196_27 = "J08h_blur"

			if arg_193_1.bgs_[var_196_27] == nil then
				local var_196_28 = Object.Instantiate(arg_193_1.blurPaintGo_)
				local var_196_29 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_27)

				var_196_28:GetComponent("SpriteRenderer").sprite = var_196_29
				var_196_28.name = var_196_27
				var_196_28.transform.parent = arg_193_1.stage_.transform
				var_196_28.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_27] = var_196_28
			end

			local var_196_30 = 2
			local var_196_31 = arg_193_1.bgs_[var_196_27]

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				local var_196_32 = manager.ui.mainCamera.transform.localPosition
				local var_196_33 = Vector3.New(0, 0, 10) + Vector3.New(var_196_32.x, var_196_32.y, 0)

				var_196_31.transform.localPosition = var_196_33
				var_196_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_34 = var_196_31:GetComponent("SpriteRenderer")

				if var_196_34 and var_196_34.sprite then
					local var_196_35 = (var_196_31.transform.localPosition - var_196_32).z
					local var_196_36 = manager.ui.mainCameraCom_
					local var_196_37 = 2 * var_196_35 * Mathf.Tan(var_196_36.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_38 = var_196_37 * var_196_36.aspect
					local var_196_39 = var_196_34.sprite.bounds.size.x
					local var_196_40 = var_196_34.sprite.bounds.size.y
					local var_196_41 = var_196_38 / var_196_39
					local var_196_42 = var_196_37 / var_196_40
					local var_196_43 = var_196_42 < var_196_41 and var_196_41 or var_196_42

					var_196_31.transform.localScale = Vector3.New(var_196_43, var_196_43, 0)
				end
			end

			local var_196_44 = 0.1

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_44 then
				local var_196_45 = (arg_193_1.time_ - var_196_30) / var_196_44
				local var_196_46 = Color.New(1, 1, 1)

				var_196_46.a = Mathf.Lerp(0, 1, var_196_45)

				var_196_31:GetComponent("SpriteRenderer").material:SetColor("_Color", var_196_46)
			end

			local var_196_47 = 0
			local var_196_48 = 1

			if var_196_47 < arg_193_1.time_ and arg_193_1.time_ <= var_196_47 + arg_196_0 then
				local var_196_49 = "play"
				local var_196_50 = "music"

				arg_193_1:AudioAction(var_196_49, var_196_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_196_51 = ""
				local var_196_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_196_52 ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_52 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_52

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_52
						arg_193_1.bgmTxt2_.text = var_196_52
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_53 = 4
			local var_196_54 = 0.3

			if var_196_53 < arg_193_1.time_ and arg_193_1.time_ <= var_196_53 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_55 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_55:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_193_1.dialogCg_.alpha = arg_198_0
				end))
				var_196_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_56 = arg_193_1:FormatText(StoryNameCfg[384].name)

				arg_193_1.leftNameTxt_.text = var_196_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_57 = arg_193_1:GetWordFromCfg(122471048)
				local var_196_58 = arg_193_1:FormatText(var_196_57.content)

				arg_193_1.text_.text = var_196_58

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_59 = 12
				local var_196_60 = utf8.len(var_196_58)
				local var_196_61 = var_196_59 <= 0 and var_196_54 or var_196_54 * (var_196_60 / var_196_59)

				if var_196_61 > 0 and var_196_54 < var_196_61 then
					arg_193_1.talkMaxDuration = var_196_61
					var_196_53 = var_196_53 + 0.3

					if var_196_61 + var_196_53 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_61 + var_196_53
					end
				end

				arg_193_1.text_.text = var_196_58
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471048", "story_v_out_122471.awb") ~= 0 then
					local var_196_62 = manager.audio:GetVoiceLength("story_v_out_122471", "122471048", "story_v_out_122471.awb") / 1000

					if var_196_62 + var_196_53 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_62 + var_196_53
					end

					if var_196_57.prefab_name ~= "" and arg_193_1.actors_[var_196_57.prefab_name] ~= nil then
						local var_196_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_57.prefab_name].transform, "story_v_out_122471", "122471048", "story_v_out_122471.awb")

						arg_193_1:RecordAudio("122471048", var_196_63)
						arg_193_1:RecordAudio("122471048", var_196_63)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122471", "122471048", "story_v_out_122471.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122471", "122471048", "story_v_out_122471.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_64 = var_196_53 + 0.3
			local var_196_65 = math.max(var_196_54, arg_193_1.talkMaxDuration)

			if var_196_64 <= arg_193_1.time_ and arg_193_1.time_ < var_196_64 + var_196_65 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_64) / var_196_65

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_64 + var_196_65 and arg_193_1.time_ < var_196_64 + var_196_65 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play122471049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 122471049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play122471050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.225

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(122471049)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 49
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play122471050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 122471050
		arg_204_1.duration_ = 14.73

		local var_204_0 = {
			ja = 12.2,
			ko = 14.733,
			zh = 14.733
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play122471051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.8

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[384].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(122471050)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 32
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471050", "story_v_out_122471.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471050", "story_v_out_122471.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_122471", "122471050", "story_v_out_122471.awb")

						arg_204_1:RecordAudio("122471050", var_207_9)
						arg_204_1:RecordAudio("122471050", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_122471", "122471050", "story_v_out_122471.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_122471", "122471050", "story_v_out_122471.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play122471051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 122471051
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play122471052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 1.075

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_2 = arg_208_1:GetWordFromCfg(122471051)
				local var_211_3 = arg_208_1:FormatText(var_211_2.content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 43
				local var_211_5 = utf8.len(var_211_3)
				local var_211_6 = var_211_4 <= 0 and var_211_1 or var_211_1 * (var_211_5 / var_211_4)

				if var_211_6 > 0 and var_211_1 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_7 and arg_208_1.time_ < var_211_0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play122471052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 122471052
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play122471053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 1.025

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_2 = arg_212_1:GetWordFromCfg(122471052)
				local var_215_3 = arg_212_1:FormatText(var_215_2.content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 41
				local var_215_5 = utf8.len(var_215_3)
				local var_215_6 = var_215_4 <= 0 and var_215_1 or var_215_1 * (var_215_5 / var_215_4)

				if var_215_6 > 0 and var_215_1 < var_215_6 then
					arg_212_1.talkMaxDuration = var_215_6

					if var_215_6 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_6 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_7 and arg_212_1.time_ < var_215_0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play122471053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 122471053
		arg_216_1.duration_ = 4.8

		local var_216_0 = {
			ja = 4.3,
			ko = 4.8,
			zh = 4.8
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play122471054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 0.425

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[453].name)

				arg_216_1.leftNameTxt_.text = var_219_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4037")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:GetWordFromCfg(122471053)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 17
				local var_219_6 = utf8.len(var_219_4)
				local var_219_7 = var_219_5 <= 0 and var_219_1 or var_219_1 * (var_219_6 / var_219_5)

				if var_219_7 > 0 and var_219_1 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471053", "story_v_out_122471.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471053", "story_v_out_122471.awb") / 1000

					if var_219_8 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_0
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_122471", "122471053", "story_v_out_122471.awb")

						arg_216_1:RecordAudio("122471053", var_219_9)
						arg_216_1:RecordAudio("122471053", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_122471", "122471053", "story_v_out_122471.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_122471", "122471053", "story_v_out_122471.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_10 and arg_216_1.time_ < var_219_0 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play122471054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 122471054
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play122471055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = "4037ui_story"

			if arg_220_1.actors_[var_223_0] == nil then
				local var_223_1 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_223_1) then
					local var_223_2 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_220_1.stage_.transform)

					var_223_2.name = var_223_0
					var_223_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_220_1.actors_[var_223_0] = var_223_2

					local var_223_3 = var_223_2:GetComponentInChildren(typeof(CharacterEffect))

					var_223_3.enabled = true

					local var_223_4 = GameObjectTools.GetOrAddComponent(var_223_2, typeof(DynamicBoneHelper))

					if var_223_4 then
						var_223_4:EnableDynamicBone(false)
					end

					arg_220_1:ShowWeapon(var_223_3.transform, false)

					arg_220_1.var_[var_223_0 .. "Animator"] = var_223_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_220_1.var_[var_223_0 .. "Animator"].applyRootMotion = true
					arg_220_1.var_[var_223_0 .. "LipSync"] = var_223_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_223_5 = arg_220_1.actors_["4037ui_story"].transform
			local var_223_6 = 0

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.var_.moveOldPos4037ui_story = var_223_5.localPosition
			end

			local var_223_7 = 0.001

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_7 then
				local var_223_8 = (arg_220_1.time_ - var_223_6) / var_223_7
				local var_223_9 = Vector3.New(0, 100, 0)

				var_223_5.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos4037ui_story, var_223_9, var_223_8)

				local var_223_10 = manager.ui.mainCamera.transform.position - var_223_5.position

				var_223_5.forward = Vector3.New(var_223_10.x, var_223_10.y, var_223_10.z)

				local var_223_11 = var_223_5.localEulerAngles

				var_223_11.z = 0
				var_223_11.x = 0
				var_223_5.localEulerAngles = var_223_11
			end

			if arg_220_1.time_ >= var_223_6 + var_223_7 and arg_220_1.time_ < var_223_6 + var_223_7 + arg_223_0 then
				var_223_5.localPosition = Vector3.New(0, 100, 0)

				local var_223_12 = manager.ui.mainCamera.transform.position - var_223_5.position

				var_223_5.forward = Vector3.New(var_223_12.x, var_223_12.y, var_223_12.z)

				local var_223_13 = var_223_5.localEulerAngles

				var_223_13.z = 0
				var_223_13.x = 0
				var_223_5.localEulerAngles = var_223_13
			end

			local var_223_14 = 0
			local var_223_15 = 1

			if var_223_14 < arg_220_1.time_ and arg_220_1.time_ <= var_223_14 + arg_223_0 then
				local var_223_16 = "play"
				local var_223_17 = "effect"

				arg_220_1:AudioAction(var_223_16, var_223_17, "se_story_122_03", "se_story_122_03_crystal2", "")
			end

			local var_223_18 = 0
			local var_223_19 = 1.225

			if var_223_18 < arg_220_1.time_ and arg_220_1.time_ <= var_223_18 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_20 = arg_220_1:GetWordFromCfg(122471054)
				local var_223_21 = arg_220_1:FormatText(var_223_20.content)

				arg_220_1.text_.text = var_223_21

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_22 = 49
				local var_223_23 = utf8.len(var_223_21)
				local var_223_24 = var_223_22 <= 0 and var_223_19 or var_223_19 * (var_223_23 / var_223_22)

				if var_223_24 > 0 and var_223_19 < var_223_24 then
					arg_220_1.talkMaxDuration = var_223_24

					if var_223_24 + var_223_18 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_24 + var_223_18
					end
				end

				arg_220_1.text_.text = var_223_21
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_25 = math.max(var_223_19, arg_220_1.talkMaxDuration)

			if var_223_18 <= arg_220_1.time_ and arg_220_1.time_ < var_223_18 + var_223_25 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_18) / var_223_25

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_18 + var_223_25 and arg_220_1.time_ < var_223_18 + var_223_25 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play122471055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 122471055
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play122471056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 1.8

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_2 = arg_224_1:GetWordFromCfg(122471055)
				local var_227_3 = arg_224_1:FormatText(var_227_2.content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 72
				local var_227_5 = utf8.len(var_227_3)
				local var_227_6 = var_227_4 <= 0 and var_227_1 or var_227_1 * (var_227_5 / var_227_4)

				if var_227_6 > 0 and var_227_1 < var_227_6 then
					arg_224_1.talkMaxDuration = var_227_6

					if var_227_6 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_6 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_7 and arg_224_1.time_ < var_227_0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play122471056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 122471056
		arg_228_1.duration_ = 5.53

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play122471057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_1 = 0.2

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_1 then
				local var_231_2 = (arg_228_1.time_ - var_231_0) / var_231_1
				local var_231_3 = Color.New(1, 1, 1)

				var_231_3.a = Mathf.Lerp(0, 1, var_231_2)
				arg_228_1.mask_.color = var_231_3
			end

			if arg_228_1.time_ >= var_231_0 + var_231_1 and arg_228_1.time_ < var_231_0 + var_231_1 + arg_231_0 then
				local var_231_4 = Color.New(1, 1, 1)

				var_231_4.a = 1
				arg_228_1.mask_.color = var_231_4
			end

			local var_231_5 = 0.2

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_6 = 0.8

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 then
				local var_231_7 = (arg_228_1.time_ - var_231_5) / var_231_6
				local var_231_8 = Color.New(1, 1, 1)

				var_231_8.a = Mathf.Lerp(1, 0, var_231_7)
				arg_228_1.mask_.color = var_231_8
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 then
				local var_231_9 = Color.New(1, 1, 1)
				local var_231_10 = 0

				arg_228_1.mask_.enabled = false
				var_231_9.a = var_231_10
				arg_228_1.mask_.color = var_231_9
			end

			local var_231_11 = 0

			if var_231_11 < arg_228_1.time_ and arg_228_1.time_ <= var_231_11 + arg_231_0 then
				arg_228_1.allBtn_.enabled = false
			end

			local var_231_12 = 1

			if arg_228_1.time_ >= var_231_11 + var_231_12 and arg_228_1.time_ < var_231_11 + var_231_12 + arg_231_0 then
				arg_228_1.allBtn_.enabled = true
			end

			local var_231_13 = manager.ui.mainCamera.transform
			local var_231_14 = 0

			if var_231_14 < arg_228_1.time_ and arg_228_1.time_ <= var_231_14 + arg_231_0 then
				arg_228_1.var_.shakeOldPos = var_231_13.localPosition
			end

			local var_231_15 = 1

			if var_231_14 <= arg_228_1.time_ and arg_228_1.time_ < var_231_14 + var_231_15 then
				local var_231_16 = (arg_228_1.time_ - var_231_14) / 0.066
				local var_231_17, var_231_18 = math.modf(var_231_16)

				var_231_13.localPosition = Vector3.New(var_231_18 * 0.13, var_231_18 * 0.13, var_231_18 * 0.13) + arg_228_1.var_.shakeOldPos
			end

			if arg_228_1.time_ >= var_231_14 + var_231_15 and arg_228_1.time_ < var_231_14 + var_231_15 + arg_231_0 then
				var_231_13.localPosition = arg_228_1.var_.shakeOldPos
			end

			local var_231_19 = 0
			local var_231_20 = 1

			if var_231_19 < arg_228_1.time_ and arg_228_1.time_ <= var_231_19 + arg_231_0 then
				local var_231_21 = "play"
				local var_231_22 = "effect"

				arg_228_1:AudioAction(var_231_21, var_231_22, "se_story_122_01", "se_story_122_01_dragon", "")
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_23 = 0.533333333333333
			local var_231_24 = 1.425

			if var_231_23 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_25 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_25:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_228_1.dialogCg_.alpha = arg_232_0
				end))
				var_231_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_26 = arg_228_1:GetWordFromCfg(122471056)
				local var_231_27 = arg_228_1:FormatText(var_231_26.content)

				arg_228_1.text_.text = var_231_27

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_28 = 57
				local var_231_29 = utf8.len(var_231_27)
				local var_231_30 = var_231_28 <= 0 and var_231_24 or var_231_24 * (var_231_29 / var_231_28)

				if var_231_30 > 0 and var_231_24 < var_231_30 then
					arg_228_1.talkMaxDuration = var_231_30
					var_231_23 = var_231_23 + 0.3

					if var_231_30 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_30 + var_231_23
					end
				end

				arg_228_1.text_.text = var_231_27
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_31 = var_231_23 + 0.3
			local var_231_32 = math.max(var_231_24, arg_228_1.talkMaxDuration)

			if var_231_31 <= arg_228_1.time_ and arg_228_1.time_ < var_231_31 + var_231_32 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_31) / var_231_32

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_31 + var_231_32 and arg_228_1.time_ < var_231_31 + var_231_32 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play122471057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 122471057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play122471058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 1

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				local var_237_2 = "play"
				local var_237_3 = "effect"

				arg_234_1:AudioAction(var_237_2, var_237_3, "se_story_122_03", "se_story_122_03_power", "")
			end

			local var_237_4 = 0
			local var_237_5 = 0.975

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(122471057)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_8 = 39
				local var_237_9 = utf8.len(var_237_7)
				local var_237_10 = var_237_8 <= 0 and var_237_5 or var_237_5 * (var_237_9 / var_237_8)

				if var_237_10 > 0 and var_237_5 < var_237_10 then
					arg_234_1.talkMaxDuration = var_237_10

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_11 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_11 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_11

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_11 and arg_234_1.time_ < var_237_4 + var_237_11 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play122471058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 122471058
		arg_238_1.duration_ = 4.3

		local var_238_0 = {
			ja = 2.266,
			ko = 4.3,
			zh = 4.3
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
				arg_238_0:Play122471059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.15

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[384].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:GetWordFromCfg(122471058)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 6
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471058", "story_v_out_122471.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471058", "story_v_out_122471.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_122471", "122471058", "story_v_out_122471.awb")

						arg_238_1:RecordAudio("122471058", var_241_9)
						arg_238_1:RecordAudio("122471058", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_122471", "122471058", "story_v_out_122471.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_122471", "122471058", "story_v_out_122471.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play122471059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 122471059
		arg_242_1.duration_ = 2.77

		local var_242_0 = {
			ja = 2.766,
			ko = 2.466,
			zh = 2.466
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play122471060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.25

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_2 = arg_242_1:FormatText(StoryNameCfg[389].name)

				arg_242_1.leftNameTxt_.text = var_245_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:GetWordFromCfg(122471059)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 10
				local var_245_6 = utf8.len(var_245_4)
				local var_245_7 = var_245_5 <= 0 and var_245_1 or var_245_1 * (var_245_6 / var_245_5)

				if var_245_7 > 0 and var_245_1 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122471", "122471059", "story_v_out_122471.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_122471", "122471059", "story_v_out_122471.awb") / 1000

					if var_245_8 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_0
					end

					if var_245_3.prefab_name ~= "" and arg_242_1.actors_[var_245_3.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_3.prefab_name].transform, "story_v_out_122471", "122471059", "story_v_out_122471.awb")

						arg_242_1:RecordAudio("122471059", var_245_9)
						arg_242_1:RecordAudio("122471059", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_122471", "122471059", "story_v_out_122471.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_122471", "122471059", "story_v_out_122471.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_10 and arg_242_1.time_ < var_245_0 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play122471060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 122471060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play122471061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1076ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1076ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, 100, 0)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1076ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, 100, 0)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = 0
			local var_249_10 = 1.45

			if var_249_9 < arg_246_1.time_ and arg_246_1.time_ <= var_249_9 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_11 = arg_246_1:GetWordFromCfg(122471060)
				local var_249_12 = arg_246_1:FormatText(var_249_11.content)

				arg_246_1.text_.text = var_249_12

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 58
				local var_249_14 = utf8.len(var_249_12)
				local var_249_15 = var_249_13 <= 0 and var_249_10 or var_249_10 * (var_249_14 / var_249_13)

				if var_249_15 > 0 and var_249_10 < var_249_15 then
					arg_246_1.talkMaxDuration = var_249_15

					if var_249_15 + var_249_9 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_9
					end
				end

				arg_246_1.text_.text = var_249_12
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_10, arg_246_1.talkMaxDuration)

			if var_249_9 <= arg_246_1.time_ and arg_246_1.time_ < var_249_9 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_9) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_9 + var_249_16 and arg_246_1.time_ < var_249_9 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play122471061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 122471061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
			arg_250_1.auto_ = false
		end

		function arg_250_1.playNext_(arg_252_0)
			arg_250_1.onStoryFinished_()
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.875

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_2 = arg_250_1:GetWordFromCfg(122471061)
				local var_253_3 = arg_250_1:FormatText(var_253_2.content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 35
				local var_253_5 = utf8.len(var_253_3)
				local var_253_6 = var_253_4 <= 0 and var_253_1 or var_253_1 * (var_253_5 / var_253_4)

				if var_253_6 > 0 and var_253_1 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_7 and arg_250_1.time_ < var_253_0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/J08h"
	},
	voices = {
		"story_v_out_122471.awb"
	}
}
