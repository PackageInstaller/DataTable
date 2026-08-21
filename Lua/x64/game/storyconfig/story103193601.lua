return {
	Play319361001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319361001
		arg_1_1.duration_ = 17.5

		local var_1_0 = {
			zh = 12.966,
			ja = 17.5
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
				arg_1_0:Play319361002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11q"

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
				local var_4_5 = arg_1_1.bgs_.I11q

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
					if iter_4_0 ~= "I11q" then
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

			local var_4_22 = "1095ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1095ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1095ui_story = var_4_27.localPosition

				local var_4_29 = "1095ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_29 .. "Animator"].transform, false)
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(0, -0.98, -6.1)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1095ui_story, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_27.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_27.localEulerAngles = var_4_36
			end

			local var_4_37 = arg_1_1.actors_["1095ui_story"]
			local var_4_38 = 1.8

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect1095ui_story == nil then
				arg_1_1.var_.characterEffect1095ui_story = var_4_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_39 = 0.200000002980232

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 and not isNil(var_4_37) then
				local var_4_40 = (arg_1_1.time_ - var_4_38) / var_4_39

				if arg_1_1.var_.characterEffect1095ui_story and not isNil(var_4_37) then
					arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect1095ui_story then
				arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_43 = 0
			local var_4_44 = 0.133333333333333

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_49 = 0.166666666666667
			local var_4_50 = 0.933333333333333

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_3_0_story_data", "bgm_activity_3_0_story_data", "bgm_activity_3_0_story_data.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_3_0_story_data", "bgm_activity_3_0_story_data")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 2
			local var_4_56 = 1.4

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_57 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_57:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_58 = arg_1_1:FormatText(StoryNameCfg[471].name)

				arg_1_1.leftNameTxt_.text = var_4_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_59 = arg_1_1:GetWordFromCfg(319361001)
				local var_4_60 = arg_1_1:FormatText(var_4_59.content)

				arg_1_1.text_.text = var_4_60

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_61 = 56
				local var_4_62 = utf8.len(var_4_60)
				local var_4_63 = var_4_61 <= 0 and var_4_56 or var_4_56 * (var_4_62 / var_4_61)

				if var_4_63 > 0 and var_4_56 < var_4_63 then
					arg_1_1.talkMaxDuration = var_4_63
					var_4_55 = var_4_55 + 0.3

					if var_4_63 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_55
					end
				end

				arg_1_1.text_.text = var_4_60
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361001", "story_v_out_319361.awb") ~= 0 then
					local var_4_64 = manager.audio:GetVoiceLength("story_v_out_319361", "319361001", "story_v_out_319361.awb") / 1000

					if var_4_64 + var_4_55 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_55
					end

					if var_4_59.prefab_name ~= "" and arg_1_1.actors_[var_4_59.prefab_name] ~= nil then
						local var_4_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_59.prefab_name].transform, "story_v_out_319361", "319361001", "story_v_out_319361.awb")

						arg_1_1:RecordAudio("319361001", var_4_65)
						arg_1_1:RecordAudio("319361001", var_4_65)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319361", "319361001", "story_v_out_319361.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319361", "319361001", "story_v_out_319361.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_66 = var_4_55 + 0.3
			local var_4_67 = math.max(var_4_56, arg_1_1.talkMaxDuration)

			if var_4_66 <= arg_1_1.time_ and arg_1_1.time_ < var_4_66 + var_4_67 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_66) / var_4_67

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319361002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319361002
		arg_9_1.duration_ = 12.33

		local var_9_0 = {
			zh = 11.9,
			ja = 12.333
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
				arg_9_0:Play319361003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.4

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[471].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(319361002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 56
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361002", "story_v_out_319361.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361002", "story_v_out_319361.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_319361", "319361002", "story_v_out_319361.awb")

						arg_9_1:RecordAudio("319361002", var_12_9)
						arg_9_1:RecordAudio("319361002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319361", "319361002", "story_v_out_319361.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319361", "319361002", "story_v_out_319361.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play319361003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319361003
		arg_13_1.duration_ = 11.5

		local var_13_0 = {
			zh = 11.5,
			ja = 8.933
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
				arg_13_0:Play319361004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.3

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[471].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(319361003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 52
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361003", "story_v_out_319361.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361003", "story_v_out_319361.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_319361", "319361003", "story_v_out_319361.awb")

						arg_13_1:RecordAudio("319361003", var_16_9)
						arg_13_1:RecordAudio("319361003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319361", "319361003", "story_v_out_319361.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319361", "319361003", "story_v_out_319361.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319361004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319361004
		arg_17_1.duration_ = 10.6

		local var_17_0 = {
			zh = 10.6,
			ja = 9.666
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
				arg_17_0:Play319361005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.2

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[471].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(319361004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361004", "story_v_out_319361.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361004", "story_v_out_319361.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_319361", "319361004", "story_v_out_319361.awb")

						arg_17_1:RecordAudio("319361004", var_20_9)
						arg_17_1:RecordAudio("319361004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319361", "319361004", "story_v_out_319361.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319361", "319361004", "story_v_out_319361.awb")
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
	Play319361005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319361005
		arg_21_1.duration_ = 13.67

		local var_21_0 = {
			zh = 13.3,
			ja = 13.666
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
				arg_21_0:Play319361006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_24_2 = 0
			local var_24_3 = 1.4

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_4 = arg_21_1:FormatText(StoryNameCfg[471].name)

				arg_21_1.leftNameTxt_.text = var_24_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:GetWordFromCfg(319361005)
				local var_24_6 = arg_21_1:FormatText(var_24_5.content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 56
				local var_24_8 = utf8.len(var_24_6)
				local var_24_9 = var_24_7 <= 0 and var_24_3 or var_24_3 * (var_24_8 / var_24_7)

				if var_24_9 > 0 and var_24_3 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361005", "story_v_out_319361.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319361", "319361005", "story_v_out_319361.awb") / 1000

					if var_24_10 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_2
					end

					if var_24_5.prefab_name ~= "" and arg_21_1.actors_[var_24_5.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_5.prefab_name].transform, "story_v_out_319361", "319361005", "story_v_out_319361.awb")

						arg_21_1:RecordAudio("319361005", var_24_11)
						arg_21_1:RecordAudio("319361005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319361", "319361005", "story_v_out_319361.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319361", "319361005", "story_v_out_319361.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_12 and arg_21_1.time_ < var_24_2 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319361006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319361006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319361007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1095ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1095ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 1.15

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(319361006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 46
				local var_28_11 = utf8.len(var_28_9)
				local var_28_12 = var_28_10 <= 0 and var_28_7 or var_28_7 * (var_28_11 / var_28_10)

				if var_28_12 > 0 and var_28_7 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_13 and arg_25_1.time_ < var_28_6 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319361007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319361007
		arg_29_1.duration_ = 3.37

		local var_29_0 = {
			zh = 2.566,
			ja = 3.366
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
				arg_29_0:Play319361008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1095ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1095ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.3

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[471].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(319361007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 12
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361007", "story_v_out_319361.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_319361", "319361007", "story_v_out_319361.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_319361", "319361007", "story_v_out_319361.awb")

						arg_29_1:RecordAudio("319361007", var_32_15)
						arg_29_1:RecordAudio("319361007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319361", "319361007", "story_v_out_319361.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319361", "319361007", "story_v_out_319361.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319361008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319361008
		arg_33_1.duration_ = 2.83

		local var_33_0 = {
			zh = 2.3,
			ja = 2.833
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
				arg_33_0:Play319361009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "10079ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["10079ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos10079ui_story = var_36_5.localPosition

				local var_36_7 = "10079ui_story"

				arg_33_1:ShowWeapon(arg_33_1.var_[var_36_7 .. "Animator"].transform, false)
			end

			local var_36_8 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_8 then
				local var_36_9 = (arg_33_1.time_ - var_36_6) / var_36_8
				local var_36_10 = Vector3.New(0.7, -0.95, -6.05)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10079ui_story, var_36_10, var_36_9)

				local var_36_11 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_11.x, var_36_11.y, var_36_11.z)

				local var_36_12 = var_36_5.localEulerAngles

				var_36_12.z = 0
				var_36_12.x = 0
				var_36_5.localEulerAngles = var_36_12
			end

			if arg_33_1.time_ >= var_36_6 + var_36_8 and arg_33_1.time_ < var_36_6 + var_36_8 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_36_13 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_13.x, var_36_13.y, var_36_13.z)

				local var_36_14 = var_36_5.localEulerAngles

				var_36_14.z = 0
				var_36_14.x = 0
				var_36_5.localEulerAngles = var_36_14
			end

			local var_36_15 = arg_33_1.actors_["10079ui_story"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect10079ui_story == nil then
				arg_33_1.var_.characterEffect10079ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_17 = 0.200000002980232

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.characterEffect10079ui_story and not isNil(var_36_15) then
					arg_33_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect10079ui_story then
				arg_33_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_36_20 = 0

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_21 = arg_33_1.actors_["1095ui_story"].transform
			local var_36_22 = 0

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 then
				arg_33_1.var_.moveOldPos1095ui_story = var_36_21.localPosition
			end

			local var_36_23 = 0.001

			if var_36_22 <= arg_33_1.time_ and arg_33_1.time_ < var_36_22 + var_36_23 then
				local var_36_24 = (arg_33_1.time_ - var_36_22) / var_36_23
				local var_36_25 = Vector3.New(-0.7, -0.98, -6.1)

				var_36_21.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1095ui_story, var_36_25, var_36_24)

				local var_36_26 = manager.ui.mainCamera.transform.position - var_36_21.position

				var_36_21.forward = Vector3.New(var_36_26.x, var_36_26.y, var_36_26.z)

				local var_36_27 = var_36_21.localEulerAngles

				var_36_27.z = 0
				var_36_27.x = 0
				var_36_21.localEulerAngles = var_36_27
			end

			if arg_33_1.time_ >= var_36_22 + var_36_23 and arg_33_1.time_ < var_36_22 + var_36_23 + arg_36_0 then
				var_36_21.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_36_28 = manager.ui.mainCamera.transform.position - var_36_21.position

				var_36_21.forward = Vector3.New(var_36_28.x, var_36_28.y, var_36_28.z)

				local var_36_29 = var_36_21.localEulerAngles

				var_36_29.z = 0
				var_36_29.x = 0
				var_36_21.localEulerAngles = var_36_29
			end

			local var_36_30 = arg_33_1.actors_["1095ui_story"]
			local var_36_31 = 0

			if var_36_31 < arg_33_1.time_ and arg_33_1.time_ <= var_36_31 + arg_36_0 and not isNil(var_36_30) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_32 = 0.200000002980232

			if var_36_31 <= arg_33_1.time_ and arg_33_1.time_ < var_36_31 + var_36_32 and not isNil(var_36_30) then
				local var_36_33 = (arg_33_1.time_ - var_36_31) / var_36_32

				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_30) then
					local var_36_34 = Mathf.Lerp(0, 0.5, var_36_33)

					arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1095ui_story.fillRatio = var_36_34
				end
			end

			if arg_33_1.time_ >= var_36_31 + var_36_32 and arg_33_1.time_ < var_36_31 + var_36_32 + arg_36_0 and not isNil(var_36_30) and arg_33_1.var_.characterEffect1095ui_story then
				local var_36_35 = 0.5

				arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1095ui_story.fillRatio = var_36_35
			end

			local var_36_36 = 0
			local var_36_37 = 0.25

			if var_36_36 < arg_33_1.time_ and arg_33_1.time_ <= var_36_36 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_38 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_39 = arg_33_1:GetWordFromCfg(319361008)
				local var_36_40 = arg_33_1:FormatText(var_36_39.content)

				arg_33_1.text_.text = var_36_40

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_41 = 10
				local var_36_42 = utf8.len(var_36_40)
				local var_36_43 = var_36_41 <= 0 and var_36_37 or var_36_37 * (var_36_42 / var_36_41)

				if var_36_43 > 0 and var_36_37 < var_36_43 then
					arg_33_1.talkMaxDuration = var_36_43

					if var_36_43 + var_36_36 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_43 + var_36_36
					end
				end

				arg_33_1.text_.text = var_36_40
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361008", "story_v_out_319361.awb") ~= 0 then
					local var_36_44 = manager.audio:GetVoiceLength("story_v_out_319361", "319361008", "story_v_out_319361.awb") / 1000

					if var_36_44 + var_36_36 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_44 + var_36_36
					end

					if var_36_39.prefab_name ~= "" and arg_33_1.actors_[var_36_39.prefab_name] ~= nil then
						local var_36_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_39.prefab_name].transform, "story_v_out_319361", "319361008", "story_v_out_319361.awb")

						arg_33_1:RecordAudio("319361008", var_36_45)
						arg_33_1:RecordAudio("319361008", var_36_45)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319361", "319361008", "story_v_out_319361.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319361", "319361008", "story_v_out_319361.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_46 = math.max(var_36_37, arg_33_1.talkMaxDuration)

			if var_36_36 <= arg_33_1.time_ and arg_33_1.time_ < var_36_36 + var_36_46 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_36) / var_36_46

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_36 + var_36_46 and arg_33_1.time_ < var_36_36 + var_36_46 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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

		arg_33_1:InitPlayNodeList()
	end,
	Play319361009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319361009
		arg_37_1.duration_ = 5.13

		local var_37_0 = {
			zh = 2.466,
			ja = 5.133
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
				arg_37_0:Play319361010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10079ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10079ui_story == nil then
				arg_37_1.var_.characterEffect10079ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10079ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10079ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10079ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10079ui_story.fillRatio = var_40_5
			end

			local var_40_6 = arg_37_1.actors_["1095ui_story"]
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.200000002980232

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 and not isNil(var_40_6) then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8

				if arg_37_1.var_.characterEffect1095ui_story and not isNil(var_40_6) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_40_10 = 0
			local var_40_11 = 0.225

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_12 = arg_37_1:FormatText(StoryNameCfg[471].name)

				arg_37_1.leftNameTxt_.text = var_40_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(319361009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_15 = 9
				local var_40_16 = utf8.len(var_40_14)
				local var_40_17 = var_40_15 <= 0 and var_40_11 or var_40_11 * (var_40_16 / var_40_15)

				if var_40_17 > 0 and var_40_11 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_10
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361009", "story_v_out_319361.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361009", "story_v_out_319361.awb") / 1000

					if var_40_18 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_10
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_319361", "319361009", "story_v_out_319361.awb")

						arg_37_1:RecordAudio("319361009", var_40_19)
						arg_37_1:RecordAudio("319361009", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319361", "319361009", "story_v_out_319361.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319361", "319361009", "story_v_out_319361.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_11, arg_37_1.talkMaxDuration)

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_10) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_10 + var_40_20 and arg_37_1.time_ < var_40_10 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319361010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319361010
		arg_41_1.duration_ = 7.93

		local var_41_0 = {
			zh = 5.266,
			ja = 7.933
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
				arg_41_0:Play319361011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10079ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10079ui_story == nil then
				arg_41_1.var_.characterEffect10079ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10079ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10079ui_story then
				arg_41_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1095ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1095ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1095ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1095ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0
			local var_44_11 = 0.675

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_12 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(319361010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_15 = 27
				local var_44_16 = utf8.len(var_44_14)
				local var_44_17 = var_44_15 <= 0 and var_44_11 or var_44_11 * (var_44_16 / var_44_15)

				if var_44_17 > 0 and var_44_11 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17

					if var_44_17 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361010", "story_v_out_319361.awb") ~= 0 then
					local var_44_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361010", "story_v_out_319361.awb") / 1000

					if var_44_18 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_10
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_319361", "319361010", "story_v_out_319361.awb")

						arg_41_1:RecordAudio("319361010", var_44_19)
						arg_41_1:RecordAudio("319361010", var_44_19)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319361", "319361010", "story_v_out_319361.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319361", "319361010", "story_v_out_319361.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_20 and arg_41_1.time_ < var_44_10 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319361011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319361011
		arg_45_1.duration_ = 6.87

		local var_45_0 = {
			zh = 5.8,
			ja = 6.866
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
				arg_45_0:Play319361012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10079ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10079ui_story == nil then
				arg_45_1.var_.characterEffect10079ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10079ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10079ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10079ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10079ui_story.fillRatio = var_48_5
			end

			local var_48_6 = arg_45_1.actors_["1095ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1095ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1095ui_story then
				arg_45_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_48_11 = 0

			if var_48_11 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_12 = 0
			local var_48_13 = 0.6

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_14 = arg_45_1:FormatText(StoryNameCfg[471].name)

				arg_45_1.leftNameTxt_.text = var_48_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(319361011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 24
				local var_48_18 = utf8.len(var_48_16)
				local var_48_19 = var_48_17 <= 0 and var_48_13 or var_48_13 * (var_48_18 / var_48_17)

				if var_48_19 > 0 and var_48_13 < var_48_19 then
					arg_45_1.talkMaxDuration = var_48_19

					if var_48_19 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361011", "story_v_out_319361.awb") ~= 0 then
					local var_48_20 = manager.audio:GetVoiceLength("story_v_out_319361", "319361011", "story_v_out_319361.awb") / 1000

					if var_48_20 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_20 + var_48_12
					end

					if var_48_15.prefab_name ~= "" and arg_45_1.actors_[var_48_15.prefab_name] ~= nil then
						local var_48_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_15.prefab_name].transform, "story_v_out_319361", "319361011", "story_v_out_319361.awb")

						arg_45_1:RecordAudio("319361011", var_48_21)
						arg_45_1:RecordAudio("319361011", var_48_21)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319361", "319361011", "story_v_out_319361.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319361", "319361011", "story_v_out_319361.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_22 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_12) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_12 + var_48_22 and arg_45_1.time_ < var_48_12 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319361012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319361012
		arg_49_1.duration_ = 10.6

		local var_49_0 = {
			zh = 10.433,
			ja = 10.6
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
				arg_49_0:Play319361013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10079ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10079ui_story == nil then
				arg_49_1.var_.characterEffect10079ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10079ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10079ui_story then
				arg_49_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1095ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1095ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1095ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0
			local var_52_11 = 1.175

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[6].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(319361012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361012", "story_v_out_319361.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361012", "story_v_out_319361.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_319361", "319361012", "story_v_out_319361.awb")

						arg_49_1:RecordAudio("319361012", var_52_19)
						arg_49_1:RecordAudio("319361012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319361", "319361012", "story_v_out_319361.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319361", "319361012", "story_v_out_319361.awb")
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
	Play319361013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319361013
		arg_53_1.duration_ = 6.77

		local var_53_0 = {
			zh = 6.766,
			ja = 4.833
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
				arg_53_0:Play319361014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10079ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10079ui_story == nil then
				arg_53_1.var_.characterEffect10079ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10079ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10079ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10079ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10079ui_story.fillRatio = var_56_5
			end

			local var_56_6 = arg_53_1.actors_["1095ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.200000002980232

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect1095ui_story and not isNil(var_56_6) then
					arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1095ui_story then
				arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_56_10 = 0
			local var_56_11 = 0.775

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_12 = arg_53_1:FormatText(StoryNameCfg[471].name)

				arg_53_1.leftNameTxt_.text = var_56_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_13 = arg_53_1:GetWordFromCfg(319361013)
				local var_56_14 = arg_53_1:FormatText(var_56_13.content)

				arg_53_1.text_.text = var_56_14

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_15 = 31
				local var_56_16 = utf8.len(var_56_14)
				local var_56_17 = var_56_15 <= 0 and var_56_11 or var_56_11 * (var_56_16 / var_56_15)

				if var_56_17 > 0 and var_56_11 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17

					if var_56_17 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_10
					end
				end

				arg_53_1.text_.text = var_56_14
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361013", "story_v_out_319361.awb") ~= 0 then
					local var_56_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361013", "story_v_out_319361.awb") / 1000

					if var_56_18 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_10
					end

					if var_56_13.prefab_name ~= "" and arg_53_1.actors_[var_56_13.prefab_name] ~= nil then
						local var_56_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_13.prefab_name].transform, "story_v_out_319361", "319361013", "story_v_out_319361.awb")

						arg_53_1:RecordAudio("319361013", var_56_19)
						arg_53_1:RecordAudio("319361013", var_56_19)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319361", "319361013", "story_v_out_319361.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319361", "319361013", "story_v_out_319361.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_20 = math.max(var_56_11, arg_53_1.talkMaxDuration)

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_20 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_10) / var_56_20

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_10 + var_56_20 and arg_53_1.time_ < var_56_10 + var_56_20 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319361014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319361014
		arg_57_1.duration_ = 7.13

		local var_57_0 = {
			zh = 7.133,
			ja = 6.566
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
				arg_57_0:Play319361015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1095ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1095ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1095ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1095ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1095ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1095ui_story then
				arg_57_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_60_13 = 0
			local var_60_14 = 0.9

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_15 = arg_57_1:FormatText(StoryNameCfg[471].name)

				arg_57_1.leftNameTxt_.text = var_60_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_16 = arg_57_1:GetWordFromCfg(319361014)
				local var_60_17 = arg_57_1:FormatText(var_60_16.content)

				arg_57_1.text_.text = var_60_17

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_18 = 36
				local var_60_19 = utf8.len(var_60_17)
				local var_60_20 = var_60_18 <= 0 and var_60_14 or var_60_14 * (var_60_19 / var_60_18)

				if var_60_20 > 0 and var_60_14 < var_60_20 then
					arg_57_1.talkMaxDuration = var_60_20

					if var_60_20 + var_60_13 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_13
					end
				end

				arg_57_1.text_.text = var_60_17
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361014", "story_v_out_319361.awb") ~= 0 then
					local var_60_21 = manager.audio:GetVoiceLength("story_v_out_319361", "319361014", "story_v_out_319361.awb") / 1000

					if var_60_21 + var_60_13 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_21 + var_60_13
					end

					if var_60_16.prefab_name ~= "" and arg_57_1.actors_[var_60_16.prefab_name] ~= nil then
						local var_60_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_16.prefab_name].transform, "story_v_out_319361", "319361014", "story_v_out_319361.awb")

						arg_57_1:RecordAudio("319361014", var_60_22)
						arg_57_1:RecordAudio("319361014", var_60_22)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319361", "319361014", "story_v_out_319361.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319361", "319361014", "story_v_out_319361.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_23 = math.max(var_60_14, arg_57_1.talkMaxDuration)

			if var_60_13 <= arg_57_1.time_ and arg_57_1.time_ < var_60_13 + var_60_23 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_13) / var_60_23

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_13 + var_60_23 and arg_57_1.time_ < var_60_13 + var_60_23 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play319361015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319361015
		arg_61_1.duration_ = 9.17

		local var_61_0 = {
			zh = 8.3,
			ja = 9.166
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
				arg_61_0:Play319361016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10079ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10079ui_story = var_64_0.localPosition

				local var_64_2 = "10079ui_story"

				arg_61_1:ShowWeapon(arg_61_1.var_[var_64_2 .. "Animator"].transform, false)
			end

			local var_64_3 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3
				local var_64_5 = Vector3.New(0.7, -0.95, -6.05)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10079ui_story, var_64_5, var_64_4)

				local var_64_6 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_6.x, var_64_6.y, var_64_6.z)

				local var_64_7 = var_64_0.localEulerAngles

				var_64_7.z = 0
				var_64_7.x = 0
				var_64_0.localEulerAngles = var_64_7
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_64_8 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_8.x, var_64_8.y, var_64_8.z)

				local var_64_9 = var_64_0.localEulerAngles

				var_64_9.z = 0
				var_64_9.x = 0
				var_64_0.localEulerAngles = var_64_9
			end

			local var_64_10 = arg_61_1.actors_["10079ui_story"]
			local var_64_11 = 0

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = var_64_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_12 = 0.200000002980232

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_12 and not isNil(var_64_10) then
				local var_64_13 = (arg_61_1.time_ - var_64_11) / var_64_12

				if arg_61_1.var_.characterEffect10079ui_story and not isNil(var_64_10) then
					arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_11 + var_64_12 and arg_61_1.time_ < var_64_11 + var_64_12 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect10079ui_story then
				arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_16 = arg_61_1.actors_["1095ui_story"]
			local var_64_17 = 0

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 and not isNil(var_64_16) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_18 = 0.200000002980232

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_18 and not isNil(var_64_16) then
				local var_64_19 = (arg_61_1.time_ - var_64_17) / var_64_18

				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_16) then
					local var_64_20 = Mathf.Lerp(0, 0.5, var_64_19)

					arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1095ui_story.fillRatio = var_64_20
				end
			end

			if arg_61_1.time_ >= var_64_17 + var_64_18 and arg_61_1.time_ < var_64_17 + var_64_18 + arg_64_0 and not isNil(var_64_16) and arg_61_1.var_.characterEffect1095ui_story then
				local var_64_21 = 0.5

				arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1095ui_story.fillRatio = var_64_21
			end

			local var_64_22 = 0
			local var_64_23 = 0.85

			if var_64_22 < arg_61_1.time_ and arg_61_1.time_ <= var_64_22 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_24 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_25 = arg_61_1:GetWordFromCfg(319361015)
				local var_64_26 = arg_61_1:FormatText(var_64_25.content)

				arg_61_1.text_.text = var_64_26

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_27 = 34
				local var_64_28 = utf8.len(var_64_26)
				local var_64_29 = var_64_27 <= 0 and var_64_23 or var_64_23 * (var_64_28 / var_64_27)

				if var_64_29 > 0 and var_64_23 < var_64_29 then
					arg_61_1.talkMaxDuration = var_64_29

					if var_64_29 + var_64_22 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_29 + var_64_22
					end
				end

				arg_61_1.text_.text = var_64_26
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361015", "story_v_out_319361.awb") ~= 0 then
					local var_64_30 = manager.audio:GetVoiceLength("story_v_out_319361", "319361015", "story_v_out_319361.awb") / 1000

					if var_64_30 + var_64_22 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_30 + var_64_22
					end

					if var_64_25.prefab_name ~= "" and arg_61_1.actors_[var_64_25.prefab_name] ~= nil then
						local var_64_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_25.prefab_name].transform, "story_v_out_319361", "319361015", "story_v_out_319361.awb")

						arg_61_1:RecordAudio("319361015", var_64_31)
						arg_61_1:RecordAudio("319361015", var_64_31)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319361", "319361015", "story_v_out_319361.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319361", "319361015", "story_v_out_319361.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_32 = math.max(var_64_23, arg_61_1.talkMaxDuration)

			if var_64_22 <= arg_61_1.time_ and arg_61_1.time_ < var_64_22 + var_64_32 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_22) / var_64_32

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_22 + var_64_32 and arg_61_1.time_ < var_64_22 + var_64_32 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319361016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319361016
		arg_65_1.duration_ = 10.07

		local var_65_0 = {
			zh = 8.5,
			ja = 10.066
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
				arg_65_0:Play319361017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10079ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10079ui_story == nil then
				arg_65_1.var_.characterEffect10079ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10079ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10079ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10079ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10079ui_story.fillRatio = var_68_5
			end

			local var_68_6 = arg_65_1.actors_["1095ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_12 = 0
			local var_68_13 = 1.075

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[471].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(319361016)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361016", "story_v_out_319361.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_319361", "319361016", "story_v_out_319361.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_319361", "319361016", "story_v_out_319361.awb")

						arg_65_1:RecordAudio("319361016", var_68_21)
						arg_65_1:RecordAudio("319361016", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319361", "319361016", "story_v_out_319361.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319361", "319361016", "story_v_out_319361.awb")
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
	Play319361017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319361017
		arg_69_1.duration_ = 2.57

		local var_69_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_69_0:Play319361018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10079ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10079ui_story == nil then
				arg_69_1.var_.characterEffect10079ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10079ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10079ui_story then
				arg_69_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["1095ui_story"]
			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_6 and not isNil(var_72_4) then
				local var_72_7 = (arg_69_1.time_ - var_72_5) / var_72_6

				if arg_69_1.var_.characterEffect1095ui_story and not isNil(var_72_4) then
					local var_72_8 = Mathf.Lerp(0, 0.5, var_72_7)

					arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1095ui_story.fillRatio = var_72_8
				end
			end

			if arg_69_1.time_ >= var_72_5 + var_72_6 and arg_69_1.time_ < var_72_5 + var_72_6 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1095ui_story then
				local var_72_9 = 0.5

				arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1095ui_story.fillRatio = var_72_9
			end

			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_72_11 = 0
			local var_72_12 = 0.1

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_13 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(319361017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 4
				local var_72_17 = utf8.len(var_72_15)
				local var_72_18 = var_72_16 <= 0 and var_72_12 or var_72_12 * (var_72_17 / var_72_16)

				if var_72_18 > 0 and var_72_12 < var_72_18 then
					arg_69_1.talkMaxDuration = var_72_18

					if var_72_18 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361017", "story_v_out_319361.awb") ~= 0 then
					local var_72_19 = manager.audio:GetVoiceLength("story_v_out_319361", "319361017", "story_v_out_319361.awb") / 1000

					if var_72_19 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_11
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_319361", "319361017", "story_v_out_319361.awb")

						arg_69_1:RecordAudio("319361017", var_72_20)
						arg_69_1:RecordAudio("319361017", var_72_20)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319361", "319361017", "story_v_out_319361.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319361", "319361017", "story_v_out_319361.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_21 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_21 and arg_69_1.time_ < var_72_11 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319361018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319361018
		arg_73_1.duration_ = 7.87

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319361019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10079ui_story"].transform
			local var_76_1 = 1.3

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10079ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10079ui_story, var_76_4, var_76_3)

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

			local var_76_9 = 1.3

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				local var_76_10 = manager.ui.mainCamera.transform.localPosition
				local var_76_11 = Vector3.New(0, 0, 10) + Vector3.New(var_76_10.x, var_76_10.y, 0)
				local var_76_12 = arg_73_1.bgs_.I11q

				var_76_12.transform.localPosition = var_76_11
				var_76_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_13 = var_76_12:GetComponent("SpriteRenderer")

				if var_76_13 and var_76_13.sprite then
					local var_76_14 = (var_76_12.transform.localPosition - var_76_10).z
					local var_76_15 = manager.ui.mainCameraCom_
					local var_76_16 = 2 * var_76_14 * Mathf.Tan(var_76_15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_76_17 = var_76_16 * var_76_15.aspect
					local var_76_18 = var_76_13.sprite.bounds.size.x
					local var_76_19 = var_76_13.sprite.bounds.size.y
					local var_76_20 = var_76_17 / var_76_18
					local var_76_21 = var_76_16 / var_76_19
					local var_76_22 = var_76_21 < var_76_20 and var_76_20 or var_76_21

					var_76_12.transform.localScale = Vector3.New(var_76_22, var_76_22, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "I11q" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_23 = 0

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_24 = 1.3

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_24 then
				local var_76_25 = (arg_73_1.time_ - var_76_23) / var_76_24
				local var_76_26 = Color.New(0, 0, 0)

				var_76_26.a = Mathf.Lerp(0, 1, var_76_25)
				arg_73_1.mask_.color = var_76_26
			end

			if arg_73_1.time_ >= var_76_23 + var_76_24 and arg_73_1.time_ < var_76_23 + var_76_24 + arg_76_0 then
				local var_76_27 = Color.New(0, 0, 0)

				var_76_27.a = 1
				arg_73_1.mask_.color = var_76_27
			end

			local var_76_28 = 1.3

			if var_76_28 < arg_73_1.time_ and arg_73_1.time_ <= var_76_28 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_29 = 2

			if var_76_28 <= arg_73_1.time_ and arg_73_1.time_ < var_76_28 + var_76_29 then
				local var_76_30 = (arg_73_1.time_ - var_76_28) / var_76_29
				local var_76_31 = Color.New(0, 0, 0)

				var_76_31.a = Mathf.Lerp(1, 0, var_76_30)
				arg_73_1.mask_.color = var_76_31
			end

			if arg_73_1.time_ >= var_76_28 + var_76_29 and arg_73_1.time_ < var_76_28 + var_76_29 + arg_76_0 then
				local var_76_32 = Color.New(0, 0, 0)
				local var_76_33 = 0

				arg_73_1.mask_.enabled = false
				var_76_32.a = var_76_33
				arg_73_1.mask_.color = var_76_32
			end

			local var_76_34 = arg_73_1.actors_["1095ui_story"].transform
			local var_76_35 = 1.3

			if var_76_35 < arg_73_1.time_ and arg_73_1.time_ <= var_76_35 + arg_76_0 then
				arg_73_1.var_.moveOldPos1095ui_story = var_76_34.localPosition

				local var_76_36 = "1095ui_story"

				arg_73_1:ShowWeapon(arg_73_1.var_[var_76_36 .. "Animator"].transform, false)
			end

			local var_76_37 = 0.001

			if var_76_35 <= arg_73_1.time_ and arg_73_1.time_ < var_76_35 + var_76_37 then
				local var_76_38 = (arg_73_1.time_ - var_76_35) / var_76_37
				local var_76_39 = Vector3.New(0, 100, 0)

				var_76_34.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1095ui_story, var_76_39, var_76_38)

				local var_76_40 = manager.ui.mainCamera.transform.position - var_76_34.position

				var_76_34.forward = Vector3.New(var_76_40.x, var_76_40.y, var_76_40.z)

				local var_76_41 = var_76_34.localEulerAngles

				var_76_41.z = 0
				var_76_41.x = 0
				var_76_34.localEulerAngles = var_76_41
			end

			if arg_73_1.time_ >= var_76_35 + var_76_37 and arg_73_1.time_ < var_76_35 + var_76_37 + arg_76_0 then
				var_76_34.localPosition = Vector3.New(0, 100, 0)

				local var_76_42 = manager.ui.mainCamera.transform.position - var_76_34.position

				var_76_34.forward = Vector3.New(var_76_42.x, var_76_42.y, var_76_42.z)

				local var_76_43 = var_76_34.localEulerAngles

				var_76_43.z = 0
				var_76_43.x = 0
				var_76_34.localEulerAngles = var_76_43
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_44 = 2.86666666666667
			local var_76_45 = 1.45

			if var_76_44 < arg_73_1.time_ and arg_73_1.time_ <= var_76_44 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_46 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_46:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_47 = arg_73_1:GetWordFromCfg(319361018)
				local var_76_48 = arg_73_1:FormatText(var_76_47.content)

				arg_73_1.text_.text = var_76_48

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_49 = 58
				local var_76_50 = utf8.len(var_76_48)
				local var_76_51 = var_76_49 <= 0 and var_76_45 or var_76_45 * (var_76_50 / var_76_49)

				if var_76_51 > 0 and var_76_45 < var_76_51 then
					arg_73_1.talkMaxDuration = var_76_51
					var_76_44 = var_76_44 + 0.3

					if var_76_51 + var_76_44 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_51 + var_76_44
					end
				end

				arg_73_1.text_.text = var_76_48
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_52 = var_76_44 + 0.3
			local var_76_53 = math.max(var_76_45, arg_73_1.talkMaxDuration)

			if var_76_52 <= arg_73_1.time_ and arg_73_1.time_ < var_76_52 + var_76_53 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_52) / var_76_53

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_52 + var_76_53 and arg_73_1.time_ < var_76_52 + var_76_53 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play319361019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319361019
		arg_79_1.duration_ = 2.1

		local var_79_0 = {
			zh = 1.533,
			ja = 2.1
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319361020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10079ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10079ui_story == nil then
				arg_79_1.var_.characterEffect10079ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect10079ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10079ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10079ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10079ui_story.fillRatio = var_82_5
			end

			local var_82_6 = arg_79_1.actors_["1095ui_story"]
			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1095ui_story == nil then
				arg_79_1.var_.characterEffect1095ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_8 = 0.200000002980232

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_8 and not isNil(var_82_6) then
				local var_82_9 = (arg_79_1.time_ - var_82_7) / var_82_8

				if arg_79_1.var_.characterEffect1095ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1095ui_story then
				arg_79_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_82_10 = arg_79_1.actors_["1095ui_story"].transform
			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.var_.moveOldPos1095ui_story = var_82_10.localPosition

				local var_82_12 = "1095ui_story"

				arg_79_1:ShowWeapon(arg_79_1.var_[var_82_12 .. "Animator"].transform, false)
			end

			local var_82_13 = 0.001

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_13 then
				local var_82_14 = (arg_79_1.time_ - var_82_11) / var_82_13
				local var_82_15 = Vector3.New(0, -0.98, -6.1)

				var_82_10.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1095ui_story, var_82_15, var_82_14)

				local var_82_16 = manager.ui.mainCamera.transform.position - var_82_10.position

				var_82_10.forward = Vector3.New(var_82_16.x, var_82_16.y, var_82_16.z)

				local var_82_17 = var_82_10.localEulerAngles

				var_82_17.z = 0
				var_82_17.x = 0
				var_82_10.localEulerAngles = var_82_17
			end

			if arg_79_1.time_ >= var_82_11 + var_82_13 and arg_79_1.time_ < var_82_11 + var_82_13 + arg_82_0 then
				var_82_10.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_82_18 = manager.ui.mainCamera.transform.position - var_82_10.position

				var_82_10.forward = Vector3.New(var_82_18.x, var_82_18.y, var_82_18.z)

				local var_82_19 = var_82_10.localEulerAngles

				var_82_19.z = 0
				var_82_19.x = 0
				var_82_10.localEulerAngles = var_82_19
			end

			local var_82_20 = 0
			local var_82_21 = 0.175

			if var_82_20 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_22 = arg_79_1:FormatText(StoryNameCfg[471].name)

				arg_79_1.leftNameTxt_.text = var_82_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_23 = arg_79_1:GetWordFromCfg(319361019)
				local var_82_24 = arg_79_1:FormatText(var_82_23.content)

				arg_79_1.text_.text = var_82_24

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_25 = 7
				local var_82_26 = utf8.len(var_82_24)
				local var_82_27 = var_82_25 <= 0 and var_82_21 or var_82_21 * (var_82_26 / var_82_25)

				if var_82_27 > 0 and var_82_21 < var_82_27 then
					arg_79_1.talkMaxDuration = var_82_27

					if var_82_27 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_27 + var_82_20
					end
				end

				arg_79_1.text_.text = var_82_24
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361019", "story_v_out_319361.awb") ~= 0 then
					local var_82_28 = manager.audio:GetVoiceLength("story_v_out_319361", "319361019", "story_v_out_319361.awb") / 1000

					if var_82_28 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_20
					end

					if var_82_23.prefab_name ~= "" and arg_79_1.actors_[var_82_23.prefab_name] ~= nil then
						local var_82_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_23.prefab_name].transform, "story_v_out_319361", "319361019", "story_v_out_319361.awb")

						arg_79_1:RecordAudio("319361019", var_82_29)
						arg_79_1:RecordAudio("319361019", var_82_29)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319361", "319361019", "story_v_out_319361.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319361", "319361019", "story_v_out_319361.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_30 = math.max(var_82_21, arg_79_1.talkMaxDuration)

			if var_82_20 <= arg_79_1.time_ and arg_79_1.time_ < var_82_20 + var_82_30 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_20) / var_82_30

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_20 + var_82_30 and arg_79_1.time_ < var_82_20 + var_82_30 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play319361020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319361020
		arg_83_1.duration_ = 8.2

		local var_83_0 = {
			zh = 5.666,
			ja = 8.2
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play319361021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10079ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10079ui_story == nil then
				arg_83_1.var_.characterEffect10079ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect10079ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect10079ui_story then
				arg_83_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_86_4 = arg_83_1.actors_["1095ui_story"]
			local var_86_5 = 0

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1095ui_story == nil then
				arg_83_1.var_.characterEffect1095ui_story = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_6 and not isNil(var_86_4) then
				local var_86_7 = (arg_83_1.time_ - var_86_5) / var_86_6

				if arg_83_1.var_.characterEffect1095ui_story and not isNil(var_86_4) then
					local var_86_8 = Mathf.Lerp(0, 0.5, var_86_7)

					arg_83_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1095ui_story.fillRatio = var_86_8
				end
			end

			if arg_83_1.time_ >= var_86_5 + var_86_6 and arg_83_1.time_ < var_86_5 + var_86_6 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1095ui_story then
				local var_86_9 = 0.5

				arg_83_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1095ui_story.fillRatio = var_86_9
			end

			local var_86_10 = arg_83_1.actors_["1095ui_story"].transform
			local var_86_11 = 0

			if var_86_11 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1.var_.moveOldPos1095ui_story = var_86_10.localPosition

				local var_86_12 = "1095ui_story"

				arg_83_1:ShowWeapon(arg_83_1.var_[var_86_12 .. "Animator"].transform, false)
			end

			local var_86_13 = 0.001

			if var_86_11 <= arg_83_1.time_ and arg_83_1.time_ < var_86_11 + var_86_13 then
				local var_86_14 = (arg_83_1.time_ - var_86_11) / var_86_13
				local var_86_15 = Vector3.New(-0.7, -0.98, -6.1)

				var_86_10.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1095ui_story, var_86_15, var_86_14)

				local var_86_16 = manager.ui.mainCamera.transform.position - var_86_10.position

				var_86_10.forward = Vector3.New(var_86_16.x, var_86_16.y, var_86_16.z)

				local var_86_17 = var_86_10.localEulerAngles

				var_86_17.z = 0
				var_86_17.x = 0
				var_86_10.localEulerAngles = var_86_17
			end

			if arg_83_1.time_ >= var_86_11 + var_86_13 and arg_83_1.time_ < var_86_11 + var_86_13 + arg_86_0 then
				var_86_10.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_86_18 = manager.ui.mainCamera.transform.position - var_86_10.position

				var_86_10.forward = Vector3.New(var_86_18.x, var_86_18.y, var_86_18.z)

				local var_86_19 = var_86_10.localEulerAngles

				var_86_19.z = 0
				var_86_19.x = 0
				var_86_10.localEulerAngles = var_86_19
			end

			local var_86_20 = arg_83_1.actors_["10079ui_story"].transform
			local var_86_21 = 0

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				arg_83_1.var_.moveOldPos10079ui_story = var_86_20.localPosition
			end

			local var_86_22 = 0.001

			if var_86_21 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_22 then
				local var_86_23 = (arg_83_1.time_ - var_86_21) / var_86_22
				local var_86_24 = Vector3.New(0.7, -0.95, -6.05)

				var_86_20.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10079ui_story, var_86_24, var_86_23)

				local var_86_25 = manager.ui.mainCamera.transform.position - var_86_20.position

				var_86_20.forward = Vector3.New(var_86_25.x, var_86_25.y, var_86_25.z)

				local var_86_26 = var_86_20.localEulerAngles

				var_86_26.z = 0
				var_86_26.x = 0
				var_86_20.localEulerAngles = var_86_26
			end

			if arg_83_1.time_ >= var_86_21 + var_86_22 and arg_83_1.time_ < var_86_21 + var_86_22 + arg_86_0 then
				var_86_20.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_86_27 = manager.ui.mainCamera.transform.position - var_86_20.position

				var_86_20.forward = Vector3.New(var_86_27.x, var_86_27.y, var_86_27.z)

				local var_86_28 = var_86_20.localEulerAngles

				var_86_28.z = 0
				var_86_28.x = 0
				var_86_20.localEulerAngles = var_86_28
			end

			local var_86_29 = 0

			if var_86_29 < arg_83_1.time_ and arg_83_1.time_ <= var_86_29 + arg_86_0 then
				arg_83_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_86_30 = 0
			local var_86_31 = 0.6

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_32 = arg_83_1:FormatText(StoryNameCfg[6].name)

				arg_83_1.leftNameTxt_.text = var_86_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_33 = arg_83_1:GetWordFromCfg(319361020)
				local var_86_34 = arg_83_1:FormatText(var_86_33.content)

				arg_83_1.text_.text = var_86_34

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_35 = 24
				local var_86_36 = utf8.len(var_86_34)
				local var_86_37 = var_86_35 <= 0 and var_86_31 or var_86_31 * (var_86_36 / var_86_35)

				if var_86_37 > 0 and var_86_31 < var_86_37 then
					arg_83_1.talkMaxDuration = var_86_37

					if var_86_37 + var_86_30 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_37 + var_86_30
					end
				end

				arg_83_1.text_.text = var_86_34
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361020", "story_v_out_319361.awb") ~= 0 then
					local var_86_38 = manager.audio:GetVoiceLength("story_v_out_319361", "319361020", "story_v_out_319361.awb") / 1000

					if var_86_38 + var_86_30 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_38 + var_86_30
					end

					if var_86_33.prefab_name ~= "" and arg_83_1.actors_[var_86_33.prefab_name] ~= nil then
						local var_86_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_33.prefab_name].transform, "story_v_out_319361", "319361020", "story_v_out_319361.awb")

						arg_83_1:RecordAudio("319361020", var_86_39)
						arg_83_1:RecordAudio("319361020", var_86_39)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319361", "319361020", "story_v_out_319361.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319361", "319361020", "story_v_out_319361.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_40 = math.max(var_86_31, arg_83_1.talkMaxDuration)

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_40 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_30) / var_86_40

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_30 + var_86_40 and arg_83_1.time_ < var_86_30 + var_86_40 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play319361021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319361021
		arg_87_1.duration_ = 6.63

		local var_87_0 = {
			zh = 6.633,
			ja = 6.4
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play319361022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10079ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10079ui_story == nil then
				arg_87_1.var_.characterEffect10079ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect10079ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10079ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10079ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10079ui_story.fillRatio = var_90_5
			end

			local var_90_6 = arg_87_1.actors_["1095ui_story"]
			local var_90_7 = 0

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1095ui_story == nil then
				arg_87_1.var_.characterEffect1095ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_8 = 0.200000002980232

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 and not isNil(var_90_6) then
				local var_90_9 = (arg_87_1.time_ - var_90_7) / var_90_8

				if arg_87_1.var_.characterEffect1095ui_story and not isNil(var_90_6) then
					arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1095ui_story then
				arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_90_11 = 0

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_90_12 = arg_87_1.actors_["10079ui_story"].transform
			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.var_.moveOldPos10079ui_story = var_90_12.localPosition
			end

			local var_90_14 = 0.001

			if var_90_13 <= arg_87_1.time_ and arg_87_1.time_ < var_90_13 + var_90_14 then
				local var_90_15 = (arg_87_1.time_ - var_90_13) / var_90_14
				local var_90_16 = Vector3.New(0.7, -0.95, -6.05)

				var_90_12.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10079ui_story, var_90_16, var_90_15)

				local var_90_17 = manager.ui.mainCamera.transform.position - var_90_12.position

				var_90_12.forward = Vector3.New(var_90_17.x, var_90_17.y, var_90_17.z)

				local var_90_18 = var_90_12.localEulerAngles

				var_90_18.z = 0
				var_90_18.x = 0
				var_90_12.localEulerAngles = var_90_18
			end

			if arg_87_1.time_ >= var_90_13 + var_90_14 and arg_87_1.time_ < var_90_13 + var_90_14 + arg_90_0 then
				var_90_12.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_90_19 = manager.ui.mainCamera.transform.position - var_90_12.position

				var_90_12.forward = Vector3.New(var_90_19.x, var_90_19.y, var_90_19.z)

				local var_90_20 = var_90_12.localEulerAngles

				var_90_20.z = 0
				var_90_20.x = 0
				var_90_12.localEulerAngles = var_90_20
			end

			local var_90_21 = 0
			local var_90_22 = 0.55

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_23 = arg_87_1:FormatText(StoryNameCfg[471].name)

				arg_87_1.leftNameTxt_.text = var_90_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_24 = arg_87_1:GetWordFromCfg(319361021)
				local var_90_25 = arg_87_1:FormatText(var_90_24.content)

				arg_87_1.text_.text = var_90_25

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_26 = 22
				local var_90_27 = utf8.len(var_90_25)
				local var_90_28 = var_90_26 <= 0 and var_90_22 or var_90_22 * (var_90_27 / var_90_26)

				if var_90_28 > 0 and var_90_22 < var_90_28 then
					arg_87_1.talkMaxDuration = var_90_28

					if var_90_28 + var_90_21 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_28 + var_90_21
					end
				end

				arg_87_1.text_.text = var_90_25
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361021", "story_v_out_319361.awb") ~= 0 then
					local var_90_29 = manager.audio:GetVoiceLength("story_v_out_319361", "319361021", "story_v_out_319361.awb") / 1000

					if var_90_29 + var_90_21 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_29 + var_90_21
					end

					if var_90_24.prefab_name ~= "" and arg_87_1.actors_[var_90_24.prefab_name] ~= nil then
						local var_90_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_24.prefab_name].transform, "story_v_out_319361", "319361021", "story_v_out_319361.awb")

						arg_87_1:RecordAudio("319361021", var_90_30)
						arg_87_1:RecordAudio("319361021", var_90_30)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319361", "319361021", "story_v_out_319361.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319361", "319361021", "story_v_out_319361.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_31 = math.max(var_90_22, arg_87_1.talkMaxDuration)

			if var_90_21 <= arg_87_1.time_ and arg_87_1.time_ < var_90_21 + var_90_31 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_21) / var_90_31

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_21 + var_90_31 and arg_87_1.time_ < var_90_21 + var_90_31 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play319361022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319361022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319361023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = "STblack"

			if arg_91_1.bgs_[var_94_0] == nil then
				local var_94_1 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_0)
				var_94_1.name = var_94_0
				var_94_1.transform.parent = arg_91_1.stage_.transform
				var_94_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_0] = var_94_1
			end

			local var_94_2 = 0

			if var_94_2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				local var_94_3 = manager.ui.mainCamera.transform.localPosition
				local var_94_4 = Vector3.New(0, 0, 10) + Vector3.New(var_94_3.x, var_94_3.y, 0)
				local var_94_5 = arg_91_1.bgs_.STblack

				var_94_5.transform.localPosition = var_94_4
				var_94_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_6 = var_94_5:GetComponent("SpriteRenderer")

				if var_94_6 and var_94_6.sprite then
					local var_94_7 = (var_94_5.transform.localPosition - var_94_3).z
					local var_94_8 = manager.ui.mainCameraCom_
					local var_94_9 = 2 * var_94_7 * Mathf.Tan(var_94_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_10 = var_94_9 * var_94_8.aspect
					local var_94_11 = var_94_6.sprite.bounds.size.x
					local var_94_12 = var_94_6.sprite.bounds.size.y
					local var_94_13 = var_94_10 / var_94_11
					local var_94_14 = var_94_9 / var_94_12
					local var_94_15 = var_94_14 < var_94_13 and var_94_13 or var_94_14

					var_94_5.transform.localScale = Vector3.New(var_94_15, var_94_15, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "STblack" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.cswbg_:SetActive(true)

				local var_94_17 = arg_91_1.cswt_:GetComponent("RectTransform")

				arg_91_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_17.offsetMin = Vector2.New(410, 330)
				var_94_17.offsetMax = Vector2.New(-400, -175)

				local var_94_18 = arg_91_1:GetWordFromCfg(419014)
				local var_94_19 = arg_91_1:FormatText(var_94_18.content)

				arg_91_1.cswt_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.cswt_)

				arg_91_1.cswt_.fontSize = 180
				arg_91_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_91_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_91_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_94_20 = 0

			if var_94_20 < arg_91_1.time_ and arg_91_1.time_ <= var_94_20 + arg_94_0 then
				arg_91_1.fswbg_:SetActive(true)
				arg_91_1.dialog_:SetActive(false)

				arg_91_1.fswtw_.percent = 0

				local var_94_21 = arg_91_1:GetWordFromCfg(319361022)
				local var_94_22 = arg_91_1:FormatText(var_94_21.content)

				arg_91_1.fswt_.text = var_94_22

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.fswt_)

				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_91_1.fswtw_:SetDirty()

				arg_91_1.typewritterCharCountI18N = 0

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_23 = 0.599999999999999

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.var_.oldValueTypewriter = arg_91_1.fswtw_.percent

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_24 = 21
			local var_94_25 = 1.4
			local var_94_26 = arg_91_1:GetWordFromCfg(319361022)
			local var_94_27 = arg_91_1:FormatText(var_94_26.content)
			local var_94_28, var_94_29 = arg_91_1:GetPercentByPara(var_94_27, 1)

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				local var_94_30 = var_94_24 <= 0 and var_94_25 or var_94_25 * ((var_94_29 - arg_91_1.typewritterCharCountI18N) / var_94_24)

				if var_94_30 > 0 and var_94_25 < var_94_30 then
					arg_91_1.talkMaxDuration = var_94_30

					if var_94_30 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_30 + var_94_23
					end
				end
			end

			local var_94_31 = 1.4
			local var_94_32 = math.max(var_94_31, arg_91_1.talkMaxDuration)

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_32 then
				local var_94_33 = (arg_91_1.time_ - var_94_23) / var_94_32

				arg_91_1.fswtw_.percent = Mathf.Lerp(arg_91_1.var_.oldValueTypewriter, var_94_28, var_94_33)
				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_91_1.fswtw_:SetDirty()
			end

			if arg_91_1.time_ >= var_94_23 + var_94_32 and arg_91_1.time_ < var_94_23 + var_94_32 + arg_94_0 then
				arg_91_1.fswtw_.percent = var_94_28

				arg_91_1.fswtw_:SetDirty()
				arg_91_1:ShowNextGo(true)

				arg_91_1.typewritterCharCountI18N = var_94_29
			end

			local var_94_34 = 0

			if var_94_34 < arg_91_1.time_ and arg_91_1.time_ <= var_94_34 + arg_94_0 then
				local var_94_35 = arg_91_1.fswbg_.transform:Find("textbox/adapt/content") or arg_91_1.fswbg_.transform:Find("textbox/content")
				local var_94_36 = arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_94_37 = var_94_35:GetComponent("Text")
				local var_94_38 = var_94_35:GetComponent("RectTransform")

				var_94_37.alignment = UnityEngine.TextAnchor.LowerCenter
				var_94_38.offsetMin = Vector2.New(0, 0)
				var_94_38.offsetMax = Vector2.New(0, 0)
			end

			local var_94_39 = arg_91_1.actors_["1095ui_story"].transform
			local var_94_40 = 0

			if var_94_40 < arg_91_1.time_ and arg_91_1.time_ <= var_94_40 + arg_94_0 then
				arg_91_1.var_.moveOldPos1095ui_story = var_94_39.localPosition
			end

			local var_94_41 = 0.001

			if var_94_40 <= arg_91_1.time_ and arg_91_1.time_ < var_94_40 + var_94_41 then
				local var_94_42 = (arg_91_1.time_ - var_94_40) / var_94_41
				local var_94_43 = Vector3.New(0, 100, 0)

				var_94_39.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1095ui_story, var_94_43, var_94_42)

				local var_94_44 = manager.ui.mainCamera.transform.position - var_94_39.position

				var_94_39.forward = Vector3.New(var_94_44.x, var_94_44.y, var_94_44.z)

				local var_94_45 = var_94_39.localEulerAngles

				var_94_45.z = 0
				var_94_45.x = 0
				var_94_39.localEulerAngles = var_94_45
			end

			if arg_91_1.time_ >= var_94_40 + var_94_41 and arg_91_1.time_ < var_94_40 + var_94_41 + arg_94_0 then
				var_94_39.localPosition = Vector3.New(0, 100, 0)

				local var_94_46 = manager.ui.mainCamera.transform.position - var_94_39.position

				var_94_39.forward = Vector3.New(var_94_46.x, var_94_46.y, var_94_46.z)

				local var_94_47 = var_94_39.localEulerAngles

				var_94_47.z = 0
				var_94_47.x = 0
				var_94_39.localEulerAngles = var_94_47
			end

			local var_94_48 = arg_91_1.actors_["10079ui_story"].transform
			local var_94_49 = 0

			if var_94_49 < arg_91_1.time_ and arg_91_1.time_ <= var_94_49 + arg_94_0 then
				arg_91_1.var_.moveOldPos10079ui_story = var_94_48.localPosition
			end

			local var_94_50 = 0.001

			if var_94_49 <= arg_91_1.time_ and arg_91_1.time_ < var_94_49 + var_94_50 then
				local var_94_51 = (arg_91_1.time_ - var_94_49) / var_94_50
				local var_94_52 = Vector3.New(0, 100, 0)

				var_94_48.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10079ui_story, var_94_52, var_94_51)

				local var_94_53 = manager.ui.mainCamera.transform.position - var_94_48.position

				var_94_48.forward = Vector3.New(var_94_53.x, var_94_53.y, var_94_53.z)

				local var_94_54 = var_94_48.localEulerAngles

				var_94_54.z = 0
				var_94_54.x = 0
				var_94_48.localEulerAngles = var_94_54
			end

			if arg_91_1.time_ >= var_94_49 + var_94_50 and arg_91_1.time_ < var_94_49 + var_94_50 + arg_94_0 then
				var_94_48.localPosition = Vector3.New(0, 100, 0)

				local var_94_55 = manager.ui.mainCamera.transform.position - var_94_48.position

				var_94_48.forward = Vector3.New(var_94_55.x, var_94_55.y, var_94_55.z)

				local var_94_56 = var_94_48.localEulerAngles

				var_94_56.z = 0
				var_94_56.x = 0
				var_94_48.localEulerAngles = var_94_56
			end

			local var_94_57 = 0.599999999999999
			local var_94_58 = 4.4
			local var_94_59 = manager.audio:GetVoiceLength("story_v_out_319361", "319361022", "story_v_out_319361.awb") / 1000

			if var_94_59 > 0 and var_94_58 < var_94_59 and var_94_59 + var_94_57 > arg_91_1.duration_ then
				local var_94_60 = var_94_59

				arg_91_1.duration_ = var_94_59 + var_94_57
			end

			if var_94_57 < arg_91_1.time_ and arg_91_1.time_ <= var_94_57 + arg_94_0 then
				local var_94_61 = "play"
				local var_94_62 = "voice"

				arg_91_1:AudioAction(var_94_61, var_94_62, "story_v_out_319361", "319361022", "story_v_out_319361.awb")
			end
		end

		arg_91_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play319361023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319361023
		arg_95_1.duration_ = 8.9

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319361024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(true)
				arg_95_1.dialog_:SetActive(false)

				arg_95_1.fswtw_.percent = 0

				local var_98_1 = arg_95_1:GetWordFromCfg(319361023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.fswt_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.fswt_)

				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_95_1.fswtw_:SetDirty()

				arg_95_1.typewritterCharCountI18N = 0

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_3 = 0.1

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_4 = 41
			local var_98_5 = 2.73333333333333
			local var_98_6 = arg_95_1:GetWordFromCfg(319361023)
			local var_98_7 = arg_95_1:FormatText(var_98_6.content)
			local var_98_8, var_98_9 = arg_95_1:GetPercentByPara(var_98_7, 1)

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_10 = var_98_4 <= 0 and var_98_5 or var_98_5 * ((var_98_9 - arg_95_1.typewritterCharCountI18N) / var_98_4)

				if var_98_10 > 0 and var_98_5 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_3
					end
				end
			end

			local var_98_11 = 2.73333333333333
			local var_98_12 = math.max(var_98_11, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_12 then
				local var_98_13 = (arg_95_1.time_ - var_98_3) / var_98_12

				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_8, var_98_13)
				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_12 and arg_95_1.time_ < var_98_3 + var_98_12 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_8

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_9
			end

			local var_98_14 = 0.1
			local var_98_15 = 8.8
			local var_98_16 = manager.audio:GetVoiceLength("story_v_out_319361", "319361023", "story_v_out_319361.awb") / 1000

			if var_98_16 > 0 and var_98_15 < var_98_16 and var_98_16 + var_98_14 > arg_95_1.duration_ then
				local var_98_17 = var_98_16

				arg_95_1.duration_ = var_98_16 + var_98_14
			end

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				local var_98_18 = "play"
				local var_98_19 = "voice"

				arg_95_1:AudioAction(var_98_18, var_98_19, "story_v_out_319361", "319361023", "story_v_out_319361.awb")
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play319361024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319361024
		arg_99_1.duration_ = 4.33

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319361025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(true)
				arg_99_1.dialog_:SetActive(false)

				arg_99_1.fswtw_.percent = 0

				local var_102_1 = arg_99_1:GetWordFromCfg(319361024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.fswt_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.fswt_)

				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_99_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_99_1.fswtw_:SetDirty()

				arg_99_1.typewritterCharCountI18N = 0

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_3 = 0.1

			if var_102_3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_4 = 14
			local var_102_5 = 0.933333333333333
			local var_102_6 = arg_99_1:GetWordFromCfg(319361024)
			local var_102_7 = arg_99_1:FormatText(var_102_6.content)
			local var_102_8, var_102_9 = arg_99_1:GetPercentByPara(var_102_7, 1)

			if var_102_3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_10 = var_102_4 <= 0 and var_102_5 or var_102_5 * ((var_102_9 - arg_99_1.typewritterCharCountI18N) / var_102_4)

				if var_102_10 > 0 and var_102_5 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_3
					end
				end
			end

			local var_102_11 = 0.933333333333333
			local var_102_12 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_12 then
				local var_102_13 = (arg_99_1.time_ - var_102_3) / var_102_12

				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_8, var_102_13)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_12 and arg_99_1.time_ < var_102_3 + var_102_12 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_8

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_9
			end

			local var_102_14 = 0.1
			local var_102_15 = 4.233
			local var_102_16 = manager.audio:GetVoiceLength("story_v_out_319361", "319361024", "story_v_out_319361.awb") / 1000

			if var_102_16 > 0 and var_102_15 < var_102_16 and var_102_16 + var_102_14 > arg_99_1.duration_ then
				local var_102_17 = var_102_16

				arg_99_1.duration_ = var_102_16 + var_102_14
			end

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				local var_102_18 = "play"
				local var_102_19 = "voice"

				arg_99_1:AudioAction(var_102_18, var_102_19, "story_v_out_319361", "319361024", "story_v_out_319361.awb")
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play319361025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319361025
		arg_103_1.duration_ = 6.37

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319361026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				local var_106_1 = manager.ui.mainCamera.transform.localPosition
				local var_106_2 = Vector3.New(0, 0, 10) + Vector3.New(var_106_1.x, var_106_1.y, 0)
				local var_106_3 = arg_103_1.bgs_.I11q

				var_106_3.transform.localPosition = var_106_2
				var_106_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_4 = var_106_3:GetComponent("SpriteRenderer")

				if var_106_4 and var_106_4.sprite then
					local var_106_5 = (var_106_3.transform.localPosition - var_106_1).z
					local var_106_6 = manager.ui.mainCameraCom_
					local var_106_7 = 2 * var_106_5 * Mathf.Tan(var_106_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_106_8 = var_106_7 * var_106_6.aspect
					local var_106_9 = var_106_4.sprite.bounds.size.x
					local var_106_10 = var_106_4.sprite.bounds.size.y
					local var_106_11 = var_106_8 / var_106_9
					local var_106_12 = var_106_7 / var_106_10
					local var_106_13 = var_106_12 < var_106_11 and var_106_11 or var_106_12

					var_106_3.transform.localScale = Vector3.New(var_106_13, var_106_13, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "I11q" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_15 = 2

			if var_106_14 <= arg_103_1.time_ and arg_103_1.time_ < var_106_14 + var_106_15 then
				local var_106_16 = (arg_103_1.time_ - var_106_14) / var_106_15
				local var_106_17 = Color.New(0, 0, 0)

				var_106_17.a = Mathf.Lerp(1, 0, var_106_16)
				arg_103_1.mask_.color = var_106_17
			end

			if arg_103_1.time_ >= var_106_14 + var_106_15 and arg_103_1.time_ < var_106_14 + var_106_15 + arg_106_0 then
				local var_106_18 = Color.New(0, 0, 0)
				local var_106_19 = 0

				arg_103_1.mask_.enabled = false
				var_106_18.a = var_106_19
				arg_103_1.mask_.color = var_106_18
			end

			local var_106_20 = 0

			if var_106_20 < arg_103_1.time_ and arg_103_1.time_ <= var_106_20 + arg_106_0 then
				arg_103_1.fswbg_:SetActive(false)
				arg_103_1.dialog_:SetActive(false)
				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_21 = 0.533333333333334

			if var_106_21 < arg_103_1.time_ and arg_103_1.time_ <= var_106_21 + arg_106_0 then
				arg_103_1.fswbg_:SetActive(false)
				arg_103_1.dialog_:SetActive(false)
				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_22 = 0

			if var_106_22 < arg_103_1.time_ and arg_103_1.time_ <= var_106_22 + arg_106_0 then
				arg_103_1.cswbg_:SetActive(false)
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_23 = 1.36666666666667
			local var_106_24 = 1.075

			if var_106_23 < arg_103_1.time_ and arg_103_1.time_ <= var_106_23 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_25 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_25:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_26 = arg_103_1:GetWordFromCfg(319361025)
				local var_106_27 = arg_103_1:FormatText(var_106_26.content)

				arg_103_1.text_.text = var_106_27

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_28 = 43
				local var_106_29 = utf8.len(var_106_27)
				local var_106_30 = var_106_28 <= 0 and var_106_24 or var_106_24 * (var_106_29 / var_106_28)

				if var_106_30 > 0 and var_106_24 < var_106_30 then
					arg_103_1.talkMaxDuration = var_106_30
					var_106_23 = var_106_23 + 0.3

					if var_106_30 + var_106_23 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_30 + var_106_23
					end
				end

				arg_103_1.text_.text = var_106_27
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_31 = var_106_23 + 0.3
			local var_106_32 = math.max(var_106_24, arg_103_1.talkMaxDuration)

			if var_106_31 <= arg_103_1.time_ and arg_103_1.time_ < var_106_31 + var_106_32 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_31) / var_106_32

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_31 + var_106_32 and arg_103_1.time_ < var_106_31 + var_106_32 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319361026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319361026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play319361027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.725

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

				local var_112_2 = arg_109_1:GetWordFromCfg(319361026)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 29
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
	Play319361027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319361027
		arg_113_1.duration_ = 13.2

		local var_113_0 = {
			zh = 13.2,
			ja = 9.066
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
				arg_113_0:Play319361028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10079ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10079ui_story = var_116_0.localPosition

				local var_116_2 = "10079ui_story"

				arg_113_1:ShowWeapon(arg_113_1.var_[var_116_2 .. "Animator"].transform, false)
			end

			local var_116_3 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3
				local var_116_5 = Vector3.New(0, -0.95, -6.05)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10079ui_story, var_116_5, var_116_4)

				local var_116_6 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_6.x, var_116_6.y, var_116_6.z)

				local var_116_7 = var_116_0.localEulerAngles

				var_116_7.z = 0
				var_116_7.x = 0
				var_116_0.localEulerAngles = var_116_7
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_116_8 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_8.x, var_116_8.y, var_116_8.z)

				local var_116_9 = var_116_0.localEulerAngles

				var_116_9.z = 0
				var_116_9.x = 0
				var_116_0.localEulerAngles = var_116_9
			end

			local var_116_10 = arg_113_1.actors_["10079ui_story"]
			local var_116_11 = 0

			if var_116_11 < arg_113_1.time_ and arg_113_1.time_ <= var_116_11 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect10079ui_story == nil then
				arg_113_1.var_.characterEffect10079ui_story = var_116_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_12 = 0.200000002980232

			if var_116_11 <= arg_113_1.time_ and arg_113_1.time_ < var_116_11 + var_116_12 and not isNil(var_116_10) then
				local var_116_13 = (arg_113_1.time_ - var_116_11) / var_116_12

				if arg_113_1.var_.characterEffect10079ui_story and not isNil(var_116_10) then
					arg_113_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_11 + var_116_12 and arg_113_1.time_ < var_116_11 + var_116_12 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect10079ui_story then
				arg_113_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_116_15 = 0

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_116_16 = 0
			local var_116_17 = 1.25

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_18 = arg_113_1:FormatText(StoryNameCfg[6].name)

				arg_113_1.leftNameTxt_.text = var_116_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_19 = arg_113_1:GetWordFromCfg(319361027)
				local var_116_20 = arg_113_1:FormatText(var_116_19.content)

				arg_113_1.text_.text = var_116_20

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_21 = 50
				local var_116_22 = utf8.len(var_116_20)
				local var_116_23 = var_116_21 <= 0 and var_116_17 or var_116_17 * (var_116_22 / var_116_21)

				if var_116_23 > 0 and var_116_17 < var_116_23 then
					arg_113_1.talkMaxDuration = var_116_23

					if var_116_23 + var_116_16 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_16
					end
				end

				arg_113_1.text_.text = var_116_20
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361027", "story_v_out_319361.awb") ~= 0 then
					local var_116_24 = manager.audio:GetVoiceLength("story_v_out_319361", "319361027", "story_v_out_319361.awb") / 1000

					if var_116_24 + var_116_16 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_24 + var_116_16
					end

					if var_116_19.prefab_name ~= "" and arg_113_1.actors_[var_116_19.prefab_name] ~= nil then
						local var_116_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_19.prefab_name].transform, "story_v_out_319361", "319361027", "story_v_out_319361.awb")

						arg_113_1:RecordAudio("319361027", var_116_25)
						arg_113_1:RecordAudio("319361027", var_116_25)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319361", "319361027", "story_v_out_319361.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319361", "319361027", "story_v_out_319361.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_26 = math.max(var_116_17, arg_113_1.talkMaxDuration)

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_26 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_16) / var_116_26

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_16 + var_116_26 and arg_113_1.time_ < var_116_16 + var_116_26 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319361028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319361028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319361029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10079ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10079ui_story == nil then
				arg_117_1.var_.characterEffect10079ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect10079ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10079ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10079ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10079ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_120_7 = 0

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_120_8 = 0
			local var_120_9 = 1.35

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(319361028)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_12 = 54
				local var_120_13 = utf8.len(var_120_11)
				local var_120_14 = var_120_12 <= 0 and var_120_9 or var_120_9 * (var_120_13 / var_120_12)

				if var_120_14 > 0 and var_120_9 < var_120_14 then
					arg_117_1.talkMaxDuration = var_120_14

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_15 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_15 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_15

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_15 and arg_117_1.time_ < var_120_8 + var_120_15 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319361029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319361029
		arg_121_1.duration_ = 3.8

		local var_121_0 = {
			zh = 3.8,
			ja = 3.2
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
				arg_121_0:Play319361030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1095ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1095ui_story == nil then
				arg_121_1.var_.characterEffect1095ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1095ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1095ui_story then
				arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1095ui_story"].transform
			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.var_.moveOldPos1095ui_story = var_124_4.localPosition
			end

			local var_124_6 = 0.001

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_6 then
				local var_124_7 = (arg_121_1.time_ - var_124_5) / var_124_6
				local var_124_8 = Vector3.New(-0.7, -0.98, -6.1)

				var_124_4.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1095ui_story, var_124_8, var_124_7)

				local var_124_9 = manager.ui.mainCamera.transform.position - var_124_4.position

				var_124_4.forward = Vector3.New(var_124_9.x, var_124_9.y, var_124_9.z)

				local var_124_10 = var_124_4.localEulerAngles

				var_124_10.z = 0
				var_124_10.x = 0
				var_124_4.localEulerAngles = var_124_10
			end

			if arg_121_1.time_ >= var_124_5 + var_124_6 and arg_121_1.time_ < var_124_5 + var_124_6 + arg_124_0 then
				var_124_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_124_11 = manager.ui.mainCamera.transform.position - var_124_4.position

				var_124_4.forward = Vector3.New(var_124_11.x, var_124_11.y, var_124_11.z)

				local var_124_12 = var_124_4.localEulerAngles

				var_124_12.z = 0
				var_124_12.x = 0
				var_124_4.localEulerAngles = var_124_12
			end

			local var_124_13 = arg_121_1.actors_["10079ui_story"].transform
			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1.var_.moveOldPos10079ui_story = var_124_13.localPosition

				local var_124_15 = "10079ui_story"

				arg_121_1:ShowWeapon(arg_121_1.var_[var_124_15 .. "Animator"].transform, false)
			end

			local var_124_16 = 0.001

			if var_124_14 <= arg_121_1.time_ and arg_121_1.time_ < var_124_14 + var_124_16 then
				local var_124_17 = (arg_121_1.time_ - var_124_14) / var_124_16
				local var_124_18 = Vector3.New(0.7, -0.95, -6.05)

				var_124_13.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10079ui_story, var_124_18, var_124_17)

				local var_124_19 = manager.ui.mainCamera.transform.position - var_124_13.position

				var_124_13.forward = Vector3.New(var_124_19.x, var_124_19.y, var_124_19.z)

				local var_124_20 = var_124_13.localEulerAngles

				var_124_20.z = 0
				var_124_20.x = 0
				var_124_13.localEulerAngles = var_124_20
			end

			if arg_121_1.time_ >= var_124_14 + var_124_16 and arg_121_1.time_ < var_124_14 + var_124_16 + arg_124_0 then
				var_124_13.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_124_21 = manager.ui.mainCamera.transform.position - var_124_13.position

				var_124_13.forward = Vector3.New(var_124_21.x, var_124_21.y, var_124_21.z)

				local var_124_22 = var_124_13.localEulerAngles

				var_124_22.z = 0
				var_124_22.x = 0
				var_124_13.localEulerAngles = var_124_22
			end

			local var_124_23 = arg_121_1.actors_["10079ui_story"]
			local var_124_24 = 0

			if var_124_24 < arg_121_1.time_ and arg_121_1.time_ <= var_124_24 + arg_124_0 and not isNil(var_124_23) and arg_121_1.var_.characterEffect10079ui_story == nil then
				arg_121_1.var_.characterEffect10079ui_story = var_124_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_25 = 0.200000002980232

			if var_124_24 <= arg_121_1.time_ and arg_121_1.time_ < var_124_24 + var_124_25 and not isNil(var_124_23) then
				local var_124_26 = (arg_121_1.time_ - var_124_24) / var_124_25

				if arg_121_1.var_.characterEffect10079ui_story and not isNil(var_124_23) then
					local var_124_27 = Mathf.Lerp(0, 0.5, var_124_26)

					arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10079ui_story.fillRatio = var_124_27
				end
			end

			if arg_121_1.time_ >= var_124_24 + var_124_25 and arg_121_1.time_ < var_124_24 + var_124_25 + arg_124_0 and not isNil(var_124_23) and arg_121_1.var_.characterEffect10079ui_story then
				local var_124_28 = 0.5

				arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10079ui_story.fillRatio = var_124_28
			end

			local var_124_29 = 0
			local var_124_30 = 0.5

			if var_124_29 < arg_121_1.time_ and arg_121_1.time_ <= var_124_29 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_31 = arg_121_1:FormatText(StoryNameCfg[471].name)

				arg_121_1.leftNameTxt_.text = var_124_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_32 = arg_121_1:GetWordFromCfg(319361029)
				local var_124_33 = arg_121_1:FormatText(var_124_32.content)

				arg_121_1.text_.text = var_124_33

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_34 = 20
				local var_124_35 = utf8.len(var_124_33)
				local var_124_36 = var_124_34 <= 0 and var_124_30 or var_124_30 * (var_124_35 / var_124_34)

				if var_124_36 > 0 and var_124_30 < var_124_36 then
					arg_121_1.talkMaxDuration = var_124_36

					if var_124_36 + var_124_29 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_36 + var_124_29
					end
				end

				arg_121_1.text_.text = var_124_33
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361029", "story_v_out_319361.awb") ~= 0 then
					local var_124_37 = manager.audio:GetVoiceLength("story_v_out_319361", "319361029", "story_v_out_319361.awb") / 1000

					if var_124_37 + var_124_29 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_29
					end

					if var_124_32.prefab_name ~= "" and arg_121_1.actors_[var_124_32.prefab_name] ~= nil then
						local var_124_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_32.prefab_name].transform, "story_v_out_319361", "319361029", "story_v_out_319361.awb")

						arg_121_1:RecordAudio("319361029", var_124_38)
						arg_121_1:RecordAudio("319361029", var_124_38)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319361", "319361029", "story_v_out_319361.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319361", "319361029", "story_v_out_319361.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_39 = math.max(var_124_30, arg_121_1.talkMaxDuration)

			if var_124_29 <= arg_121_1.time_ and arg_121_1.time_ < var_124_29 + var_124_39 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_29) / var_124_39

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_29 + var_124_39 and arg_121_1.time_ < var_124_29 + var_124_39 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
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
	Play319361030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319361030
		arg_125_1.duration_ = 4.9

		local var_125_0 = {
			zh = 2.833,
			ja = 4.9
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
				arg_125_0:Play319361031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10079ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10079ui_story == nil then
				arg_125_1.var_.characterEffect10079ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect10079ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10079ui_story then
				arg_125_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1095ui_story"]
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1095ui_story == nil then
				arg_125_1.var_.characterEffect1095ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 and not isNil(var_128_4) then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6

				if arg_125_1.var_.characterEffect1095ui_story and not isNil(var_128_4) then
					local var_128_8 = Mathf.Lerp(0, 0.5, var_128_7)

					arg_125_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1095ui_story.fillRatio = var_128_8
				end
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1095ui_story then
				local var_128_9 = 0.5

				arg_125_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1095ui_story.fillRatio = var_128_9
			end

			local var_128_10 = 0
			local var_128_11 = 0.25

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_12 = arg_125_1:FormatText(StoryNameCfg[6].name)

				arg_125_1.leftNameTxt_.text = var_128_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_13 = arg_125_1:GetWordFromCfg(319361030)
				local var_128_14 = arg_125_1:FormatText(var_128_13.content)

				arg_125_1.text_.text = var_128_14

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 10
				local var_128_16 = utf8.len(var_128_14)
				local var_128_17 = var_128_15 <= 0 and var_128_11 or var_128_11 * (var_128_16 / var_128_15)

				if var_128_17 > 0 and var_128_11 < var_128_17 then
					arg_125_1.talkMaxDuration = var_128_17

					if var_128_17 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_10
					end
				end

				arg_125_1.text_.text = var_128_14
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361030", "story_v_out_319361.awb") ~= 0 then
					local var_128_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361030", "story_v_out_319361.awb") / 1000

					if var_128_18 + var_128_10 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_10
					end

					if var_128_13.prefab_name ~= "" and arg_125_1.actors_[var_128_13.prefab_name] ~= nil then
						local var_128_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_13.prefab_name].transform, "story_v_out_319361", "319361030", "story_v_out_319361.awb")

						arg_125_1:RecordAudio("319361030", var_128_19)
						arg_125_1:RecordAudio("319361030", var_128_19)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319361", "319361030", "story_v_out_319361.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319361", "319361030", "story_v_out_319361.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_20 = math.max(var_128_11, arg_125_1.talkMaxDuration)

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_20 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_10) / var_128_20

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_10 + var_128_20 and arg_125_1.time_ < var_128_10 + var_128_20 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319361031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319361031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319361032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10079ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10079ui_story == nil then
				arg_129_1.var_.characterEffect10079ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10079ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10079ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10079ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10079ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.95

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(319361031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 38
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_7 or var_132_7 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_7 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_13 and arg_129_1.time_ < var_132_6 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319361032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319361032
		arg_133_1.duration_ = 9.9

		local var_133_0 = {
			zh = 9.9,
			ja = 9.6
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
				arg_133_0:Play319361033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10079ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10079ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0.7, -0.95, -6.05)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10079ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["10079ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect10079ui_story == nil then
				arg_133_1.var_.characterEffect10079ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect10079ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect10079ui_story then
				arg_133_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_136_13 = 0

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_14 = 0
			local var_136_15 = 1.125

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_16 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_17 = arg_133_1:GetWordFromCfg(319361032)
				local var_136_18 = arg_133_1:FormatText(var_136_17.content)

				arg_133_1.text_.text = var_136_18

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_19 = 45
				local var_136_20 = utf8.len(var_136_18)
				local var_136_21 = var_136_19 <= 0 and var_136_15 or var_136_15 * (var_136_20 / var_136_19)

				if var_136_21 > 0 and var_136_15 < var_136_21 then
					arg_133_1.talkMaxDuration = var_136_21

					if var_136_21 + var_136_14 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_21 + var_136_14
					end
				end

				arg_133_1.text_.text = var_136_18
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361032", "story_v_out_319361.awb") ~= 0 then
					local var_136_22 = manager.audio:GetVoiceLength("story_v_out_319361", "319361032", "story_v_out_319361.awb") / 1000

					if var_136_22 + var_136_14 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_14
					end

					if var_136_17.prefab_name ~= "" and arg_133_1.actors_[var_136_17.prefab_name] ~= nil then
						local var_136_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_17.prefab_name].transform, "story_v_out_319361", "319361032", "story_v_out_319361.awb")

						arg_133_1:RecordAudio("319361032", var_136_23)
						arg_133_1:RecordAudio("319361032", var_136_23)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319361", "319361032", "story_v_out_319361.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319361", "319361032", "story_v_out_319361.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_24 = math.max(var_136_15, arg_133_1.talkMaxDuration)

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_24 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_14) / var_136_24

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_14 + var_136_24 and arg_133_1.time_ < var_136_14 + var_136_24 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play319361033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319361033
		arg_137_1.duration_ = 8.6

		local var_137_0 = {
			zh = 6.466,
			ja = 8.6
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
				arg_137_0:Play319361034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10079ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10079ui_story == nil then
				arg_137_1.var_.characterEffect10079ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect10079ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10079ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10079ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10079ui_story.fillRatio = var_140_5
			end

			local var_140_6 = arg_137_1.actors_["1095ui_story"]
			local var_140_7 = 0

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1095ui_story == nil then
				arg_137_1.var_.characterEffect1095ui_story = var_140_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_8 = 0.200000002980232

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_8 and not isNil(var_140_6) then
				local var_140_9 = (arg_137_1.time_ - var_140_7) / var_140_8

				if arg_137_1.var_.characterEffect1095ui_story and not isNil(var_140_6) then
					arg_137_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_7 + var_140_8 and arg_137_1.time_ < var_140_7 + var_140_8 + arg_140_0 and not isNil(var_140_6) and arg_137_1.var_.characterEffect1095ui_story then
				arg_137_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_140_11 = 0

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_12 = 0
			local var_140_13 = 0.675

			if var_140_12 < arg_137_1.time_ and arg_137_1.time_ <= var_140_12 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_14 = arg_137_1:FormatText(StoryNameCfg[471].name)

				arg_137_1.leftNameTxt_.text = var_140_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_15 = arg_137_1:GetWordFromCfg(319361033)
				local var_140_16 = arg_137_1:FormatText(var_140_15.content)

				arg_137_1.text_.text = var_140_16

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_17 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361033", "story_v_out_319361.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_319361", "319361033", "story_v_out_319361.awb") / 1000

					if var_140_20 + var_140_12 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_12
					end

					if var_140_15.prefab_name ~= "" and arg_137_1.actors_[var_140_15.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_15.prefab_name].transform, "story_v_out_319361", "319361033", "story_v_out_319361.awb")

						arg_137_1:RecordAudio("319361033", var_140_21)
						arg_137_1:RecordAudio("319361033", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319361", "319361033", "story_v_out_319361.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319361", "319361033", "story_v_out_319361.awb")
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
	Play319361034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319361034
		arg_141_1.duration_ = 5.1

		local var_141_0 = {
			zh = 4.366,
			ja = 5.1
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
				arg_141_0:Play319361035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10079ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story == nil then
				arg_141_1.var_.characterEffect10079ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10079ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story then
				arg_141_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["1095ui_story"]
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1095ui_story == nil then
				arg_141_1.var_.characterEffect1095ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 and not isNil(var_144_4) then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6

				if arg_141_1.var_.characterEffect1095ui_story and not isNil(var_144_4) then
					local var_144_8 = Mathf.Lerp(0, 0.5, var_144_7)

					arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1095ui_story.fillRatio = var_144_8
				end
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1095ui_story then
				local var_144_9 = 0.5

				arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1095ui_story.fillRatio = var_144_9
			end

			local var_144_10 = 0
			local var_144_11 = 0.55

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_12 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(319361034)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 22
				local var_144_16 = utf8.len(var_144_14)
				local var_144_17 = var_144_15 <= 0 and var_144_11 or var_144_11 * (var_144_16 / var_144_15)

				if var_144_17 > 0 and var_144_11 < var_144_17 then
					arg_141_1.talkMaxDuration = var_144_17

					if var_144_17 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361034", "story_v_out_319361.awb") ~= 0 then
					local var_144_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361034", "story_v_out_319361.awb") / 1000

					if var_144_18 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_10
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_319361", "319361034", "story_v_out_319361.awb")

						arg_141_1:RecordAudio("319361034", var_144_19)
						arg_141_1:RecordAudio("319361034", var_144_19)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319361", "319361034", "story_v_out_319361.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319361", "319361034", "story_v_out_319361.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_20 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_20 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_20

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_20 and arg_141_1.time_ < var_144_10 + var_144_20 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319361035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319361035
		arg_145_1.duration_ = 5.1

		local var_145_0 = {
			zh = 3.233,
			ja = 5.1
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
				arg_145_0:Play319361036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10079ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10079ui_story == nil then
				arg_145_1.var_.characterEffect10079ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect10079ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10079ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10079ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10079ui_story.fillRatio = var_148_5
			end

			local var_148_6 = arg_145_1.actors_["1095ui_story"]
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.200000002980232

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 and not isNil(var_148_6) then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8

				if arg_145_1.var_.characterEffect1095ui_story and not isNil(var_148_6) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_148_11 = 0

			if var_148_11 < arg_145_1.time_ and arg_145_1.time_ <= var_148_11 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_12 = 0
			local var_148_13 = 0.275

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_14 = arg_145_1:FormatText(StoryNameCfg[471].name)

				arg_145_1.leftNameTxt_.text = var_148_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:GetWordFromCfg(319361035)
				local var_148_16 = arg_145_1:FormatText(var_148_15.content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361035", "story_v_out_319361.awb") ~= 0 then
					local var_148_20 = manager.audio:GetVoiceLength("story_v_out_319361", "319361035", "story_v_out_319361.awb") / 1000

					if var_148_20 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_12
					end

					if var_148_15.prefab_name ~= "" and arg_145_1.actors_[var_148_15.prefab_name] ~= nil then
						local var_148_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_15.prefab_name].transform, "story_v_out_319361", "319361035", "story_v_out_319361.awb")

						arg_145_1:RecordAudio("319361035", var_148_21)
						arg_145_1:RecordAudio("319361035", var_148_21)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319361", "319361035", "story_v_out_319361.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319361", "319361035", "story_v_out_319361.awb")
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
	Play319361036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319361036
		arg_149_1.duration_ = 9.3

		local var_149_0 = {
			zh = 6,
			ja = 9.3
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
				arg_149_0:Play319361037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10079ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10079ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0.7, -0.95, -6.05)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10079ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["10079ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect10079ui_story == nil then
				arg_149_1.var_.characterEffect10079ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect10079ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect10079ui_story then
				arg_149_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_152_15 = arg_149_1.actors_["1095ui_story"]
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.characterEffect1095ui_story == nil then
				arg_149_1.var_.characterEffect1095ui_story = var_152_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_17 = 0.200000002980232

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 and not isNil(var_152_15) then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17

				if arg_149_1.var_.characterEffect1095ui_story and not isNil(var_152_15) then
					local var_152_19 = Mathf.Lerp(0, 0.5, var_152_18)

					arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1095ui_story.fillRatio = var_152_19
				end
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.characterEffect1095ui_story then
				local var_152_20 = 0.5

				arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1095ui_story.fillRatio = var_152_20
			end

			local var_152_21 = 0
			local var_152_22 = 0.625

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_23 = arg_149_1:FormatText(StoryNameCfg[6].name)

				arg_149_1.leftNameTxt_.text = var_152_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_24 = arg_149_1:GetWordFromCfg(319361036)
				local var_152_25 = arg_149_1:FormatText(var_152_24.content)

				arg_149_1.text_.text = var_152_25

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_26 = 25
				local var_152_27 = utf8.len(var_152_25)
				local var_152_28 = var_152_26 <= 0 and var_152_22 or var_152_22 * (var_152_27 / var_152_26)

				if var_152_28 > 0 and var_152_22 < var_152_28 then
					arg_149_1.talkMaxDuration = var_152_28

					if var_152_28 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_28 + var_152_21
					end
				end

				arg_149_1.text_.text = var_152_25
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361036", "story_v_out_319361.awb") ~= 0 then
					local var_152_29 = manager.audio:GetVoiceLength("story_v_out_319361", "319361036", "story_v_out_319361.awb") / 1000

					if var_152_29 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_29 + var_152_21
					end

					if var_152_24.prefab_name ~= "" and arg_149_1.actors_[var_152_24.prefab_name] ~= nil then
						local var_152_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_24.prefab_name].transform, "story_v_out_319361", "319361036", "story_v_out_319361.awb")

						arg_149_1:RecordAudio("319361036", var_152_30)
						arg_149_1:RecordAudio("319361036", var_152_30)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319361", "319361036", "story_v_out_319361.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319361", "319361036", "story_v_out_319361.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_31 = math.max(var_152_22, arg_149_1.talkMaxDuration)

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_31 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_21) / var_152_31

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_21 + var_152_31 and arg_149_1.time_ < var_152_21 + var_152_31 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319361037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319361037
		arg_153_1.duration_ = 16.4

		local var_153_0 = {
			zh = 9.633,
			ja = 16.4
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
				arg_153_0:Play319361038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.2

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[6].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(319361037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361037", "story_v_out_319361.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361037", "story_v_out_319361.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_319361", "319361037", "story_v_out_319361.awb")

						arg_153_1:RecordAudio("319361037", var_156_9)
						arg_153_1:RecordAudio("319361037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_319361", "319361037", "story_v_out_319361.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_319361", "319361037", "story_v_out_319361.awb")
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
	Play319361038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319361038
		arg_157_1.duration_ = 17.4

		local var_157_0 = {
			zh = 9.6,
			ja = 17.4
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
				arg_157_0:Play319361039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1.3

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[6].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(319361038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 52
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361038", "story_v_out_319361.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361038", "story_v_out_319361.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_319361", "319361038", "story_v_out_319361.awb")

						arg_157_1:RecordAudio("319361038", var_160_9)
						arg_157_1:RecordAudio("319361038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_319361", "319361038", "story_v_out_319361.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_319361", "319361038", "story_v_out_319361.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319361039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319361039
		arg_161_1.duration_ = 15.27

		local var_161_0 = {
			zh = 12.633,
			ja = 15.266
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
				arg_161_0:Play319361040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1.525

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[6].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(319361039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 61
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361039", "story_v_out_319361.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361039", "story_v_out_319361.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_319361", "319361039", "story_v_out_319361.awb")

						arg_161_1:RecordAudio("319361039", var_164_9)
						arg_161_1:RecordAudio("319361039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319361", "319361039", "story_v_out_319361.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319361", "319361039", "story_v_out_319361.awb")
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
	Play319361040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319361040
		arg_165_1.duration_ = 9.93

		local var_165_0 = {
			zh = 3.166,
			ja = 9.933
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
				arg_165_0:Play319361041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_168_1 = 0
			local var_168_2 = 0.45

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_3 = arg_165_1:FormatText(StoryNameCfg[6].name)

				arg_165_1.leftNameTxt_.text = var_168_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(319361040)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 18
				local var_168_7 = utf8.len(var_168_5)
				local var_168_8 = var_168_6 <= 0 and var_168_2 or var_168_2 * (var_168_7 / var_168_6)

				if var_168_8 > 0 and var_168_2 < var_168_8 then
					arg_165_1.talkMaxDuration = var_168_8

					if var_168_8 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361040", "story_v_out_319361.awb") ~= 0 then
					local var_168_9 = manager.audio:GetVoiceLength("story_v_out_319361", "319361040", "story_v_out_319361.awb") / 1000

					if var_168_9 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_1
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_out_319361", "319361040", "story_v_out_319361.awb")

						arg_165_1:RecordAudio("319361040", var_168_10)
						arg_165_1:RecordAudio("319361040", var_168_10)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319361", "319361040", "story_v_out_319361.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319361", "319361040", "story_v_out_319361.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_11 and arg_165_1.time_ < var_168_1 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319361041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319361041
		arg_169_1.duration_ = 8.4

		local var_169_0 = {
			zh = 5.7,
			ja = 8.4
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
				arg_169_0:Play319361042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1095ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1095ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1095ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1095ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1095ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1095ui_story then
				arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_172_13 = arg_169_1.actors_["10079ui_story"]
			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 and not isNil(var_172_13) and arg_169_1.var_.characterEffect10079ui_story == nil then
				arg_169_1.var_.characterEffect10079ui_story = var_172_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_15 = 0.200000002980232

			if var_172_14 <= arg_169_1.time_ and arg_169_1.time_ < var_172_14 + var_172_15 and not isNil(var_172_13) then
				local var_172_16 = (arg_169_1.time_ - var_172_14) / var_172_15

				if arg_169_1.var_.characterEffect10079ui_story and not isNil(var_172_13) then
					local var_172_17 = Mathf.Lerp(0, 0.5, var_172_16)

					arg_169_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10079ui_story.fillRatio = var_172_17
				end
			end

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 and not isNil(var_172_13) and arg_169_1.var_.characterEffect10079ui_story then
				local var_172_18 = 0.5

				arg_169_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10079ui_story.fillRatio = var_172_18
			end

			local var_172_19 = 0
			local var_172_20 = 0.625

			if var_172_19 < arg_169_1.time_ and arg_169_1.time_ <= var_172_19 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_21 = arg_169_1:FormatText(StoryNameCfg[471].name)

				arg_169_1.leftNameTxt_.text = var_172_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_22 = arg_169_1:GetWordFromCfg(319361041)
				local var_172_23 = arg_169_1:FormatText(var_172_22.content)

				arg_169_1.text_.text = var_172_23

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_24 = 25
				local var_172_25 = utf8.len(var_172_23)
				local var_172_26 = var_172_24 <= 0 and var_172_20 or var_172_20 * (var_172_25 / var_172_24)

				if var_172_26 > 0 and var_172_20 < var_172_26 then
					arg_169_1.talkMaxDuration = var_172_26

					if var_172_26 + var_172_19 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_26 + var_172_19
					end
				end

				arg_169_1.text_.text = var_172_23
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361041", "story_v_out_319361.awb") ~= 0 then
					local var_172_27 = manager.audio:GetVoiceLength("story_v_out_319361", "319361041", "story_v_out_319361.awb") / 1000

					if var_172_27 + var_172_19 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_27 + var_172_19
					end

					if var_172_22.prefab_name ~= "" and arg_169_1.actors_[var_172_22.prefab_name] ~= nil then
						local var_172_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_22.prefab_name].transform, "story_v_out_319361", "319361041", "story_v_out_319361.awb")

						arg_169_1:RecordAudio("319361041", var_172_28)
						arg_169_1:RecordAudio("319361041", var_172_28)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319361", "319361041", "story_v_out_319361.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319361", "319361041", "story_v_out_319361.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_29 = math.max(var_172_20, arg_169_1.talkMaxDuration)

			if var_172_19 <= arg_169_1.time_ and arg_169_1.time_ < var_172_19 + var_172_29 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_19) / var_172_29

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_19 + var_172_29 and arg_169_1.time_ < var_172_19 + var_172_29 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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

		arg_169_1:InitPlayNodeList()
	end,
	Play319361042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319361042
		arg_173_1.duration_ = 8.57

		local var_173_0 = {
			zh = 6.5,
			ja = 8.566
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
				arg_173_0:Play319361043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1095ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1095ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1095ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1095ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1095ui_story.fillRatio = var_176_5
			end

			local var_176_6 = arg_173_1.actors_["10079ui_story"]
			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10079ui_story == nil then
				arg_173_1.var_.characterEffect10079ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 and not isNil(var_176_6) then
				local var_176_9 = (arg_173_1.time_ - var_176_7) / var_176_8

				if arg_173_1.var_.characterEffect10079ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10079ui_story then
				arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_176_10 = 0
			local var_176_11 = 0.75

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_12 = arg_173_1:FormatText(StoryNameCfg[6].name)

				arg_173_1.leftNameTxt_.text = var_176_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_13 = arg_173_1:GetWordFromCfg(319361042)
				local var_176_14 = arg_173_1:FormatText(var_176_13.content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_15 = 30
				local var_176_16 = utf8.len(var_176_14)
				local var_176_17 = var_176_15 <= 0 and var_176_11 or var_176_11 * (var_176_16 / var_176_15)

				if var_176_17 > 0 and var_176_11 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_10
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361042", "story_v_out_319361.awb") ~= 0 then
					local var_176_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361042", "story_v_out_319361.awb") / 1000

					if var_176_18 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_10
					end

					if var_176_13.prefab_name ~= "" and arg_173_1.actors_[var_176_13.prefab_name] ~= nil then
						local var_176_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_13.prefab_name].transform, "story_v_out_319361", "319361042", "story_v_out_319361.awb")

						arg_173_1:RecordAudio("319361042", var_176_19)
						arg_173_1:RecordAudio("319361042", var_176_19)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319361", "319361042", "story_v_out_319361.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319361", "319361042", "story_v_out_319361.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_20 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_20 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_10) / var_176_20

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_10 + var_176_20 and arg_173_1.time_ < var_176_10 + var_176_20 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319361043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319361043
		arg_177_1.duration_ = 9.1

		local var_177_0 = {
			zh = 5.966,
			ja = 9.1
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
				arg_177_0:Play319361044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_180_2 = 0
			local var_180_3 = 0.75

			if var_180_2 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_4 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_5 = arg_177_1:GetWordFromCfg(319361043)
				local var_180_6 = arg_177_1:FormatText(var_180_5.content)

				arg_177_1.text_.text = var_180_6

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361043", "story_v_out_319361.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_319361", "319361043", "story_v_out_319361.awb") / 1000

					if var_180_10 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_2
					end

					if var_180_5.prefab_name ~= "" and arg_177_1.actors_[var_180_5.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_5.prefab_name].transform, "story_v_out_319361", "319361043", "story_v_out_319361.awb")

						arg_177_1:RecordAudio("319361043", var_180_11)
						arg_177_1:RecordAudio("319361043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319361", "319361043", "story_v_out_319361.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319361", "319361043", "story_v_out_319361.awb")
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
	Play319361044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319361044
		arg_181_1.duration_ = 10.43

		local var_181_0 = {
			zh = 6.4,
			ja = 10.433
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
				arg_181_0:Play319361045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1095ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1095ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1095ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1095ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1095ui_story == nil then
				arg_181_1.var_.characterEffect1095ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1095ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1095ui_story then
				arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_184_13 = arg_181_1.actors_["10079ui_story"]
			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect10079ui_story == nil then
				arg_181_1.var_.characterEffect10079ui_story = var_184_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_15 = 0.200000002980232

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 and not isNil(var_184_13) then
				local var_184_16 = (arg_181_1.time_ - var_184_14) / var_184_15

				if arg_181_1.var_.characterEffect10079ui_story and not isNil(var_184_13) then
					local var_184_17 = Mathf.Lerp(0, 0.5, var_184_16)

					arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10079ui_story.fillRatio = var_184_17
				end
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect10079ui_story then
				local var_184_18 = 0.5

				arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10079ui_story.fillRatio = var_184_18
			end

			local var_184_19 = 0

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_184_20 = 0

			if var_184_20 < arg_181_1.time_ and arg_181_1.time_ <= var_184_20 + arg_184_0 then
				arg_181_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_21 = 0
			local var_184_22 = 0.7

			if var_184_21 < arg_181_1.time_ and arg_181_1.time_ <= var_184_21 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_23 = arg_181_1:FormatText(StoryNameCfg[471].name)

				arg_181_1.leftNameTxt_.text = var_184_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_24 = arg_181_1:GetWordFromCfg(319361044)
				local var_184_25 = arg_181_1:FormatText(var_184_24.content)

				arg_181_1.text_.text = var_184_25

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_26 = 28
				local var_184_27 = utf8.len(var_184_25)
				local var_184_28 = var_184_26 <= 0 and var_184_22 or var_184_22 * (var_184_27 / var_184_26)

				if var_184_28 > 0 and var_184_22 < var_184_28 then
					arg_181_1.talkMaxDuration = var_184_28

					if var_184_28 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_28 + var_184_21
					end
				end

				arg_181_1.text_.text = var_184_25
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361044", "story_v_out_319361.awb") ~= 0 then
					local var_184_29 = manager.audio:GetVoiceLength("story_v_out_319361", "319361044", "story_v_out_319361.awb") / 1000

					if var_184_29 + var_184_21 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_29 + var_184_21
					end

					if var_184_24.prefab_name ~= "" and arg_181_1.actors_[var_184_24.prefab_name] ~= nil then
						local var_184_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_24.prefab_name].transform, "story_v_out_319361", "319361044", "story_v_out_319361.awb")

						arg_181_1:RecordAudio("319361044", var_184_30)
						arg_181_1:RecordAudio("319361044", var_184_30)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319361", "319361044", "story_v_out_319361.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319361", "319361044", "story_v_out_319361.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_31 = math.max(var_184_22, arg_181_1.talkMaxDuration)

			if var_184_21 <= arg_181_1.time_ and arg_181_1.time_ < var_184_21 + var_184_31 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_21) / var_184_31

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_21 + var_184_31 and arg_181_1.time_ < var_184_21 + var_184_31 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play319361045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319361045
		arg_185_1.duration_ = 8.97

		local var_185_0 = {
			zh = 7.4,
			ja = 8.966
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
				arg_185_0:Play319361046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.925

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[471].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(319361045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361045", "story_v_out_319361.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361045", "story_v_out_319361.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_319361", "319361045", "story_v_out_319361.awb")

						arg_185_1:RecordAudio("319361045", var_188_9)
						arg_185_1:RecordAudio("319361045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319361", "319361045", "story_v_out_319361.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319361", "319361045", "story_v_out_319361.awb")
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
	Play319361046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319361046
		arg_189_1.duration_ = 7.83

		local var_189_0 = {
			zh = 4.533,
			ja = 7.833
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
				arg_189_0:Play319361047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10079ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10079ui_story == nil then
				arg_189_1.var_.characterEffect10079ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect10079ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10079ui_story then
				arg_189_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1095ui_story"]
			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_6 and not isNil(var_192_4) then
				local var_192_7 = (arg_189_1.time_ - var_192_5) / var_192_6

				if arg_189_1.var_.characterEffect1095ui_story and not isNil(var_192_4) then
					local var_192_8 = Mathf.Lerp(0, 0.5, var_192_7)

					arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1095ui_story.fillRatio = var_192_8
				end
			end

			if arg_189_1.time_ >= var_192_5 + var_192_6 and arg_189_1.time_ < var_192_5 + var_192_6 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1095ui_story then
				local var_192_9 = 0.5

				arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1095ui_story.fillRatio = var_192_9
			end

			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_192_11 = 0

			if var_192_11 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_192_12 = 0
			local var_192_13 = 0.6

			if var_192_12 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_14 = arg_189_1:FormatText(StoryNameCfg[6].name)

				arg_189_1.leftNameTxt_.text = var_192_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_15 = arg_189_1:GetWordFromCfg(319361046)
				local var_192_16 = arg_189_1:FormatText(var_192_15.content)

				arg_189_1.text_.text = var_192_16

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_17 = 24
				local var_192_18 = utf8.len(var_192_16)
				local var_192_19 = var_192_17 <= 0 and var_192_13 or var_192_13 * (var_192_18 / var_192_17)

				if var_192_19 > 0 and var_192_13 < var_192_19 then
					arg_189_1.talkMaxDuration = var_192_19

					if var_192_19 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_12
					end
				end

				arg_189_1.text_.text = var_192_16
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361046", "story_v_out_319361.awb") ~= 0 then
					local var_192_20 = manager.audio:GetVoiceLength("story_v_out_319361", "319361046", "story_v_out_319361.awb") / 1000

					if var_192_20 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_20 + var_192_12
					end

					if var_192_15.prefab_name ~= "" and arg_189_1.actors_[var_192_15.prefab_name] ~= nil then
						local var_192_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_15.prefab_name].transform, "story_v_out_319361", "319361046", "story_v_out_319361.awb")

						arg_189_1:RecordAudio("319361046", var_192_21)
						arg_189_1:RecordAudio("319361046", var_192_21)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319361", "319361046", "story_v_out_319361.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319361", "319361046", "story_v_out_319361.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = math.max(var_192_13, arg_189_1.talkMaxDuration)

			if var_192_12 <= arg_189_1.time_ and arg_189_1.time_ < var_192_12 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_12) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_12 + var_192_22 and arg_189_1.time_ < var_192_12 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319361047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319361047
		arg_193_1.duration_ = 1.33

		local var_193_0 = {
			zh = 1.3,
			ja = 1.333
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
				arg_193_0:Play319361048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10079ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10079ui_story == nil then
				arg_193_1.var_.characterEffect10079ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect10079ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10079ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10079ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10079ui_story.fillRatio = var_196_5
			end

			local var_196_6 = arg_193_1.actors_["1095ui_story"]
			local var_196_7 = 0

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1095ui_story == nil then
				arg_193_1.var_.characterEffect1095ui_story = var_196_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_8 = 0.200000002980232

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_8 and not isNil(var_196_6) then
				local var_196_9 = (arg_193_1.time_ - var_196_7) / var_196_8

				if arg_193_1.var_.characterEffect1095ui_story and not isNil(var_196_6) then
					arg_193_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_7 + var_196_8 and arg_193_1.time_ < var_196_7 + var_196_8 + arg_196_0 and not isNil(var_196_6) and arg_193_1.var_.characterEffect1095ui_story then
				arg_193_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_196_10 = 0
			local var_196_11 = 0.1

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_12 = arg_193_1:FormatText(StoryNameCfg[471].name)

				arg_193_1.leftNameTxt_.text = var_196_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(319361047)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_15 = 4
				local var_196_16 = utf8.len(var_196_14)
				local var_196_17 = var_196_15 <= 0 and var_196_11 or var_196_11 * (var_196_16 / var_196_15)

				if var_196_17 > 0 and var_196_11 < var_196_17 then
					arg_193_1.talkMaxDuration = var_196_17

					if var_196_17 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_10
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361047", "story_v_out_319361.awb") ~= 0 then
					local var_196_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361047", "story_v_out_319361.awb") / 1000

					if var_196_18 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_10
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_319361", "319361047", "story_v_out_319361.awb")

						arg_193_1:RecordAudio("319361047", var_196_19)
						arg_193_1:RecordAudio("319361047", var_196_19)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319361", "319361047", "story_v_out_319361.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319361", "319361047", "story_v_out_319361.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_20 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_20 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_10) / var_196_20

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_10 + var_196_20 and arg_193_1.time_ < var_196_10 + var_196_20 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319361048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319361048
		arg_197_1.duration_ = 10.07

		local var_197_0 = {
			zh = 8.966,
			ja = 10.066
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
				arg_197_0:Play319361049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10079ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10079ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0.7, -0.95, -6.05)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10079ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["10079ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10079ui_story == nil then
				arg_197_1.var_.characterEffect10079ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect10079ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect10079ui_story then
				arg_197_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_200_13 = arg_197_1.actors_["1095ui_story"]
			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 and not isNil(var_200_13) and arg_197_1.var_.characterEffect1095ui_story == nil then
				arg_197_1.var_.characterEffect1095ui_story = var_200_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_15 = 0.200000002980232

			if var_200_14 <= arg_197_1.time_ and arg_197_1.time_ < var_200_14 + var_200_15 and not isNil(var_200_13) then
				local var_200_16 = (arg_197_1.time_ - var_200_14) / var_200_15

				if arg_197_1.var_.characterEffect1095ui_story and not isNil(var_200_13) then
					local var_200_17 = Mathf.Lerp(0, 0.5, var_200_16)

					arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1095ui_story.fillRatio = var_200_17
				end
			end

			if arg_197_1.time_ >= var_200_14 + var_200_15 and arg_197_1.time_ < var_200_14 + var_200_15 + arg_200_0 and not isNil(var_200_13) and arg_197_1.var_.characterEffect1095ui_story then
				local var_200_18 = 0.5

				arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1095ui_story.fillRatio = var_200_18
			end

			local var_200_19 = 0

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				arg_197_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_200_20 = 0
			local var_200_21 = 1.025

			if var_200_20 < arg_197_1.time_ and arg_197_1.time_ <= var_200_20 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_22 = arg_197_1:FormatText(StoryNameCfg[6].name)

				arg_197_1.leftNameTxt_.text = var_200_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_23 = arg_197_1:GetWordFromCfg(319361048)
				local var_200_24 = arg_197_1:FormatText(var_200_23.content)

				arg_197_1.text_.text = var_200_24

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_25 = 41
				local var_200_26 = utf8.len(var_200_24)
				local var_200_27 = var_200_25 <= 0 and var_200_21 or var_200_21 * (var_200_26 / var_200_25)

				if var_200_27 > 0 and var_200_21 < var_200_27 then
					arg_197_1.talkMaxDuration = var_200_27

					if var_200_27 + var_200_20 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_27 + var_200_20
					end
				end

				arg_197_1.text_.text = var_200_24
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361048", "story_v_out_319361.awb") ~= 0 then
					local var_200_28 = manager.audio:GetVoiceLength("story_v_out_319361", "319361048", "story_v_out_319361.awb") / 1000

					if var_200_28 + var_200_20 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_28 + var_200_20
					end

					if var_200_23.prefab_name ~= "" and arg_197_1.actors_[var_200_23.prefab_name] ~= nil then
						local var_200_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_23.prefab_name].transform, "story_v_out_319361", "319361048", "story_v_out_319361.awb")

						arg_197_1:RecordAudio("319361048", var_200_29)
						arg_197_1:RecordAudio("319361048", var_200_29)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319361", "319361048", "story_v_out_319361.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319361", "319361048", "story_v_out_319361.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_30 = math.max(var_200_21, arg_197_1.talkMaxDuration)

			if var_200_20 <= arg_197_1.time_ and arg_197_1.time_ < var_200_20 + var_200_30 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_20) / var_200_30

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_20 + var_200_30 and arg_197_1.time_ < var_200_20 + var_200_30 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319361049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319361049
		arg_201_1.duration_ = 9.3

		local var_201_0 = {
			zh = 8.566,
			ja = 9.3
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
				arg_201_0:Play319361050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.95

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[6].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(319361049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361049", "story_v_out_319361.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361049", "story_v_out_319361.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_319361", "319361049", "story_v_out_319361.awb")

						arg_201_1:RecordAudio("319361049", var_204_9)
						arg_201_1:RecordAudio("319361049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_319361", "319361049", "story_v_out_319361.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_319361", "319361049", "story_v_out_319361.awb")
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
	Play319361050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319361050
		arg_205_1.duration_ = 2.33

		local var_205_0 = {
			zh = 1.999999999999,
			ja = 2.333
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
				arg_205_0:Play319361051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1095ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1095ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1095ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1095ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1095ui_story == nil then
				arg_205_1.var_.characterEffect1095ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect1095ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1095ui_story then
				arg_205_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_208_13 = arg_205_1.actors_["10079ui_story"]
			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 and not isNil(var_208_13) and arg_205_1.var_.characterEffect10079ui_story == nil then
				arg_205_1.var_.characterEffect10079ui_story = var_208_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_15 = 0.200000002980232

			if var_208_14 <= arg_205_1.time_ and arg_205_1.time_ < var_208_14 + var_208_15 and not isNil(var_208_13) then
				local var_208_16 = (arg_205_1.time_ - var_208_14) / var_208_15

				if arg_205_1.var_.characterEffect10079ui_story and not isNil(var_208_13) then
					local var_208_17 = Mathf.Lerp(0, 0.5, var_208_16)

					arg_205_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10079ui_story.fillRatio = var_208_17
				end
			end

			if arg_205_1.time_ >= var_208_14 + var_208_15 and arg_205_1.time_ < var_208_14 + var_208_15 + arg_208_0 and not isNil(var_208_13) and arg_205_1.var_.characterEffect10079ui_story then
				local var_208_18 = 0.5

				arg_205_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10079ui_story.fillRatio = var_208_18
			end

			local var_208_19 = 0

			if var_208_19 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 then
				arg_205_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_208_20 = 0
			local var_208_21 = 0.1

			if var_208_20 < arg_205_1.time_ and arg_205_1.time_ <= var_208_20 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_22 = arg_205_1:FormatText(StoryNameCfg[471].name)

				arg_205_1.leftNameTxt_.text = var_208_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_23 = arg_205_1:GetWordFromCfg(319361050)
				local var_208_24 = arg_205_1:FormatText(var_208_23.content)

				arg_205_1.text_.text = var_208_24

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_25 = 4
				local var_208_26 = utf8.len(var_208_24)
				local var_208_27 = var_208_25 <= 0 and var_208_21 or var_208_21 * (var_208_26 / var_208_25)

				if var_208_27 > 0 and var_208_21 < var_208_27 then
					arg_205_1.talkMaxDuration = var_208_27

					if var_208_27 + var_208_20 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_27 + var_208_20
					end
				end

				arg_205_1.text_.text = var_208_24
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361050", "story_v_out_319361.awb") ~= 0 then
					local var_208_28 = manager.audio:GetVoiceLength("story_v_out_319361", "319361050", "story_v_out_319361.awb") / 1000

					if var_208_28 + var_208_20 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_28 + var_208_20
					end

					if var_208_23.prefab_name ~= "" and arg_205_1.actors_[var_208_23.prefab_name] ~= nil then
						local var_208_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_23.prefab_name].transform, "story_v_out_319361", "319361050", "story_v_out_319361.awb")

						arg_205_1:RecordAudio("319361050", var_208_29)
						arg_205_1:RecordAudio("319361050", var_208_29)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319361", "319361050", "story_v_out_319361.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319361", "319361050", "story_v_out_319361.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_30 = math.max(var_208_21, arg_205_1.talkMaxDuration)

			if var_208_20 <= arg_205_1.time_ and arg_205_1.time_ < var_208_20 + var_208_30 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_20) / var_208_30

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_20 + var_208_30 and arg_205_1.time_ < var_208_20 + var_208_30 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play319361051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319361051
		arg_209_1.duration_ = 4.13

		local var_209_0 = {
			zh = 2.366,
			ja = 4.133
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
				arg_209_0:Play319361052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1095ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1095ui_story == nil then
				arg_209_1.var_.characterEffect1095ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1095ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1095ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1095ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1095ui_story.fillRatio = var_212_5
			end

			local var_212_6 = arg_209_1.actors_["10079ui_story"]
			local var_212_7 = 0

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10079ui_story == nil then
				arg_209_1.var_.characterEffect10079ui_story = var_212_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_8 = 0.200000002980232

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_8 and not isNil(var_212_6) then
				local var_212_9 = (arg_209_1.time_ - var_212_7) / var_212_8

				if arg_209_1.var_.characterEffect10079ui_story and not isNil(var_212_6) then
					arg_209_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_7 + var_212_8 and arg_209_1.time_ < var_212_7 + var_212_8 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10079ui_story then
				arg_209_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_212_11 = 0

			if var_212_11 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_212_12 = 0
			local var_212_13 = 0.225

			if var_212_12 < arg_209_1.time_ and arg_209_1.time_ <= var_212_12 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_14 = arg_209_1:FormatText(StoryNameCfg[6].name)

				arg_209_1.leftNameTxt_.text = var_212_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_15 = arg_209_1:GetWordFromCfg(319361051)
				local var_212_16 = arg_209_1:FormatText(var_212_15.content)

				arg_209_1.text_.text = var_212_16

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_17 = 9
				local var_212_18 = utf8.len(var_212_16)
				local var_212_19 = var_212_17 <= 0 and var_212_13 or var_212_13 * (var_212_18 / var_212_17)

				if var_212_19 > 0 and var_212_13 < var_212_19 then
					arg_209_1.talkMaxDuration = var_212_19

					if var_212_19 + var_212_12 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_19 + var_212_12
					end
				end

				arg_209_1.text_.text = var_212_16
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361051", "story_v_out_319361.awb") ~= 0 then
					local var_212_20 = manager.audio:GetVoiceLength("story_v_out_319361", "319361051", "story_v_out_319361.awb") / 1000

					if var_212_20 + var_212_12 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_12
					end

					if var_212_15.prefab_name ~= "" and arg_209_1.actors_[var_212_15.prefab_name] ~= nil then
						local var_212_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_15.prefab_name].transform, "story_v_out_319361", "319361051", "story_v_out_319361.awb")

						arg_209_1:RecordAudio("319361051", var_212_21)
						arg_209_1:RecordAudio("319361051", var_212_21)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319361", "319361051", "story_v_out_319361.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319361", "319361051", "story_v_out_319361.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_22 = math.max(var_212_13, arg_209_1.talkMaxDuration)

			if var_212_12 <= arg_209_1.time_ and arg_209_1.time_ < var_212_12 + var_212_22 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_12) / var_212_22

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_12 + var_212_22 and arg_209_1.time_ < var_212_12 + var_212_22 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319361052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319361052
		arg_213_1.duration_ = 4.2

		local var_213_0 = {
			zh = 4.2,
			ja = 1.333
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
				arg_213_0:Play319361053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10079ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect10079ui_story == nil then
				arg_213_1.var_.characterEffect10079ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect10079ui_story and not isNil(var_216_0) then
					local var_216_4 = Mathf.Lerp(0, 0.5, var_216_3)

					arg_213_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10079ui_story.fillRatio = var_216_4
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect10079ui_story then
				local var_216_5 = 0.5

				arg_213_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10079ui_story.fillRatio = var_216_5
			end

			local var_216_6 = arg_213_1.actors_["1095ui_story"]
			local var_216_7 = 0

			if var_216_7 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1095ui_story == nil then
				arg_213_1.var_.characterEffect1095ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_8 = 0.200000002980232

			if var_216_7 <= arg_213_1.time_ and arg_213_1.time_ < var_216_7 + var_216_8 and not isNil(var_216_6) then
				local var_216_9 = (arg_213_1.time_ - var_216_7) / var_216_8

				if arg_213_1.var_.characterEffect1095ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_7 + var_216_8 and arg_213_1.time_ < var_216_7 + var_216_8 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1095ui_story then
				arg_213_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_216_10 = 0
			local var_216_11 = 0.45

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_12 = arg_213_1:FormatText(StoryNameCfg[471].name)

				arg_213_1.leftNameTxt_.text = var_216_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_13 = arg_213_1:GetWordFromCfg(319361052)
				local var_216_14 = arg_213_1:FormatText(var_216_13.content)

				arg_213_1.text_.text = var_216_14

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_15 = 18
				local var_216_16 = utf8.len(var_216_14)
				local var_216_17 = var_216_15 <= 0 and var_216_11 or var_216_11 * (var_216_16 / var_216_15)

				if var_216_17 > 0 and var_216_11 < var_216_17 then
					arg_213_1.talkMaxDuration = var_216_17

					if var_216_17 + var_216_10 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_17 + var_216_10
					end
				end

				arg_213_1.text_.text = var_216_14
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361052", "story_v_out_319361.awb") ~= 0 then
					local var_216_18 = manager.audio:GetVoiceLength("story_v_out_319361", "319361052", "story_v_out_319361.awb") / 1000

					if var_216_18 + var_216_10 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_18 + var_216_10
					end

					if var_216_13.prefab_name ~= "" and arg_213_1.actors_[var_216_13.prefab_name] ~= nil then
						local var_216_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_13.prefab_name].transform, "story_v_out_319361", "319361052", "story_v_out_319361.awb")

						arg_213_1:RecordAudio("319361052", var_216_19)
						arg_213_1:RecordAudio("319361052", var_216_19)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319361", "319361052", "story_v_out_319361.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319361", "319361052", "story_v_out_319361.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_20 = math.max(var_216_11, arg_213_1.talkMaxDuration)

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_20 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_10) / var_216_20

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_10 + var_216_20 and arg_213_1.time_ < var_216_10 + var_216_20 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319361053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319361053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319361054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1095ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1095ui_story == nil then
				arg_217_1.var_.characterEffect1095ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1095ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1095ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1095ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1095ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 1.175

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(319361053)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 47
				local var_220_11 = utf8.len(var_220_9)
				local var_220_12 = var_220_10 <= 0 and var_220_7 or var_220_7 * (var_220_11 / var_220_10)

				if var_220_12 > 0 and var_220_7 < var_220_12 then
					arg_217_1.talkMaxDuration = var_220_12

					if var_220_12 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_13 and arg_217_1.time_ < var_220_6 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319361054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319361054
		arg_221_1.duration_ = 16

		local var_221_0 = {
			zh = 15.5,
			ja = 16
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
				arg_221_0:Play319361055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1095ui_story"]
			local var_224_1 = 3.3

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1095ui_story == nil then
				arg_221_1.var_.characterEffect1095ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1095ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1095ui_story then
				arg_221_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_224_4 = 3.3

			if var_224_4 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_224_5 = 3.3

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_224_6 = 2

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				local var_224_7 = manager.ui.mainCamera.transform.localPosition
				local var_224_8 = Vector3.New(0, 0, 10) + Vector3.New(var_224_7.x, var_224_7.y, 0)
				local var_224_9 = arg_221_1.bgs_.I11q

				var_224_9.transform.localPosition = var_224_8
				var_224_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_10 = var_224_9:GetComponent("SpriteRenderer")

				if var_224_10 and var_224_10.sprite then
					local var_224_11 = (var_224_9.transform.localPosition - var_224_7).z
					local var_224_12 = manager.ui.mainCameraCom_
					local var_224_13 = 2 * var_224_11 * Mathf.Tan(var_224_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_224_14 = var_224_13 * var_224_12.aspect
					local var_224_15 = var_224_10.sprite.bounds.size.x
					local var_224_16 = var_224_10.sprite.bounds.size.y
					local var_224_17 = var_224_14 / var_224_15
					local var_224_18 = var_224_13 / var_224_16
					local var_224_19 = var_224_18 < var_224_17 and var_224_17 or var_224_18

					var_224_9.transform.localScale = Vector3.New(var_224_19, var_224_19, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "I11q" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_20 = 0

			if var_224_20 < arg_221_1.time_ and arg_221_1.time_ <= var_224_20 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_21 = 2

			if var_224_20 <= arg_221_1.time_ and arg_221_1.time_ < var_224_20 + var_224_21 then
				local var_224_22 = (arg_221_1.time_ - var_224_20) / var_224_21
				local var_224_23 = Color.New(0, 0, 0)

				var_224_23.a = Mathf.Lerp(0, 1, var_224_22)
				arg_221_1.mask_.color = var_224_23
			end

			if arg_221_1.time_ >= var_224_20 + var_224_21 and arg_221_1.time_ < var_224_20 + var_224_21 + arg_224_0 then
				local var_224_24 = Color.New(0, 0, 0)

				var_224_24.a = 1
				arg_221_1.mask_.color = var_224_24
			end

			local var_224_25 = 2

			if var_224_25 < arg_221_1.time_ and arg_221_1.time_ <= var_224_25 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_26 = 1.3

			if var_224_25 <= arg_221_1.time_ and arg_221_1.time_ < var_224_25 + var_224_26 then
				local var_224_27 = (arg_221_1.time_ - var_224_25) / var_224_26
				local var_224_28 = Color.New(0, 0, 0)

				var_224_28.a = Mathf.Lerp(1, 0, var_224_27)
				arg_221_1.mask_.color = var_224_28
			end

			if arg_221_1.time_ >= var_224_25 + var_224_26 and arg_221_1.time_ < var_224_25 + var_224_26 + arg_224_0 then
				local var_224_29 = Color.New(0, 0, 0)
				local var_224_30 = 0

				arg_221_1.mask_.enabled = false
				var_224_29.a = var_224_30
				arg_221_1.mask_.color = var_224_29
			end

			local var_224_31 = arg_221_1.actors_["1095ui_story"].transform
			local var_224_32 = 2

			if var_224_32 < arg_221_1.time_ and arg_221_1.time_ <= var_224_32 + arg_224_0 then
				arg_221_1.var_.moveOldPos1095ui_story = var_224_31.localPosition
			end

			local var_224_33 = 0.001

			if var_224_32 <= arg_221_1.time_ and arg_221_1.time_ < var_224_32 + var_224_33 then
				local var_224_34 = (arg_221_1.time_ - var_224_32) / var_224_33
				local var_224_35 = Vector3.New(0, 100, 0)

				var_224_31.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1095ui_story, var_224_35, var_224_34)

				local var_224_36 = manager.ui.mainCamera.transform.position - var_224_31.position

				var_224_31.forward = Vector3.New(var_224_36.x, var_224_36.y, var_224_36.z)

				local var_224_37 = var_224_31.localEulerAngles

				var_224_37.z = 0
				var_224_37.x = 0
				var_224_31.localEulerAngles = var_224_37
			end

			if arg_221_1.time_ >= var_224_32 + var_224_33 and arg_221_1.time_ < var_224_32 + var_224_33 + arg_224_0 then
				var_224_31.localPosition = Vector3.New(0, 100, 0)

				local var_224_38 = manager.ui.mainCamera.transform.position - var_224_31.position

				var_224_31.forward = Vector3.New(var_224_38.x, var_224_38.y, var_224_38.z)

				local var_224_39 = var_224_31.localEulerAngles

				var_224_39.z = 0
				var_224_39.x = 0
				var_224_31.localEulerAngles = var_224_39
			end

			local var_224_40 = arg_221_1.actors_["10079ui_story"].transform
			local var_224_41 = 2

			if var_224_41 < arg_221_1.time_ and arg_221_1.time_ <= var_224_41 + arg_224_0 then
				arg_221_1.var_.moveOldPos10079ui_story = var_224_40.localPosition
			end

			local var_224_42 = 0.001

			if var_224_41 <= arg_221_1.time_ and arg_221_1.time_ < var_224_41 + var_224_42 then
				local var_224_43 = (arg_221_1.time_ - var_224_41) / var_224_42
				local var_224_44 = Vector3.New(0, 100, 0)

				var_224_40.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10079ui_story, var_224_44, var_224_43)

				local var_224_45 = manager.ui.mainCamera.transform.position - var_224_40.position

				var_224_40.forward = Vector3.New(var_224_45.x, var_224_45.y, var_224_45.z)

				local var_224_46 = var_224_40.localEulerAngles

				var_224_46.z = 0
				var_224_46.x = 0
				var_224_40.localEulerAngles = var_224_46
			end

			if arg_221_1.time_ >= var_224_41 + var_224_42 and arg_221_1.time_ < var_224_41 + var_224_42 + arg_224_0 then
				var_224_40.localPosition = Vector3.New(0, 100, 0)

				local var_224_47 = manager.ui.mainCamera.transform.position - var_224_40.position

				var_224_40.forward = Vector3.New(var_224_47.x, var_224_47.y, var_224_47.z)

				local var_224_48 = var_224_40.localEulerAngles

				var_224_48.z = 0
				var_224_48.x = 0
				var_224_40.localEulerAngles = var_224_48
			end

			local var_224_49 = arg_221_1.actors_["1095ui_story"].transform
			local var_224_50 = 3.30000000298023

			if var_224_50 < arg_221_1.time_ and arg_221_1.time_ <= var_224_50 + arg_224_0 then
				arg_221_1.var_.moveOldPos1095ui_story = var_224_49.localPosition
			end

			local var_224_51 = 0.001

			if var_224_50 <= arg_221_1.time_ and arg_221_1.time_ < var_224_50 + var_224_51 then
				local var_224_52 = (arg_221_1.time_ - var_224_50) / var_224_51
				local var_224_53 = Vector3.New(0, -0.98, -6.1)

				var_224_49.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1095ui_story, var_224_53, var_224_52)

				local var_224_54 = manager.ui.mainCamera.transform.position - var_224_49.position

				var_224_49.forward = Vector3.New(var_224_54.x, var_224_54.y, var_224_54.z)

				local var_224_55 = var_224_49.localEulerAngles

				var_224_55.z = 0
				var_224_55.x = 0
				var_224_49.localEulerAngles = var_224_55
			end

			if arg_221_1.time_ >= var_224_50 + var_224_51 and arg_221_1.time_ < var_224_50 + var_224_51 + arg_224_0 then
				var_224_49.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_224_56 = manager.ui.mainCamera.transform.position - var_224_49.position

				var_224_49.forward = Vector3.New(var_224_56.x, var_224_56.y, var_224_56.z)

				local var_224_57 = var_224_49.localEulerAngles

				var_224_57.z = 0
				var_224_57.x = 0
				var_224_49.localEulerAngles = var_224_57
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_58 = 3.3
			local var_224_59 = 1.175

			if var_224_58 < arg_221_1.time_ and arg_221_1.time_ <= var_224_58 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_60 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_60:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_61 = arg_221_1:FormatText(StoryNameCfg[471].name)

				arg_221_1.leftNameTxt_.text = var_224_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_62 = arg_221_1:GetWordFromCfg(319361054)
				local var_224_63 = arg_221_1:FormatText(var_224_62.content)

				arg_221_1.text_.text = var_224_63

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_64 = 47
				local var_224_65 = utf8.len(var_224_63)
				local var_224_66 = var_224_64 <= 0 and var_224_59 or var_224_59 * (var_224_65 / var_224_64)

				if var_224_66 > 0 and var_224_59 < var_224_66 then
					arg_221_1.talkMaxDuration = var_224_66
					var_224_58 = var_224_58 + 0.3

					if var_224_66 + var_224_58 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_66 + var_224_58
					end
				end

				arg_221_1.text_.text = var_224_63
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361054", "story_v_out_319361.awb") ~= 0 then
					local var_224_67 = manager.audio:GetVoiceLength("story_v_out_319361", "319361054", "story_v_out_319361.awb") / 1000

					if var_224_67 + var_224_58 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_67 + var_224_58
					end

					if var_224_62.prefab_name ~= "" and arg_221_1.actors_[var_224_62.prefab_name] ~= nil then
						local var_224_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_62.prefab_name].transform, "story_v_out_319361", "319361054", "story_v_out_319361.awb")

						arg_221_1:RecordAudio("319361054", var_224_68)
						arg_221_1:RecordAudio("319361054", var_224_68)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319361", "319361054", "story_v_out_319361.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319361", "319361054", "story_v_out_319361.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_69 = var_224_58 + 0.3
			local var_224_70 = math.max(var_224_59, arg_221_1.talkMaxDuration)

			if var_224_69 <= arg_221_1.time_ and arg_221_1.time_ < var_224_69 + var_224_70 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_69) / var_224_70

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_69 + var_224_70 and arg_221_1.time_ < var_224_69 + var_224_70 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 3.30000000298023,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play319361055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319361055
		arg_227_1.duration_ = 11.6

		local var_227_0 = {
			zh = 11.6,
			ja = 9.166
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
				arg_227_0:Play319361056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_230_1 = 0
			local var_230_2 = 1.25

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_3 = arg_227_1:FormatText(StoryNameCfg[471].name)

				arg_227_1.leftNameTxt_.text = var_230_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(319361055)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_6 = 50
				local var_230_7 = utf8.len(var_230_5)
				local var_230_8 = var_230_6 <= 0 and var_230_2 or var_230_2 * (var_230_7 / var_230_6)

				if var_230_8 > 0 and var_230_2 < var_230_8 then
					arg_227_1.talkMaxDuration = var_230_8

					if var_230_8 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361055", "story_v_out_319361.awb") ~= 0 then
					local var_230_9 = manager.audio:GetVoiceLength("story_v_out_319361", "319361055", "story_v_out_319361.awb") / 1000

					if var_230_9 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_1
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_319361", "319361055", "story_v_out_319361.awb")

						arg_227_1:RecordAudio("319361055", var_230_10)
						arg_227_1:RecordAudio("319361055", var_230_10)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_319361", "319361055", "story_v_out_319361.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_319361", "319361055", "story_v_out_319361.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_11 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_11 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_11

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_11 and arg_227_1.time_ < var_230_1 + var_230_11 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play319361056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319361056
		arg_231_1.duration_ = 10.5

		local var_231_0 = {
			zh = 3.6,
			ja = 10.5
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
				arg_231_0:Play319361057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.375

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[471].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:GetWordFromCfg(319361056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 15
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361056", "story_v_out_319361.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_319361", "319361056", "story_v_out_319361.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_319361", "319361056", "story_v_out_319361.awb")

						arg_231_1:RecordAudio("319361056", var_234_9)
						arg_231_1:RecordAudio("319361056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319361", "319361056", "story_v_out_319361.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319361", "319361056", "story_v_out_319361.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play319361057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319361057
		arg_235_1.duration_ = 8.23

		local var_235_0 = {
			zh = 1.999999999999,
			ja = 8.233
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play319361058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10079ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos10079ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0.7, -0.95, -6.05)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10079ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["10079ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10079ui_story == nil then
				arg_235_1.var_.characterEffect10079ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 and not isNil(var_238_9) then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect10079ui_story and not isNil(var_238_9) then
					arg_235_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10079ui_story then
				arg_235_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_238_13 = 0

			if var_238_13 < arg_235_1.time_ and arg_235_1.time_ <= var_238_13 + arg_238_0 then
				arg_235_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_238_14 = 0

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 then
				arg_235_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_15 = arg_235_1.actors_["1095ui_story"]
			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 and not isNil(var_238_15) and arg_235_1.var_.characterEffect1095ui_story == nil then
				arg_235_1.var_.characterEffect1095ui_story = var_238_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_17 = 0.200000002980232

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_17 and not isNil(var_238_15) then
				local var_238_18 = (arg_235_1.time_ - var_238_16) / var_238_17

				if arg_235_1.var_.characterEffect1095ui_story and not isNil(var_238_15) then
					local var_238_19 = Mathf.Lerp(0, 0.5, var_238_18)

					arg_235_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1095ui_story.fillRatio = var_238_19
				end
			end

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 and not isNil(var_238_15) and arg_235_1.var_.characterEffect1095ui_story then
				local var_238_20 = 0.5

				arg_235_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1095ui_story.fillRatio = var_238_20
			end

			local var_238_21 = arg_235_1.actors_["1095ui_story"].transform
			local var_238_22 = 0

			if var_238_22 < arg_235_1.time_ and arg_235_1.time_ <= var_238_22 + arg_238_0 then
				arg_235_1.var_.moveOldPos1095ui_story = var_238_21.localPosition
			end

			local var_238_23 = 0.001

			if var_238_22 <= arg_235_1.time_ and arg_235_1.time_ < var_238_22 + var_238_23 then
				local var_238_24 = (arg_235_1.time_ - var_238_22) / var_238_23
				local var_238_25 = Vector3.New(-0.7, -0.98, -6.1)

				var_238_21.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1095ui_story, var_238_25, var_238_24)

				local var_238_26 = manager.ui.mainCamera.transform.position - var_238_21.position

				var_238_21.forward = Vector3.New(var_238_26.x, var_238_26.y, var_238_26.z)

				local var_238_27 = var_238_21.localEulerAngles

				var_238_27.z = 0
				var_238_27.x = 0
				var_238_21.localEulerAngles = var_238_27
			end

			if arg_235_1.time_ >= var_238_22 + var_238_23 and arg_235_1.time_ < var_238_22 + var_238_23 + arg_238_0 then
				var_238_21.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_238_28 = manager.ui.mainCamera.transform.position - var_238_21.position

				var_238_21.forward = Vector3.New(var_238_28.x, var_238_28.y, var_238_28.z)

				local var_238_29 = var_238_21.localEulerAngles

				var_238_29.z = 0
				var_238_29.x = 0
				var_238_21.localEulerAngles = var_238_29
			end

			local var_238_30 = 0
			local var_238_31 = 0.2

			if var_238_30 < arg_235_1.time_ and arg_235_1.time_ <= var_238_30 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_32 = arg_235_1:FormatText(StoryNameCfg[6].name)

				arg_235_1.leftNameTxt_.text = var_238_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_33 = arg_235_1:GetWordFromCfg(319361057)
				local var_238_34 = arg_235_1:FormatText(var_238_33.content)

				arg_235_1.text_.text = var_238_34

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_35 = 8
				local var_238_36 = utf8.len(var_238_34)
				local var_238_37 = var_238_35 <= 0 and var_238_31 or var_238_31 * (var_238_36 / var_238_35)

				if var_238_37 > 0 and var_238_31 < var_238_37 then
					arg_235_1.talkMaxDuration = var_238_37

					if var_238_37 + var_238_30 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_37 + var_238_30
					end
				end

				arg_235_1.text_.text = var_238_34
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361057", "story_v_out_319361.awb") ~= 0 then
					local var_238_38 = manager.audio:GetVoiceLength("story_v_out_319361", "319361057", "story_v_out_319361.awb") / 1000

					if var_238_38 + var_238_30 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_38 + var_238_30
					end

					if var_238_33.prefab_name ~= "" and arg_235_1.actors_[var_238_33.prefab_name] ~= nil then
						local var_238_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_33.prefab_name].transform, "story_v_out_319361", "319361057", "story_v_out_319361.awb")

						arg_235_1:RecordAudio("319361057", var_238_39)
						arg_235_1:RecordAudio("319361057", var_238_39)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_319361", "319361057", "story_v_out_319361.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_319361", "319361057", "story_v_out_319361.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_40 = math.max(var_238_31, arg_235_1.talkMaxDuration)

			if var_238_30 <= arg_235_1.time_ and arg_235_1.time_ < var_238_30 + var_238_40 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_30) / var_238_40

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_30 + var_238_40 and arg_235_1.time_ < var_238_30 + var_238_40 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play319361058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319361058
		arg_239_1.duration_ = 7.8

		local var_239_0 = {
			zh = 2.333,
			ja = 7.8
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
				arg_239_0:Play319361059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10079ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10079ui_story == nil then
				arg_239_1.var_.characterEffect10079ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect10079ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10079ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10079ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10079ui_story.fillRatio = var_242_5
			end

			local var_242_6 = arg_239_1.actors_["1095ui_story"]
			local var_242_7 = 0

			if var_242_7 < arg_239_1.time_ and arg_239_1.time_ <= var_242_7 + arg_242_0 and not isNil(var_242_6) and arg_239_1.var_.characterEffect1095ui_story == nil then
				arg_239_1.var_.characterEffect1095ui_story = var_242_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_8 = 0.200000002980232

			if var_242_7 <= arg_239_1.time_ and arg_239_1.time_ < var_242_7 + var_242_8 and not isNil(var_242_6) then
				local var_242_9 = (arg_239_1.time_ - var_242_7) / var_242_8

				if arg_239_1.var_.characterEffect1095ui_story and not isNil(var_242_6) then
					arg_239_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_7 + var_242_8 and arg_239_1.time_ < var_242_7 + var_242_8 + arg_242_0 and not isNil(var_242_6) and arg_239_1.var_.characterEffect1095ui_story then
				arg_239_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			local var_242_11 = 0
			local var_242_12 = 0.3

			if var_242_11 < arg_239_1.time_ and arg_239_1.time_ <= var_242_11 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_13 = arg_239_1:FormatText(StoryNameCfg[471].name)

				arg_239_1.leftNameTxt_.text = var_242_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_14 = arg_239_1:GetWordFromCfg(319361058)
				local var_242_15 = arg_239_1:FormatText(var_242_14.content)

				arg_239_1.text_.text = var_242_15

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_16 = 12
				local var_242_17 = utf8.len(var_242_15)
				local var_242_18 = var_242_16 <= 0 and var_242_12 or var_242_12 * (var_242_17 / var_242_16)

				if var_242_18 > 0 and var_242_12 < var_242_18 then
					arg_239_1.talkMaxDuration = var_242_18

					if var_242_18 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_18 + var_242_11
					end
				end

				arg_239_1.text_.text = var_242_15
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361058", "story_v_out_319361.awb") ~= 0 then
					local var_242_19 = manager.audio:GetVoiceLength("story_v_out_319361", "319361058", "story_v_out_319361.awb") / 1000

					if var_242_19 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_19 + var_242_11
					end

					if var_242_14.prefab_name ~= "" and arg_239_1.actors_[var_242_14.prefab_name] ~= nil then
						local var_242_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_14.prefab_name].transform, "story_v_out_319361", "319361058", "story_v_out_319361.awb")

						arg_239_1:RecordAudio("319361058", var_242_20)
						arg_239_1:RecordAudio("319361058", var_242_20)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_319361", "319361058", "story_v_out_319361.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_319361", "319361058", "story_v_out_319361.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_21 = math.max(var_242_12, arg_239_1.talkMaxDuration)

			if var_242_11 <= arg_239_1.time_ and arg_239_1.time_ < var_242_11 + var_242_21 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_11) / var_242_21

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_11 + var_242_21 and arg_239_1.time_ < var_242_11 + var_242_21 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play319361059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 319361059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play319361060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1095ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1095ui_story == nil then
				arg_243_1.var_.characterEffect1095ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1095ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1095ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1095ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1095ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 1.125

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_8 = arg_243_1:GetWordFromCfg(319361059)
				local var_246_9 = arg_243_1:FormatText(var_246_8.content)

				arg_243_1.text_.text = var_246_9

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 45
				local var_246_11 = utf8.len(var_246_9)
				local var_246_12 = var_246_10 <= 0 and var_246_7 or var_246_7 * (var_246_11 / var_246_10)

				if var_246_12 > 0 and var_246_7 < var_246_12 then
					arg_243_1.talkMaxDuration = var_246_12

					if var_246_12 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_9
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_13 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_13 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_13

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_13 and arg_243_1.time_ < var_246_6 + var_246_13 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play319361060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 319361060
		arg_247_1.duration_ = 6.5

		local var_247_0 = {
			zh = 6.5,
			ja = 6.466
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
				arg_247_0:Play319361061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1095ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1095ui_story == nil then
				arg_247_1.var_.characterEffect1095ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1095ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1095ui_story then
				arg_247_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_250_4 = 0
			local var_250_5 = 0.7

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_6 = arg_247_1:FormatText(StoryNameCfg[471].name)

				arg_247_1.leftNameTxt_.text = var_250_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(319361060)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 28
				local var_250_10 = utf8.len(var_250_8)
				local var_250_11 = var_250_9 <= 0 and var_250_5 or var_250_5 * (var_250_10 / var_250_9)

				if var_250_11 > 0 and var_250_5 < var_250_11 then
					arg_247_1.talkMaxDuration = var_250_11

					if var_250_11 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361060", "story_v_out_319361.awb") ~= 0 then
					local var_250_12 = manager.audio:GetVoiceLength("story_v_out_319361", "319361060", "story_v_out_319361.awb") / 1000

					if var_250_12 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_12 + var_250_4
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_319361", "319361060", "story_v_out_319361.awb")

						arg_247_1:RecordAudio("319361060", var_250_13)
						arg_247_1:RecordAudio("319361060", var_250_13)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_319361", "319361060", "story_v_out_319361.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_319361", "319361060", "story_v_out_319361.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_14 and arg_247_1.time_ < var_250_4 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play319361061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319361061
		arg_251_1.duration_ = 2.73

		local var_251_0 = {
			zh = 1.999999999999,
			ja = 2.733
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
			arg_251_1.auto_ = false
		end

		function arg_251_1.playNext_(arg_253_0)
			arg_251_1.onStoryFinished_()
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1095ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1095ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1095ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["1095ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1095ui_story == nil then
				arg_251_1.var_.characterEffect1095ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect1095ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1095ui_story then
				arg_251_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_254_13 = 0

			if var_254_13 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_254_14 = 0

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 then
				arg_251_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_15 = 0
			local var_254_16 = 0.0666666666666667

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				local var_254_17 = "play"
				local var_254_18 = "music"

				arg_251_1:AudioAction(var_254_17, var_254_18, "", "", "")

				local var_254_19 = ""
				local var_254_20 = manager.audio:GetAudioName("", "")

				if var_254_20 ~= "" then
					if arg_251_1.bgmTxt_.text ~= var_254_20 and arg_251_1.bgmTxt_.text ~= "" then
						if arg_251_1.bgmTxt2_.text ~= "" then
							arg_251_1.bgmTxt_.text = arg_251_1.bgmTxt2_.text
						end

						arg_251_1.bgmTxt2_.text = var_254_20

						arg_251_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_251_1.bgmTxt_.text = var_254_20
						arg_251_1.bgmTxt2_.text = var_254_20
					end

					if arg_251_1.bgmTimer then
						arg_251_1.bgmTimer:Stop()

						arg_251_1.bgmTimer = nil
					end

					if arg_251_1.settingData.show_music_name == 1 then
						arg_251_1.musicController:SetSelectedState("show")
						arg_251_1.musicAnimator_:Play("open", 0, 0)

						if arg_251_1.settingData.music_time ~= 0 then
							arg_251_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_251_1.settingData.music_time), function()
								if arg_251_1 == nil or isNil(arg_251_1.bgmTxt_) then
									return
								end

								arg_251_1.musicController:SetSelectedState("hide")
								arg_251_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_254_21 = 0
			local var_254_22 = 0.2

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_23 = arg_251_1:FormatText(StoryNameCfg[471].name)

				arg_251_1.leftNameTxt_.text = var_254_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_24 = arg_251_1:GetWordFromCfg(319361061)
				local var_254_25 = arg_251_1:FormatText(var_254_24.content)

				arg_251_1.text_.text = var_254_25

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_26 = 8
				local var_254_27 = utf8.len(var_254_25)
				local var_254_28 = var_254_26 <= 0 and var_254_22 or var_254_22 * (var_254_27 / var_254_26)

				if var_254_28 > 0 and var_254_22 < var_254_28 then
					arg_251_1.talkMaxDuration = var_254_28

					if var_254_28 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_28 + var_254_21
					end
				end

				arg_251_1.text_.text = var_254_25
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319361", "319361061", "story_v_out_319361.awb") ~= 0 then
					local var_254_29 = manager.audio:GetVoiceLength("story_v_out_319361", "319361061", "story_v_out_319361.awb") / 1000

					if var_254_29 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_29 + var_254_21
					end

					if var_254_24.prefab_name ~= "" and arg_251_1.actors_[var_254_24.prefab_name] ~= nil then
						local var_254_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_24.prefab_name].transform, "story_v_out_319361", "319361061", "story_v_out_319361.awb")

						arg_251_1:RecordAudio("319361061", var_254_30)
						arg_251_1:RecordAudio("319361061", var_254_30)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_319361", "319361061", "story_v_out_319361.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_319361", "319361061", "story_v_out_319361.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_31 = math.max(var_254_22, arg_251_1.talkMaxDuration)

			if var_254_21 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_31 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_21) / var_254_31

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_21 + var_254_31 and arg_251_1.time_ < var_254_21 + var_254_31 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11q",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319361.awb"
	}
}
