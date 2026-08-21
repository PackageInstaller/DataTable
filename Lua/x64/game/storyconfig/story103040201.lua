return {
	Play304021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304021001
		arg_1_1.duration_ = 13.2

		local var_1_0 = {
			zh = 8.3,
			ja = 13.2
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
				arg_1_0:Play304021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "A00"

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
				local var_4_5 = arg_1_1.bgs_.A00

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
					if iter_4_0 ~= "A00" then
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

			local var_4_24 = "1019ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1019ui_story"].transform
			local var_4_30 = 1.76666666666667

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(-0.2, -1.08, -5.9)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1019ui_story"]
			local var_4_39 = 1.76666666666667

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_42 = 1.76666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_4_43 = 1.76666666666667

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.2
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_142", "se_story_142_amb_command room", "")
			end

			local var_4_48 = 1
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

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

			local var_4_54 = 0
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "effect"

				arg_1_1:AudioAction(var_4_56, var_4_57, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_58 = 2
			local var_4_59 = 0.875

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(304021001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021001", "story_v_out_304021.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_304021", "304021001", "story_v_out_304021.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_304021", "304021001", "story_v_out_304021.awb")

						arg_1_1:RecordAudio("304021001", var_4_68)
						arg_1_1:RecordAudio("304021001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304021", "304021001", "story_v_out_304021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304021", "304021001", "story_v_out_304021.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play304021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304021002
		arg_8_1.duration_ = 6.6

		local var_8_0 = {
			zh = 4.166,
			ja = 6.6
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
				arg_8_0:Play304021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1084ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0, -0.97, -6)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = arg_8_1.actors_["1019ui_story"].transform
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_14.localPosition
			end

			local var_11_16 = 0.001

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16
				local var_11_18 = Vector3.New(0, 100, 0)

				var_11_14.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, var_11_18, var_11_17)

				local var_11_19 = manager.ui.mainCamera.transform.position - var_11_14.position

				var_11_14.forward = Vector3.New(var_11_19.x, var_11_19.y, var_11_19.z)

				local var_11_20 = var_11_14.localEulerAngles

				var_11_20.z = 0
				var_11_20.x = 0
				var_11_14.localEulerAngles = var_11_20
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 then
				var_11_14.localPosition = Vector3.New(0, 100, 0)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_14.position

				var_11_14.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_14.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_14.localEulerAngles = var_11_22
			end

			local var_11_23 = arg_8_1.actors_["1084ui_story"]
			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 and not isNil(var_11_23) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_25 = 0.200000002980232

			if var_11_24 <= arg_8_1.time_ and arg_8_1.time_ < var_11_24 + var_11_25 and not isNil(var_11_23) then
				local var_11_26 = (arg_8_1.time_ - var_11_24) / var_11_25

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_23) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_24 + var_11_25 and arg_8_1.time_ < var_11_24 + var_11_25 + arg_11_0 and not isNil(var_11_23) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_27 = arg_8_1.actors_["1019ui_story"]
			local var_11_28 = 0

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 and not isNil(var_11_27) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_29 = 0.200000002980232

			if var_11_28 <= arg_8_1.time_ and arg_8_1.time_ < var_11_28 + var_11_29 and not isNil(var_11_27) then
				local var_11_30 = (arg_8_1.time_ - var_11_28) / var_11_29

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_27) then
					local var_11_31 = Mathf.Lerp(0, 0.5, var_11_30)

					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_31
				end
			end

			if arg_8_1.time_ >= var_11_28 + var_11_29 and arg_8_1.time_ < var_11_28 + var_11_29 + arg_11_0 and not isNil(var_11_27) and arg_8_1.var_.characterEffect1019ui_story then
				local var_11_32 = 0.5

				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_32
			end

			local var_11_33 = 0

			if var_11_33 < arg_8_1.time_ and arg_8_1.time_ <= var_11_33 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_11_34 = 0

			if var_11_34 < arg_8_1.time_ and arg_8_1.time_ <= var_11_34 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_35 = 0
			local var_11_36 = 0.45

			if var_11_35 < arg_8_1.time_ and arg_8_1.time_ <= var_11_35 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_37 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_38 = arg_8_1:GetWordFromCfg(304021002)
				local var_11_39 = arg_8_1:FormatText(var_11_38.content)

				arg_8_1.text_.text = var_11_39

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_40 = 18
				local var_11_41 = utf8.len(var_11_39)
				local var_11_42 = var_11_40 <= 0 and var_11_36 or var_11_36 * (var_11_41 / var_11_40)

				if var_11_42 > 0 and var_11_36 < var_11_42 then
					arg_8_1.talkMaxDuration = var_11_42

					if var_11_42 + var_11_35 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_42 + var_11_35
					end
				end

				arg_8_1.text_.text = var_11_39
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021002", "story_v_out_304021.awb") ~= 0 then
					local var_11_43 = manager.audio:GetVoiceLength("story_v_out_304021", "304021002", "story_v_out_304021.awb") / 1000

					if var_11_43 + var_11_35 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_43 + var_11_35
					end

					if var_11_38.prefab_name ~= "" and arg_8_1.actors_[var_11_38.prefab_name] ~= nil then
						local var_11_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_38.prefab_name].transform, "story_v_out_304021", "304021002", "story_v_out_304021.awb")

						arg_8_1:RecordAudio("304021002", var_11_44)
						arg_8_1:RecordAudio("304021002", var_11_44)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_304021", "304021002", "story_v_out_304021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_304021", "304021002", "story_v_out_304021.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_45 = math.max(var_11_36, arg_8_1.talkMaxDuration)

			if var_11_35 <= arg_8_1.time_ and arg_8_1.time_ < var_11_35 + var_11_45 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_35) / var_11_45

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_35 + var_11_45 and arg_8_1.time_ < var_11_35 + var_11_45 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play304021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304021003
		arg_12_1.duration_ = 7.97

		local var_12_0 = {
			zh = 5.733,
			ja = 7.966
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1019ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1019ui_story == nil then
				arg_12_1.var_.characterEffect1019ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1019ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1019ui_story then
				arg_12_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["1084ui_story"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_9
			end

			local var_15_10 = arg_12_1.actors_["1019ui_story"].transform
			local var_15_11 = 0

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_10.localPosition
			end

			local var_15_12 = 0.001

			if var_15_11 <= arg_12_1.time_ and arg_12_1.time_ < var_15_11 + var_15_12 then
				local var_15_13 = (arg_12_1.time_ - var_15_11) / var_15_12
				local var_15_14 = Vector3.New(-0.2, -1.08, -5.9)

				var_15_10.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, var_15_14, var_15_13)

				local var_15_15 = manager.ui.mainCamera.transform.position - var_15_10.position

				var_15_10.forward = Vector3.New(var_15_15.x, var_15_15.y, var_15_15.z)

				local var_15_16 = var_15_10.localEulerAngles

				var_15_16.z = 0
				var_15_16.x = 0
				var_15_10.localEulerAngles = var_15_16
			end

			if arg_12_1.time_ >= var_15_11 + var_15_12 and arg_12_1.time_ < var_15_11 + var_15_12 + arg_15_0 then
				var_15_10.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_15_17 = manager.ui.mainCamera.transform.position - var_15_10.position

				var_15_10.forward = Vector3.New(var_15_17.x, var_15_17.y, var_15_17.z)

				local var_15_18 = var_15_10.localEulerAngles

				var_15_18.z = 0
				var_15_18.x = 0
				var_15_10.localEulerAngles = var_15_18
			end

			local var_15_19 = arg_12_1.actors_["1084ui_story"].transform
			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_19.localPosition
			end

			local var_15_21 = 0.001

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_21 then
				local var_15_22 = (arg_12_1.time_ - var_15_20) / var_15_21
				local var_15_23 = Vector3.New(0, 100, 0)

				var_15_19.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, var_15_23, var_15_22)

				local var_15_24 = manager.ui.mainCamera.transform.position - var_15_19.position

				var_15_19.forward = Vector3.New(var_15_24.x, var_15_24.y, var_15_24.z)

				local var_15_25 = var_15_19.localEulerAngles

				var_15_25.z = 0
				var_15_25.x = 0
				var_15_19.localEulerAngles = var_15_25
			end

			if arg_12_1.time_ >= var_15_20 + var_15_21 and arg_12_1.time_ < var_15_20 + var_15_21 + arg_15_0 then
				var_15_19.localPosition = Vector3.New(0, 100, 0)

				local var_15_26 = manager.ui.mainCamera.transform.position - var_15_19.position

				var_15_19.forward = Vector3.New(var_15_26.x, var_15_26.y, var_15_26.z)

				local var_15_27 = var_15_19.localEulerAngles

				var_15_27.z = 0
				var_15_27.x = 0
				var_15_19.localEulerAngles = var_15_27
			end

			local var_15_28 = 0
			local var_15_29 = 0.7

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_30 = arg_12_1:FormatText(StoryNameCfg[13].name)

				arg_12_1.leftNameTxt_.text = var_15_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_31 = arg_12_1:GetWordFromCfg(304021003)
				local var_15_32 = arg_12_1:FormatText(var_15_31.content)

				arg_12_1.text_.text = var_15_32

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_33 = 28
				local var_15_34 = utf8.len(var_15_32)
				local var_15_35 = var_15_33 <= 0 and var_15_29 or var_15_29 * (var_15_34 / var_15_33)

				if var_15_35 > 0 and var_15_29 < var_15_35 then
					arg_12_1.talkMaxDuration = var_15_35

					if var_15_35 + var_15_28 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_35 + var_15_28
					end
				end

				arg_12_1.text_.text = var_15_32
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021003", "story_v_out_304021.awb") ~= 0 then
					local var_15_36 = manager.audio:GetVoiceLength("story_v_out_304021", "304021003", "story_v_out_304021.awb") / 1000

					if var_15_36 + var_15_28 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_36 + var_15_28
					end

					if var_15_31.prefab_name ~= "" and arg_12_1.actors_[var_15_31.prefab_name] ~= nil then
						local var_15_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_31.prefab_name].transform, "story_v_out_304021", "304021003", "story_v_out_304021.awb")

						arg_12_1:RecordAudio("304021003", var_15_37)
						arg_12_1:RecordAudio("304021003", var_15_37)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304021", "304021003", "story_v_out_304021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304021", "304021003", "story_v_out_304021.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_38 = math.max(var_15_29, arg_12_1.talkMaxDuration)

			if var_15_28 <= arg_12_1.time_ and arg_12_1.time_ < var_15_28 + var_15_38 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_28) / var_15_38

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_28 + var_15_38 and arg_12_1.time_ < var_15_28 + var_15_38 + arg_15_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play304021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304021004
		arg_16_1.duration_ = 16.1

		local var_16_0 = {
			zh = 13.5,
			ja = 16.1
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
				arg_16_0:Play304021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.675

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:GetWordFromCfg(304021004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 67
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021004", "story_v_out_304021.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021004", "story_v_out_304021.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_304021", "304021004", "story_v_out_304021.awb")

						arg_16_1:RecordAudio("304021004", var_19_9)
						arg_16_1:RecordAudio("304021004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304021", "304021004", "story_v_out_304021.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304021", "304021004", "story_v_out_304021.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play304021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304021005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play304021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1019ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

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
			local var_23_7 = 0.85

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

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(304021005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 34
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
	Play304021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304021006
		arg_24_1.duration_ = 13.5

		local var_24_0 = {
			zh = 7.5,
			ja = 13.5
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
				arg_24_0:Play304021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1019ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_27_5 = 0
			local var_27_6 = 0.875

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_7 = arg_24_1:FormatText(StoryNameCfg[13].name)

				arg_24_1.leftNameTxt_.text = var_27_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(304021006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 35
				local var_27_11 = utf8.len(var_27_9)
				local var_27_12 = var_27_10 <= 0 and var_27_6 or var_27_6 * (var_27_11 / var_27_10)

				if var_27_12 > 0 and var_27_6 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_5
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021006", "story_v_out_304021.awb") ~= 0 then
					local var_27_13 = manager.audio:GetVoiceLength("story_v_out_304021", "304021006", "story_v_out_304021.awb") / 1000

					if var_27_13 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_5
					end

					if var_27_8.prefab_name ~= "" and arg_24_1.actors_[var_27_8.prefab_name] ~= nil then
						local var_27_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_8.prefab_name].transform, "story_v_out_304021", "304021006", "story_v_out_304021.awb")

						arg_24_1:RecordAudio("304021006", var_27_14)
						arg_24_1:RecordAudio("304021006", var_27_14)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304021", "304021006", "story_v_out_304021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304021", "304021006", "story_v_out_304021.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_15 = math.max(var_27_6, arg_24_1.talkMaxDuration)

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_15 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_5) / var_27_15

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_5 + var_27_15 and arg_24_1.time_ < var_27_5 + var_27_15 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304021007
		arg_28_1.duration_ = 8.87

		local var_28_0 = {
			zh = 8.866,
			ja = 7.566
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
				arg_28_0:Play304021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.175

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:GetWordFromCfg(304021007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 47
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021007", "story_v_out_304021.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021007", "story_v_out_304021.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_304021", "304021007", "story_v_out_304021.awb")

						arg_28_1:RecordAudio("304021007", var_31_9)
						arg_28_1:RecordAudio("304021007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304021", "304021007", "story_v_out_304021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304021", "304021007", "story_v_out_304021.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304021008
		arg_32_1.duration_ = 13.3

		local var_32_0 = {
			zh = 9.266,
			ja = 13.3
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
				arg_32_0:Play304021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_2 = 0
			local var_35_3 = 1.15

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_4 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(304021008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 46
				local var_35_8 = utf8.len(var_35_6)
				local var_35_9 = var_35_7 <= 0 and var_35_3 or var_35_3 * (var_35_8 / var_35_7)

				if var_35_9 > 0 and var_35_3 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021008", "story_v_out_304021.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021008", "story_v_out_304021.awb") / 1000

					if var_35_10 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_2
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_304021", "304021008", "story_v_out_304021.awb")

						arg_32_1:RecordAudio("304021008", var_35_11)
						arg_32_1:RecordAudio("304021008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304021", "304021008", "story_v_out_304021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304021", "304021008", "story_v_out_304021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_12 and arg_32_1.time_ < var_35_2 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304021009
		arg_36_1.duration_ = 1

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"

			SetActive(arg_36_1.choicesGo_, true)

			for iter_37_0, iter_37_1 in ipairs(arg_36_1.choices_) do
				local var_37_0 = iter_37_0 <= 2

				SetActive(iter_37_1.go, var_37_0)
			end

			arg_36_1.choices_[1].txt.text = arg_36_1:FormatText(StoryChoiceCfg[1758].name)
			arg_36_1.choices_[2].txt.text = arg_36_1:FormatText(StoryChoiceCfg[1759].name)
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play304021010(arg_36_1)
			end

			if arg_38_0 == 2 then
				arg_36_0:Play304021010(arg_36_1)
			end

			arg_36_1:RecordChoiceLog(304021009, 1758, 1759)
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1019ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = var_39_5
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304021010
		arg_40_1.duration_ = 6.8

		local var_40_0 = {
			zh = 6.5,
			ja = 6.8
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
				arg_40_0:Play304021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1019ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_43_4 = 0
			local var_43_5 = 0.8

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_6 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(304021010)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 32
				local var_43_10 = utf8.len(var_43_8)
				local var_43_11 = var_43_9 <= 0 and var_43_5 or var_43_5 * (var_43_10 / var_43_9)

				if var_43_11 > 0 and var_43_5 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021010", "story_v_out_304021.awb") ~= 0 then
					local var_43_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021010", "story_v_out_304021.awb") / 1000

					if var_43_12 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_4
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_304021", "304021010", "story_v_out_304021.awb")

						arg_40_1:RecordAudio("304021010", var_43_13)
						arg_40_1:RecordAudio("304021010", var_43_13)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304021", "304021010", "story_v_out_304021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304021", "304021010", "story_v_out_304021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_14 and arg_40_1.time_ < var_43_4 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304021011
		arg_44_1.duration_ = 7.23

		local var_44_0 = {
			zh = 5.3,
			ja = 7.233
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_2 = 0
			local var_47_3 = 0.725

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_4 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:GetWordFromCfg(304021011)
				local var_47_6 = arg_44_1:FormatText(var_47_5.content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 29
				local var_47_8 = utf8.len(var_47_6)
				local var_47_9 = var_47_7 <= 0 and var_47_3 or var_47_3 * (var_47_8 / var_47_7)

				if var_47_9 > 0 and var_47_3 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021011", "story_v_out_304021.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021011", "story_v_out_304021.awb") / 1000

					if var_47_10 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_2
					end

					if var_47_5.prefab_name ~= "" and arg_44_1.actors_[var_47_5.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_5.prefab_name].transform, "story_v_out_304021", "304021011", "story_v_out_304021.awb")

						arg_44_1:RecordAudio("304021011", var_47_11)
						arg_44_1:RecordAudio("304021011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304021", "304021011", "story_v_out_304021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304021", "304021011", "story_v_out_304021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_12 and arg_44_1.time_ < var_47_2 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304021012
		arg_48_1.duration_ = 5

		local var_48_0 = {
			zh = 5,
			ja = 1.999999999999
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
				arg_48_0:Play304021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, -0.97, -6)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["1019ui_story"].transform
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.var_.moveOldPos1019ui_story = var_51_9.localPosition
			end

			local var_51_11 = 0.001

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_11 then
				local var_51_12 = (arg_48_1.time_ - var_51_10) / var_51_11
				local var_51_13 = Vector3.New(0, 100, 0)

				var_51_9.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1019ui_story, var_51_13, var_51_12)

				local var_51_14 = manager.ui.mainCamera.transform.position - var_51_9.position

				var_51_9.forward = Vector3.New(var_51_14.x, var_51_14.y, var_51_14.z)

				local var_51_15 = var_51_9.localEulerAngles

				var_51_15.z = 0
				var_51_15.x = 0
				var_51_9.localEulerAngles = var_51_15
			end

			if arg_48_1.time_ >= var_51_10 + var_51_11 and arg_48_1.time_ < var_51_10 + var_51_11 + arg_51_0 then
				var_51_9.localPosition = Vector3.New(0, 100, 0)

				local var_51_16 = manager.ui.mainCamera.transform.position - var_51_9.position

				var_51_9.forward = Vector3.New(var_51_16.x, var_51_16.y, var_51_16.z)

				local var_51_17 = var_51_9.localEulerAngles

				var_51_17.z = 0
				var_51_17.x = 0
				var_51_9.localEulerAngles = var_51_17
			end

			local var_51_18 = arg_48_1.actors_["1084ui_story"]
			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 and not isNil(var_51_18) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_20 = 0.200000002980232

			if var_51_19 <= arg_48_1.time_ and arg_48_1.time_ < var_51_19 + var_51_20 and not isNil(var_51_18) then
				local var_51_21 = (arg_48_1.time_ - var_51_19) / var_51_20

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_18) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_19 + var_51_20 and arg_48_1.time_ < var_51_19 + var_51_20 + arg_51_0 and not isNil(var_51_18) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_22 = arg_48_1.actors_["1019ui_story"]
			local var_51_23 = 0

			if var_51_23 < arg_48_1.time_ and arg_48_1.time_ <= var_51_23 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_24 = 0.200000002980232

			if var_51_23 <= arg_48_1.time_ and arg_48_1.time_ < var_51_23 + var_51_24 and not isNil(var_51_22) then
				local var_51_25 = (arg_48_1.time_ - var_51_23) / var_51_24

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_22) then
					local var_51_26 = Mathf.Lerp(0, 0.5, var_51_25)

					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_26
				end
			end

			if arg_48_1.time_ >= var_51_23 + var_51_24 and arg_48_1.time_ < var_51_23 + var_51_24 + arg_51_0 and not isNil(var_51_22) and arg_48_1.var_.characterEffect1019ui_story then
				local var_51_27 = 0.5

				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_27
			end

			local var_51_28 = 0

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_51_29 = 0

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_30 = 0
			local var_51_31 = 0.325

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_32 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_33 = arg_48_1:GetWordFromCfg(304021012)
				local var_51_34 = arg_48_1:FormatText(var_51_33.content)

				arg_48_1.text_.text = var_51_34

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_35 = 13
				local var_51_36 = utf8.len(var_51_34)
				local var_51_37 = var_51_35 <= 0 and var_51_31 or var_51_31 * (var_51_36 / var_51_35)

				if var_51_37 > 0 and var_51_31 < var_51_37 then
					arg_48_1.talkMaxDuration = var_51_37

					if var_51_37 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_37 + var_51_30
					end
				end

				arg_48_1.text_.text = var_51_34
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021012", "story_v_out_304021.awb") ~= 0 then
					local var_51_38 = manager.audio:GetVoiceLength("story_v_out_304021", "304021012", "story_v_out_304021.awb") / 1000

					if var_51_38 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_38 + var_51_30
					end

					if var_51_33.prefab_name ~= "" and arg_48_1.actors_[var_51_33.prefab_name] ~= nil then
						local var_51_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_33.prefab_name].transform, "story_v_out_304021", "304021012", "story_v_out_304021.awb")

						arg_48_1:RecordAudio("304021012", var_51_39)
						arg_48_1:RecordAudio("304021012", var_51_39)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304021", "304021012", "story_v_out_304021.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304021", "304021012", "story_v_out_304021.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_40 = math.max(var_51_31, arg_48_1.talkMaxDuration)

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_40 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_30) / var_51_40

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_30 + var_51_40 and arg_48_1.time_ < var_51_30 + var_51_40 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304021013
		arg_52_1.duration_ = 7.67

		local var_52_0 = {
			zh = 5,
			ja = 7.666
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
				arg_52_0:Play304021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1084ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_5
			end

			local var_55_6 = arg_52_1.actors_["1084ui_story"].transform
			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.var_.moveOldPos1084ui_story = var_55_6.localPosition
			end

			local var_55_8 = 0.001

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_8 then
				local var_55_9 = (arg_52_1.time_ - var_55_7) / var_55_8
				local var_55_10 = Vector3.New(0, 100, 0)

				var_55_6.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1084ui_story, var_55_10, var_55_9)

				local var_55_11 = manager.ui.mainCamera.transform.position - var_55_6.position

				var_55_6.forward = Vector3.New(var_55_11.x, var_55_11.y, var_55_11.z)

				local var_55_12 = var_55_6.localEulerAngles

				var_55_12.z = 0
				var_55_12.x = 0
				var_55_6.localEulerAngles = var_55_12
			end

			if arg_52_1.time_ >= var_55_7 + var_55_8 and arg_52_1.time_ < var_55_7 + var_55_8 + arg_55_0 then
				var_55_6.localPosition = Vector3.New(0, 100, 0)

				local var_55_13 = manager.ui.mainCamera.transform.position - var_55_6.position

				var_55_6.forward = Vector3.New(var_55_13.x, var_55_13.y, var_55_13.z)

				local var_55_14 = var_55_6.localEulerAngles

				var_55_14.z = 0
				var_55_14.x = 0
				var_55_6.localEulerAngles = var_55_14
			end

			local var_55_15 = 0
			local var_55_16 = 0.325

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[36].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_18 = arg_52_1:GetWordFromCfg(304021013)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 13
				local var_55_21 = utf8.len(var_55_19)
				local var_55_22 = var_55_20 <= 0 and var_55_16 or var_55_16 * (var_55_21 / var_55_20)

				if var_55_22 > 0 and var_55_16 < var_55_22 then
					arg_52_1.talkMaxDuration = var_55_22

					if var_55_22 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_22 + var_55_15
					end
				end

				arg_52_1.text_.text = var_55_19
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021013", "story_v_out_304021.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_304021", "304021013", "story_v_out_304021.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_304021", "304021013", "story_v_out_304021.awb")

						arg_52_1:RecordAudio("304021013", var_55_24)
						arg_52_1:RecordAudio("304021013", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304021", "304021013", "story_v_out_304021.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304021", "304021013", "story_v_out_304021.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_16, arg_52_1.talkMaxDuration)

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_15) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_15 + var_55_25 and arg_52_1.time_ < var_55_15 + var_55_25 + arg_55_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play304021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304021014
		arg_56_1.duration_ = 3.07

		local var_56_0 = {
			zh = 3.066,
			ja = 2.4
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
				arg_56_0:Play304021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1019ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1019ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1019ui_story then
				arg_56_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_15 = 0
			local var_59_16 = 0.275

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[13].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(304021014)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 11
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021014", "story_v_out_304021.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_304021", "304021014", "story_v_out_304021.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_304021", "304021014", "story_v_out_304021.awb")

						arg_56_1:RecordAudio("304021014", var_59_24)
						arg_56_1:RecordAudio("304021014", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304021", "304021014", "story_v_out_304021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304021", "304021014", "story_v_out_304021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play304021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304021015
		arg_60_1.duration_ = 2.97

		local var_60_0 = {
			zh = 2.966,
			ja = 2.533
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
				arg_60_0:Play304021016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "1011ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_60_1.stage_.transform)

					var_63_2.name = var_63_0
					var_63_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_0] = var_63_2

					local var_63_3 = var_63_2:GetComponentInChildren(typeof(CharacterEffect))

					var_63_3.enabled = true

					local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_2, typeof(DynamicBoneHelper))

					if var_63_4 then
						var_63_4:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_3.transform, false)

					arg_60_1.var_[var_63_0 .. "Animator"] = var_63_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_0 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_0 .. "LipSync"] = var_63_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_5 = arg_60_1.actors_["1011ui_story"].transform
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.var_.moveOldPos1011ui_story = var_63_5.localPosition
			end

			local var_63_7 = 0.001

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 then
				local var_63_8 = (arg_60_1.time_ - var_63_6) / var_63_7
				local var_63_9 = Vector3.New(0, 100, 0)

				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1011ui_story, var_63_9, var_63_8)

				local var_63_10 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_10.x, var_63_10.y, var_63_10.z)

				local var_63_11 = var_63_5.localEulerAngles

				var_63_11.z = 0
				var_63_11.x = 0
				var_63_5.localEulerAngles = var_63_11
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(0, 100, 0)

				local var_63_12 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_12.x, var_63_12.y, var_63_12.z)

				local var_63_13 = var_63_5.localEulerAngles

				var_63_13.z = 0
				var_63_13.x = 0
				var_63_5.localEulerAngles = var_63_13
			end

			local var_63_14 = arg_60_1.actors_["1019ui_story"].transform
			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_14.localPosition
			end

			local var_63_16 = 0.001

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_16 then
				local var_63_17 = (arg_60_1.time_ - var_63_15) / var_63_16
				local var_63_18 = Vector3.New(0, 100, 0)

				var_63_14.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, var_63_18, var_63_17)

				local var_63_19 = manager.ui.mainCamera.transform.position - var_63_14.position

				var_63_14.forward = Vector3.New(var_63_19.x, var_63_19.y, var_63_19.z)

				local var_63_20 = var_63_14.localEulerAngles

				var_63_20.z = 0
				var_63_20.x = 0
				var_63_14.localEulerAngles = var_63_20
			end

			if arg_60_1.time_ >= var_63_15 + var_63_16 and arg_60_1.time_ < var_63_15 + var_63_16 + arg_63_0 then
				var_63_14.localPosition = Vector3.New(0, 100, 0)

				local var_63_21 = manager.ui.mainCamera.transform.position - var_63_14.position

				var_63_14.forward = Vector3.New(var_63_21.x, var_63_21.y, var_63_21.z)

				local var_63_22 = var_63_14.localEulerAngles

				var_63_22.z = 0
				var_63_22.x = 0
				var_63_14.localEulerAngles = var_63_22
			end

			local var_63_23 = arg_60_1.actors_["1011ui_story"]
			local var_63_24 = 0

			if var_63_24 < arg_60_1.time_ and arg_60_1.time_ <= var_63_24 + arg_63_0 and not isNil(var_63_23) and arg_60_1.var_.characterEffect1011ui_story == nil then
				arg_60_1.var_.characterEffect1011ui_story = var_63_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_25 = 0.200000002980232

			if var_63_24 <= arg_60_1.time_ and arg_60_1.time_ < var_63_24 + var_63_25 and not isNil(var_63_23) then
				local var_63_26 = (arg_60_1.time_ - var_63_24) / var_63_25

				if arg_60_1.var_.characterEffect1011ui_story and not isNil(var_63_23) then
					arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_24 + var_63_25 and arg_60_1.time_ < var_63_24 + var_63_25 + arg_63_0 and not isNil(var_63_23) and arg_60_1.var_.characterEffect1011ui_story then
				arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_63_27 = arg_60_1.actors_["1019ui_story"]
			local var_63_28 = 0

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 and not isNil(var_63_27) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_29 = 0.200000002980232

			if var_63_28 <= arg_60_1.time_ and arg_60_1.time_ < var_63_28 + var_63_29 and not isNil(var_63_27) then
				local var_63_30 = (arg_60_1.time_ - var_63_28) / var_63_29

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_27) then
					local var_63_31 = Mathf.Lerp(0, 0.5, var_63_30)

					arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1019ui_story.fillRatio = var_63_31
				end
			end

			if arg_60_1.time_ >= var_63_28 + var_63_29 and arg_60_1.time_ < var_63_28 + var_63_29 + arg_63_0 and not isNil(var_63_27) and arg_60_1.var_.characterEffect1019ui_story then
				local var_63_32 = 0.5

				arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1019ui_story.fillRatio = var_63_32
			end

			local var_63_33 = 0

			if var_63_33 < arg_60_1.time_ and arg_60_1.time_ <= var_63_33 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_63_34 = 0

			if var_63_34 < arg_60_1.time_ and arg_60_1.time_ <= var_63_34 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_63_35 = 0.1
			local var_63_36 = 1

			if var_63_35 < arg_60_1.time_ and arg_60_1.time_ <= var_63_35 + arg_63_0 then
				local var_63_37 = "play"
				local var_63_38 = "effect"

				arg_60_1:AudioAction(var_63_37, var_63_38, "se_story_144", "se_story_144_door_open", "")
			end

			local var_63_39 = 0
			local var_63_40 = 0.175

			if var_63_39 < arg_60_1.time_ and arg_60_1.time_ <= var_63_39 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_41 = arg_60_1:FormatText(StoryNameCfg[37].name)

				arg_60_1.leftNameTxt_.text = var_63_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_42 = arg_60_1:GetWordFromCfg(304021015)
				local var_63_43 = arg_60_1:FormatText(var_63_42.content)

				arg_60_1.text_.text = var_63_43

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_44 = 7
				local var_63_45 = utf8.len(var_63_43)
				local var_63_46 = var_63_44 <= 0 and var_63_40 or var_63_40 * (var_63_45 / var_63_44)

				if var_63_46 > 0 and var_63_40 < var_63_46 then
					arg_60_1.talkMaxDuration = var_63_46

					if var_63_46 + var_63_39 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_46 + var_63_39
					end
				end

				arg_60_1.text_.text = var_63_43
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021015", "story_v_out_304021.awb") ~= 0 then
					local var_63_47 = manager.audio:GetVoiceLength("story_v_out_304021", "304021015", "story_v_out_304021.awb") / 1000

					if var_63_47 + var_63_39 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_47 + var_63_39
					end

					if var_63_42.prefab_name ~= "" and arg_60_1.actors_[var_63_42.prefab_name] ~= nil then
						local var_63_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_42.prefab_name].transform, "story_v_out_304021", "304021015", "story_v_out_304021.awb")

						arg_60_1:RecordAudio("304021015", var_63_48)
						arg_60_1:RecordAudio("304021015", var_63_48)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304021", "304021015", "story_v_out_304021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304021", "304021015", "story_v_out_304021.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_49 = math.max(var_63_40, arg_60_1.talkMaxDuration)

			if var_63_39 <= arg_60_1.time_ and arg_60_1.time_ < var_63_39 + var_63_49 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_39) / var_63_49

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_39 + var_63_49 and arg_60_1.time_ < var_63_39 + var_63_49 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304021016
		arg_64_1.duration_ = 8.63

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "S0101"

			if arg_64_1.bgs_[var_67_0] == nil then
				local var_67_1 = Object.Instantiate(arg_64_1.paintGo_)

				var_67_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_67_0)
				var_67_1.name = var_67_0
				var_67_1.transform.parent = arg_64_1.stage_.transform
				var_67_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.bgs_[var_67_0] = var_67_1
			end

			local var_67_2 = 2

			if var_67_2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				local var_67_3 = manager.ui.mainCamera.transform.localPosition
				local var_67_4 = Vector3.New(0, 0, 10) + Vector3.New(var_67_3.x, var_67_3.y, 0)
				local var_67_5 = arg_64_1.bgs_.S0101

				var_67_5.transform.localPosition = var_67_4
				var_67_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_6 = var_67_5:GetComponent("SpriteRenderer")

				if var_67_6 and var_67_6.sprite then
					local var_67_7 = (var_67_5.transform.localPosition - var_67_3).z
					local var_67_8 = manager.ui.mainCameraCom_
					local var_67_9 = 2 * var_67_7 * Mathf.Tan(var_67_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_67_10 = var_67_9 * var_67_8.aspect
					local var_67_11 = var_67_6.sprite.bounds.size.x
					local var_67_12 = var_67_6.sprite.bounds.size.y
					local var_67_13 = var_67_10 / var_67_11
					local var_67_14 = var_67_9 / var_67_12
					local var_67_15 = var_67_14 < var_67_13 and var_67_13 or var_67_14

					var_67_5.transform.localScale = Vector3.New(var_67_15, var_67_15, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "S0101" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			local var_67_17 = 0.3

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_19 = 2

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_19 then
				local var_67_20 = (arg_64_1.time_ - var_67_18) / var_67_19
				local var_67_21 = Color.New(0, 0, 0)

				var_67_21.a = Mathf.Lerp(0, 1, var_67_20)
				arg_64_1.mask_.color = var_67_21
			end

			if arg_64_1.time_ >= var_67_18 + var_67_19 and arg_64_1.time_ < var_67_18 + var_67_19 + arg_67_0 then
				local var_67_22 = Color.New(0, 0, 0)

				var_67_22.a = 1
				arg_64_1.mask_.color = var_67_22
			end

			local var_67_23 = 2

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_24 = 2

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24
				local var_67_26 = Color.New(0, 0, 0)

				var_67_26.a = Mathf.Lerp(1, 0, var_67_25)
				arg_64_1.mask_.color = var_67_26
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 then
				local var_67_27 = Color.New(0, 0, 0)
				local var_67_28 = 0

				arg_64_1.mask_.enabled = false
				var_67_27.a = var_67_28
				arg_64_1.mask_.color = var_67_27
			end

			local var_67_29 = arg_64_1.actors_["1011ui_story"].transform
			local var_67_30 = 2

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_29.localPosition
			end

			local var_67_31 = 0.001

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_31 then
				local var_67_32 = (arg_64_1.time_ - var_67_30) / var_67_31
				local var_67_33 = Vector3.New(0, 100, 0)

				var_67_29.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, var_67_33, var_67_32)

				local var_67_34 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_34.x, var_67_34.y, var_67_34.z)

				local var_67_35 = var_67_29.localEulerAngles

				var_67_35.z = 0
				var_67_35.x = 0
				var_67_29.localEulerAngles = var_67_35
			end

			if arg_64_1.time_ >= var_67_30 + var_67_31 and arg_64_1.time_ < var_67_30 + var_67_31 + arg_67_0 then
				var_67_29.localPosition = Vector3.New(0, 100, 0)

				local var_67_36 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_36.x, var_67_36.y, var_67_36.z)

				local var_67_37 = var_67_29.localEulerAngles

				var_67_37.z = 0
				var_67_37.x = 0
				var_67_29.localEulerAngles = var_67_37
			end

			local var_67_38 = arg_64_1.actors_["1011ui_story"]
			local var_67_39 = 2

			if var_67_39 < arg_64_1.time_ and arg_64_1.time_ <= var_67_39 + arg_67_0 and not isNil(var_67_38) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_40 = 0.200000002980232

			if var_67_39 <= arg_64_1.time_ and arg_64_1.time_ < var_67_39 + var_67_40 and not isNil(var_67_38) then
				local var_67_41 = (arg_64_1.time_ - var_67_39) / var_67_40

				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_38) then
					local var_67_42 = Mathf.Lerp(0, 0.5, var_67_41)

					arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1011ui_story.fillRatio = var_67_42
				end
			end

			if arg_64_1.time_ >= var_67_39 + var_67_40 and arg_64_1.time_ < var_67_39 + var_67_40 + arg_67_0 and not isNil(var_67_38) and arg_64_1.var_.characterEffect1011ui_story then
				local var_67_43 = 0.5

				arg_64_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1011ui_story.fillRatio = var_67_43
			end

			local var_67_44 = arg_64_1.bgs_.S0101.transform
			local var_67_45 = 2

			if var_67_45 < arg_64_1.time_ and arg_64_1.time_ <= var_67_45 + arg_67_0 then
				arg_64_1.var_.moveOldPosS0101 = var_67_44.localPosition
			end

			local var_67_46 = 2

			if var_67_45 <= arg_64_1.time_ and arg_64_1.time_ < var_67_45 + var_67_46 then
				local var_67_47 = (arg_64_1.time_ - var_67_45) / var_67_46
				local var_67_48 = Vector3.New(0, 1.09, 9)

				var_67_44.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPosS0101, var_67_48, var_67_47)
			end

			if arg_64_1.time_ >= var_67_45 + var_67_46 and arg_64_1.time_ < var_67_45 + var_67_46 + arg_67_0 then
				var_67_44.localPosition = Vector3.New(0, 1.09, 9)
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_49 = 3.63333333333333
			local var_67_50 = 0.6

			if var_67_49 < arg_64_1.time_ and arg_64_1.time_ <= var_67_49 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_51 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_51:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_52 = arg_64_1:GetWordFromCfg(304021016)
				local var_67_53 = arg_64_1:FormatText(var_67_52.content)

				arg_64_1.text_.text = var_67_53

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_54 = 24
				local var_67_55 = utf8.len(var_67_53)
				local var_67_56 = var_67_54 <= 0 and var_67_50 or var_67_50 * (var_67_55 / var_67_54)

				if var_67_56 > 0 and var_67_50 < var_67_56 then
					arg_64_1.talkMaxDuration = var_67_56
					var_67_49 = var_67_49 + 0.3

					if var_67_56 + var_67_49 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_56 + var_67_49
					end
				end

				arg_64_1.text_.text = var_67_53
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_57 = var_67_49 + 0.3
			local var_67_58 = math.max(var_67_50, arg_64_1.talkMaxDuration)

			if var_67_57 <= arg_64_1.time_ and arg_64_1.time_ < var_67_57 + var_67_58 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_57) / var_67_58

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_57 + var_67_58 and arg_64_1.time_ < var_67_57 + var_67_58 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0101",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 6.23),
					endPos = Vector3.New(0, 1.09, 9),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play304021017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304021017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play304021018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.75

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(304021017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 70
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play304021018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304021018
		arg_74_1.duration_ = 6.77

		local var_74_0 = {
			zh = 5.433,
			ja = 6.766
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play304021019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.775

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[13].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(304021018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 28
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021018", "story_v_out_304021.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021018", "story_v_out_304021.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_304021", "304021018", "story_v_out_304021.awb")

						arg_74_1:RecordAudio("304021018", var_77_9)
						arg_74_1:RecordAudio("304021018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_304021", "304021018", "story_v_out_304021.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_304021", "304021018", "story_v_out_304021.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304021019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 304021019
		arg_78_1.duration_ = 7.67

		local var_78_0 = {
			zh = 7.333,
			ja = 7.666
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
				arg_78_0:Play304021020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1019ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1019ui_story == nil then
				arg_78_1.var_.characterEffect1019ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1019ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1019ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1019ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1019ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0
			local var_81_7 = 0.725

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[37].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_9 = arg_78_1:GetWordFromCfg(304021019)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 29
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021019", "story_v_out_304021.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021019", "story_v_out_304021.awb") / 1000

					if var_81_14 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_6
					end

					if var_81_9.prefab_name ~= "" and arg_78_1.actors_[var_81_9.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_9.prefab_name].transform, "story_v_out_304021", "304021019", "story_v_out_304021.awb")

						arg_78_1:RecordAudio("304021019", var_81_15)
						arg_78_1:RecordAudio("304021019", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_304021", "304021019", "story_v_out_304021.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_304021", "304021019", "story_v_out_304021.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_16 and arg_78_1.time_ < var_81_6 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play304021020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 304021020
		arg_82_1.duration_ = 1

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"

			SetActive(arg_82_1.choicesGo_, true)

			for iter_83_0, iter_83_1 in ipairs(arg_82_1.choices_) do
				local var_83_0 = iter_83_0 <= 2

				SetActive(iter_83_1.go, var_83_0)
			end

			arg_82_1.choices_[1].txt.text = arg_82_1:FormatText(StoryChoiceCfg[1760].name)
			arg_82_1.choices_[2].txt.text = arg_82_1:FormatText(StoryChoiceCfg[1761].name)
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play304021021(arg_82_1)
			end

			if arg_84_0 == 2 then
				arg_82_0:Play304021022(arg_82_1)
			end

			arg_82_1:RecordChoiceLog(304021020, 1760, 1761)
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			return
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play304021021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 304021021
		arg_86_1.duration_ = 8.43

		local var_86_0 = {
			zh = 7,
			ja = 8.433
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
				arg_86_0:Play304021024(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1019ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1019ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1019ui_story then
				arg_86_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_89_4 = 0
			local var_89_5 = 0.75

			if var_89_4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_6 = arg_86_1:FormatText(StoryNameCfg[13].name)

				arg_86_1.leftNameTxt_.text = var_89_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_7 = arg_86_1:GetWordFromCfg(304021021)
				local var_89_8 = arg_86_1:FormatText(var_89_7.content)

				arg_86_1.text_.text = var_89_8

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 30
				local var_89_10 = utf8.len(var_89_8)
				local var_89_11 = var_89_9 <= 0 and var_89_5 or var_89_5 * (var_89_10 / var_89_9)

				if var_89_11 > 0 and var_89_5 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_8
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021021", "story_v_out_304021.awb") ~= 0 then
					local var_89_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021021", "story_v_out_304021.awb") / 1000

					if var_89_12 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_4
					end

					if var_89_7.prefab_name ~= "" and arg_86_1.actors_[var_89_7.prefab_name] ~= nil then
						local var_89_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_7.prefab_name].transform, "story_v_out_304021", "304021021", "story_v_out_304021.awb")

						arg_86_1:RecordAudio("304021021", var_89_13)
						arg_86_1:RecordAudio("304021021", var_89_13)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_304021", "304021021", "story_v_out_304021.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_304021", "304021021", "story_v_out_304021.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_14 and arg_86_1.time_ < var_89_4 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play304021024 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304021024
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play304021025(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1011ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1011ui_story == nil then
				arg_90_1.var_.characterEffect1011ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1011ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1011ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1011ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1011ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.425

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(304021024)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 17
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304021025 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 304021025
		arg_94_1.duration_ = 5.3

		local var_94_0 = {
			zh = 5.3,
			ja = 5.033
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play304021026(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.5

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(304021025)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 20
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021025", "story_v_out_304021.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021025", "story_v_out_304021.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_304021", "304021025", "story_v_out_304021.awb")

						arg_94_1:RecordAudio("304021025", var_97_9)
						arg_94_1:RecordAudio("304021025", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_304021", "304021025", "story_v_out_304021.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_304021", "304021025", "story_v_out_304021.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play304021026 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 304021026
		arg_98_1.duration_ = 4.23

		local var_98_0 = {
			zh = 4,
			ja = 4.233
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play304021027(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.525

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[6].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(304021026)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 21
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021026", "story_v_out_304021.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021026", "story_v_out_304021.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_304021", "304021026", "story_v_out_304021.awb")

						arg_98_1:RecordAudio("304021026", var_101_9)
						arg_98_1:RecordAudio("304021026", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_304021", "304021026", "story_v_out_304021.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_304021", "304021026", "story_v_out_304021.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play304021027 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 304021027
		arg_102_1.duration_ = 6.2

		local var_102_0 = {
			zh = 3.9,
			ja = 6.2
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
				arg_102_0:Play304021028(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.475

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[37].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:GetWordFromCfg(304021027)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 19
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021027", "story_v_out_304021.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021027", "story_v_out_304021.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_304021", "304021027", "story_v_out_304021.awb")

						arg_102_1:RecordAudio("304021027", var_105_9)
						arg_102_1:RecordAudio("304021027", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_304021", "304021027", "story_v_out_304021.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_304021", "304021027", "story_v_out_304021.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play304021028 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 304021028
		arg_106_1.duration_ = 7.27

		local var_106_0 = {
			zh = 6.6,
			ja = 7.266
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
				arg_106_0:Play304021029(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.85

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[6].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(304021028)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 34
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021028", "story_v_out_304021.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021028", "story_v_out_304021.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_304021", "304021028", "story_v_out_304021.awb")

						arg_106_1:RecordAudio("304021028", var_109_9)
						arg_106_1:RecordAudio("304021028", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_304021", "304021028", "story_v_out_304021.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_304021", "304021028", "story_v_out_304021.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play304021029 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 304021029
		arg_110_1.duration_ = 8.07

		local var_110_0 = {
			zh = 6,
			ja = 8.066
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play304021030(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.725

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[13].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(304021029)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 29
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021029", "story_v_out_304021.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021029", "story_v_out_304021.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_304021", "304021029", "story_v_out_304021.awb")

						arg_110_1:RecordAudio("304021029", var_113_9)
						arg_110_1:RecordAudio("304021029", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_304021", "304021029", "story_v_out_304021.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_304021", "304021029", "story_v_out_304021.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play304021030 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 304021030
		arg_114_1.duration_ = 7.41

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play304021031(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.325

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				local var_117_1 = manager.ui.mainCamera.transform.localPosition
				local var_117_2 = Vector3.New(0, 0, 10) + Vector3.New(var_117_1.x, var_117_1.y, 0)
				local var_117_3 = arg_114_1.bgs_.A00

				var_117_3.transform.localPosition = var_117_2
				var_117_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_4 = var_117_3:GetComponent("SpriteRenderer")

				if var_117_4 and var_117_4.sprite then
					local var_117_5 = (var_117_3.transform.localPosition - var_117_1).z
					local var_117_6 = manager.ui.mainCameraCom_
					local var_117_7 = 2 * var_117_5 * Mathf.Tan(var_117_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_8 = var_117_7 * var_117_6.aspect
					local var_117_9 = var_117_4.sprite.bounds.size.x
					local var_117_10 = var_117_4.sprite.bounds.size.y
					local var_117_11 = var_117_8 / var_117_9
					local var_117_12 = var_117_7 / var_117_10
					local var_117_13 = var_117_12 < var_117_11 and var_117_11 or var_117_12

					var_117_3.transform.localScale = Vector3.New(var_117_13, var_117_13, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "A00" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_14 = 0

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			local var_117_15 = 0.3

			if arg_114_1.time_ >= var_117_14 + var_117_15 and arg_114_1.time_ < var_117_14 + var_117_15 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_16 = 0

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_17 = 1.325

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_17 then
				local var_117_18 = (arg_114_1.time_ - var_117_16) / var_117_17
				local var_117_19 = Color.New(0, 0, 0)

				var_117_19.a = Mathf.Lerp(0, 1, var_117_18)
				arg_114_1.mask_.color = var_117_19
			end

			if arg_114_1.time_ >= var_117_16 + var_117_17 and arg_114_1.time_ < var_117_16 + var_117_17 + arg_117_0 then
				local var_117_20 = Color.New(0, 0, 0)

				var_117_20.a = 1
				arg_114_1.mask_.color = var_117_20
			end

			local var_117_21 = 1.325

			if var_117_21 < arg_114_1.time_ and arg_114_1.time_ <= var_117_21 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_22 = 2

			if var_117_21 <= arg_114_1.time_ and arg_114_1.time_ < var_117_21 + var_117_22 then
				local var_117_23 = (arg_114_1.time_ - var_117_21) / var_117_22
				local var_117_24 = Color.New(0, 0, 0)

				var_117_24.a = Mathf.Lerp(1, 0, var_117_23)
				arg_114_1.mask_.color = var_117_24
			end

			if arg_114_1.time_ >= var_117_21 + var_117_22 and arg_114_1.time_ < var_117_21 + var_117_22 + arg_117_0 then
				local var_117_25 = Color.New(0, 0, 0)
				local var_117_26 = 0

				arg_114_1.mask_.enabled = false
				var_117_25.a = var_117_26
				arg_114_1.mask_.color = var_117_25
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_27 = 2.41302393882846
			local var_117_28 = 0.675

			if var_117_27 < arg_114_1.time_ and arg_114_1.time_ <= var_117_27 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_29 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_29:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_30 = arg_114_1:GetWordFromCfg(304021030)
				local var_117_31 = arg_114_1:FormatText(var_117_30.content)

				arg_114_1.text_.text = var_117_31

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_32 = 27
				local var_117_33 = utf8.len(var_117_31)
				local var_117_34 = var_117_32 <= 0 and var_117_28 or var_117_28 * (var_117_33 / var_117_32)

				if var_117_34 > 0 and var_117_28 < var_117_34 then
					arg_114_1.talkMaxDuration = var_117_34
					var_117_27 = var_117_27 + 0.3

					if var_117_34 + var_117_27 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_34 + var_117_27
					end
				end

				arg_114_1.text_.text = var_117_31
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_35 = var_117_27 + 0.3
			local var_117_36 = math.max(var_117_28, arg_114_1.talkMaxDuration)

			if var_117_35 <= arg_114_1.time_ and arg_114_1.time_ < var_117_35 + var_117_36 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_35) / var_117_36

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_35 + var_117_36 and arg_114_1.time_ < var_117_35 + var_117_36 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play304021031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 304021031
		arg_120_1.duration_ = 10.6

		local var_120_0 = {
			zh = 10.033,
			ja = 10.6
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
				arg_120_0:Play304021032(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1019ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1019ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1019ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1019ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_9) then
					arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1019ui_story then
				arg_120_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_123_13 = 0

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_15 = 0
			local var_123_16 = 1.35

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[13].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(304021031)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 54
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021031", "story_v_out_304021.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_304021", "304021031", "story_v_out_304021.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_304021", "304021031", "story_v_out_304021.awb")

						arg_120_1:RecordAudio("304021031", var_123_24)
						arg_120_1:RecordAudio("304021031", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_304021", "304021031", "story_v_out_304021.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_304021", "304021031", "story_v_out_304021.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play304021032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 304021032
		arg_124_1.duration_ = 7.5

		local var_124_0 = {
			zh = 7.5,
			ja = 5.933
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
				arg_124_0:Play304021033(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.95

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[13].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(304021032)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021032", "story_v_out_304021.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021032", "story_v_out_304021.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_304021", "304021032", "story_v_out_304021.awb")

						arg_124_1:RecordAudio("304021032", var_127_9)
						arg_124_1:RecordAudio("304021032", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_304021", "304021032", "story_v_out_304021.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_304021", "304021032", "story_v_out_304021.awb")
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
	Play304021033 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 304021033
		arg_128_1.duration_ = 11.47

		local var_128_0 = {
			zh = 11.466,
			ja = 11.266
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
				arg_128_0:Play304021034(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 1.425

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[13].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(304021033)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 57
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021033", "story_v_out_304021.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021033", "story_v_out_304021.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_out_304021", "304021033", "story_v_out_304021.awb")

						arg_128_1:RecordAudio("304021033", var_131_9)
						arg_128_1:RecordAudio("304021033", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_304021", "304021033", "story_v_out_304021.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_304021", "304021033", "story_v_out_304021.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play304021034 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 304021034
		arg_132_1.duration_ = 2.23

		local var_132_0 = {
			zh = 2.233,
			ja = 1.999999999999
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
				arg_132_0:Play304021035(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1084ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1084ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0.7, -0.97, -6)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1084ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1084ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_9) then
					arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1084ui_story then
				arg_132_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_135_13 = arg_132_1.actors_["1019ui_story"]
			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 and not isNil(var_135_13) and arg_132_1.var_.characterEffect1019ui_story == nil then
				arg_132_1.var_.characterEffect1019ui_story = var_135_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_15 = 0.200000002980232

			if var_135_14 <= arg_132_1.time_ and arg_132_1.time_ < var_135_14 + var_135_15 and not isNil(var_135_13) then
				local var_135_16 = (arg_132_1.time_ - var_135_14) / var_135_15

				if arg_132_1.var_.characterEffect1019ui_story and not isNil(var_135_13) then
					local var_135_17 = Mathf.Lerp(0, 0.5, var_135_16)

					arg_132_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1019ui_story.fillRatio = var_135_17
				end
			end

			if arg_132_1.time_ >= var_135_14 + var_135_15 and arg_132_1.time_ < var_135_14 + var_135_15 + arg_135_0 and not isNil(var_135_13) and arg_132_1.var_.characterEffect1019ui_story then
				local var_135_18 = 0.5

				arg_132_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1019ui_story.fillRatio = var_135_18
			end

			local var_135_19 = 0

			if var_135_19 < arg_132_1.time_ and arg_132_1.time_ <= var_135_19 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_135_20 = 0

			if var_135_20 < arg_132_1.time_ and arg_132_1.time_ <= var_135_20 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_135_21 = arg_132_1.actors_["1019ui_story"].transform
			local var_135_22 = 0

			if var_135_22 < arg_132_1.time_ and arg_132_1.time_ <= var_135_22 + arg_135_0 then
				arg_132_1.var_.moveOldPos1019ui_story = var_135_21.localPosition
			end

			local var_135_23 = 0.001

			if var_135_22 <= arg_132_1.time_ and arg_132_1.time_ < var_135_22 + var_135_23 then
				local var_135_24 = (arg_132_1.time_ - var_135_22) / var_135_23
				local var_135_25 = Vector3.New(-0.7, -1.08, -5.9)

				var_135_21.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1019ui_story, var_135_25, var_135_24)

				local var_135_26 = manager.ui.mainCamera.transform.position - var_135_21.position

				var_135_21.forward = Vector3.New(var_135_26.x, var_135_26.y, var_135_26.z)

				local var_135_27 = var_135_21.localEulerAngles

				var_135_27.z = 0
				var_135_27.x = 0
				var_135_21.localEulerAngles = var_135_27
			end

			if arg_132_1.time_ >= var_135_22 + var_135_23 and arg_132_1.time_ < var_135_22 + var_135_23 + arg_135_0 then
				var_135_21.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_135_28 = manager.ui.mainCamera.transform.position - var_135_21.position

				var_135_21.forward = Vector3.New(var_135_28.x, var_135_28.y, var_135_28.z)

				local var_135_29 = var_135_21.localEulerAngles

				var_135_29.z = 0
				var_135_29.x = 0
				var_135_21.localEulerAngles = var_135_29
			end

			local var_135_30 = 0
			local var_135_31 = 0.325

			if var_135_30 < arg_132_1.time_ and arg_132_1.time_ <= var_135_30 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_32 = arg_132_1:FormatText(StoryNameCfg[6].name)

				arg_132_1.leftNameTxt_.text = var_135_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_33 = arg_132_1:GetWordFromCfg(304021034)
				local var_135_34 = arg_132_1:FormatText(var_135_33.content)

				arg_132_1.text_.text = var_135_34

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_35 = 13
				local var_135_36 = utf8.len(var_135_34)
				local var_135_37 = var_135_35 <= 0 and var_135_31 or var_135_31 * (var_135_36 / var_135_35)

				if var_135_37 > 0 and var_135_31 < var_135_37 then
					arg_132_1.talkMaxDuration = var_135_37

					if var_135_37 + var_135_30 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_37 + var_135_30
					end
				end

				arg_132_1.text_.text = var_135_34
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021034", "story_v_out_304021.awb") ~= 0 then
					local var_135_38 = manager.audio:GetVoiceLength("story_v_out_304021", "304021034", "story_v_out_304021.awb") / 1000

					if var_135_38 + var_135_30 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_38 + var_135_30
					end

					if var_135_33.prefab_name ~= "" and arg_132_1.actors_[var_135_33.prefab_name] ~= nil then
						local var_135_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_33.prefab_name].transform, "story_v_out_304021", "304021034", "story_v_out_304021.awb")

						arg_132_1:RecordAudio("304021034", var_135_39)
						arg_132_1:RecordAudio("304021034", var_135_39)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_304021", "304021034", "story_v_out_304021.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_304021", "304021034", "story_v_out_304021.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_40 = math.max(var_135_31, arg_132_1.talkMaxDuration)

			if var_135_30 <= arg_132_1.time_ and arg_132_1.time_ < var_135_30 + var_135_40 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_30) / var_135_40

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_30 + var_135_40 and arg_132_1.time_ < var_135_30 + var_135_40 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play304021035 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 304021035
		arg_136_1.duration_ = 6.37

		local var_136_0 = {
			zh = 6.233,
			ja = 6.366
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
				arg_136_0:Play304021036(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1019ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1019ui_story == nil then
				arg_136_1.var_.characterEffect1019ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1019ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1019ui_story then
				arg_136_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1084ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.200000002980232

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1084ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_9
			end

			local var_139_10 = arg_136_1.actors_["1084ui_story"].transform
			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.var_.moveOldPos1084ui_story = var_139_10.localPosition
			end

			local var_139_12 = 0.001

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_12 then
				local var_139_13 = (arg_136_1.time_ - var_139_11) / var_139_12
				local var_139_14 = Vector3.New(0, 100, 0)

				var_139_10.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1084ui_story, var_139_14, var_139_13)

				local var_139_15 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_15.x, var_139_15.y, var_139_15.z)

				local var_139_16 = var_139_10.localEulerAngles

				var_139_16.z = 0
				var_139_16.x = 0
				var_139_10.localEulerAngles = var_139_16
			end

			if arg_136_1.time_ >= var_139_11 + var_139_12 and arg_136_1.time_ < var_139_11 + var_139_12 + arg_139_0 then
				var_139_10.localPosition = Vector3.New(0, 100, 0)

				local var_139_17 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_17.x, var_139_17.y, var_139_17.z)

				local var_139_18 = var_139_10.localEulerAngles

				var_139_18.z = 0
				var_139_18.x = 0
				var_139_10.localEulerAngles = var_139_18
			end

			local var_139_19 = arg_136_1.actors_["1019ui_story"].transform
			local var_139_20 = 0

			if var_139_20 < arg_136_1.time_ and arg_136_1.time_ <= var_139_20 + arg_139_0 then
				arg_136_1.var_.moveOldPos1019ui_story = var_139_19.localPosition
			end

			local var_139_21 = 0.001

			if var_139_20 <= arg_136_1.time_ and arg_136_1.time_ < var_139_20 + var_139_21 then
				local var_139_22 = (arg_136_1.time_ - var_139_20) / var_139_21
				local var_139_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_139_19.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1019ui_story, var_139_23, var_139_22)

				local var_139_24 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_24.x, var_139_24.y, var_139_24.z)

				local var_139_25 = var_139_19.localEulerAngles

				var_139_25.z = 0
				var_139_25.x = 0
				var_139_19.localEulerAngles = var_139_25
			end

			if arg_136_1.time_ >= var_139_20 + var_139_21 and arg_136_1.time_ < var_139_20 + var_139_21 + arg_139_0 then
				var_139_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_139_26 = manager.ui.mainCamera.transform.position - var_139_19.position

				var_139_19.forward = Vector3.New(var_139_26.x, var_139_26.y, var_139_26.z)

				local var_139_27 = var_139_19.localEulerAngles

				var_139_27.z = 0
				var_139_27.x = 0
				var_139_19.localEulerAngles = var_139_27
			end

			local var_139_28 = 0

			if var_139_28 < arg_136_1.time_ and arg_136_1.time_ <= var_139_28 + arg_139_0 then
				arg_136_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			local var_139_29 = 0
			local var_139_30 = 0.95

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_31 = arg_136_1:FormatText(StoryNameCfg[13].name)

				arg_136_1.leftNameTxt_.text = var_139_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_32 = arg_136_1:GetWordFromCfg(304021035)
				local var_139_33 = arg_136_1:FormatText(var_139_32.content)

				arg_136_1.text_.text = var_139_33

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_34 = 38
				local var_139_35 = utf8.len(var_139_33)
				local var_139_36 = var_139_34 <= 0 and var_139_30 or var_139_30 * (var_139_35 / var_139_34)

				if var_139_36 > 0 and var_139_30 < var_139_36 then
					arg_136_1.talkMaxDuration = var_139_36

					if var_139_36 + var_139_29 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_36 + var_139_29
					end
				end

				arg_136_1.text_.text = var_139_33
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021035", "story_v_out_304021.awb") ~= 0 then
					local var_139_37 = manager.audio:GetVoiceLength("story_v_out_304021", "304021035", "story_v_out_304021.awb") / 1000

					if var_139_37 + var_139_29 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_29
					end

					if var_139_32.prefab_name ~= "" and arg_136_1.actors_[var_139_32.prefab_name] ~= nil then
						local var_139_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_32.prefab_name].transform, "story_v_out_304021", "304021035", "story_v_out_304021.awb")

						arg_136_1:RecordAudio("304021035", var_139_38)
						arg_136_1:RecordAudio("304021035", var_139_38)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_304021", "304021035", "story_v_out_304021.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_304021", "304021035", "story_v_out_304021.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_39 = math.max(var_139_30, arg_136_1.talkMaxDuration)

			if var_139_29 <= arg_136_1.time_ and arg_136_1.time_ < var_139_29 + var_139_39 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_29) / var_139_39

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_29 + var_139_39 and arg_136_1.time_ < var_139_29 + var_139_39 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304021036 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 304021036
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play304021037(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1019ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1019ui_story == nil then
				arg_140_1.var_.characterEffect1019ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1019ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1019ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1019ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1019ui_story.fillRatio = var_143_5
			end

			local var_143_6 = arg_140_1.actors_["1084ui_story"].transform
			local var_143_7 = 0

			if var_143_7 < arg_140_1.time_ and arg_140_1.time_ <= var_143_7 + arg_143_0 then
				arg_140_1.var_.moveOldPos1084ui_story = var_143_6.localPosition
			end

			local var_143_8 = 0.001

			if var_143_7 <= arg_140_1.time_ and arg_140_1.time_ < var_143_7 + var_143_8 then
				local var_143_9 = (arg_140_1.time_ - var_143_7) / var_143_8
				local var_143_10 = Vector3.New(0, 100, 0)

				var_143_6.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1084ui_story, var_143_10, var_143_9)

				local var_143_11 = manager.ui.mainCamera.transform.position - var_143_6.position

				var_143_6.forward = Vector3.New(var_143_11.x, var_143_11.y, var_143_11.z)

				local var_143_12 = var_143_6.localEulerAngles

				var_143_12.z = 0
				var_143_12.x = 0
				var_143_6.localEulerAngles = var_143_12
			end

			if arg_140_1.time_ >= var_143_7 + var_143_8 and arg_140_1.time_ < var_143_7 + var_143_8 + arg_143_0 then
				var_143_6.localPosition = Vector3.New(0, 100, 0)

				local var_143_13 = manager.ui.mainCamera.transform.position - var_143_6.position

				var_143_6.forward = Vector3.New(var_143_13.x, var_143_13.y, var_143_13.z)

				local var_143_14 = var_143_6.localEulerAngles

				var_143_14.z = 0
				var_143_14.x = 0
				var_143_6.localEulerAngles = var_143_14
			end

			local var_143_15 = arg_140_1.actors_["1019ui_story"].transform
			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.var_.moveOldPos1019ui_story = var_143_15.localPosition
			end

			local var_143_17 = 0.001

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_17 then
				local var_143_18 = (arg_140_1.time_ - var_143_16) / var_143_17
				local var_143_19 = Vector3.New(-0.2, -1.08, -5.9)

				var_143_15.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1019ui_story, var_143_19, var_143_18)

				local var_143_20 = manager.ui.mainCamera.transform.position - var_143_15.position

				var_143_15.forward = Vector3.New(var_143_20.x, var_143_20.y, var_143_20.z)

				local var_143_21 = var_143_15.localEulerAngles

				var_143_21.z = 0
				var_143_21.x = 0
				var_143_15.localEulerAngles = var_143_21
			end

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 then
				var_143_15.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_143_22 = manager.ui.mainCamera.transform.position - var_143_15.position

				var_143_15.forward = Vector3.New(var_143_22.x, var_143_22.y, var_143_22.z)

				local var_143_23 = var_143_15.localEulerAngles

				var_143_23.z = 0
				var_143_23.x = 0
				var_143_15.localEulerAngles = var_143_23
			end

			local var_143_24 = 0
			local var_143_25 = 0.35

			if var_143_24 < arg_140_1.time_ and arg_140_1.time_ <= var_143_24 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_26 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_27 = arg_140_1:GetWordFromCfg(304021036)
				local var_143_28 = arg_140_1:FormatText(var_143_27.content)

				arg_140_1.text_.text = var_143_28

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_29 = 14
				local var_143_30 = utf8.len(var_143_28)
				local var_143_31 = var_143_29 <= 0 and var_143_25 or var_143_25 * (var_143_30 / var_143_29)

				if var_143_31 > 0 and var_143_25 < var_143_31 then
					arg_140_1.talkMaxDuration = var_143_31

					if var_143_31 + var_143_24 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_31 + var_143_24
					end
				end

				arg_140_1.text_.text = var_143_28
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_32 = math.max(var_143_25, arg_140_1.talkMaxDuration)

			if var_143_24 <= arg_140_1.time_ and arg_140_1.time_ < var_143_24 + var_143_32 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_24) / var_143_32

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_24 + var_143_32 and arg_140_1.time_ < var_143_24 + var_143_32 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304021037 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 304021037
		arg_144_1.duration_ = 8.87

		local var_144_0 = {
			zh = 8.733,
			ja = 8.866
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
				arg_144_0:Play304021038(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1019ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1019ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1019ui_story then
				arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_147_4 = 0

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_147_6 = 0
			local var_147_7 = 1.075

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[13].name)

				arg_144_1.leftNameTxt_.text = var_147_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_9 = arg_144_1:GetWordFromCfg(304021037)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 43
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_7 or var_147_7 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_7 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021037", "story_v_out_304021.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021037", "story_v_out_304021.awb") / 1000

					if var_147_14 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_6
					end

					if var_147_9.prefab_name ~= "" and arg_144_1.actors_[var_147_9.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_9.prefab_name].transform, "story_v_out_304021", "304021037", "story_v_out_304021.awb")

						arg_144_1:RecordAudio("304021037", var_147_15)
						arg_144_1:RecordAudio("304021037", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_304021", "304021037", "story_v_out_304021.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_304021", "304021037", "story_v_out_304021.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_16 and arg_144_1.time_ < var_147_6 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play304021038 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 304021038
		arg_148_1.duration_ = 11.13

		local var_148_0 = {
			zh = 11.133,
			ja = 9.733
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play304021039(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 1.5

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[13].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(304021038)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 60
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021038", "story_v_out_304021.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021038", "story_v_out_304021.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_304021", "304021038", "story_v_out_304021.awb")

						arg_148_1:RecordAudio("304021038", var_151_9)
						arg_148_1:RecordAudio("304021038", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_304021", "304021038", "story_v_out_304021.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_304021", "304021038", "story_v_out_304021.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play304021039 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 304021039
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play304021040(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1019ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story == nil then
				arg_152_1.var_.characterEffect1019ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1019ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1019ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1019ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 0.65

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(304021039)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 26
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play304021040 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 304021040
		arg_156_1.duration_ = 9.6

		local var_156_0 = {
			zh = 8.4,
			ja = 9.6
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
				arg_156_0:Play304021041(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1019ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1019ui_story == nil then
				arg_156_1.var_.characterEffect1019ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1019ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1019ui_story then
				arg_156_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_159_4 = 0

			if var_159_4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_159_5 = 0
			local var_159_6 = 1.05

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_7 = arg_156_1:FormatText(StoryNameCfg[13].name)

				arg_156_1.leftNameTxt_.text = var_159_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(304021040)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 42
				local var_159_11 = utf8.len(var_159_9)
				local var_159_12 = var_159_10 <= 0 and var_159_6 or var_159_6 * (var_159_11 / var_159_10)

				if var_159_12 > 0 and var_159_6 < var_159_12 then
					arg_156_1.talkMaxDuration = var_159_12

					if var_159_12 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_5
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021040", "story_v_out_304021.awb") ~= 0 then
					local var_159_13 = manager.audio:GetVoiceLength("story_v_out_304021", "304021040", "story_v_out_304021.awb") / 1000

					if var_159_13 + var_159_5 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_5
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_304021", "304021040", "story_v_out_304021.awb")

						arg_156_1:RecordAudio("304021040", var_159_14)
						arg_156_1:RecordAudio("304021040", var_159_14)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_304021", "304021040", "story_v_out_304021.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_304021", "304021040", "story_v_out_304021.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_15 = math.max(var_159_6, arg_156_1.talkMaxDuration)

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_15 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_5) / var_159_15

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_5 + var_159_15 and arg_156_1.time_ < var_159_5 + var_159_15 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play304021041 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 304021041
		arg_160_1.duration_ = 2.43

		local var_160_0 = {
			zh = 2.433,
			ja = 2.166
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play304021042(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.275

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[13].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(304021041)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 11
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021041", "story_v_out_304021.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021041", "story_v_out_304021.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_304021", "304021041", "story_v_out_304021.awb")

						arg_160_1:RecordAudio("304021041", var_163_9)
						arg_160_1:RecordAudio("304021041", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_304021", "304021041", "story_v_out_304021.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_304021", "304021041", "story_v_out_304021.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play304021042 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 304021042
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play304021043(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1019ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1019ui_story == nil then
				arg_164_1.var_.characterEffect1019ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1019ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1019ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1019ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1019ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.5

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_9 = arg_164_1:GetWordFromCfg(304021042)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 20
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play304021043 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 304021043
		arg_168_1.duration_ = 4.7

		local var_168_0 = {
			zh = 4.7,
			ja = 1.999999999999
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
				arg_168_0:Play304021044(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1084ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1084ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(-0.7, -0.97, -6)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1084ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["1084ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_171_14 = arg_168_1.actors_["1019ui_story"].transform
			local var_171_15 = 0

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1.var_.moveOldPos1019ui_story = var_171_14.localPosition
			end

			local var_171_16 = 0.001

			if var_171_15 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_16 then
				local var_171_17 = (arg_168_1.time_ - var_171_15) / var_171_16
				local var_171_18 = Vector3.New(0, 100, 0)

				var_171_14.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1019ui_story, var_171_18, var_171_17)

				local var_171_19 = manager.ui.mainCamera.transform.position - var_171_14.position

				var_171_14.forward = Vector3.New(var_171_19.x, var_171_19.y, var_171_19.z)

				local var_171_20 = var_171_14.localEulerAngles

				var_171_20.z = 0
				var_171_20.x = 0
				var_171_14.localEulerAngles = var_171_20
			end

			if arg_168_1.time_ >= var_171_15 + var_171_16 and arg_168_1.time_ < var_171_15 + var_171_16 + arg_171_0 then
				var_171_14.localPosition = Vector3.New(0, 100, 0)

				local var_171_21 = manager.ui.mainCamera.transform.position - var_171_14.position

				var_171_14.forward = Vector3.New(var_171_21.x, var_171_21.y, var_171_21.z)

				local var_171_22 = var_171_14.localEulerAngles

				var_171_22.z = 0
				var_171_22.x = 0
				var_171_14.localEulerAngles = var_171_22
			end

			local var_171_23 = 0

			if var_171_23 < arg_168_1.time_ and arg_168_1.time_ <= var_171_23 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_24 = 0
			local var_171_25 = 0.55

			if var_171_24 < arg_168_1.time_ and arg_168_1.time_ <= var_171_24 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_26 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_27 = arg_168_1:GetWordFromCfg(304021043)
				local var_171_28 = arg_168_1:FormatText(var_171_27.content)

				arg_168_1.text_.text = var_171_28

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_29 = 22
				local var_171_30 = utf8.len(var_171_28)
				local var_171_31 = var_171_29 <= 0 and var_171_25 or var_171_25 * (var_171_30 / var_171_29)

				if var_171_31 > 0 and var_171_25 < var_171_31 then
					arg_168_1.talkMaxDuration = var_171_31

					if var_171_31 + var_171_24 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_31 + var_171_24
					end
				end

				arg_168_1.text_.text = var_171_28
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021043", "story_v_out_304021.awb") ~= 0 then
					local var_171_32 = manager.audio:GetVoiceLength("story_v_out_304021", "304021043", "story_v_out_304021.awb") / 1000

					if var_171_32 + var_171_24 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_32 + var_171_24
					end

					if var_171_27.prefab_name ~= "" and arg_168_1.actors_[var_171_27.prefab_name] ~= nil then
						local var_171_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_27.prefab_name].transform, "story_v_out_304021", "304021043", "story_v_out_304021.awb")

						arg_168_1:RecordAudio("304021043", var_171_33)
						arg_168_1:RecordAudio("304021043", var_171_33)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_304021", "304021043", "story_v_out_304021.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_304021", "304021043", "story_v_out_304021.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_34 = math.max(var_171_25, arg_168_1.talkMaxDuration)

			if var_171_24 <= arg_168_1.time_ and arg_168_1.time_ < var_171_24 + var_171_34 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_24) / var_171_34

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_24 + var_171_34 and arg_168_1.time_ < var_171_24 + var_171_34 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304021044 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 304021044
		arg_172_1.duration_ = 4.1

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play304021045(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1011ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1011ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0.7, -0.71, -6)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1011ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["1011ui_story"]
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1011ui_story == nil then
				arg_172_1.var_.characterEffect1011ui_story = var_175_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_11 = 0.200000002980232

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_11 and not isNil(var_175_9) then
				local var_175_12 = (arg_172_1.time_ - var_175_10) / var_175_11

				if arg_172_1.var_.characterEffect1011ui_story and not isNil(var_175_9) then
					arg_172_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_10 + var_175_11 and arg_172_1.time_ < var_175_10 + var_175_11 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1011ui_story then
				arg_172_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_175_13 = arg_172_1.actors_["1084ui_story"]
			local var_175_14 = 0

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 and not isNil(var_175_13) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_15 = 0.200000002980232

			if var_175_14 <= arg_172_1.time_ and arg_172_1.time_ < var_175_14 + var_175_15 and not isNil(var_175_13) then
				local var_175_16 = (arg_172_1.time_ - var_175_14) / var_175_15

				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_13) then
					local var_175_17 = Mathf.Lerp(0, 0.5, var_175_16)

					arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_17
				end
			end

			if arg_172_1.time_ >= var_175_14 + var_175_15 and arg_172_1.time_ < var_175_14 + var_175_15 + arg_175_0 and not isNil(var_175_13) and arg_172_1.var_.characterEffect1084ui_story then
				local var_175_18 = 0.5

				arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_18
			end

			local var_175_19 = 0

			if var_175_19 < arg_172_1.time_ and arg_172_1.time_ <= var_175_19 + arg_175_0 then
				arg_172_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_175_20 = 0

			if var_175_20 < arg_172_1.time_ and arg_172_1.time_ <= var_175_20 + arg_175_0 then
				arg_172_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_175_21 = 0
			local var_175_22 = 0.35

			if var_175_21 < arg_172_1.time_ and arg_172_1.time_ <= var_175_21 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_23 = arg_172_1:FormatText(StoryNameCfg[37].name)

				arg_172_1.leftNameTxt_.text = var_175_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_24 = arg_172_1:GetWordFromCfg(304021044)
				local var_175_25 = arg_172_1:FormatText(var_175_24.content)

				arg_172_1.text_.text = var_175_25

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_26 = 14
				local var_175_27 = utf8.len(var_175_25)
				local var_175_28 = var_175_26 <= 0 and var_175_22 or var_175_22 * (var_175_27 / var_175_26)

				if var_175_28 > 0 and var_175_22 < var_175_28 then
					arg_172_1.talkMaxDuration = var_175_28

					if var_175_28 + var_175_21 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_28 + var_175_21
					end
				end

				arg_172_1.text_.text = var_175_25
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021044", "story_v_out_304021.awb") ~= 0 then
					local var_175_29 = manager.audio:GetVoiceLength("story_v_out_304021", "304021044", "story_v_out_304021.awb") / 1000

					if var_175_29 + var_175_21 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_29 + var_175_21
					end

					if var_175_24.prefab_name ~= "" and arg_172_1.actors_[var_175_24.prefab_name] ~= nil then
						local var_175_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_24.prefab_name].transform, "story_v_out_304021", "304021044", "story_v_out_304021.awb")

						arg_172_1:RecordAudio("304021044", var_175_30)
						arg_172_1:RecordAudio("304021044", var_175_30)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_304021", "304021044", "story_v_out_304021.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_304021", "304021044", "story_v_out_304021.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_31 = math.max(var_175_22, arg_172_1.talkMaxDuration)

			if var_175_21 <= arg_172_1.time_ and arg_172_1.time_ < var_175_21 + var_175_31 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_21) / var_175_31

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_21 + var_175_31 and arg_172_1.time_ < var_175_21 + var_175_31 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play304021045 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 304021045
		arg_176_1.duration_ = 9.5

		local var_176_0 = {
			zh = 7.433,
			ja = 9.5
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play304021046(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1019ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1019ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(-0.7, -1.08, -5.9)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1019ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = arg_176_1.actors_["1084ui_story"].transform
			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1.var_.moveOldPos1084ui_story = var_179_9.localPosition
			end

			local var_179_11 = 0.001

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_11 then
				local var_179_12 = (arg_176_1.time_ - var_179_10) / var_179_11
				local var_179_13 = Vector3.New(0, 100, 0)

				var_179_9.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1084ui_story, var_179_13, var_179_12)

				local var_179_14 = manager.ui.mainCamera.transform.position - var_179_9.position

				var_179_9.forward = Vector3.New(var_179_14.x, var_179_14.y, var_179_14.z)

				local var_179_15 = var_179_9.localEulerAngles

				var_179_15.z = 0
				var_179_15.x = 0
				var_179_9.localEulerAngles = var_179_15
			end

			if arg_176_1.time_ >= var_179_10 + var_179_11 and arg_176_1.time_ < var_179_10 + var_179_11 + arg_179_0 then
				var_179_9.localPosition = Vector3.New(0, 100, 0)

				local var_179_16 = manager.ui.mainCamera.transform.position - var_179_9.position

				var_179_9.forward = Vector3.New(var_179_16.x, var_179_16.y, var_179_16.z)

				local var_179_17 = var_179_9.localEulerAngles

				var_179_17.z = 0
				var_179_17.x = 0
				var_179_9.localEulerAngles = var_179_17
			end

			local var_179_18 = arg_176_1.actors_["1019ui_story"]
			local var_179_19 = 0

			if var_179_19 < arg_176_1.time_ and arg_176_1.time_ <= var_179_19 + arg_179_0 and not isNil(var_179_18) and arg_176_1.var_.characterEffect1019ui_story == nil then
				arg_176_1.var_.characterEffect1019ui_story = var_179_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_20 = 0.200000002980232

			if var_179_19 <= arg_176_1.time_ and arg_176_1.time_ < var_179_19 + var_179_20 and not isNil(var_179_18) then
				local var_179_21 = (arg_176_1.time_ - var_179_19) / var_179_20

				if arg_176_1.var_.characterEffect1019ui_story and not isNil(var_179_18) then
					arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_19 + var_179_20 and arg_176_1.time_ < var_179_19 + var_179_20 + arg_179_0 and not isNil(var_179_18) and arg_176_1.var_.characterEffect1019ui_story then
				arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_179_22 = arg_176_1.actors_["1011ui_story"]
			local var_179_23 = 0

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 and not isNil(var_179_22) and arg_176_1.var_.characterEffect1011ui_story == nil then
				arg_176_1.var_.characterEffect1011ui_story = var_179_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_24 = 0.200000002980232

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_24 and not isNil(var_179_22) then
				local var_179_25 = (arg_176_1.time_ - var_179_23) / var_179_24

				if arg_176_1.var_.characterEffect1011ui_story and not isNil(var_179_22) then
					local var_179_26 = Mathf.Lerp(0, 0.5, var_179_25)

					arg_176_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1011ui_story.fillRatio = var_179_26
				end
			end

			if arg_176_1.time_ >= var_179_23 + var_179_24 and arg_176_1.time_ < var_179_23 + var_179_24 + arg_179_0 and not isNil(var_179_22) and arg_176_1.var_.characterEffect1011ui_story then
				local var_179_27 = 0.5

				arg_176_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1011ui_story.fillRatio = var_179_27
			end

			local var_179_28 = 0

			if var_179_28 < arg_176_1.time_ and arg_176_1.time_ <= var_179_28 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_179_29 = 0

			if var_179_29 < arg_176_1.time_ and arg_176_1.time_ <= var_179_29 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_30 = 0
			local var_179_31 = 0.975

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_32 = arg_176_1:FormatText(StoryNameCfg[13].name)

				arg_176_1.leftNameTxt_.text = var_179_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_33 = arg_176_1:GetWordFromCfg(304021045)
				local var_179_34 = arg_176_1:FormatText(var_179_33.content)

				arg_176_1.text_.text = var_179_34

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_35 = 39
				local var_179_36 = utf8.len(var_179_34)
				local var_179_37 = var_179_35 <= 0 and var_179_31 or var_179_31 * (var_179_36 / var_179_35)

				if var_179_37 > 0 and var_179_31 < var_179_37 then
					arg_176_1.talkMaxDuration = var_179_37

					if var_179_37 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_37 + var_179_30
					end
				end

				arg_176_1.text_.text = var_179_34
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021045", "story_v_out_304021.awb") ~= 0 then
					local var_179_38 = manager.audio:GetVoiceLength("story_v_out_304021", "304021045", "story_v_out_304021.awb") / 1000

					if var_179_38 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_38 + var_179_30
					end

					if var_179_33.prefab_name ~= "" and arg_176_1.actors_[var_179_33.prefab_name] ~= nil then
						local var_179_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_33.prefab_name].transform, "story_v_out_304021", "304021045", "story_v_out_304021.awb")

						arg_176_1:RecordAudio("304021045", var_179_39)
						arg_176_1:RecordAudio("304021045", var_179_39)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_304021", "304021045", "story_v_out_304021.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_304021", "304021045", "story_v_out_304021.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_40 = math.max(var_179_31, arg_176_1.talkMaxDuration)

			if var_179_30 <= arg_176_1.time_ and arg_176_1.time_ < var_179_30 + var_179_40 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_30) / var_179_40

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_30 + var_179_40 and arg_176_1.time_ < var_179_30 + var_179_40 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play304021046 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 304021046
		arg_180_1.duration_ = 4.07

		local var_180_0 = {
			zh = 4.066,
			ja = 3.433
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play304021047(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 0.45

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_2 = arg_180_1:FormatText(StoryNameCfg[13].name)

				arg_180_1.leftNameTxt_.text = var_183_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:GetWordFromCfg(304021046)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 18
				local var_183_6 = utf8.len(var_183_4)
				local var_183_7 = var_183_5 <= 0 and var_183_1 or var_183_1 * (var_183_6 / var_183_5)

				if var_183_7 > 0 and var_183_1 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021046", "story_v_out_304021.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021046", "story_v_out_304021.awb") / 1000

					if var_183_8 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_0
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_304021", "304021046", "story_v_out_304021.awb")

						arg_180_1:RecordAudio("304021046", var_183_9)
						arg_180_1:RecordAudio("304021046", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_304021", "304021046", "story_v_out_304021.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_304021", "304021046", "story_v_out_304021.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_10 and arg_180_1.time_ < var_183_0 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play304021047 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 304021047
		arg_184_1.duration_ = 10.53

		local var_184_0 = {
			zh = 5.3,
			ja = 10.533
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
				arg_184_0:Play304021048(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1011ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1011ui_story == nil then
				arg_184_1.var_.characterEffect1011ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1011ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1011ui_story then
				arg_184_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["1019ui_story"]
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1019ui_story == nil then
				arg_184_1.var_.characterEffect1019ui_story = var_187_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.200000002980232

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 and not isNil(var_187_4) then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6

				if arg_184_1.var_.characterEffect1019ui_story and not isNil(var_187_4) then
					local var_187_8 = Mathf.Lerp(0, 0.5, var_187_7)

					arg_184_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1019ui_story.fillRatio = var_187_8
				end
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1019ui_story then
				local var_187_9 = 0.5

				arg_184_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1019ui_story.fillRatio = var_187_9
			end

			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			local var_187_11 = 0

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_187_12 = 0
			local var_187_13 = 0.525

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_14 = arg_184_1:FormatText(StoryNameCfg[37].name)

				arg_184_1.leftNameTxt_.text = var_187_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_15 = arg_184_1:GetWordFromCfg(304021047)
				local var_187_16 = arg_184_1:FormatText(var_187_15.content)

				arg_184_1.text_.text = var_187_16

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_17 = 21
				local var_187_18 = utf8.len(var_187_16)
				local var_187_19 = var_187_17 <= 0 and var_187_13 or var_187_13 * (var_187_18 / var_187_17)

				if var_187_19 > 0 and var_187_13 < var_187_19 then
					arg_184_1.talkMaxDuration = var_187_19

					if var_187_19 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_19 + var_187_12
					end
				end

				arg_184_1.text_.text = var_187_16
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021047", "story_v_out_304021.awb") ~= 0 then
					local var_187_20 = manager.audio:GetVoiceLength("story_v_out_304021", "304021047", "story_v_out_304021.awb") / 1000

					if var_187_20 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_20 + var_187_12
					end

					if var_187_15.prefab_name ~= "" and arg_184_1.actors_[var_187_15.prefab_name] ~= nil then
						local var_187_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_15.prefab_name].transform, "story_v_out_304021", "304021047", "story_v_out_304021.awb")

						arg_184_1:RecordAudio("304021047", var_187_21)
						arg_184_1:RecordAudio("304021047", var_187_21)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_304021", "304021047", "story_v_out_304021.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_304021", "304021047", "story_v_out_304021.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_22 = math.max(var_187_13, arg_184_1.talkMaxDuration)

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_22 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_12) / var_187_22

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_12 + var_187_22 and arg_184_1.time_ < var_187_12 + var_187_22 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play304021048 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 304021048
		arg_188_1.duration_ = 14.03

		local var_188_0 = {
			zh = 10.4,
			ja = 14.033
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play304021049(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1019ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1019ui_story == nil then
				arg_188_1.var_.characterEffect1019ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1019ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1019ui_story then
				arg_188_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_191_4 = arg_188_1.actors_["1011ui_story"]
			local var_191_5 = 0

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1011ui_story == nil then
				arg_188_1.var_.characterEffect1011ui_story = var_191_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_6 = 0.200000002980232

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 and not isNil(var_191_4) then
				local var_191_7 = (arg_188_1.time_ - var_191_5) / var_191_6

				if arg_188_1.var_.characterEffect1011ui_story and not isNil(var_191_4) then
					local var_191_8 = Mathf.Lerp(0, 0.5, var_191_7)

					arg_188_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1011ui_story.fillRatio = var_191_8
				end
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1011ui_story then
				local var_191_9 = 0.5

				arg_188_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1011ui_story.fillRatio = var_191_9
			end

			local var_191_10 = 0
			local var_191_11 = 1.225

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_12 = arg_188_1:FormatText(StoryNameCfg[13].name)

				arg_188_1.leftNameTxt_.text = var_191_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_13 = arg_188_1:GetWordFromCfg(304021048)
				local var_191_14 = arg_188_1:FormatText(var_191_13.content)

				arg_188_1.text_.text = var_191_14

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_15 = 49
				local var_191_16 = utf8.len(var_191_14)
				local var_191_17 = var_191_15 <= 0 and var_191_11 or var_191_11 * (var_191_16 / var_191_15)

				if var_191_17 > 0 and var_191_11 < var_191_17 then
					arg_188_1.talkMaxDuration = var_191_17

					if var_191_17 + var_191_10 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_10
					end
				end

				arg_188_1.text_.text = var_191_14
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021048", "story_v_out_304021.awb") ~= 0 then
					local var_191_18 = manager.audio:GetVoiceLength("story_v_out_304021", "304021048", "story_v_out_304021.awb") / 1000

					if var_191_18 + var_191_10 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_18 + var_191_10
					end

					if var_191_13.prefab_name ~= "" and arg_188_1.actors_[var_191_13.prefab_name] ~= nil then
						local var_191_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_13.prefab_name].transform, "story_v_out_304021", "304021048", "story_v_out_304021.awb")

						arg_188_1:RecordAudio("304021048", var_191_19)
						arg_188_1:RecordAudio("304021048", var_191_19)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_304021", "304021048", "story_v_out_304021.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_304021", "304021048", "story_v_out_304021.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_20 = math.max(var_191_11, arg_188_1.talkMaxDuration)

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_20 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_10) / var_191_20

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_10 + var_191_20 and arg_188_1.time_ < var_191_10 + var_191_20 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play304021049 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 304021049
		arg_192_1.duration_ = 3.6

		local var_192_0 = {
			zh = 3.6,
			ja = 1.999999999999
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play304021050(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = "1037ui_story"

			if arg_192_1.actors_[var_195_0] == nil then
				local var_195_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_195_1) then
					local var_195_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_192_1.stage_.transform)

					var_195_2.name = var_195_0
					var_195_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_192_1.actors_[var_195_0] = var_195_2

					local var_195_3 = var_195_2:GetComponentInChildren(typeof(CharacterEffect))

					var_195_3.enabled = true

					local var_195_4 = GameObjectTools.GetOrAddComponent(var_195_2, typeof(DynamicBoneHelper))

					if var_195_4 then
						var_195_4:EnableDynamicBone(false)
					end

					arg_192_1:ShowWeapon(var_195_3.transform, false)

					arg_192_1.var_[var_195_0 .. "Animator"] = var_195_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_192_1.var_[var_195_0 .. "Animator"].applyRootMotion = true
					arg_192_1.var_[var_195_0 .. "LipSync"] = var_195_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_195_5 = arg_192_1.actors_["1037ui_story"].transform
			local var_195_6 = 0

			if var_195_6 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.var_.moveOldPos1037ui_story = var_195_5.localPosition
			end

			local var_195_7 = 0.001

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_7 then
				local var_195_8 = (arg_192_1.time_ - var_195_6) / var_195_7
				local var_195_9 = Vector3.New(0.7, -1.09, -5.81)

				var_195_5.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1037ui_story, var_195_9, var_195_8)

				local var_195_10 = manager.ui.mainCamera.transform.position - var_195_5.position

				var_195_5.forward = Vector3.New(var_195_10.x, var_195_10.y, var_195_10.z)

				local var_195_11 = var_195_5.localEulerAngles

				var_195_11.z = 0
				var_195_11.x = 0
				var_195_5.localEulerAngles = var_195_11
			end

			if arg_192_1.time_ >= var_195_6 + var_195_7 and arg_192_1.time_ < var_195_6 + var_195_7 + arg_195_0 then
				var_195_5.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_195_12 = manager.ui.mainCamera.transform.position - var_195_5.position

				var_195_5.forward = Vector3.New(var_195_12.x, var_195_12.y, var_195_12.z)

				local var_195_13 = var_195_5.localEulerAngles

				var_195_13.z = 0
				var_195_13.x = 0
				var_195_5.localEulerAngles = var_195_13
			end

			local var_195_14 = arg_192_1.actors_["1011ui_story"].transform
			local var_195_15 = 0

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.var_.moveOldPos1011ui_story = var_195_14.localPosition
			end

			local var_195_16 = 0.001

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_16 then
				local var_195_17 = (arg_192_1.time_ - var_195_15) / var_195_16
				local var_195_18 = Vector3.New(0, 100, 0)

				var_195_14.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1011ui_story, var_195_18, var_195_17)

				local var_195_19 = manager.ui.mainCamera.transform.position - var_195_14.position

				var_195_14.forward = Vector3.New(var_195_19.x, var_195_19.y, var_195_19.z)

				local var_195_20 = var_195_14.localEulerAngles

				var_195_20.z = 0
				var_195_20.x = 0
				var_195_14.localEulerAngles = var_195_20
			end

			if arg_192_1.time_ >= var_195_15 + var_195_16 and arg_192_1.time_ < var_195_15 + var_195_16 + arg_195_0 then
				var_195_14.localPosition = Vector3.New(0, 100, 0)

				local var_195_21 = manager.ui.mainCamera.transform.position - var_195_14.position

				var_195_14.forward = Vector3.New(var_195_21.x, var_195_21.y, var_195_21.z)

				local var_195_22 = var_195_14.localEulerAngles

				var_195_22.z = 0
				var_195_22.x = 0
				var_195_14.localEulerAngles = var_195_22
			end

			local var_195_23 = arg_192_1.actors_["1037ui_story"]
			local var_195_24 = 0

			if var_195_24 < arg_192_1.time_ and arg_192_1.time_ <= var_195_24 + arg_195_0 and not isNil(var_195_23) and arg_192_1.var_.characterEffect1037ui_story == nil then
				arg_192_1.var_.characterEffect1037ui_story = var_195_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_25 = 0.200000002980232

			if var_195_24 <= arg_192_1.time_ and arg_192_1.time_ < var_195_24 + var_195_25 and not isNil(var_195_23) then
				local var_195_26 = (arg_192_1.time_ - var_195_24) / var_195_25

				if arg_192_1.var_.characterEffect1037ui_story and not isNil(var_195_23) then
					arg_192_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_24 + var_195_25 and arg_192_1.time_ < var_195_24 + var_195_25 + arg_195_0 and not isNil(var_195_23) and arg_192_1.var_.characterEffect1037ui_story then
				arg_192_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_195_27 = arg_192_1.actors_["1019ui_story"]
			local var_195_28 = 0

			if var_195_28 < arg_192_1.time_ and arg_192_1.time_ <= var_195_28 + arg_195_0 and not isNil(var_195_27) and arg_192_1.var_.characterEffect1019ui_story == nil then
				arg_192_1.var_.characterEffect1019ui_story = var_195_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_29 = 0.200000002980232

			if var_195_28 <= arg_192_1.time_ and arg_192_1.time_ < var_195_28 + var_195_29 and not isNil(var_195_27) then
				local var_195_30 = (arg_192_1.time_ - var_195_28) / var_195_29

				if arg_192_1.var_.characterEffect1019ui_story and not isNil(var_195_27) then
					local var_195_31 = Mathf.Lerp(0, 0.5, var_195_30)

					arg_192_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1019ui_story.fillRatio = var_195_31
				end
			end

			if arg_192_1.time_ >= var_195_28 + var_195_29 and arg_192_1.time_ < var_195_28 + var_195_29 + arg_195_0 and not isNil(var_195_27) and arg_192_1.var_.characterEffect1019ui_story then
				local var_195_32 = 0.5

				arg_192_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1019ui_story.fillRatio = var_195_32
			end

			local var_195_33 = 0

			if var_195_33 < arg_192_1.time_ and arg_192_1.time_ <= var_195_33 + arg_195_0 then
				arg_192_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_195_34 = 0

			if var_195_34 < arg_192_1.time_ and arg_192_1.time_ <= var_195_34 + arg_195_0 then
				arg_192_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_195_35 = 0
			local var_195_36 = 0.3

			if var_195_35 < arg_192_1.time_ and arg_192_1.time_ <= var_195_35 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_37 = arg_192_1:FormatText(StoryNameCfg[15].name)

				arg_192_1.leftNameTxt_.text = var_195_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_38 = arg_192_1:GetWordFromCfg(304021049)
				local var_195_39 = arg_192_1:FormatText(var_195_38.content)

				arg_192_1.text_.text = var_195_39

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_40 = 12
				local var_195_41 = utf8.len(var_195_39)
				local var_195_42 = var_195_40 <= 0 and var_195_36 or var_195_36 * (var_195_41 / var_195_40)

				if var_195_42 > 0 and var_195_36 < var_195_42 then
					arg_192_1.talkMaxDuration = var_195_42

					if var_195_42 + var_195_35 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_42 + var_195_35
					end
				end

				arg_192_1.text_.text = var_195_39
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021049", "story_v_out_304021.awb") ~= 0 then
					local var_195_43 = manager.audio:GetVoiceLength("story_v_out_304021", "304021049", "story_v_out_304021.awb") / 1000

					if var_195_43 + var_195_35 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_43 + var_195_35
					end

					if var_195_38.prefab_name ~= "" and arg_192_1.actors_[var_195_38.prefab_name] ~= nil then
						local var_195_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_38.prefab_name].transform, "story_v_out_304021", "304021049", "story_v_out_304021.awb")

						arg_192_1:RecordAudio("304021049", var_195_44)
						arg_192_1:RecordAudio("304021049", var_195_44)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_304021", "304021049", "story_v_out_304021.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_304021", "304021049", "story_v_out_304021.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_45 = math.max(var_195_36, arg_192_1.talkMaxDuration)

			if var_195_35 <= arg_192_1.time_ and arg_192_1.time_ < var_195_35 + var_195_45 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_35) / var_195_45

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_35 + var_195_45 and arg_192_1.time_ < var_195_35 + var_195_45 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play304021050 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 304021050
		arg_196_1.duration_ = 7.6

		local var_196_0 = {
			zh = 7.6,
			ja = 7.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play304021051(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1019ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1019ui_story == nil then
				arg_196_1.var_.characterEffect1019ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect1019ui_story and not isNil(var_199_0) then
					arg_196_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1019ui_story then
				arg_196_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_199_4 = arg_196_1.actors_["1037ui_story"]
			local var_199_5 = 0

			if var_199_5 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1037ui_story == nil then
				arg_196_1.var_.characterEffect1037ui_story = var_199_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_6 = 0.200000002980232

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_6 and not isNil(var_199_4) then
				local var_199_7 = (arg_196_1.time_ - var_199_5) / var_199_6

				if arg_196_1.var_.characterEffect1037ui_story and not isNil(var_199_4) then
					local var_199_8 = Mathf.Lerp(0, 0.5, var_199_7)

					arg_196_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1037ui_story.fillRatio = var_199_8
				end
			end

			if arg_196_1.time_ >= var_199_5 + var_199_6 and arg_196_1.time_ < var_199_5 + var_199_6 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1037ui_story then
				local var_199_9 = 0.5

				arg_196_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1037ui_story.fillRatio = var_199_9
			end

			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_199_11 = 0

			if var_199_11 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_12 = 0
			local var_199_13 = 0.925

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_14 = arg_196_1:FormatText(StoryNameCfg[13].name)

				arg_196_1.leftNameTxt_.text = var_199_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_15 = arg_196_1:GetWordFromCfg(304021050)
				local var_199_16 = arg_196_1:FormatText(var_199_15.content)

				arg_196_1.text_.text = var_199_16

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_17 = 37
				local var_199_18 = utf8.len(var_199_16)
				local var_199_19 = var_199_17 <= 0 and var_199_13 or var_199_13 * (var_199_18 / var_199_17)

				if var_199_19 > 0 and var_199_13 < var_199_19 then
					arg_196_1.talkMaxDuration = var_199_19

					if var_199_19 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_19 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_16
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021050", "story_v_out_304021.awb") ~= 0 then
					local var_199_20 = manager.audio:GetVoiceLength("story_v_out_304021", "304021050", "story_v_out_304021.awb") / 1000

					if var_199_20 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_20 + var_199_12
					end

					if var_199_15.prefab_name ~= "" and arg_196_1.actors_[var_199_15.prefab_name] ~= nil then
						local var_199_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_15.prefab_name].transform, "story_v_out_304021", "304021050", "story_v_out_304021.awb")

						arg_196_1:RecordAudio("304021050", var_199_21)
						arg_196_1:RecordAudio("304021050", var_199_21)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_304021", "304021050", "story_v_out_304021.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_304021", "304021050", "story_v_out_304021.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_22 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_22 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_12) / var_199_22

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_12 + var_199_22 and arg_196_1.time_ < var_199_12 + var_199_22 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play304021051 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 304021051
		arg_200_1.duration_ = 5

		local var_200_0 = {
			zh = 5,
			ja = 1.999999999999
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play304021052(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1037ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1037ui_story == nil then
				arg_200_1.var_.characterEffect1037ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1037ui_story and not isNil(var_203_0) then
					arg_200_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1037ui_story then
				arg_200_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_203_4 = arg_200_1.actors_["1019ui_story"]
			local var_203_5 = 0

			if var_203_5 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect1019ui_story == nil then
				arg_200_1.var_.characterEffect1019ui_story = var_203_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_6 = 0.200000002980232

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_6 and not isNil(var_203_4) then
				local var_203_7 = (arg_200_1.time_ - var_203_5) / var_203_6

				if arg_200_1.var_.characterEffect1019ui_story and not isNil(var_203_4) then
					local var_203_8 = Mathf.Lerp(0, 0.5, var_203_7)

					arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1019ui_story.fillRatio = var_203_8
				end
			end

			if arg_200_1.time_ >= var_203_5 + var_203_6 and arg_200_1.time_ < var_203_5 + var_203_6 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect1019ui_story then
				local var_203_9 = 0.5

				arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1019ui_story.fillRatio = var_203_9
			end

			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 then
				arg_200_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_203_11 = 0

			if var_203_11 < arg_200_1.time_ and arg_200_1.time_ <= var_203_11 + arg_203_0 then
				arg_200_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_203_12 = 0
			local var_203_13 = 0.4

			if var_203_12 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_14 = arg_200_1:FormatText(StoryNameCfg[15].name)

				arg_200_1.leftNameTxt_.text = var_203_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_15 = arg_200_1:GetWordFromCfg(304021051)
				local var_203_16 = arg_200_1:FormatText(var_203_15.content)

				arg_200_1.text_.text = var_203_16

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_17 = 16
				local var_203_18 = utf8.len(var_203_16)
				local var_203_19 = var_203_17 <= 0 and var_203_13 or var_203_13 * (var_203_18 / var_203_17)

				if var_203_19 > 0 and var_203_13 < var_203_19 then
					arg_200_1.talkMaxDuration = var_203_19

					if var_203_19 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_19 + var_203_12
					end
				end

				arg_200_1.text_.text = var_203_16
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021051", "story_v_out_304021.awb") ~= 0 then
					local var_203_20 = manager.audio:GetVoiceLength("story_v_out_304021", "304021051", "story_v_out_304021.awb") / 1000

					if var_203_20 + var_203_12 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_20 + var_203_12
					end

					if var_203_15.prefab_name ~= "" and arg_200_1.actors_[var_203_15.prefab_name] ~= nil then
						local var_203_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_15.prefab_name].transform, "story_v_out_304021", "304021051", "story_v_out_304021.awb")

						arg_200_1:RecordAudio("304021051", var_203_21)
						arg_200_1:RecordAudio("304021051", var_203_21)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_304021", "304021051", "story_v_out_304021.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_304021", "304021051", "story_v_out_304021.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_22 = math.max(var_203_13, arg_200_1.talkMaxDuration)

			if var_203_12 <= arg_200_1.time_ and arg_200_1.time_ < var_203_12 + var_203_22 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_12) / var_203_22

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_12 + var_203_22 and arg_200_1.time_ < var_203_12 + var_203_22 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play304021052 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 304021052
		arg_204_1.duration_ = 11.97

		local var_204_0 = {
			zh = 9.566,
			ja = 11.966
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
				arg_204_0:Play304021053(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1019ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1019ui_story == nil then
				arg_204_1.var_.characterEffect1019ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1019ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1019ui_story then
				arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_207_4 = arg_204_1.actors_["1037ui_story"]
			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1037ui_story == nil then
				arg_204_1.var_.characterEffect1037ui_story = var_207_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_6 = 0.200000002980232

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_6 and not isNil(var_207_4) then
				local var_207_7 = (arg_204_1.time_ - var_207_5) / var_207_6

				if arg_204_1.var_.characterEffect1037ui_story and not isNil(var_207_4) then
					local var_207_8 = Mathf.Lerp(0, 0.5, var_207_7)

					arg_204_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1037ui_story.fillRatio = var_207_8
				end
			end

			if arg_204_1.time_ >= var_207_5 + var_207_6 and arg_204_1.time_ < var_207_5 + var_207_6 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1037ui_story then
				local var_207_9 = 0.5

				arg_204_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1037ui_story.fillRatio = var_207_9
			end

			local var_207_10 = 0
			local var_207_11 = 1.2

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_12 = arg_204_1:FormatText(StoryNameCfg[13].name)

				arg_204_1.leftNameTxt_.text = var_207_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_13 = arg_204_1:GetWordFromCfg(304021052)
				local var_207_14 = arg_204_1:FormatText(var_207_13.content)

				arg_204_1.text_.text = var_207_14

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_15 = 47
				local var_207_16 = utf8.len(var_207_14)
				local var_207_17 = var_207_15 <= 0 and var_207_11 or var_207_11 * (var_207_16 / var_207_15)

				if var_207_17 > 0 and var_207_11 < var_207_17 then
					arg_204_1.talkMaxDuration = var_207_17

					if var_207_17 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_17 + var_207_10
					end
				end

				arg_204_1.text_.text = var_207_14
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021052", "story_v_out_304021.awb") ~= 0 then
					local var_207_18 = manager.audio:GetVoiceLength("story_v_out_304021", "304021052", "story_v_out_304021.awb") / 1000

					if var_207_18 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_18 + var_207_10
					end

					if var_207_13.prefab_name ~= "" and arg_204_1.actors_[var_207_13.prefab_name] ~= nil then
						local var_207_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_13.prefab_name].transform, "story_v_out_304021", "304021052", "story_v_out_304021.awb")

						arg_204_1:RecordAudio("304021052", var_207_19)
						arg_204_1:RecordAudio("304021052", var_207_19)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_304021", "304021052", "story_v_out_304021.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_304021", "304021052", "story_v_out_304021.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_20 = math.max(var_207_11, arg_204_1.talkMaxDuration)

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_20 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_10) / var_207_20

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_10 + var_207_20 and arg_204_1.time_ < var_207_10 + var_207_20 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play304021053 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 304021053
		arg_208_1.duration_ = 8.5

		local var_208_0 = {
			zh = 6.866,
			ja = 8.5
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play304021054(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_211_2 = 0
			local var_211_3 = 0.95

			if var_211_2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_4 = arg_208_1:FormatText(StoryNameCfg[13].name)

				arg_208_1.leftNameTxt_.text = var_211_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_5 = arg_208_1:GetWordFromCfg(304021053)
				local var_211_6 = arg_208_1:FormatText(var_211_5.content)

				arg_208_1.text_.text = var_211_6

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 38
				local var_211_8 = utf8.len(var_211_6)
				local var_211_9 = var_211_7 <= 0 and var_211_3 or var_211_3 * (var_211_8 / var_211_7)

				if var_211_9 > 0 and var_211_3 < var_211_9 then
					arg_208_1.talkMaxDuration = var_211_9

					if var_211_9 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_9 + var_211_2
					end
				end

				arg_208_1.text_.text = var_211_6
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021053", "story_v_out_304021.awb") ~= 0 then
					local var_211_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021053", "story_v_out_304021.awb") / 1000

					if var_211_10 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_2
					end

					if var_211_5.prefab_name ~= "" and arg_208_1.actors_[var_211_5.prefab_name] ~= nil then
						local var_211_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_5.prefab_name].transform, "story_v_out_304021", "304021053", "story_v_out_304021.awb")

						arg_208_1:RecordAudio("304021053", var_211_11)
						arg_208_1:RecordAudio("304021053", var_211_11)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_304021", "304021053", "story_v_out_304021.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_304021", "304021053", "story_v_out_304021.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_12 = math.max(var_211_3, arg_208_1.talkMaxDuration)

			if var_211_2 <= arg_208_1.time_ and arg_208_1.time_ < var_211_2 + var_211_12 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_2) / var_211_12

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_2 + var_211_12 and arg_208_1.time_ < var_211_2 + var_211_12 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play304021054 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 304021054
		arg_212_1.duration_ = 2.5

		local var_212_0 = {
			zh = 2.5,
			ja = 1.333
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play304021055(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1037ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1037ui_story == nil then
				arg_212_1.var_.characterEffect1037ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1037ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1037ui_story then
				arg_212_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_215_4 = arg_212_1.actors_["1019ui_story"]
			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect1019ui_story == nil then
				arg_212_1.var_.characterEffect1019ui_story = var_215_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_6 = 0.200000002980232

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_6 and not isNil(var_215_4) then
				local var_215_7 = (arg_212_1.time_ - var_215_5) / var_215_6

				if arg_212_1.var_.characterEffect1019ui_story and not isNil(var_215_4) then
					local var_215_8 = Mathf.Lerp(0, 0.5, var_215_7)

					arg_212_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1019ui_story.fillRatio = var_215_8
				end
			end

			if arg_212_1.time_ >= var_215_5 + var_215_6 and arg_212_1.time_ < var_215_5 + var_215_6 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect1019ui_story then
				local var_215_9 = 0.5

				arg_212_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1019ui_story.fillRatio = var_215_9
			end

			local var_215_10 = 0
			local var_215_11 = 0.1

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_12 = arg_212_1:FormatText(StoryNameCfg[15].name)

				arg_212_1.leftNameTxt_.text = var_215_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_13 = arg_212_1:GetWordFromCfg(304021054)
				local var_215_14 = arg_212_1:FormatText(var_215_13.content)

				arg_212_1.text_.text = var_215_14

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_15 = 4
				local var_215_16 = utf8.len(var_215_14)
				local var_215_17 = var_215_15 <= 0 and var_215_11 or var_215_11 * (var_215_16 / var_215_15)

				if var_215_17 > 0 and var_215_11 < var_215_17 then
					arg_212_1.talkMaxDuration = var_215_17

					if var_215_17 + var_215_10 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_17 + var_215_10
					end
				end

				arg_212_1.text_.text = var_215_14
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021054", "story_v_out_304021.awb") ~= 0 then
					local var_215_18 = manager.audio:GetVoiceLength("story_v_out_304021", "304021054", "story_v_out_304021.awb") / 1000

					if var_215_18 + var_215_10 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_18 + var_215_10
					end

					if var_215_13.prefab_name ~= "" and arg_212_1.actors_[var_215_13.prefab_name] ~= nil then
						local var_215_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_13.prefab_name].transform, "story_v_out_304021", "304021054", "story_v_out_304021.awb")

						arg_212_1:RecordAudio("304021054", var_215_19)
						arg_212_1:RecordAudio("304021054", var_215_19)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_304021", "304021054", "story_v_out_304021.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_304021", "304021054", "story_v_out_304021.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_20 = math.max(var_215_11, arg_212_1.talkMaxDuration)

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_20 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_10) / var_215_20

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_10 + var_215_20 and arg_212_1.time_ < var_215_10 + var_215_20 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play304021055 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 304021055
		arg_216_1.duration_ = 16.77

		local var_216_0 = {
			zh = 10.466,
			ja = 16.766
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
				arg_216_0:Play304021056(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1019ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1019ui_story == nil then
				arg_216_1.var_.characterEffect1019ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1019ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1019ui_story then
				arg_216_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_219_4 = arg_216_1.actors_["1037ui_story"]
			local var_219_5 = 0

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect1037ui_story == nil then
				arg_216_1.var_.characterEffect1037ui_story = var_219_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_6 = 0.200000002980232

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_6 and not isNil(var_219_4) then
				local var_219_7 = (arg_216_1.time_ - var_219_5) / var_219_6

				if arg_216_1.var_.characterEffect1037ui_story and not isNil(var_219_4) then
					local var_219_8 = Mathf.Lerp(0, 0.5, var_219_7)

					arg_216_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1037ui_story.fillRatio = var_219_8
				end
			end

			if arg_216_1.time_ >= var_219_5 + var_219_6 and arg_216_1.time_ < var_219_5 + var_219_6 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect1037ui_story then
				local var_219_9 = 0.5

				arg_216_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1037ui_story.fillRatio = var_219_9
			end

			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 then
				arg_216_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_219_11 = 0

			if var_219_11 < arg_216_1.time_ and arg_216_1.time_ <= var_219_11 + arg_219_0 then
				arg_216_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_219_12 = 0
			local var_219_13 = 1.4

			if var_219_12 < arg_216_1.time_ and arg_216_1.time_ <= var_219_12 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_14 = arg_216_1:FormatText(StoryNameCfg[13].name)

				arg_216_1.leftNameTxt_.text = var_219_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_15 = arg_216_1:GetWordFromCfg(304021055)
				local var_219_16 = arg_216_1:FormatText(var_219_15.content)

				arg_216_1.text_.text = var_219_16

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_17 = 56
				local var_219_18 = utf8.len(var_219_16)
				local var_219_19 = var_219_17 <= 0 and var_219_13 or var_219_13 * (var_219_18 / var_219_17)

				if var_219_19 > 0 and var_219_13 < var_219_19 then
					arg_216_1.talkMaxDuration = var_219_19

					if var_219_19 + var_219_12 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_19 + var_219_12
					end
				end

				arg_216_1.text_.text = var_219_16
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021055", "story_v_out_304021.awb") ~= 0 then
					local var_219_20 = manager.audio:GetVoiceLength("story_v_out_304021", "304021055", "story_v_out_304021.awb") / 1000

					if var_219_20 + var_219_12 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_20 + var_219_12
					end

					if var_219_15.prefab_name ~= "" and arg_216_1.actors_[var_219_15.prefab_name] ~= nil then
						local var_219_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_15.prefab_name].transform, "story_v_out_304021", "304021055", "story_v_out_304021.awb")

						arg_216_1:RecordAudio("304021055", var_219_21)
						arg_216_1:RecordAudio("304021055", var_219_21)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_304021", "304021055", "story_v_out_304021.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_304021", "304021055", "story_v_out_304021.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_22 = math.max(var_219_13, arg_216_1.talkMaxDuration)

			if var_219_12 <= arg_216_1.time_ and arg_216_1.time_ < var_219_12 + var_219_22 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_12) / var_219_22

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_12 + var_219_22 and arg_216_1.time_ < var_219_12 + var_219_22 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play304021056 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 304021056
		arg_220_1.duration_ = 8.8

		local var_220_0 = {
			zh = 8.79933333631356,
			ja = 5.533333333332
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play304021057(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = "B13"

			if arg_220_1.bgs_[var_223_0] == nil then
				local var_223_1 = Object.Instantiate(arg_220_1.paintGo_)

				var_223_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_223_0)
				var_223_1.name = var_223_0
				var_223_1.transform.parent = arg_220_1.stage_.transform
				var_223_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.bgs_[var_223_0] = var_223_1
			end

			local var_223_2 = 1.8

			if var_223_2 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				local var_223_3 = manager.ui.mainCamera.transform.localPosition
				local var_223_4 = Vector3.New(0, 0, 10) + Vector3.New(var_223_3.x, var_223_3.y, 0)
				local var_223_5 = arg_220_1.bgs_.B13

				var_223_5.transform.localPosition = var_223_4
				var_223_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_223_6 = var_223_5:GetComponent("SpriteRenderer")

				if var_223_6 and var_223_6.sprite then
					local var_223_7 = (var_223_5.transform.localPosition - var_223_3).z
					local var_223_8 = manager.ui.mainCameraCom_
					local var_223_9 = 2 * var_223_7 * Mathf.Tan(var_223_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_223_10 = var_223_9 * var_223_8.aspect
					local var_223_11 = var_223_6.sprite.bounds.size.x
					local var_223_12 = var_223_6.sprite.bounds.size.y
					local var_223_13 = var_223_10 / var_223_11
					local var_223_14 = var_223_9 / var_223_12
					local var_223_15 = var_223_14 < var_223_13 and var_223_13 or var_223_14

					var_223_5.transform.localScale = Vector3.New(var_223_15, var_223_15, 0)
				end

				for iter_223_0, iter_223_1 in pairs(arg_220_1.bgs_) do
					if iter_223_0 ~= "B13" then
						iter_223_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_223_16 = 0

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1.allBtn_.enabled = false
			end

			local var_223_17 = 0.3

			if arg_220_1.time_ >= var_223_16 + var_223_17 and arg_220_1.time_ < var_223_16 + var_223_17 + arg_223_0 then
				arg_220_1.allBtn_.enabled = true
			end

			local var_223_18 = 0

			if var_223_18 < arg_220_1.time_ and arg_220_1.time_ <= var_223_18 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_19 = 1.8

			if var_223_18 <= arg_220_1.time_ and arg_220_1.time_ < var_223_18 + var_223_19 then
				local var_223_20 = (arg_220_1.time_ - var_223_18) / var_223_19
				local var_223_21 = Color.New(0, 0, 0)

				var_223_21.a = Mathf.Lerp(0, 1, var_223_20)
				arg_220_1.mask_.color = var_223_21
			end

			if arg_220_1.time_ >= var_223_18 + var_223_19 and arg_220_1.time_ < var_223_18 + var_223_19 + arg_223_0 then
				local var_223_22 = Color.New(0, 0, 0)

				var_223_22.a = 1
				arg_220_1.mask_.color = var_223_22
			end

			local var_223_23 = 1.8

			if var_223_23 < arg_220_1.time_ and arg_220_1.time_ <= var_223_23 + arg_223_0 then
				arg_220_1.mask_.enabled = true
				arg_220_1.mask_.raycastTarget = true

				arg_220_1:SetGaussion(false)
			end

			local var_223_24 = 2.2

			if var_223_23 <= arg_220_1.time_ and arg_220_1.time_ < var_223_23 + var_223_24 then
				local var_223_25 = (arg_220_1.time_ - var_223_23) / var_223_24
				local var_223_26 = Color.New(0, 0, 0)

				var_223_26.a = Mathf.Lerp(1, 0, var_223_25)
				arg_220_1.mask_.color = var_223_26
			end

			if arg_220_1.time_ >= var_223_23 + var_223_24 and arg_220_1.time_ < var_223_23 + var_223_24 + arg_223_0 then
				local var_223_27 = Color.New(0, 0, 0)
				local var_223_28 = 0

				arg_220_1.mask_.enabled = false
				var_223_27.a = var_223_28
				arg_220_1.mask_.color = var_223_27
			end

			local var_223_29 = arg_220_1.actors_["1084ui_story"].transform
			local var_223_30 = 3.53333333333333

			if var_223_30 < arg_220_1.time_ and arg_220_1.time_ <= var_223_30 + arg_223_0 then
				arg_220_1.var_.moveOldPos1084ui_story = var_223_29.localPosition
			end

			local var_223_31 = 0.001

			if var_223_30 <= arg_220_1.time_ and arg_220_1.time_ < var_223_30 + var_223_31 then
				local var_223_32 = (arg_220_1.time_ - var_223_30) / var_223_31
				local var_223_33 = Vector3.New(0, -0.97, -6)

				var_223_29.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1084ui_story, var_223_33, var_223_32)

				local var_223_34 = manager.ui.mainCamera.transform.position - var_223_29.position

				var_223_29.forward = Vector3.New(var_223_34.x, var_223_34.y, var_223_34.z)

				local var_223_35 = var_223_29.localEulerAngles

				var_223_35.z = 0
				var_223_35.x = 0
				var_223_29.localEulerAngles = var_223_35
			end

			if arg_220_1.time_ >= var_223_30 + var_223_31 and arg_220_1.time_ < var_223_30 + var_223_31 + arg_223_0 then
				var_223_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_223_36 = manager.ui.mainCamera.transform.position - var_223_29.position

				var_223_29.forward = Vector3.New(var_223_36.x, var_223_36.y, var_223_36.z)

				local var_223_37 = var_223_29.localEulerAngles

				var_223_37.z = 0
				var_223_37.x = 0
				var_223_29.localEulerAngles = var_223_37
			end

			local var_223_38 = arg_220_1.actors_["1037ui_story"].transform
			local var_223_39 = 1.8

			if var_223_39 < arg_220_1.time_ and arg_220_1.time_ <= var_223_39 + arg_223_0 then
				arg_220_1.var_.moveOldPos1037ui_story = var_223_38.localPosition
			end

			local var_223_40 = 0.001

			if var_223_39 <= arg_220_1.time_ and arg_220_1.time_ < var_223_39 + var_223_40 then
				local var_223_41 = (arg_220_1.time_ - var_223_39) / var_223_40
				local var_223_42 = Vector3.New(0, 100, 0)

				var_223_38.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1037ui_story, var_223_42, var_223_41)

				local var_223_43 = manager.ui.mainCamera.transform.position - var_223_38.position

				var_223_38.forward = Vector3.New(var_223_43.x, var_223_43.y, var_223_43.z)

				local var_223_44 = var_223_38.localEulerAngles

				var_223_44.z = 0
				var_223_44.x = 0
				var_223_38.localEulerAngles = var_223_44
			end

			if arg_220_1.time_ >= var_223_39 + var_223_40 and arg_220_1.time_ < var_223_39 + var_223_40 + arg_223_0 then
				var_223_38.localPosition = Vector3.New(0, 100, 0)

				local var_223_45 = manager.ui.mainCamera.transform.position - var_223_38.position

				var_223_38.forward = Vector3.New(var_223_45.x, var_223_45.y, var_223_45.z)

				local var_223_46 = var_223_38.localEulerAngles

				var_223_46.z = 0
				var_223_46.x = 0
				var_223_38.localEulerAngles = var_223_46
			end

			local var_223_47 = arg_220_1.actors_["1084ui_story"]
			local var_223_48 = 3.53333333333333

			if var_223_48 < arg_220_1.time_ and arg_220_1.time_ <= var_223_48 + arg_223_0 and not isNil(var_223_47) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_49 = 0.200000002980232

			if var_223_48 <= arg_220_1.time_ and arg_220_1.time_ < var_223_48 + var_223_49 and not isNil(var_223_47) then
				local var_223_50 = (arg_220_1.time_ - var_223_48) / var_223_49

				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_47) then
					arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_48 + var_223_49 and arg_220_1.time_ < var_223_48 + var_223_49 + arg_223_0 and not isNil(var_223_47) and arg_220_1.var_.characterEffect1084ui_story then
				arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_223_51 = arg_220_1.actors_["1019ui_story"]
			local var_223_52 = 3.53333333333333

			if var_223_52 < arg_220_1.time_ and arg_220_1.time_ <= var_223_52 + arg_223_0 and not isNil(var_223_51) and arg_220_1.var_.characterEffect1019ui_story == nil then
				arg_220_1.var_.characterEffect1019ui_story = var_223_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_53 = 0.200000002980232

			if var_223_52 <= arg_220_1.time_ and arg_220_1.time_ < var_223_52 + var_223_53 and not isNil(var_223_51) then
				local var_223_54 = (arg_220_1.time_ - var_223_52) / var_223_53

				if arg_220_1.var_.characterEffect1019ui_story and not isNil(var_223_51) then
					local var_223_55 = Mathf.Lerp(0, 0.5, var_223_54)

					arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1019ui_story.fillRatio = var_223_55
				end
			end

			if arg_220_1.time_ >= var_223_52 + var_223_53 and arg_220_1.time_ < var_223_52 + var_223_53 + arg_223_0 and not isNil(var_223_51) and arg_220_1.var_.characterEffect1019ui_story then
				local var_223_56 = 0.5

				arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1019ui_story.fillRatio = var_223_56
			end

			local var_223_57 = 3.53333333333333

			if var_223_57 < arg_220_1.time_ and arg_220_1.time_ <= var_223_57 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_223_58 = 3.53333333333333

			if var_223_58 < arg_220_1.time_ and arg_220_1.time_ <= var_223_58 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_223_59 = arg_220_1.actors_["1037ui_story"].transform
			local var_223_60 = 1.8

			if var_223_60 < arg_220_1.time_ and arg_220_1.time_ <= var_223_60 + arg_223_0 then
				arg_220_1.var_.moveOldPos1037ui_story = var_223_59.localPosition
			end

			local var_223_61 = 0.001

			if var_223_60 <= arg_220_1.time_ and arg_220_1.time_ < var_223_60 + var_223_61 then
				local var_223_62 = (arg_220_1.time_ - var_223_60) / var_223_61
				local var_223_63 = Vector3.New(0, 100, 0)

				var_223_59.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1037ui_story, var_223_63, var_223_62)

				local var_223_64 = manager.ui.mainCamera.transform.position - var_223_59.position

				var_223_59.forward = Vector3.New(var_223_64.x, var_223_64.y, var_223_64.z)

				local var_223_65 = var_223_59.localEulerAngles

				var_223_65.z = 0
				var_223_65.x = 0
				var_223_59.localEulerAngles = var_223_65
			end

			if arg_220_1.time_ >= var_223_60 + var_223_61 and arg_220_1.time_ < var_223_60 + var_223_61 + arg_223_0 then
				var_223_59.localPosition = Vector3.New(0, 100, 0)

				local var_223_66 = manager.ui.mainCamera.transform.position - var_223_59.position

				var_223_59.forward = Vector3.New(var_223_66.x, var_223_66.y, var_223_66.z)

				local var_223_67 = var_223_59.localEulerAngles

				var_223_67.z = 0
				var_223_67.x = 0
				var_223_59.localEulerAngles = var_223_67
			end

			local var_223_68 = arg_220_1.actors_["1019ui_story"].transform
			local var_223_69 = 1.8

			if var_223_69 < arg_220_1.time_ and arg_220_1.time_ <= var_223_69 + arg_223_0 then
				arg_220_1.var_.moveOldPos1019ui_story = var_223_68.localPosition
			end

			local var_223_70 = 0.001

			if var_223_69 <= arg_220_1.time_ and arg_220_1.time_ < var_223_69 + var_223_70 then
				local var_223_71 = (arg_220_1.time_ - var_223_69) / var_223_70
				local var_223_72 = Vector3.New(0, 100, 0)

				var_223_68.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1019ui_story, var_223_72, var_223_71)

				local var_223_73 = manager.ui.mainCamera.transform.position - var_223_68.position

				var_223_68.forward = Vector3.New(var_223_73.x, var_223_73.y, var_223_73.z)

				local var_223_74 = var_223_68.localEulerAngles

				var_223_74.z = 0
				var_223_74.x = 0
				var_223_68.localEulerAngles = var_223_74
			end

			if arg_220_1.time_ >= var_223_69 + var_223_70 and arg_220_1.time_ < var_223_69 + var_223_70 + arg_223_0 then
				var_223_68.localPosition = Vector3.New(0, 100, 0)

				local var_223_75 = manager.ui.mainCamera.transform.position - var_223_68.position

				var_223_68.forward = Vector3.New(var_223_75.x, var_223_75.y, var_223_75.z)

				local var_223_76 = var_223_68.localEulerAngles

				var_223_76.z = 0
				var_223_76.x = 0
				var_223_68.localEulerAngles = var_223_76
			end

			local var_223_77 = 1.2
			local var_223_78 = 1

			if var_223_77 < arg_220_1.time_ and arg_220_1.time_ <= var_223_77 + arg_223_0 then
				local var_223_79 = "play"
				local var_223_80 = "effect"

				arg_220_1:AudioAction(var_223_79, var_223_80, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_223_81 = 0.2
			local var_223_82 = 1

			if var_223_81 < arg_220_1.time_ and arg_220_1.time_ <= var_223_81 + arg_223_0 then
				local var_223_83 = "stop"
				local var_223_84 = "effect"

				arg_220_1:AudioAction(var_223_83, var_223_84, "se_story_142", "se_story_142_amb_command room", "")
			end

			if arg_220_1.frameCnt_ <= 1 then
				arg_220_1.dialog_:SetActive(false)
			end

			local var_223_85 = 3.73333333631356
			local var_223_86 = 0.7

			if var_223_85 < arg_220_1.time_ and arg_220_1.time_ <= var_223_85 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0

				arg_220_1.dialog_:SetActive(true)

				arg_220_1.dialogCg_.alpha = 0

				local var_223_87 = LeanTween.value(arg_220_1.dialog_, 0, 1, 0.3)

				var_223_87:setOnUpdate(LuaHelper.FloatAction(function(arg_224_0)
					arg_220_1.dialogCg_.alpha = arg_224_0
				end))
				var_223_87:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_220_1.dialog_)
					var_223_87:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_220_1.duration_ = arg_220_1.duration_ + 0.3

				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_88 = arg_220_1:FormatText(StoryNameCfg[6].name)

				arg_220_1.leftNameTxt_.text = var_223_88

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_89 = arg_220_1:GetWordFromCfg(304021056)
				local var_223_90 = arg_220_1:FormatText(var_223_89.content)

				arg_220_1.text_.text = var_223_90

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_91 = 28
				local var_223_92 = utf8.len(var_223_90)
				local var_223_93 = var_223_91 <= 0 and var_223_86 or var_223_86 * (var_223_92 / var_223_91)

				if var_223_93 > 0 and var_223_86 < var_223_93 then
					arg_220_1.talkMaxDuration = var_223_93
					var_223_85 = var_223_85 + 0.3

					if var_223_93 + var_223_85 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_93 + var_223_85
					end
				end

				arg_220_1.text_.text = var_223_90
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021056", "story_v_out_304021.awb") ~= 0 then
					local var_223_94 = manager.audio:GetVoiceLength("story_v_out_304021", "304021056", "story_v_out_304021.awb") / 1000

					if var_223_94 + var_223_85 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_94 + var_223_85
					end

					if var_223_89.prefab_name ~= "" and arg_220_1.actors_[var_223_89.prefab_name] ~= nil then
						local var_223_95 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_89.prefab_name].transform, "story_v_out_304021", "304021056", "story_v_out_304021.awb")

						arg_220_1:RecordAudio("304021056", var_223_95)
						arg_220_1:RecordAudio("304021056", var_223_95)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_304021", "304021056", "story_v_out_304021.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_304021", "304021056", "story_v_out_304021.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_96 = var_223_85 + 0.3
			local var_223_97 = math.max(var_223_86, arg_220_1.talkMaxDuration)

			if var_223_96 <= arg_220_1.time_ and arg_220_1.time_ < var_223_96 + var_223_97 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_96) / var_223_97

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_96 + var_223_97 and arg_220_1.time_ < var_223_96 + var_223_97 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play304021057 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 304021057
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play304021058(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1084ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1084ui_story == nil then
				arg_226_1.var_.characterEffect1084ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1084ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1084ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1084ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1084ui_story.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 0.275

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_9 = arg_226_1:GetWordFromCfg(304021057)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 11
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play304021058 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 304021058
		arg_230_1.duration_ = 6.27

		local var_230_0 = {
			zh = 6.266,
			ja = 1.333
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play304021059(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1084ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1084ui_story and not isNil(var_233_0) then
					arg_230_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1084ui_story then
				arg_230_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_233_4 = 0
			local var_233_5 = 0.825

			if var_233_4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_6 = arg_230_1:FormatText(StoryNameCfg[6].name)

				arg_230_1.leftNameTxt_.text = var_233_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_7 = arg_230_1:GetWordFromCfg(304021058)
				local var_233_8 = arg_230_1:FormatText(var_233_7.content)

				arg_230_1.text_.text = var_233_8

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 33
				local var_233_10 = utf8.len(var_233_8)
				local var_233_11 = var_233_9 <= 0 and var_233_5 or var_233_5 * (var_233_10 / var_233_9)

				if var_233_11 > 0 and var_233_5 < var_233_11 then
					arg_230_1.talkMaxDuration = var_233_11

					if var_233_11 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_8
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021058", "story_v_out_304021.awb") ~= 0 then
					local var_233_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021058", "story_v_out_304021.awb") / 1000

					if var_233_12 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_4
					end

					if var_233_7.prefab_name ~= "" and arg_230_1.actors_[var_233_7.prefab_name] ~= nil then
						local var_233_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_7.prefab_name].transform, "story_v_out_304021", "304021058", "story_v_out_304021.awb")

						arg_230_1:RecordAudio("304021058", var_233_13)
						arg_230_1:RecordAudio("304021058", var_233_13)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_304021", "304021058", "story_v_out_304021.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_304021", "304021058", "story_v_out_304021.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_14 and arg_230_1.time_ < var_233_4 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play304021059 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 304021059
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play304021060(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1084ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1084ui_story == nil then
				arg_234_1.var_.characterEffect1084ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1084ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1084ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1084ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1084ui_story.fillRatio = var_237_5
			end

			local var_237_6 = 0
			local var_237_7 = 1.1

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_8 = arg_234_1:FormatText(StoryNameCfg[7].name)

				arg_234_1.leftNameTxt_.text = var_237_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_9 = arg_234_1:GetWordFromCfg(304021059)
				local var_237_10 = arg_234_1:FormatText(var_237_9.content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 44
				local var_237_12 = utf8.len(var_237_10)
				local var_237_13 = var_237_11 <= 0 and var_237_7 or var_237_7 * (var_237_12 / var_237_11)

				if var_237_13 > 0 and var_237_7 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_10
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play304021060 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 304021060
		arg_238_1.duration_ = 6.57

		local var_238_0 = {
			zh = 6.566,
			ja = 1.999999999999
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
				arg_238_0:Play304021061(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1084ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_0) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_241_4 = 0

			if var_241_4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action482")
			end

			local var_241_5 = 0

			if var_241_5 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_241_6 = 0
			local var_241_7 = 0.75

			if var_241_6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_8 = arg_238_1:FormatText(StoryNameCfg[6].name)

				arg_238_1.leftNameTxt_.text = var_241_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_9 = arg_238_1:GetWordFromCfg(304021060)
				local var_241_10 = arg_238_1:FormatText(var_241_9.content)

				arg_238_1.text_.text = var_241_10

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 30
				local var_241_12 = utf8.len(var_241_10)
				local var_241_13 = var_241_11 <= 0 and var_241_7 or var_241_7 * (var_241_12 / var_241_11)

				if var_241_13 > 0 and var_241_7 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_10
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021060", "story_v_out_304021.awb") ~= 0 then
					local var_241_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021060", "story_v_out_304021.awb") / 1000

					if var_241_14 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_6
					end

					if var_241_9.prefab_name ~= "" and arg_238_1.actors_[var_241_9.prefab_name] ~= nil then
						local var_241_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_9.prefab_name].transform, "story_v_out_304021", "304021060", "story_v_out_304021.awb")

						arg_238_1:RecordAudio("304021060", var_241_15)
						arg_238_1:RecordAudio("304021060", var_241_15)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_304021", "304021060", "story_v_out_304021.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_304021", "304021060", "story_v_out_304021.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_16 and arg_238_1.time_ < var_241_6 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play304021061 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 304021061
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play304021062(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1084ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1084ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1084ui_story.fillRatio = var_245_5
			end

			local var_245_6 = 0
			local var_245_7 = 0.625

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[7].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_9 = arg_242_1:GetWordFromCfg(304021061)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 25
				local var_245_12 = utf8.len(var_245_10)
				local var_245_13 = var_245_11 <= 0 and var_245_7 or var_245_7 * (var_245_12 / var_245_11)

				if var_245_13 > 0 and var_245_7 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_10
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_14 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_14 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_14

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_14 and arg_242_1.time_ < var_245_6 + var_245_14 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play304021062 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 304021062
		arg_246_1.duration_ = 7.1

		local var_246_0 = {
			zh = 7.1,
			ja = 4.666
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play304021063(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1011ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1011ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, -0.71, -6)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1011ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["1084ui_story"].transform
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.var_.moveOldPos1084ui_story = var_249_9.localPosition
			end

			local var_249_11 = 0.001

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11
				local var_249_13 = Vector3.New(0, 100, 0)

				var_249_9.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1084ui_story, var_249_13, var_249_12)

				local var_249_14 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_14.x, var_249_14.y, var_249_14.z)

				local var_249_15 = var_249_9.localEulerAngles

				var_249_15.z = 0
				var_249_15.x = 0
				var_249_9.localEulerAngles = var_249_15
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 then
				var_249_9.localPosition = Vector3.New(0, 100, 0)

				local var_249_16 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_16.x, var_249_16.y, var_249_16.z)

				local var_249_17 = var_249_9.localEulerAngles

				var_249_17.z = 0
				var_249_17.x = 0
				var_249_9.localEulerAngles = var_249_17
			end

			local var_249_18 = arg_246_1.actors_["1011ui_story"]
			local var_249_19 = 0

			if var_249_19 < arg_246_1.time_ and arg_246_1.time_ <= var_249_19 + arg_249_0 and not isNil(var_249_18) and arg_246_1.var_.characterEffect1011ui_story == nil then
				arg_246_1.var_.characterEffect1011ui_story = var_249_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_20 = 0.200000002980232

			if var_249_19 <= arg_246_1.time_ and arg_246_1.time_ < var_249_19 + var_249_20 and not isNil(var_249_18) then
				local var_249_21 = (arg_246_1.time_ - var_249_19) / var_249_20

				if arg_246_1.var_.characterEffect1011ui_story and not isNil(var_249_18) then
					arg_246_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_19 + var_249_20 and arg_246_1.time_ < var_249_19 + var_249_20 + arg_249_0 and not isNil(var_249_18) and arg_246_1.var_.characterEffect1011ui_story then
				arg_246_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_249_22 = 0

			if var_249_22 < arg_246_1.time_ and arg_246_1.time_ <= var_249_22 + arg_249_0 then
				arg_246_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_249_23 = 0

			if var_249_23 < arg_246_1.time_ and arg_246_1.time_ <= var_249_23 + arg_249_0 then
				arg_246_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_249_24 = 0
			local var_249_25 = 0.7

			if var_249_24 < arg_246_1.time_ and arg_246_1.time_ <= var_249_24 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_26 = arg_246_1:FormatText(StoryNameCfg[37].name)

				arg_246_1.leftNameTxt_.text = var_249_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_27 = arg_246_1:GetWordFromCfg(304021062)
				local var_249_28 = arg_246_1:FormatText(var_249_27.content)

				arg_246_1.text_.text = var_249_28

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_29 = 28
				local var_249_30 = utf8.len(var_249_28)
				local var_249_31 = var_249_29 <= 0 and var_249_25 or var_249_25 * (var_249_30 / var_249_29)

				if var_249_31 > 0 and var_249_25 < var_249_31 then
					arg_246_1.talkMaxDuration = var_249_31

					if var_249_31 + var_249_24 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_31 + var_249_24
					end
				end

				arg_246_1.text_.text = var_249_28
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021062", "story_v_out_304021.awb") ~= 0 then
					local var_249_32 = manager.audio:GetVoiceLength("story_v_out_304021", "304021062", "story_v_out_304021.awb") / 1000

					if var_249_32 + var_249_24 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_32 + var_249_24
					end

					if var_249_27.prefab_name ~= "" and arg_246_1.actors_[var_249_27.prefab_name] ~= nil then
						local var_249_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_27.prefab_name].transform, "story_v_out_304021", "304021062", "story_v_out_304021.awb")

						arg_246_1:RecordAudio("304021062", var_249_33)
						arg_246_1:RecordAudio("304021062", var_249_33)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_304021", "304021062", "story_v_out_304021.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_304021", "304021062", "story_v_out_304021.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_34 = math.max(var_249_25, arg_246_1.talkMaxDuration)

			if var_249_24 <= arg_246_1.time_ and arg_246_1.time_ < var_249_24 + var_249_34 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_24) / var_249_34

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_24 + var_249_34 and arg_246_1.time_ < var_249_24 + var_249_34 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play304021063 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 304021063
		arg_250_1.duration_ = 7.37

		local var_250_0 = {
			zh = 7.366,
			ja = 6.6
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play304021064(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.725

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[37].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(304021063)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 29
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021063", "story_v_out_304021.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021063", "story_v_out_304021.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_304021", "304021063", "story_v_out_304021.awb")

						arg_250_1:RecordAudio("304021063", var_253_9)
						arg_250_1:RecordAudio("304021063", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_304021", "304021063", "story_v_out_304021.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_304021", "304021063", "story_v_out_304021.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play304021064 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 304021064
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play304021065(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1011ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1011ui_story == nil then
				arg_254_1.var_.characterEffect1011ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1011ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1011ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1011ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1011ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 0.65

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[7].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_9 = arg_254_1:GetWordFromCfg(304021064)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 26
				local var_257_12 = utf8.len(var_257_10)
				local var_257_13 = var_257_11 <= 0 and var_257_7 or var_257_7 * (var_257_12 / var_257_11)

				if var_257_13 > 0 and var_257_7 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play304021065 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 304021065
		arg_258_1.duration_ = 8.13

		local var_258_0 = {
			zh = 7.866,
			ja = 8.133
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
				arg_258_0:Play304021066(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1011ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1011ui_story == nil then
				arg_258_1.var_.characterEffect1011ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect1011ui_story and not isNil(var_261_0) then
					arg_258_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1011ui_story then
				arg_258_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_261_4 = 0

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			local var_261_5 = 0
			local var_261_6 = 0.725

			if var_261_5 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_7 = arg_258_1:FormatText(StoryNameCfg[37].name)

				arg_258_1.leftNameTxt_.text = var_261_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(304021065)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_10 = 29
				local var_261_11 = utf8.len(var_261_9)
				local var_261_12 = var_261_10 <= 0 and var_261_6 or var_261_6 * (var_261_11 / var_261_10)

				if var_261_12 > 0 and var_261_6 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021065", "story_v_out_304021.awb") ~= 0 then
					local var_261_13 = manager.audio:GetVoiceLength("story_v_out_304021", "304021065", "story_v_out_304021.awb") / 1000

					if var_261_13 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_5
					end

					if var_261_8.prefab_name ~= "" and arg_258_1.actors_[var_261_8.prefab_name] ~= nil then
						local var_261_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_8.prefab_name].transform, "story_v_out_304021", "304021065", "story_v_out_304021.awb")

						arg_258_1:RecordAudio("304021065", var_261_14)
						arg_258_1:RecordAudio("304021065", var_261_14)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_304021", "304021065", "story_v_out_304021.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_304021", "304021065", "story_v_out_304021.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_15 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_15 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_15

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_15 and arg_258_1.time_ < var_261_5 + var_261_15 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play304021066 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 304021066
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play304021067(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1011ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1011ui_story == nil then
				arg_262_1.var_.characterEffect1011ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1011ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1011ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1011ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1011ui_story.fillRatio = var_265_5
			end

			local var_265_6 = 0
			local var_265_7 = 0.2

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_8 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_9 = arg_262_1:GetWordFromCfg(304021066)
				local var_265_10 = arg_262_1:FormatText(var_265_9.content)

				arg_262_1.text_.text = var_265_10

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 8
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
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_14 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_14 and arg_262_1.time_ < var_265_6 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play304021067 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 304021067
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play304021068(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1011ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1011ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, 100, 0)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1011ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, 100, 0)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = 0
			local var_269_10 = 1.4

			if var_269_9 < arg_266_1.time_ and arg_266_1.time_ <= var_269_9 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_11 = arg_266_1:GetWordFromCfg(304021067)
				local var_269_12 = arg_266_1:FormatText(var_269_11.content)

				arg_266_1.text_.text = var_269_12

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_13 = 56
				local var_269_14 = utf8.len(var_269_12)
				local var_269_15 = var_269_13 <= 0 and var_269_10 or var_269_10 * (var_269_14 / var_269_13)

				if var_269_15 > 0 and var_269_10 < var_269_15 then
					arg_266_1.talkMaxDuration = var_269_15

					if var_269_15 + var_269_9 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_15 + var_269_9
					end
				end

				arg_266_1.text_.text = var_269_12
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_10, arg_266_1.talkMaxDuration)

			if var_269_9 <= arg_266_1.time_ and arg_266_1.time_ < var_269_9 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_9) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_9 + var_269_16 and arg_266_1.time_ < var_269_9 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play304021068 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 304021068
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play304021069(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.375

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(304021068)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 15
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play304021069 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 304021069
		arg_274_1.duration_ = 5.7

		local var_274_0 = {
			zh = 5.7,
			ja = 1.999999999999
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
				arg_274_0:Play304021070(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1037ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1037ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, -1.09, -5.81)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1037ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["1037ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1037ui_story == nil then
				arg_274_1.var_.characterEffect1037ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect1037ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1037ui_story then
				arg_274_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_277_15 = 0
			local var_277_16 = 0.8

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_17 = arg_274_1:FormatText(StoryNameCfg[15].name)

				arg_274_1.leftNameTxt_.text = var_277_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_18 = arg_274_1:GetWordFromCfg(304021069)
				local var_277_19 = arg_274_1:FormatText(var_277_18.content)

				arg_274_1.text_.text = var_277_19

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_20 = 32
				local var_277_21 = utf8.len(var_277_19)
				local var_277_22 = var_277_20 <= 0 and var_277_16 or var_277_16 * (var_277_21 / var_277_20)

				if var_277_22 > 0 and var_277_16 < var_277_22 then
					arg_274_1.talkMaxDuration = var_277_22

					if var_277_22 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_22 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_19
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021069", "story_v_out_304021.awb") ~= 0 then
					local var_277_23 = manager.audio:GetVoiceLength("story_v_out_304021", "304021069", "story_v_out_304021.awb") / 1000

					if var_277_23 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_15
					end

					if var_277_18.prefab_name ~= "" and arg_274_1.actors_[var_277_18.prefab_name] ~= nil then
						local var_277_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_18.prefab_name].transform, "story_v_out_304021", "304021069", "story_v_out_304021.awb")

						arg_274_1:RecordAudio("304021069", var_277_24)
						arg_274_1:RecordAudio("304021069", var_277_24)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_304021", "304021069", "story_v_out_304021.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_304021", "304021069", "story_v_out_304021.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_25 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_25

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_25 and arg_274_1.time_ < var_277_15 + var_277_25 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play304021070 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 304021070
		arg_278_1.duration_ = 8.8

		local var_278_0 = {
			zh = 8.8,
			ja = 1.333
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
				arg_278_0:Play304021071(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.925

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[15].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:GetWordFromCfg(304021070)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 37
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021070", "story_v_out_304021.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021070", "story_v_out_304021.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_304021", "304021070", "story_v_out_304021.awb")

						arg_278_1:RecordAudio("304021070", var_281_9)
						arg_278_1:RecordAudio("304021070", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_304021", "304021070", "story_v_out_304021.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_304021", "304021070", "story_v_out_304021.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play304021071 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 304021071
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play304021072(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1037ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1037ui_story == nil then
				arg_282_1.var_.characterEffect1037ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1037ui_story and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1037ui_story.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1037ui_story then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1037ui_story.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.3

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_8 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_9 = arg_282_1:GetWordFromCfg(304021071)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 12
				local var_285_12 = utf8.len(var_285_10)
				local var_285_13 = var_285_11 <= 0 and var_285_7 or var_285_7 * (var_285_12 / var_285_11)

				if var_285_13 > 0 and var_285_7 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_14 and arg_282_1.time_ < var_285_6 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play304021072 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 304021072
		arg_286_1.duration_ = 7.57

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play304021073(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = "STblack"

			if arg_286_1.bgs_[var_289_0] == nil then
				local var_289_1 = Object.Instantiate(arg_286_1.paintGo_)

				var_289_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_289_0)
				var_289_1.name = var_289_0
				var_289_1.transform.parent = arg_286_1.stage_.transform
				var_289_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.bgs_[var_289_0] = var_289_1
			end

			local var_289_2 = 1.2

			if var_289_2 < arg_286_1.time_ and arg_286_1.time_ <= var_289_2 + arg_289_0 then
				local var_289_3 = manager.ui.mainCamera.transform.localPosition
				local var_289_4 = Vector3.New(0, 0, 10) + Vector3.New(var_289_3.x, var_289_3.y, 0)
				local var_289_5 = arg_286_1.bgs_.STblack

				var_289_5.transform.localPosition = var_289_4
				var_289_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_6 = var_289_5:GetComponent("SpriteRenderer")

				if var_289_6 and var_289_6.sprite then
					local var_289_7 = (var_289_5.transform.localPosition - var_289_3).z
					local var_289_8 = manager.ui.mainCameraCom_
					local var_289_9 = 2 * var_289_7 * Mathf.Tan(var_289_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_289_10 = var_289_9 * var_289_8.aspect
					local var_289_11 = var_289_6.sprite.bounds.size.x
					local var_289_12 = var_289_6.sprite.bounds.size.y
					local var_289_13 = var_289_10 / var_289_11
					local var_289_14 = var_289_9 / var_289_12
					local var_289_15 = var_289_14 < var_289_13 and var_289_13 or var_289_14

					var_289_5.transform.localScale = Vector3.New(var_289_15, var_289_15, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "STblack" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_16 = 0

			if var_289_16 < arg_286_1.time_ and arg_286_1.time_ <= var_289_16 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			local var_289_17 = 0.3

			if arg_286_1.time_ >= var_289_16 + var_289_17 and arg_286_1.time_ < var_289_16 + var_289_17 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_18 = 0

			if var_289_18 < arg_286_1.time_ and arg_286_1.time_ <= var_289_18 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_19 = 1.2

			if var_289_18 <= arg_286_1.time_ and arg_286_1.time_ < var_289_18 + var_289_19 then
				local var_289_20 = (arg_286_1.time_ - var_289_18) / var_289_19
				local var_289_21 = Color.New(0, 0, 0)

				var_289_21.a = Mathf.Lerp(0, 1, var_289_20)
				arg_286_1.mask_.color = var_289_21
			end

			if arg_286_1.time_ >= var_289_18 + var_289_19 and arg_286_1.time_ < var_289_18 + var_289_19 + arg_289_0 then
				local var_289_22 = Color.New(0, 0, 0)

				var_289_22.a = 1
				arg_286_1.mask_.color = var_289_22
			end

			local var_289_23 = 1.2

			if var_289_23 < arg_286_1.time_ and arg_286_1.time_ <= var_289_23 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_24 = 1.6

			if var_289_23 <= arg_286_1.time_ and arg_286_1.time_ < var_289_23 + var_289_24 then
				local var_289_25 = (arg_286_1.time_ - var_289_23) / var_289_24
				local var_289_26 = Color.New(0, 0, 0)

				var_289_26.a = Mathf.Lerp(1, 0, var_289_25)
				arg_286_1.mask_.color = var_289_26
			end

			if arg_286_1.time_ >= var_289_23 + var_289_24 and arg_286_1.time_ < var_289_23 + var_289_24 + arg_289_0 then
				local var_289_27 = Color.New(0, 0, 0)
				local var_289_28 = 0

				arg_286_1.mask_.enabled = false
				var_289_27.a = var_289_28
				arg_286_1.mask_.color = var_289_27
			end

			local var_289_29 = arg_286_1.actors_["1037ui_story"].transform
			local var_289_30 = 1.2

			if var_289_30 < arg_286_1.time_ and arg_286_1.time_ <= var_289_30 + arg_289_0 then
				arg_286_1.var_.moveOldPos1037ui_story = var_289_29.localPosition
			end

			local var_289_31 = 0.001

			if var_289_30 <= arg_286_1.time_ and arg_286_1.time_ < var_289_30 + var_289_31 then
				local var_289_32 = (arg_286_1.time_ - var_289_30) / var_289_31
				local var_289_33 = Vector3.New(0, 100, 0)

				var_289_29.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1037ui_story, var_289_33, var_289_32)

				local var_289_34 = manager.ui.mainCamera.transform.position - var_289_29.position

				var_289_29.forward = Vector3.New(var_289_34.x, var_289_34.y, var_289_34.z)

				local var_289_35 = var_289_29.localEulerAngles

				var_289_35.z = 0
				var_289_35.x = 0
				var_289_29.localEulerAngles = var_289_35
			end

			if arg_286_1.time_ >= var_289_30 + var_289_31 and arg_286_1.time_ < var_289_30 + var_289_31 + arg_289_0 then
				var_289_29.localPosition = Vector3.New(0, 100, 0)

				local var_289_36 = manager.ui.mainCamera.transform.position - var_289_29.position

				var_289_29.forward = Vector3.New(var_289_36.x, var_289_36.y, var_289_36.z)

				local var_289_37 = var_289_29.localEulerAngles

				var_289_37.z = 0
				var_289_37.x = 0
				var_289_29.localEulerAngles = var_289_37
			end

			local var_289_38 = 1
			local var_289_39 = 1

			if var_289_38 < arg_286_1.time_ and arg_286_1.time_ <= var_289_38 + arg_289_0 then
				local var_289_40 = "play"
				local var_289_41 = "effect"

				arg_286_1:AudioAction(var_289_40, var_289_41, "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_42 = 2.56666666666667
			local var_289_43 = 0.075

			if var_289_42 < arg_286_1.time_ and arg_286_1.time_ <= var_289_42 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_44 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_44:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_45 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_46 = arg_286_1:GetWordFromCfg(304021072)
				local var_289_47 = arg_286_1:FormatText(var_289_46.content)

				arg_286_1.text_.text = var_289_47

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_48 = 3
				local var_289_49 = utf8.len(var_289_47)
				local var_289_50 = var_289_48 <= 0 and var_289_43 or var_289_43 * (var_289_49 / var_289_48)

				if var_289_50 > 0 and var_289_43 < var_289_50 then
					arg_286_1.talkMaxDuration = var_289_50
					var_289_42 = var_289_42 + 0.3

					if var_289_50 + var_289_42 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_50 + var_289_42
					end
				end

				arg_286_1.text_.text = var_289_47
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_51 = var_289_42 + 0.3
			local var_289_52 = math.max(var_289_43, arg_286_1.talkMaxDuration)

			if var_289_51 <= arg_286_1.time_ and arg_286_1.time_ < var_289_51 + var_289_52 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_51) / var_289_52

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_51 + var_289_52 and arg_286_1.time_ < var_289_51 + var_289_52 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play304021073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 304021073
		arg_292_1.duration_ = 6.77

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play304021074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = "D02a"

			if arg_292_1.bgs_[var_295_0] == nil then
				local var_295_1 = Object.Instantiate(arg_292_1.paintGo_)

				var_295_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_295_0)
				var_295_1.name = var_295_0
				var_295_1.transform.parent = arg_292_1.stage_.transform
				var_295_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.bgs_[var_295_0] = var_295_1
			end

			local var_295_2 = 0

			if var_295_2 < arg_292_1.time_ and arg_292_1.time_ <= var_295_2 + arg_295_0 then
				local var_295_3 = manager.ui.mainCamera.transform.localPosition
				local var_295_4 = Vector3.New(0, 0, 10) + Vector3.New(var_295_3.x, var_295_3.y, 0)
				local var_295_5 = arg_292_1.bgs_.D02a

				var_295_5.transform.localPosition = var_295_4
				var_295_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_295_6 = var_295_5:GetComponent("SpriteRenderer")

				if var_295_6 and var_295_6.sprite then
					local var_295_7 = (var_295_5.transform.localPosition - var_295_3).z
					local var_295_8 = manager.ui.mainCameraCom_
					local var_295_9 = 2 * var_295_7 * Mathf.Tan(var_295_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_295_10 = var_295_9 * var_295_8.aspect
					local var_295_11 = var_295_6.sprite.bounds.size.x
					local var_295_12 = var_295_6.sprite.bounds.size.y
					local var_295_13 = var_295_10 / var_295_11
					local var_295_14 = var_295_9 / var_295_12
					local var_295_15 = var_295_14 < var_295_13 and var_295_13 or var_295_14

					var_295_5.transform.localScale = Vector3.New(var_295_15, var_295_15, 0)
				end

				for iter_295_0, iter_295_1 in pairs(arg_292_1.bgs_) do
					if iter_295_0 ~= "D02a" then
						iter_295_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_295_16 = 0

			if var_295_16 < arg_292_1.time_ and arg_292_1.time_ <= var_295_16 + arg_295_0 then
				arg_292_1.allBtn_.enabled = false
			end

			local var_295_17 = 0.3

			if arg_292_1.time_ >= var_295_16 + var_295_17 and arg_292_1.time_ < var_295_16 + var_295_17 + arg_295_0 then
				arg_292_1.allBtn_.enabled = true
			end

			local var_295_18 = 0

			if var_295_18 < arg_292_1.time_ and arg_292_1.time_ <= var_295_18 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = true

				arg_292_1:SetGaussion(false)
			end

			local var_295_19 = 2

			if var_295_18 <= arg_292_1.time_ and arg_292_1.time_ < var_295_18 + var_295_19 then
				local var_295_20 = (arg_292_1.time_ - var_295_18) / var_295_19
				local var_295_21 = Color.New(0, 0, 0)

				var_295_21.a = Mathf.Lerp(1, 0, var_295_20)
				arg_292_1.mask_.color = var_295_21
			end

			if arg_292_1.time_ >= var_295_18 + var_295_19 and arg_292_1.time_ < var_295_18 + var_295_19 + arg_295_0 then
				local var_295_22 = Color.New(0, 0, 0)
				local var_295_23 = 0

				arg_292_1.mask_.enabled = false
				var_295_22.a = var_295_23
				arg_292_1.mask_.color = var_295_22
			end

			local var_295_24 = 1
			local var_295_25 = 1

			if var_295_24 < arg_292_1.time_ and arg_292_1.time_ <= var_295_24 + arg_295_0 then
				local var_295_26 = "play"
				local var_295_27 = "effect"

				arg_292_1:AudioAction(var_295_26, var_295_27, "se_story_147", "se_story_147_light_button_off", "")
			end

			local var_295_28 = 1.2
			local var_295_29 = 1

			if var_295_28 < arg_292_1.time_ and arg_292_1.time_ <= var_295_28 + arg_295_0 then
				local var_295_30 = "play"
				local var_295_31 = "effect"

				arg_292_1:AudioAction(var_295_30, var_295_31, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_295_32 = 0.2
			local var_295_33 = 1

			if var_295_32 < arg_292_1.time_ and arg_292_1.time_ <= var_295_32 + arg_295_0 then
				local var_295_34 = "stop"
				local var_295_35 = "effect"

				arg_292_1:AudioAction(var_295_34, var_295_35, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_292_1.frameCnt_ <= 1 then
				arg_292_1.dialog_:SetActive(false)
			end

			local var_295_36 = 1.774999999999
			local var_295_37 = 0.225

			if var_295_36 < arg_292_1.time_ and arg_292_1.time_ <= var_295_36 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				arg_292_1.dialog_:SetActive(true)

				arg_292_1.dialogCg_.alpha = 0

				local var_295_38 = LeanTween.value(arg_292_1.dialog_, 0, 1, 0.3)

				var_295_38:setOnUpdate(LuaHelper.FloatAction(function(arg_296_0)
					arg_292_1.dialogCg_.alpha = arg_296_0
				end))
				var_295_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_292_1.dialog_)
					var_295_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_292_1.duration_ = arg_292_1.duration_ + 0.3

				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_39 = arg_292_1:FormatText(StoryNameCfg[7].name)

				arg_292_1.leftNameTxt_.text = var_295_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_40 = arg_292_1:GetWordFromCfg(304021073)
				local var_295_41 = arg_292_1:FormatText(var_295_40.content)

				arg_292_1.text_.text = var_295_41

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_42 = 9
				local var_295_43 = utf8.len(var_295_41)
				local var_295_44 = var_295_42 <= 0 and var_295_37 or var_295_37 * (var_295_43 / var_295_42)

				if var_295_44 > 0 and var_295_37 < var_295_44 then
					arg_292_1.talkMaxDuration = var_295_44
					var_295_36 = var_295_36 + 0.3

					if var_295_44 + var_295_36 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_44 + var_295_36
					end
				end

				arg_292_1.text_.text = var_295_41
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_45 = var_295_36 + 0.3
			local var_295_46 = math.max(var_295_37, arg_292_1.talkMaxDuration)

			if var_295_45 <= arg_292_1.time_ and arg_292_1.time_ < var_295_45 + var_295_46 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_45) / var_295_46

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_45 + var_295_46 and arg_292_1.time_ < var_295_45 + var_295_46 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play304021074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 304021074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play304021075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 1.825

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_2 = arg_298_1:GetWordFromCfg(304021074)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 73
				local var_301_5 = utf8.len(var_301_3)
				local var_301_6 = var_301_4 <= 0 and var_301_1 or var_301_1 * (var_301_5 / var_301_4)

				if var_301_6 > 0 and var_301_1 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_7 and arg_298_1.time_ < var_301_0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play304021075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 304021075
		arg_302_1.duration_ = 4.73

		local var_302_0 = {
			zh = 4.733,
			ja = 1.999999999999
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
				arg_302_0:Play304021076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1037ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1037ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, -1.09, -5.81)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1037ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = arg_302_1.actors_["1037ui_story"]
			local var_305_10 = 0

			if var_305_10 < arg_302_1.time_ and arg_302_1.time_ <= var_305_10 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1037ui_story == nil then
				arg_302_1.var_.characterEffect1037ui_story = var_305_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_11 = 0.200000002980232

			if var_305_10 <= arg_302_1.time_ and arg_302_1.time_ < var_305_10 + var_305_11 and not isNil(var_305_9) then
				local var_305_12 = (arg_302_1.time_ - var_305_10) / var_305_11

				if arg_302_1.var_.characterEffect1037ui_story and not isNil(var_305_9) then
					arg_302_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_10 + var_305_11 and arg_302_1.time_ < var_305_10 + var_305_11 + arg_305_0 and not isNil(var_305_9) and arg_302_1.var_.characterEffect1037ui_story then
				arg_302_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_305_13 = 0

			if var_305_13 < arg_302_1.time_ and arg_302_1.time_ <= var_305_13 + arg_305_0 then
				arg_302_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_2")
			end

			local var_305_14 = 0

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				arg_302_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_15 = 0
			local var_305_16 = 0.5

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[15].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(304021075)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021075", "story_v_out_304021.awb") ~= 0 then
					local var_305_23 = manager.audio:GetVoiceLength("story_v_out_304021", "304021075", "story_v_out_304021.awb") / 1000

					if var_305_23 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_15
					end

					if var_305_18.prefab_name ~= "" and arg_302_1.actors_[var_305_18.prefab_name] ~= nil then
						local var_305_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_18.prefab_name].transform, "story_v_out_304021", "304021075", "story_v_out_304021.awb")

						arg_302_1:RecordAudio("304021075", var_305_24)
						arg_302_1:RecordAudio("304021075", var_305_24)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_304021", "304021075", "story_v_out_304021.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_304021", "304021075", "story_v_out_304021.awb")
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
				actorName = "1037ui_story",
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
	Play304021076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 304021076
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play304021077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1037ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1037ui_story == nil then
				arg_306_1.var_.characterEffect1037ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1037ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1037ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1037ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1037ui_story.fillRatio = var_309_5
			end

			local var_309_6 = 0
			local var_309_7 = 0.55

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_8 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_9 = arg_306_1:GetWordFromCfg(304021076)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 22
				local var_309_12 = utf8.len(var_309_10)
				local var_309_13 = var_309_11 <= 0 and var_309_7 or var_309_7 * (var_309_12 / var_309_11)

				if var_309_13 > 0 and var_309_7 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_14 and arg_306_1.time_ < var_309_6 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play304021077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 304021077
		arg_310_1.duration_ = 3.23

		local var_310_0 = {
			zh = 3.233,
			ja = 1.999999999999
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
				arg_310_0:Play304021078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1037ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1037ui_story == nil then
				arg_310_1.var_.characterEffect1037ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1037ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1037ui_story then
				arg_310_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_313_4 = 0

			if var_313_4 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_313_5 = 0

			if var_313_5 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_313_6 = 0
			local var_313_7 = 0.425

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_8 = arg_310_1:FormatText(StoryNameCfg[15].name)

				arg_310_1.leftNameTxt_.text = var_313_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_9 = arg_310_1:GetWordFromCfg(304021077)
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021077", "story_v_out_304021.awb") ~= 0 then
					local var_313_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021077", "story_v_out_304021.awb") / 1000

					if var_313_14 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_14 + var_313_6
					end

					if var_313_9.prefab_name ~= "" and arg_310_1.actors_[var_313_9.prefab_name] ~= nil then
						local var_313_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_9.prefab_name].transform, "story_v_out_304021", "304021077", "story_v_out_304021.awb")

						arg_310_1:RecordAudio("304021077", var_313_15)
						arg_310_1:RecordAudio("304021077", var_313_15)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_304021", "304021077", "story_v_out_304021.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_304021", "304021077", "story_v_out_304021.awb")
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
	Play304021078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 304021078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play304021079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1037ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1037ui_story == nil then
				arg_314_1.var_.characterEffect1037ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1037ui_story and not isNil(var_317_0) then
					local var_317_4 = Mathf.Lerp(0, 0.5, var_317_3)

					arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1037ui_story.fillRatio = var_317_4
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1037ui_story then
				local var_317_5 = 0.5

				arg_314_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1037ui_story.fillRatio = var_317_5
			end

			local var_317_6 = 0
			local var_317_7 = 0.6

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_8 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_9 = arg_314_1:GetWordFromCfg(304021078)
				local var_317_10 = arg_314_1:FormatText(var_317_9.content)

				arg_314_1.text_.text = var_317_10

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_11 = 24
				local var_317_12 = utf8.len(var_317_10)
				local var_317_13 = var_317_11 <= 0 and var_317_7 or var_317_7 * (var_317_12 / var_317_11)

				if var_317_13 > 0 and var_317_7 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_6
					end
				end

				arg_314_1.text_.text = var_317_10
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_14 = math.max(var_317_7, arg_314_1.talkMaxDuration)

			if var_317_6 <= arg_314_1.time_ and arg_314_1.time_ < var_317_6 + var_317_14 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_6) / var_317_14

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_6 + var_317_14 and arg_314_1.time_ < var_317_6 + var_317_14 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play304021079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 304021079
		arg_318_1.duration_ = 1.7

		local var_318_0 = {
			zh = 1.7,
			ja = 1.333
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
				arg_318_0:Play304021080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1037ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1037ui_story == nil then
				arg_318_1.var_.characterEffect1037ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1037ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1037ui_story then
				arg_318_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_321_4 = 0
			local var_321_5 = 0.05

			if var_321_4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_6 = arg_318_1:FormatText(StoryNameCfg[15].name)

				arg_318_1.leftNameTxt_.text = var_321_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_7 = arg_318_1:GetWordFromCfg(304021079)
				local var_321_8 = arg_318_1:FormatText(var_321_7.content)

				arg_318_1.text_.text = var_321_8

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_9 = 2
				local var_321_10 = utf8.len(var_321_8)
				local var_321_11 = var_321_9 <= 0 and var_321_5 or var_321_5 * (var_321_10 / var_321_9)

				if var_321_11 > 0 and var_321_5 < var_321_11 then
					arg_318_1.talkMaxDuration = var_321_11

					if var_321_11 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_11 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_8
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021079", "story_v_out_304021.awb") ~= 0 then
					local var_321_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021079", "story_v_out_304021.awb") / 1000

					if var_321_12 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_12 + var_321_4
					end

					if var_321_7.prefab_name ~= "" and arg_318_1.actors_[var_321_7.prefab_name] ~= nil then
						local var_321_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_7.prefab_name].transform, "story_v_out_304021", "304021079", "story_v_out_304021.awb")

						arg_318_1:RecordAudio("304021079", var_321_13)
						arg_318_1:RecordAudio("304021079", var_321_13)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_304021", "304021079", "story_v_out_304021.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_304021", "304021079", "story_v_out_304021.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_14 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_14 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_14

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_14 and arg_318_1.time_ < var_321_4 + var_321_14 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play304021080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 304021080
		arg_322_1.duration_ = 5.3

		local var_322_0 = {
			zh = 5.3,
			ja = 1.999999999999
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
				arg_322_0:Play304021081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_2")
			end

			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_325_2 = 0
			local var_325_3 = 0.575

			if var_325_2 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_4 = arg_322_1:FormatText(StoryNameCfg[15].name)

				arg_322_1.leftNameTxt_.text = var_325_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_5 = arg_322_1:GetWordFromCfg(304021080)
				local var_325_6 = arg_322_1:FormatText(var_325_5.content)

				arg_322_1.text_.text = var_325_6

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 23
				local var_325_8 = utf8.len(var_325_6)
				local var_325_9 = var_325_7 <= 0 and var_325_3 or var_325_3 * (var_325_8 / var_325_7)

				if var_325_9 > 0 and var_325_3 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_6
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021080", "story_v_out_304021.awb") ~= 0 then
					local var_325_10 = manager.audio:GetVoiceLength("story_v_out_304021", "304021080", "story_v_out_304021.awb") / 1000

					if var_325_10 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_2
					end

					if var_325_5.prefab_name ~= "" and arg_322_1.actors_[var_325_5.prefab_name] ~= nil then
						local var_325_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_5.prefab_name].transform, "story_v_out_304021", "304021080", "story_v_out_304021.awb")

						arg_322_1:RecordAudio("304021080", var_325_11)
						arg_322_1:RecordAudio("304021080", var_325_11)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_304021", "304021080", "story_v_out_304021.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_304021", "304021080", "story_v_out_304021.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_12 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_12 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_12

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_12 and arg_322_1.time_ < var_325_2 + var_325_12 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play304021081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 304021081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play304021082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1037ui_story"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1037ui_story == nil then
				arg_326_1.var_.characterEffect1037ui_story = var_329_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.characterEffect1037ui_story and not isNil(var_329_0) then
					local var_329_4 = Mathf.Lerp(0, 0.5, var_329_3)

					arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1037ui_story.fillRatio = var_329_4
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect1037ui_story then
				local var_329_5 = 0.5

				arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1037ui_story.fillRatio = var_329_5
			end

			local var_329_6 = 0
			local var_329_7 = 0.175

			if var_329_6 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_8 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_9 = arg_326_1:GetWordFromCfg(304021081)
				local var_329_10 = arg_326_1:FormatText(var_329_9.content)

				arg_326_1.text_.text = var_329_10

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_11 = 7
				local var_329_12 = utf8.len(var_329_10)
				local var_329_13 = var_329_11 <= 0 and var_329_7 or var_329_7 * (var_329_12 / var_329_11)

				if var_329_13 > 0 and var_329_7 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_10
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_14 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_14 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_14

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_14 and arg_326_1.time_ < var_329_6 + var_329_14 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play304021082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 304021082
		arg_330_1.duration_ = 9.83

		local var_330_0 = {
			zh = 9.833,
			ja = 1.999999999999
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
				arg_330_0:Play304021083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1037ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1037ui_story == nil then
				arg_330_1.var_.characterEffect1037ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect1037ui_story and not isNil(var_333_0) then
					arg_330_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1037ui_story then
				arg_330_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_333_4 = 0

			if var_333_4 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action7_1")
			end

			local var_333_5 = 0
			local var_333_6 = 1.15

			if var_333_5 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_7 = arg_330_1:FormatText(StoryNameCfg[15].name)

				arg_330_1.leftNameTxt_.text = var_333_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:GetWordFromCfg(304021082)
				local var_333_9 = arg_330_1:FormatText(var_333_8.content)

				arg_330_1.text_.text = var_333_9

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 46
				local var_333_11 = utf8.len(var_333_9)
				local var_333_12 = var_333_10 <= 0 and var_333_6 or var_333_6 * (var_333_11 / var_333_10)

				if var_333_12 > 0 and var_333_6 < var_333_12 then
					arg_330_1.talkMaxDuration = var_333_12

					if var_333_12 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_5
					end
				end

				arg_330_1.text_.text = var_333_9
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021082", "story_v_out_304021.awb") ~= 0 then
					local var_333_13 = manager.audio:GetVoiceLength("story_v_out_304021", "304021082", "story_v_out_304021.awb") / 1000

					if var_333_13 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_13 + var_333_5
					end

					if var_333_8.prefab_name ~= "" and arg_330_1.actors_[var_333_8.prefab_name] ~= nil then
						local var_333_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_8.prefab_name].transform, "story_v_out_304021", "304021082", "story_v_out_304021.awb")

						arg_330_1:RecordAudio("304021082", var_333_14)
						arg_330_1:RecordAudio("304021082", var_333_14)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_304021", "304021082", "story_v_out_304021.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_304021", "304021082", "story_v_out_304021.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_15 = math.max(var_333_6, arg_330_1.talkMaxDuration)

			if var_333_5 <= arg_330_1.time_ and arg_330_1.time_ < var_333_5 + var_333_15 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_5) / var_333_15

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_5 + var_333_15 and arg_330_1.time_ < var_333_5 + var_333_15 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play304021083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 304021083
		arg_334_1.duration_ = 9.53

		local var_334_0 = {
			zh = 9.533,
			ja = 1.333
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
				arg_334_0:Play304021084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 1.15

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[15].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_3 = arg_334_1:GetWordFromCfg(304021083)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 46
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021083", "story_v_out_304021.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021083", "story_v_out_304021.awb") / 1000

					if var_337_8 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_0
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_out_304021", "304021083", "story_v_out_304021.awb")

						arg_334_1:RecordAudio("304021083", var_337_9)
						arg_334_1:RecordAudio("304021083", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_304021", "304021083", "story_v_out_304021.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_304021", "304021083", "story_v_out_304021.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_10 and arg_334_1.time_ < var_337_0 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play304021084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 304021084
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play304021085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1037ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1037ui_story == nil then
				arg_338_1.var_.characterEffect1037ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1037ui_story and not isNil(var_341_0) then
					local var_341_4 = Mathf.Lerp(0, 0.5, var_341_3)

					arg_338_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1037ui_story.fillRatio = var_341_4
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1037ui_story then
				local var_341_5 = 0.5

				arg_338_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1037ui_story.fillRatio = var_341_5
			end

			local var_341_6 = 0
			local var_341_7 = 0.075

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_8 = arg_338_1:FormatText(StoryNameCfg[7].name)

				arg_338_1.leftNameTxt_.text = var_341_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_9 = arg_338_1:GetWordFromCfg(304021084)
				local var_341_10 = arg_338_1:FormatText(var_341_9.content)

				arg_338_1.text_.text = var_341_10

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 3
				local var_341_12 = utf8.len(var_341_10)
				local var_341_13 = var_341_11 <= 0 and var_341_7 or var_341_7 * (var_341_12 / var_341_11)

				if var_341_13 > 0 and var_341_7 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_10
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_14 and arg_338_1.time_ < var_341_6 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play304021085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 304021085
		arg_342_1.duration_ = 1

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"

			SetActive(arg_342_1.choicesGo_, true)

			for iter_343_0, iter_343_1 in ipairs(arg_342_1.choices_) do
				local var_343_0 = iter_343_0 <= 2

				SetActive(iter_343_1.go, var_343_0)
			end

			arg_342_1.choices_[1].txt.text = arg_342_1:FormatText(StoryChoiceCfg[1762].name)
			arg_342_1.choices_[2].txt.text = arg_342_1:FormatText(StoryChoiceCfg[1763].name)
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play304021086(arg_342_1)
			end

			if arg_344_0 == 2 then
				arg_342_0:Play304021089(arg_342_1)
			end

			arg_342_1:RecordChoiceLog(304021085, 1762, 1763)
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			return
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play304021086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 304021086
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play304021087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.925

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[7].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(304021086)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 37
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_8 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_8 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_8

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_8 and arg_346_1.time_ < var_349_0 + var_349_8 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play304021087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 304021087
		arg_350_1.duration_ = 6.53

		local var_350_0 = {
			zh = 6.533,
			ja = 1.999999999999
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
				arg_350_0:Play304021088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1037ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1037ui_story == nil then
				arg_350_1.var_.characterEffect1037ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect1037ui_story and not isNil(var_353_0) then
					arg_350_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect1037ui_story then
				arg_350_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_353_4 = 0

			if var_353_4 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action472")
			end

			local var_353_5 = 0

			if var_353_5 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_353_6 = 0
			local var_353_7 = 0.675

			if var_353_6 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_8 = arg_350_1:FormatText(StoryNameCfg[15].name)

				arg_350_1.leftNameTxt_.text = var_353_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_9 = arg_350_1:GetWordFromCfg(304021087)
				local var_353_10 = arg_350_1:FormatText(var_353_9.content)

				arg_350_1.text_.text = var_353_10

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_11 = 27
				local var_353_12 = utf8.len(var_353_10)
				local var_353_13 = var_353_11 <= 0 and var_353_7 or var_353_7 * (var_353_12 / var_353_11)

				if var_353_13 > 0 and var_353_7 < var_353_13 then
					arg_350_1.talkMaxDuration = var_353_13

					if var_353_13 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_13 + var_353_6
					end
				end

				arg_350_1.text_.text = var_353_10
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021087", "story_v_out_304021.awb") ~= 0 then
					local var_353_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021087", "story_v_out_304021.awb") / 1000

					if var_353_14 + var_353_6 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_6
					end

					if var_353_9.prefab_name ~= "" and arg_350_1.actors_[var_353_9.prefab_name] ~= nil then
						local var_353_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_9.prefab_name].transform, "story_v_out_304021", "304021087", "story_v_out_304021.awb")

						arg_350_1:RecordAudio("304021087", var_353_15)
						arg_350_1:RecordAudio("304021087", var_353_15)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_304021", "304021087", "story_v_out_304021.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_304021", "304021087", "story_v_out_304021.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_16 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_16 and arg_350_1.time_ < var_353_6 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play304021088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 304021088
		arg_354_1.duration_ = 5.8

		local var_354_0 = {
			zh = 5.8,
			ja = 1.333
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
				arg_354_0:Play304021093(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 0.55

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_2 = arg_354_1:FormatText(StoryNameCfg[15].name)

				arg_354_1.leftNameTxt_.text = var_357_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_3 = arg_354_1:GetWordFromCfg(304021088)
				local var_357_4 = arg_354_1:FormatText(var_357_3.content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021088", "story_v_out_304021.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021088", "story_v_out_304021.awb") / 1000

					if var_357_8 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_0
					end

					if var_357_3.prefab_name ~= "" and arg_354_1.actors_[var_357_3.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_3.prefab_name].transform, "story_v_out_304021", "304021088", "story_v_out_304021.awb")

						arg_354_1:RecordAudio("304021088", var_357_9)
						arg_354_1:RecordAudio("304021088", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_304021", "304021088", "story_v_out_304021.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_304021", "304021088", "story_v_out_304021.awb")
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
	Play304021093 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 304021093
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play304021094(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1037ui_story"].transform
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.var_.moveOldPos1037ui_story = var_361_0.localPosition
			end

			local var_361_2 = 0.001

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2
				local var_361_4 = Vector3.New(0, 100, 0)

				var_361_0.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1037ui_story, var_361_4, var_361_3)

				local var_361_5 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_5.x, var_361_5.y, var_361_5.z)

				local var_361_6 = var_361_0.localEulerAngles

				var_361_6.z = 0
				var_361_6.x = 0
				var_361_0.localEulerAngles = var_361_6
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 then
				var_361_0.localPosition = Vector3.New(0, 100, 0)

				local var_361_7 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_7.x, var_361_7.y, var_361_7.z)

				local var_361_8 = var_361_0.localEulerAngles

				var_361_8.z = 0
				var_361_8.x = 0
				var_361_0.localEulerAngles = var_361_8
			end

			local var_361_9 = arg_358_1.actors_["1037ui_story"]
			local var_361_10 = 0

			if var_361_10 < arg_358_1.time_ and arg_358_1.time_ <= var_361_10 + arg_361_0 and not isNil(var_361_9) and arg_358_1.var_.characterEffect1037ui_story == nil then
				arg_358_1.var_.characterEffect1037ui_story = var_361_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_11 = 0.200000002980232

			if var_361_10 <= arg_358_1.time_ and arg_358_1.time_ < var_361_10 + var_361_11 and not isNil(var_361_9) then
				local var_361_12 = (arg_358_1.time_ - var_361_10) / var_361_11

				if arg_358_1.var_.characterEffect1037ui_story and not isNil(var_361_9) then
					local var_361_13 = Mathf.Lerp(0, 0.5, var_361_12)

					arg_358_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1037ui_story.fillRatio = var_361_13
				end
			end

			if arg_358_1.time_ >= var_361_10 + var_361_11 and arg_358_1.time_ < var_361_10 + var_361_11 + arg_361_0 and not isNil(var_361_9) and arg_358_1.var_.characterEffect1037ui_story then
				local var_361_14 = 0.5

				arg_358_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1037ui_story.fillRatio = var_361_14
			end

			local var_361_15 = 0
			local var_361_16 = 1.05

			if var_361_15 < arg_358_1.time_ and arg_358_1.time_ <= var_361_15 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_17 = arg_358_1:GetWordFromCfg(304021093)
				local var_361_18 = arg_358_1:FormatText(var_361_17.content)

				arg_358_1.text_.text = var_361_18

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_19 = 42
				local var_361_20 = utf8.len(var_361_18)
				local var_361_21 = var_361_19 <= 0 and var_361_16 or var_361_16 * (var_361_20 / var_361_19)

				if var_361_21 > 0 and var_361_16 < var_361_21 then
					arg_358_1.talkMaxDuration = var_361_21

					if var_361_21 + var_361_15 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_21 + var_361_15
					end
				end

				arg_358_1.text_.text = var_361_18
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_22 = math.max(var_361_16, arg_358_1.talkMaxDuration)

			if var_361_15 <= arg_358_1.time_ and arg_358_1.time_ < var_361_15 + var_361_22 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_15) / var_361_22

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_15 + var_361_22 and arg_358_1.time_ < var_361_15 + var_361_22 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play304021094 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 304021094
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play304021095(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 0.175

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[7].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:GetWordFromCfg(304021094)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 7
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_8 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_8 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_8

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_8 and arg_362_1.time_ < var_365_0 + var_365_8 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play304021095 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 304021095
		arg_366_1.duration_ = 2.27

		local var_366_0 = {
			zh = 2.266,
			ja = 1.999999999999
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play304021096(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1037ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos1037ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(0, -1.09, -5.81)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1037ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = arg_366_1.actors_["1037ui_story"]
			local var_369_10 = 0

			if var_369_10 < arg_366_1.time_ and arg_366_1.time_ <= var_369_10 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect1037ui_story == nil then
				arg_366_1.var_.characterEffect1037ui_story = var_369_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_11 = 0.200000002980232

			if var_369_10 <= arg_366_1.time_ and arg_366_1.time_ < var_369_10 + var_369_11 and not isNil(var_369_9) then
				local var_369_12 = (arg_366_1.time_ - var_369_10) / var_369_11

				if arg_366_1.var_.characterEffect1037ui_story and not isNil(var_369_9) then
					arg_366_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_10 + var_369_11 and arg_366_1.time_ < var_369_10 + var_369_11 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect1037ui_story then
				arg_366_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_369_13 = 0

			if var_369_13 < arg_366_1.time_ and arg_366_1.time_ <= var_369_13 + arg_369_0 then
				arg_366_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_369_14 = 0

			if var_369_14 < arg_366_1.time_ and arg_366_1.time_ <= var_369_14 + arg_369_0 then
				arg_366_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_369_15 = 0
			local var_369_16 = 0.125

			if var_369_15 < arg_366_1.time_ and arg_366_1.time_ <= var_369_15 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_17 = arg_366_1:FormatText(StoryNameCfg[15].name)

				arg_366_1.leftNameTxt_.text = var_369_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_18 = arg_366_1:GetWordFromCfg(304021095)
				local var_369_19 = arg_366_1:FormatText(var_369_18.content)

				arg_366_1.text_.text = var_369_19

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_20 = 5
				local var_369_21 = utf8.len(var_369_19)
				local var_369_22 = var_369_20 <= 0 and var_369_16 or var_369_16 * (var_369_21 / var_369_20)

				if var_369_22 > 0 and var_369_16 < var_369_22 then
					arg_366_1.talkMaxDuration = var_369_22

					if var_369_22 + var_369_15 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_22 + var_369_15
					end
				end

				arg_366_1.text_.text = var_369_19
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021095", "story_v_out_304021.awb") ~= 0 then
					local var_369_23 = manager.audio:GetVoiceLength("story_v_out_304021", "304021095", "story_v_out_304021.awb") / 1000

					if var_369_23 + var_369_15 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_23 + var_369_15
					end

					if var_369_18.prefab_name ~= "" and arg_366_1.actors_[var_369_18.prefab_name] ~= nil then
						local var_369_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_18.prefab_name].transform, "story_v_out_304021", "304021095", "story_v_out_304021.awb")

						arg_366_1:RecordAudio("304021095", var_369_24)
						arg_366_1:RecordAudio("304021095", var_369_24)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_304021", "304021095", "story_v_out_304021.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_304021", "304021095", "story_v_out_304021.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_25 = math.max(var_369_16, arg_366_1.talkMaxDuration)

			if var_369_15 <= arg_366_1.time_ and arg_366_1.time_ < var_369_15 + var_369_25 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_15) / var_369_25

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_15 + var_369_25 and arg_366_1.time_ < var_369_15 + var_369_25 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play304021096 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 304021096
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play304021097(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1037ui_story"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1037ui_story == nil then
				arg_370_1.var_.characterEffect1037ui_story = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect1037ui_story and not isNil(var_373_0) then
					local var_373_4 = Mathf.Lerp(0, 0.5, var_373_3)

					arg_370_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1037ui_story.fillRatio = var_373_4
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1037ui_story then
				local var_373_5 = 0.5

				arg_370_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1037ui_story.fillRatio = var_373_5
			end

			local var_373_6 = 0
			local var_373_7 = 0.775

			if var_373_6 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_8 = arg_370_1:FormatText(StoryNameCfg[7].name)

				arg_370_1.leftNameTxt_.text = var_373_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_9 = arg_370_1:GetWordFromCfg(304021096)
				local var_373_10 = arg_370_1:FormatText(var_373_9.content)

				arg_370_1.text_.text = var_373_10

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_11 = 31
				local var_373_12 = utf8.len(var_373_10)
				local var_373_13 = var_373_11 <= 0 and var_373_7 or var_373_7 * (var_373_12 / var_373_11)

				if var_373_13 > 0 and var_373_7 < var_373_13 then
					arg_370_1.talkMaxDuration = var_373_13

					if var_373_13 + var_373_6 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_13 + var_373_6
					end
				end

				arg_370_1.text_.text = var_373_10
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_14 = math.max(var_373_7, arg_370_1.talkMaxDuration)

			if var_373_6 <= arg_370_1.time_ and arg_370_1.time_ < var_373_6 + var_373_14 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_6) / var_373_14

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_6 + var_373_14 and arg_370_1.time_ < var_373_6 + var_373_14 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play304021097 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 304021097
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play304021098(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.775

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_2 = arg_374_1:FormatText(StoryNameCfg[7].name)

				arg_374_1.leftNameTxt_.text = var_377_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:GetWordFromCfg(304021097)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 31
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
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_8 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_8 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_8

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_8 and arg_374_1.time_ < var_377_0 + var_377_8 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play304021098 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 304021098
		arg_378_1.duration_ = 8

		local var_378_0 = {
			zh = 8,
			ja = 1.333
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play304021099(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1037ui_story"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1037ui_story == nil then
				arg_378_1.var_.characterEffect1037ui_story = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1037ui_story and not isNil(var_381_0) then
					arg_378_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1037ui_story then
				arg_378_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_381_4 = 0
			local var_381_5 = 0.925

			if var_381_4 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_6 = arg_378_1:FormatText(StoryNameCfg[15].name)

				arg_378_1.leftNameTxt_.text = var_381_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_7 = arg_378_1:GetWordFromCfg(304021098)
				local var_381_8 = arg_378_1:FormatText(var_381_7.content)

				arg_378_1.text_.text = var_381_8

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_9 = 37
				local var_381_10 = utf8.len(var_381_8)
				local var_381_11 = var_381_9 <= 0 and var_381_5 or var_381_5 * (var_381_10 / var_381_9)

				if var_381_11 > 0 and var_381_5 < var_381_11 then
					arg_378_1.talkMaxDuration = var_381_11

					if var_381_11 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_11 + var_381_4
					end
				end

				arg_378_1.text_.text = var_381_8
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021098", "story_v_out_304021.awb") ~= 0 then
					local var_381_12 = manager.audio:GetVoiceLength("story_v_out_304021", "304021098", "story_v_out_304021.awb") / 1000

					if var_381_12 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_12 + var_381_4
					end

					if var_381_7.prefab_name ~= "" and arg_378_1.actors_[var_381_7.prefab_name] ~= nil then
						local var_381_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_7.prefab_name].transform, "story_v_out_304021", "304021098", "story_v_out_304021.awb")

						arg_378_1:RecordAudio("304021098", var_381_13)
						arg_378_1:RecordAudio("304021098", var_381_13)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_304021", "304021098", "story_v_out_304021.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_304021", "304021098", "story_v_out_304021.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_14 = math.max(var_381_5, arg_378_1.talkMaxDuration)

			if var_381_4 <= arg_378_1.time_ and arg_378_1.time_ < var_381_4 + var_381_14 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_4) / var_381_14

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_4 + var_381_14 and arg_378_1.time_ < var_381_4 + var_381_14 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play304021099 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 304021099
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play304021100(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1037ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1037ui_story == nil then
				arg_382_1.var_.characterEffect1037ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect1037ui_story and not isNil(var_385_0) then
					local var_385_4 = Mathf.Lerp(0, 0.5, var_385_3)

					arg_382_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1037ui_story.fillRatio = var_385_4
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1037ui_story then
				local var_385_5 = 0.5

				arg_382_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1037ui_story.fillRatio = var_385_5
			end

			local var_385_6 = 0
			local var_385_7 = 0.55

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_8 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_9 = arg_382_1:GetWordFromCfg(304021099)
				local var_385_10 = arg_382_1:FormatText(var_385_9.content)

				arg_382_1.text_.text = var_385_10

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_11 = 22
				local var_385_12 = utf8.len(var_385_10)
				local var_385_13 = var_385_11 <= 0 and var_385_7 or var_385_7 * (var_385_12 / var_385_11)

				if var_385_13 > 0 and var_385_7 < var_385_13 then
					arg_382_1.talkMaxDuration = var_385_13

					if var_385_13 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_13 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_10
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_14 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_14 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_14

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_14 and arg_382_1.time_ < var_385_6 + var_385_14 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play304021100 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 304021100
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play304021101(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.95

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[7].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:GetWordFromCfg(304021100)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 38
				local var_389_6 = utf8.len(var_389_4)
				local var_389_7 = var_389_5 <= 0 and var_389_1 or var_389_1 * (var_389_6 / var_389_5)

				if var_389_7 > 0 and var_389_1 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_8 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_8 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_8

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_8 and arg_386_1.time_ < var_389_0 + var_389_8 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play304021101 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 304021101
		arg_390_1.duration_ = 3.73

		local var_390_0 = {
			zh = 3.733,
			ja = 1.999999999999
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
				arg_390_0:Play304021102(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1037ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1037ui_story == nil then
				arg_390_1.var_.characterEffect1037ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect1037ui_story and not isNil(var_393_0) then
					arg_390_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1037ui_story then
				arg_390_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_393_4 = 0

			if var_393_4 < arg_390_1.time_ and arg_390_1.time_ <= var_393_4 + arg_393_0 then
				arg_390_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_393_5 = 0

			if var_393_5 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 then
				arg_390_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_393_6 = 0
			local var_393_7 = 0.375

			if var_393_6 < arg_390_1.time_ and arg_390_1.time_ <= var_393_6 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_8 = arg_390_1:FormatText(StoryNameCfg[15].name)

				arg_390_1.leftNameTxt_.text = var_393_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_9 = arg_390_1:GetWordFromCfg(304021101)
				local var_393_10 = arg_390_1:FormatText(var_393_9.content)

				arg_390_1.text_.text = var_393_10

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021101", "story_v_out_304021.awb") ~= 0 then
					local var_393_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021101", "story_v_out_304021.awb") / 1000

					if var_393_14 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_14 + var_393_6
					end

					if var_393_9.prefab_name ~= "" and arg_390_1.actors_[var_393_9.prefab_name] ~= nil then
						local var_393_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_9.prefab_name].transform, "story_v_out_304021", "304021101", "story_v_out_304021.awb")

						arg_390_1:RecordAudio("304021101", var_393_15)
						arg_390_1:RecordAudio("304021101", var_393_15)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_304021", "304021101", "story_v_out_304021.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_304021", "304021101", "story_v_out_304021.awb")
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
	Play304021102 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 304021102
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play304021103(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1037ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1037ui_story == nil then
				arg_394_1.var_.characterEffect1037ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1037ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1037ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1037ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1037ui_story.fillRatio = var_397_5
			end

			local var_397_6 = 0
			local var_397_7 = 0.35

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[7].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_9 = arg_394_1:GetWordFromCfg(304021102)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 14
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_14 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_14 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_14

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_14 and arg_394_1.time_ < var_397_6 + var_397_14 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play304021103 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 304021103
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play304021104(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1037ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos1037ui_story = var_401_0.localPosition
			end

			local var_401_2 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2
				local var_401_4 = Vector3.New(0, 100, 0)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1037ui_story, var_401_4, var_401_3)

				local var_401_5 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_5.x, var_401_5.y, var_401_5.z)

				local var_401_6 = var_401_0.localEulerAngles

				var_401_6.z = 0
				var_401_6.x = 0
				var_401_0.localEulerAngles = var_401_6
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0, 100, 0)

				local var_401_7 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_7.x, var_401_7.y, var_401_7.z)

				local var_401_8 = var_401_0.localEulerAngles

				var_401_8.z = 0
				var_401_8.x = 0
				var_401_0.localEulerAngles = var_401_8
			end

			local var_401_9 = 0
			local var_401_10 = 0.575

			if var_401_9 < arg_398_1.time_ and arg_398_1.time_ <= var_401_9 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_11 = arg_398_1:GetWordFromCfg(304021103)
				local var_401_12 = arg_398_1:FormatText(var_401_11.content)

				arg_398_1.text_.text = var_401_12

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_13 = 23
				local var_401_14 = utf8.len(var_401_12)
				local var_401_15 = var_401_13 <= 0 and var_401_10 or var_401_10 * (var_401_14 / var_401_13)

				if var_401_15 > 0 and var_401_10 < var_401_15 then
					arg_398_1.talkMaxDuration = var_401_15

					if var_401_15 + var_401_9 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_15 + var_401_9
					end
				end

				arg_398_1.text_.text = var_401_12
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_16 = math.max(var_401_10, arg_398_1.talkMaxDuration)

			if var_401_9 <= arg_398_1.time_ and arg_398_1.time_ < var_401_9 + var_401_16 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_9) / var_401_16

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_9 + var_401_16 and arg_398_1.time_ < var_401_9 + var_401_16 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play304021104 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 304021104
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play304021105(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.45

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[7].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(304021104)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 18
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_8 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_8 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_8

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_8 and arg_402_1.time_ < var_405_0 + var_405_8 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play304021105 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 304021105
		arg_406_1.duration_ = 3.7

		local var_406_0 = {
			zh = 3.7,
			ja = 1.633
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
				arg_406_0:Play304021106(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 0.45

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_2 = arg_406_1:FormatText(StoryNameCfg[14].name)

				arg_406_1.leftNameTxt_.text = var_409_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:GetWordFromCfg(304021105)
				local var_409_4 = arg_406_1:FormatText(var_409_3.content)

				arg_406_1.text_.text = var_409_4

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 18
				local var_409_6 = utf8.len(var_409_4)
				local var_409_7 = var_409_5 <= 0 and var_409_1 or var_409_1 * (var_409_6 / var_409_5)

				if var_409_7 > 0 and var_409_1 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_0
					end
				end

				arg_406_1.text_.text = var_409_4
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021105", "story_v_out_304021.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021105", "story_v_out_304021.awb") / 1000

					if var_409_8 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_0
					end

					if var_409_3.prefab_name ~= "" and arg_406_1.actors_[var_409_3.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_3.prefab_name].transform, "story_v_out_304021", "304021105", "story_v_out_304021.awb")

						arg_406_1:RecordAudio("304021105", var_409_9)
						arg_406_1:RecordAudio("304021105", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_304021", "304021105", "story_v_out_304021.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_304021", "304021105", "story_v_out_304021.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_10 and arg_406_1.time_ < var_409_0 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play304021106 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 304021106
		arg_410_1.duration_ = 6.43

		local var_410_0 = {
			zh = 4.866,
			ja = 6.433
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
			arg_410_1.auto_ = false
		end

		function arg_410_1.playNext_(arg_412_0)
			arg_410_1.onStoryFinished_()
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.525

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[14].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:GetWordFromCfg(304021106)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 21
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021106", "story_v_out_304021.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021106", "story_v_out_304021.awb") / 1000

					if var_413_8 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_0
					end

					if var_413_3.prefab_name ~= "" and arg_410_1.actors_[var_413_3.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_3.prefab_name].transform, "story_v_out_304021", "304021106", "story_v_out_304021.awb")

						arg_410_1:RecordAudio("304021106", var_413_9)
						arg_410_1:RecordAudio("304021106", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_304021", "304021106", "story_v_out_304021.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_304021", "304021106", "story_v_out_304021.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_10 and arg_410_1.time_ < var_413_0 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play304021089 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 304021089
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play304021090(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.975

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(304021089)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 39
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
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_8 and arg_414_1.time_ < var_417_0 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play304021090 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 304021090
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play304021091(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.925

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_2 = arg_418_1:FormatText(StoryNameCfg[7].name)

				arg_418_1.leftNameTxt_.text = var_421_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_3 = arg_418_1:GetWordFromCfg(304021090)
				local var_421_4 = arg_418_1:FormatText(var_421_3.content)

				arg_418_1.text_.text = var_421_4

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 37
				local var_421_6 = utf8.len(var_421_4)
				local var_421_7 = var_421_5 <= 0 and var_421_1 or var_421_1 * (var_421_6 / var_421_5)

				if var_421_7 > 0 and var_421_1 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_4
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_8 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_8 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_8

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_8 and arg_418_1.time_ < var_421_0 + var_421_8 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play304021091 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 304021091
		arg_422_1.duration_ = 6.13

		local var_422_0 = {
			zh = 6.133,
			ja = 1.999999999999
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
				arg_422_0:Play304021092(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1037ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1037ui_story == nil then
				arg_422_1.var_.characterEffect1037ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.200000002980232

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect1037ui_story and not isNil(var_425_0) then
					arg_422_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1037ui_story then
				arg_422_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_425_4 = 0

			if var_425_4 < arg_422_1.time_ and arg_422_1.time_ <= var_425_4 + arg_425_0 then
				arg_422_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_425_5 = 0

			if var_425_5 < arg_422_1.time_ and arg_422_1.time_ <= var_425_5 + arg_425_0 then
				arg_422_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action472")
			end

			local var_425_6 = 0
			local var_425_7 = 0.7

			if var_425_6 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_8 = arg_422_1:FormatText(StoryNameCfg[15].name)

				arg_422_1.leftNameTxt_.text = var_425_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_9 = arg_422_1:GetWordFromCfg(304021091)
				local var_425_10 = arg_422_1:FormatText(var_425_9.content)

				arg_422_1.text_.text = var_425_10

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_11 = 27
				local var_425_12 = utf8.len(var_425_10)
				local var_425_13 = var_425_11 <= 0 and var_425_7 or var_425_7 * (var_425_12 / var_425_11)

				if var_425_13 > 0 and var_425_7 < var_425_13 then
					arg_422_1.talkMaxDuration = var_425_13

					if var_425_13 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_13 + var_425_6
					end
				end

				arg_422_1.text_.text = var_425_10
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021091", "story_v_out_304021.awb") ~= 0 then
					local var_425_14 = manager.audio:GetVoiceLength("story_v_out_304021", "304021091", "story_v_out_304021.awb") / 1000

					if var_425_14 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_14 + var_425_6
					end

					if var_425_9.prefab_name ~= "" and arg_422_1.actors_[var_425_9.prefab_name] ~= nil then
						local var_425_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_9.prefab_name].transform, "story_v_out_304021", "304021091", "story_v_out_304021.awb")

						arg_422_1:RecordAudio("304021091", var_425_15)
						arg_422_1:RecordAudio("304021091", var_425_15)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_304021", "304021091", "story_v_out_304021.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_304021", "304021091", "story_v_out_304021.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_16 = math.max(var_425_7, arg_422_1.talkMaxDuration)

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_16 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_6) / var_425_16

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_6 + var_425_16 and arg_422_1.time_ < var_425_6 + var_425_16 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play304021092 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 304021092
		arg_426_1.duration_ = 4.87

		local var_426_0 = {
			zh = 4.866,
			ja = 1.333
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
				arg_426_0:Play304021093(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 0.575

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[15].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_3 = arg_426_1:GetWordFromCfg(304021092)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021092", "story_v_out_304021.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021092", "story_v_out_304021.awb") / 1000

					if var_429_8 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_0
					end

					if var_429_3.prefab_name ~= "" and arg_426_1.actors_[var_429_3.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_3.prefab_name].transform, "story_v_out_304021", "304021092", "story_v_out_304021.awb")

						arg_426_1:RecordAudio("304021092", var_429_9)
						arg_426_1:RecordAudio("304021092", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_304021", "304021092", "story_v_out_304021.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_304021", "304021092", "story_v_out_304021.awb")
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
	Play304021022 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 304021022
		arg_430_1.duration_ = 4.23

		local var_430_0 = {
			zh = 4.233,
			ja = 2.433
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
				arg_430_0:Play304021023(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1011ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1011ui_story == nil then
				arg_430_1.var_.characterEffect1011ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1011ui_story and not isNil(var_433_0) then
					arg_430_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1011ui_story then
				arg_430_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_433_4 = arg_430_1.actors_["1019ui_story"]
			local var_433_5 = 0

			if var_433_5 < arg_430_1.time_ and arg_430_1.time_ <= var_433_5 + arg_433_0 and not isNil(var_433_4) and arg_430_1.var_.characterEffect1019ui_story == nil then
				arg_430_1.var_.characterEffect1019ui_story = var_433_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_6 = 0.200000002980232

			if var_433_5 <= arg_430_1.time_ and arg_430_1.time_ < var_433_5 + var_433_6 and not isNil(var_433_4) then
				local var_433_7 = (arg_430_1.time_ - var_433_5) / var_433_6

				if arg_430_1.var_.characterEffect1019ui_story and not isNil(var_433_4) then
					local var_433_8 = Mathf.Lerp(0, 0.5, var_433_7)

					arg_430_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1019ui_story.fillRatio = var_433_8
				end
			end

			if arg_430_1.time_ >= var_433_5 + var_433_6 and arg_430_1.time_ < var_433_5 + var_433_6 + arg_433_0 and not isNil(var_433_4) and arg_430_1.var_.characterEffect1019ui_story then
				local var_433_9 = 0.5

				arg_430_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1019ui_story.fillRatio = var_433_9
			end

			local var_433_10 = 0
			local var_433_11 = 0.375

			if var_433_10 < arg_430_1.time_ and arg_430_1.time_ <= var_433_10 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_12 = arg_430_1:FormatText(StoryNameCfg[37].name)

				arg_430_1.leftNameTxt_.text = var_433_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_13 = arg_430_1:GetWordFromCfg(304021022)
				local var_433_14 = arg_430_1:FormatText(var_433_13.content)

				arg_430_1.text_.text = var_433_14

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_15 = 15
				local var_433_16 = utf8.len(var_433_14)
				local var_433_17 = var_433_15 <= 0 and var_433_11 or var_433_11 * (var_433_16 / var_433_15)

				if var_433_17 > 0 and var_433_11 < var_433_17 then
					arg_430_1.talkMaxDuration = var_433_17

					if var_433_17 + var_433_10 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_17 + var_433_10
					end
				end

				arg_430_1.text_.text = var_433_14
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021022", "story_v_out_304021.awb") ~= 0 then
					local var_433_18 = manager.audio:GetVoiceLength("story_v_out_304021", "304021022", "story_v_out_304021.awb") / 1000

					if var_433_18 + var_433_10 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_18 + var_433_10
					end

					if var_433_13.prefab_name ~= "" and arg_430_1.actors_[var_433_13.prefab_name] ~= nil then
						local var_433_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_13.prefab_name].transform, "story_v_out_304021", "304021022", "story_v_out_304021.awb")

						arg_430_1:RecordAudio("304021022", var_433_19)
						arg_430_1:RecordAudio("304021022", var_433_19)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_304021", "304021022", "story_v_out_304021.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_304021", "304021022", "story_v_out_304021.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_20 = math.max(var_433_11, arg_430_1.talkMaxDuration)

			if var_433_10 <= arg_430_1.time_ and arg_430_1.time_ < var_433_10 + var_433_20 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_10) / var_433_20

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_10 + var_433_20 and arg_430_1.time_ < var_433_10 + var_433_20 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play304021023 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 304021023
		arg_434_1.duration_ = 8.5

		local var_434_0 = {
			zh = 8.4,
			ja = 8.5
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
				arg_434_0:Play304021024(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.95

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
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_3 = arg_434_1:GetWordFromCfg(304021023)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_304021", "304021023", "story_v_out_304021.awb") ~= 0 then
					local var_437_8 = manager.audio:GetVoiceLength("story_v_out_304021", "304021023", "story_v_out_304021.awb") / 1000

					if var_437_8 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_8 + var_437_0
					end

					if var_437_3.prefab_name ~= "" and arg_434_1.actors_[var_437_3.prefab_name] ~= nil then
						local var_437_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_3.prefab_name].transform, "story_v_out_304021", "304021023", "story_v_out_304021.awb")

						arg_434_1:RecordAudio("304021023", var_437_9)
						arg_434_1:RecordAudio("304021023", var_437_9)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_304021", "304021023", "story_v_out_304021.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_304021", "304021023", "story_v_out_304021.awb")
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
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/S0101",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D02a"
	},
	voices = {
		"story_v_out_304021.awb"
	}
}
